import 'dart:convert';

import 'package:flathunt/app.dart';
import 'package:flathunt/model/board.dart';
import 'package:flathunt/state/app_state.dart';
import 'package:flathunt/state/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/demo.dart';

Future<(AppState, MemoryStorage)> start(
  WidgetTester t, [
  Board board = const Board(),
]) async {
  t.view.physicalSize = const Size(440, 956) * 3;
  t.view.devicePixelRatio = 3;
  addTearDown(t.view.reset);
  final storage = MemoryStorage();
  final state = AppState(storage, board: board, now: () => demoToday);
  await t.pumpWidget(FlatboardApp(state: state, locale: const Locale('en')));
  await t.pumpAndSettle();
  return (state, storage);
}

/// Scrolls the topmost list until [text] is built, then taps it.
Future<void> tapText(WidgetTester t, String text) async {
  await reveal(t, find.text(text));
  final f = find.text(text).last;
  await t.ensureVisible(f);
  await t.pumpAndSettle();
  await t.tap(f);
  await t.pumpAndSettle();
}

Future<void> reveal(WidgetTester t, Finder f) async {
  if (f.evaluate().isNotEmpty) return;
  await t.scrollUntilVisible(f, 300, scrollable: find.byType(Scrollable).last);
  await t.pumpAndSettle();
}

Finder field(String label) => find.descendant(
  of: find.byWidgetPredicate(
    (w) => w is Semantics && w.properties.label == label,
  ),
  matching: find.byType(EditableText),
);

Future<void> openCompare(WidgetTester t) async {
  await t.tap(find.byIcon(CupertinoIcons.chart_bar).first);
  await t.pumpAndSettle();
}

void main() {
  testWidgets('add a flat from the empty state', (t) async {
    final (state, storage) = await start(t);
    expect(find.text('No Flats Yet'), findsOneWidget);
    await tapText(t, 'Add Flat');
    expect(find.text('New Flat'), findsOneWidget);
    await t.enterText(field('Title'), 'Room in Gaarden');
    await t.enterText(field('Warm Rent'), '430,50');
    await t.enterText(field('Size in m²'), '17');
    await t.enterText(field('District'), 'Gaarden');
    await t.enterText(field('Link'), 'https://example.org/1');
    await t.pumpAndSettle();
    await tapText(t, 'Other');
    await tapText(t, 'WG-Gesucht');
    await tapText(t, 'Save');
    final f = state.board.flats.single;
    expect(f.title, 'Room in Gaarden');
    expect(f.warmCents, 43050);
    expect(f.sizeSqm, 17);
    expect(f.source, Source.wgGesucht);
    expect(f.stage, Stage.interested);
    expect(f.stageSince, demoToday);
    expect(find.text('Interested'), findsOneWidget);
    expect(find.textContaining('€430.50\u00a0warm'), findsOneWidget);
    await state.flush();
    expect(jsonDecode(storage.contents!), isA<Map<String, Object?>>());
  });

  testWidgets('save needs a title and readable numbers', (t) async {
    final (state, _) = await start(t);
    await tapText(t, 'Add Flat');
    await tapText(t, 'Save');
    expect(find.text('New Flat'), findsOneWidget);
    await t.enterText(field('Title'), 'Room');
    await t.enterText(field('Warm Rent'), 'lots');
    await t.pumpAndSettle();
    expect(find.textContaining('Enter amounts like 480'), findsOneWidget);
    await tapText(t, 'Save');
    expect(state.board.isEmpty, isTrue);
    await t.enterText(field('Warm Rent'), '480');
    await t.pumpAndSettle();
    await tapText(t, 'Save');
    expect(state.board.flats.single.warmCents, 48000);
  });

  testWidgets('cancel asks before throwing away edits', (t) async {
    final (state, _) = await start(t, typicalBoard());
    await tapText(t, 'Room in a 3-Person WG');
    await tapText(t, 'Edit');
    expect(find.text('395'), findsOneWidget);
    await t.enterText(field('Title'), 'Changed');
    await t.pumpAndSettle();
    await tapText(t, 'Cancel');
    await tapText(t, 'Keep Editing');
    expect(find.text('Edit Flat'), findsOneWidget);
    await tapText(t, 'Cancel');
    await tapText(t, 'Discard Changes');
    expect(find.text('Edit Flat'), findsNothing);
    expect(state.board.flat('f3')!.title, 'Room in a 3-Person WG');
  });

  testWidgets('editing keeps stage and checks and can clear a rent', (t) async {
    final (state, _) = await start(t, typicalBoard());
    await tapText(t, 'WG Room Near Campus');
    await tapText(t, 'Edit');
    await t.enterText(field('Cold Rent'), '');
    await t.pumpAndSettle();
    await tapText(t, 'Save');
    final f = state.board.flat('f1')!;
    expect(f.coldCents, isNull);
    expect(f.warmCents, 45000);
    expect(f.stage, Stage.viewing);
    expect(f.checks, {Check.noPrepay});
  });

  testWidgets('move a flat through the whole pipeline', (t) async {
    final (state, _) = await start(t, typicalBoard());
    await tapText(t, 'Studentenwerk Dorm Room');
    expect(find.text('Added Oct 5'), findsOneWidget);

    await tapText(t, 'Mark as Messaged');
    expect(state.board.flat('f4')!.stage, Stage.messaged);
    expect(find.text('Messaged Oct 6'), findsOneWidget);

    await tapText(t, 'Schedule Viewing');
    expect(find.text('Viewing Time'), findsOneWidget);
    await tapText(t, 'Done');
    final f = state.board.flat('f4')!;
    expect(f.stage, Stage.viewing);
    expect(f.viewing, DateTime(2026, 10, 7, 17));
    expect(
      find.textContaining(RegExp(r'^Viewing Wed, Oct 7, 5:00.PM$')),
      findsOneWidget,
    );

    await tapText(t, 'Mark as Applied');
    expect(state.board.flat('f4')!.stage, Stage.applied);

    await tapText(t, 'Record Answer');
    expect(find.text('Did you get the flat?'), findsOneWidget);
    await tapText(t, 'Accepted');
    expect(state.board.flat('f4')!.stage, Stage.accepted);
    expect(find.text('Record Answer'), findsNothing);

    await t.pageBack();
    await t.pumpAndSettle();
    expect(find.text('Accepted'), findsOneWidget);
  });

  testWidgets('cancelling the viewing time keeps the stage', (t) async {
    final (state, _) = await start(t, typicalBoard());
    await tapText(t, 'Room in a 3-Person WG');
    await tapText(t, 'Schedule Viewing');
    await tapText(t, 'Cancel');
    expect(state.board.flat('f3')!.stage, Stage.messaged);
    await tapText(t, 'Schedule Viewing');
    await tapText(t, 'Set Time Later');
    expect(state.board.flat('f3')!.stage, Stage.viewing);
    expect(state.board.flat('f3')!.viewing, isNull);
    expect(find.text('No viewing time yet'), findsOneWidget);
  });

  testWidgets('setting a viewing time on a messaged flat moves it', (t) async {
    final (state, _) = await start(t, typicalBoard());
    await tapText(t, 'Room in a 3-Person WG');
    await tapText(t, 'Not Set');
    await tapText(t, 'Done');
    expect(state.board.flat('f3')!.stage, Stage.viewing);
    await tapText(t, 'Viewing');
    await tapText(t, 'Remove Viewing Time');
    expect(state.board.flat('f3')!.viewing, isNull);
  });

  testWidgets('choose any stage from the Stage row', (t) async {
    final (state, _) = await start(t, typicalBoard());
    await tapText(t, 'Bright 1-Room Flat');
    await tapText(t, 'Stage');
    expect(find.text('Move this flat to another stage.'), findsOneWidget);
    await tapText(t, 'Declined');
    expect(state.board.flat('f2')!.stage, Stage.declined);
    await t.drag(find.byType(Scrollable).last, const Offset(0, 600));
    await t.pumpAndSettle();
    expect(find.text('Declined Oct 6'), findsOneWidget);
  });

  testWidgets('tick safety checks', (t) async {
    final (state, _) = await start(t, typicalBoard());
    await tapText(t, 'WG Room Near Campus');
    await reveal(t, find.text('Safety Checks'));
    await tapText(t, 'You have seen the flat in person');
    expect(state.board.flat('f1')!.checks, {Check.noPrepay, Check.viewed});
    await tapText(t, 'You have seen the flat in person');
    expect(state.board.flat('f1')!.checks, {Check.noPrepay});
  });

  testWidgets('copy the link', (t) async {
    String? copied;
    t.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          copied = (call.arguments as Map)['text'] as String?;
        }
        return null;
      },
    );
    await start(t, typicalBoard());
    await tapText(t, 'WG Room Near Campus');
    await tapText(t, 'Copy Link');
    expect(copied, contains('wg-gesucht.de'));
    expect(find.text('Link copied.'), findsOneWidget);
  });

  testWidgets('delete a flat closes its page', (t) async {
    final (state, _) = await start(t, typicalBoard());
    await tapText(t, 'Sublet Until March');
    await tapText(t, 'Edit');
    await tapText(t, 'Delete Flat');
    await tapText(t, 'Delete Flat');
    expect(state.board.flat('f5'), isNull);
    expect(find.text('Sublet Until March'), findsNothing);
    expect(find.text('Flats'), findsWidgets);
  });

  testWidgets('compare per month and per m²', (t) async {
    await start(t, typicalBoard());
    await openCompare(t);
    expect(find.text('Cheapest  ·  Interested  ·  Westring'), findsOneWidget);
    expect(find.text('€310'), findsOneWidget);
    expect(find.text('Cheap Room, Deposit First'), findsNothing);
    expect(find.text('Warm rent missing'), findsOneWidget);
    await tapText(t, 'Per m²');
    expect(find.text('€18.57'), findsOneWidget);
    expect(find.text('Size missing'), findsOneWidget);
    expect(find.text('Warm rent and size missing'), findsOneWidget);
    await tapText(t, 'Attic Flat With Balcony');
    expect(find.text('Warm per m²'), findsOneWidget);
  });

  testWidgets('compare starts empty and teaches adding a flat', (t) async {
    final (state, _) = await start(t);
    await openCompare(t);
    expect(find.text('Nothing to Compare Yet'), findsOneWidget);
    await tapText(t, 'Add Flat');
    await t.enterText(field('Title'), 'Room');
    await t.enterText(field('Warm Rent'), '400');
    await t.pumpAndSettle();
    await tapText(t, 'Save');
    expect(state.board.flats, hasLength(1));
    expect(find.text('€400'), findsOneWidget);
  });

  testWidgets('a flat without numbers offers to add them', (t) async {
    await start(t, typicalBoard());
    await tapText(t, 'Room via a Friend');
    await tapText(t, 'Add Rent and Size');
    expect(find.text('Edit Flat'), findsOneWidget);
  });

  testWidgets('load error banner can be dismissed', (t) async {
    t.view.physicalSize = const Size(440, 956) * 3;
    t.view.devicePixelRatio = 3;
    addTearDown(t.view.reset);
    final state = await AppState.load(MemoryStorage('broken'));
    await t.pumpWidget(FlatboardApp(state: state, locale: const Locale('en')));
    await t.pumpAndSettle();
    expect(find.textContaining('could not be read'), findsOneWidget);
    await tapText(t, 'OK');
    expect(find.textContaining('could not be read'), findsNothing);
  });

  testWidgets('German and Turkish load', (t) async {
    for (final (locale, title) in [('de', 'Wohnungen'), ('tr', 'Evler')]) {
      final state = AppState(MemoryStorage(), board: typicalBoard(locale));
      await t.pumpWidget(FlatboardApp(state: state, locale: Locale(locale)));
      await t.pumpAndSettle();
      expect(find.text(title), findsWidgets);
    }
  });
}
