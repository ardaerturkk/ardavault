import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sagbar/app.dart';
import 'package:sagbar/model/book.dart';
import 'package:sagbar/model/content.dart';
import 'package:sagbar/state/app_state.dart';
import 'package:sagbar/state/storage.dart';

import 'support/demo.dart';

Future<(AppState, MemoryStorage)> start(
  WidgetTester t, [
  Book book = const Book(),
]) async {
  t.view.physicalSize = const Size(440, 956) * 3;
  t.view.devicePixelRatio = 3;
  addTearDown(t.view.reset);
  final storage = MemoryStorage();
  final state = AppState(storage, book: book, now: () => demoToday);
  await t.pumpWidget(SagbarApp(state: state, locale: const Locale('en')));
  await t.pumpAndSettle();
  return (state, storage);
}

/// Scrolls the page down until [f] is built (lists build lazily).
Future<void> reveal(WidgetTester t, Finder f) async {
  if (f.evaluate().isNotEmpty) return;
  await t.scrollUntilVisible(f, 200, scrollable: find.byType(Scrollable).last);
  await t.pumpAndSettle();
}

Future<void> tapText(WidgetTester t, String text) async {
  await reveal(t, find.text(text));
  final f = find.text(text).last;
  await t.ensureVisible(f);
  await t.pumpAndSettle();
  await t.tap(f);
  await t.pumpAndSettle();
}

/// Finds rich text (lines with filled details) by its plain content.
Finder richText(String text) => find.byWidgetPredicate(
  (w) => w is RichText && w.text.toPlainText().contains(text),
);

Future<void> tapRich(WidgetTester t, String text) async {
  final f = richText(text).first;
  await t.ensureVisible(f);
  await t.pumpAndSettle();
  await t.tap(f);
  await t.pumpAndSettle();
}

Future<void> holdRich(WidgetTester t, Finder f) async {
  await reveal(t, f);
  await t.ensureVisible(f.first);
  await t.pumpAndSettle();
  await t.longPress(f.first);
  await t.pumpAndSettle();
}

Future<void> enter(WidgetTester t, String text) async {
  await t.enterText(find.byType(CupertinoTextField).first, text);
  await t.pumpAndSettle();
}

void main() {
  testWidgets('first launch teaches adding details, then fills lines', (
    t,
  ) async {
    final (state, storage) = await start(t);
    expect(find.text('Add Your Details Once'), findsOneWidget);
    await tapText(t, 'Add My Details');
    expect(find.text('About You'), findsOneWidget);
    await tapText(t, 'Full Name');
    await enter(t, 'Arda Ertürk');
    await tapText(t, 'Save');
    expect(state.book.detail(Slot.name), 'Arda Ertürk');
    expect(find.text('Arda Ertürk'), findsOneWidget);
    await t.tap(find.byIcon(CupertinoIcons.text_bubble).first);
    await t.pumpAndSettle();
    expect(find.text('Add Your Details Once'), findsNothing);
    await tapText(t, 'Allgemein');
    expect(
      richText('Mein Name ist Arda Ertürk. Ich buchstabiere: A-R-D-A'),
      findsOneWidget,
    );
    expect(richText('My name is Arda Ertürk.'), findsOneWidget);
    await state.flush();
    expect(jsonDecode(storage.contents!), isA<Map<String, Object?>>());
  });

  testWidgets('missing details are listed and filled from the situation', (
    t,
  ) async {
    final (state, _) = await start(t, partialBook());
    await tapText(t, 'Bürgeramt');
    expect(find.text('Fill In Missing Details'), findsOneWidget);
    expect(richText('[Address]'), findsWidgets);
    await tapText(t, 'Address');
    await enter(t, 'Holtenauer Straße 12, 24105 Kiel');
    await tapText(t, 'Save');
    expect(
      richText('Meine neue Adresse lautet: Holtenauer Straße 12, 24105 Kiel.'),
      findsOneWidget,
    );
    expect(state.book.missingFor(situationById('buergeramt')!, 'en'), [
      Slot.birthDate,
      Slot.ref,
      Slot.time,
    ]);
  });

  testWidgets('visit: reference number and appointment fill the lines', (
    t,
  ) async {
    final (state, _) = await start(t, partialBook());
    await tapText(t, 'Ausländerbehörde');
    await tapText(t, 'Aktenzeichen');
    await enter(t, 'ab 31-0925');
    await tapText(t, 'Save');
    expect(state.book.visit('auslaenderbehoerde').ref, 'ab 31-0925');
    expect(richText('Mein Aktenzeichen lautet ab 31-0925.'), findsOneWidget);
    await tapText(t, 'Appointment');
    await tapText(t, 'Done');
    expect(
      state.book.visit('auslaenderbehoerde').appointment,
      DateTime(2026, 10, 7, 9),
    );
    expect(richText('ich habe um 09:00 Uhr einen Termin'), findsOneWidget);
    await tapText(t, 'Appointment');
    await tapText(t, 'Remove Appointment');
    expect(state.book.visit('auslaenderbehoerde').appointment, isNull);
    await t.pageBack();
    await t.pumpAndSettle();
    expect(find.textContaining('Appointment'), findsNothing);
  });

  testWidgets('the situation list shows a set appointment', (t) async {
    await start(t, typicalBook());
    expect(richText('Appointment Thu, Oct 8, 10:40'), findsOneWidget);
  });

  testWidgets('show a line as a card, move on, copy it', (t) async {
    String? clip;
    t.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          clip = (call.arguments as Map)['text'] as String?;
        }
        return null;
      },
    );
    await start(t, typicalBook());
    await tapText(t, 'Bürgeramt');
    await tapRich(t, 'Meine Vorgangsnummer ist KI-2026-4815.');
    expect(find.text('2 of 8'), findsOneWidget);
    expect(find.text('Copy'), findsOneWidget);
    await t.tap(find.bySemanticsLabel('Next Line'));
    await t.pumpAndSettle();
    expect(find.text('3 of 8'), findsOneWidget);
    await tapText(t, 'Copy');
    expect(clip, 'Ich möchte meinen Wohnsitz anmelden.');
    expect(find.text('Copied'), findsOneWidget);
    await t.drag(find.byType(PageView), const Offset(-400, 0));
    await t.pumpAndSettle();
    expect(find.text('4 of 8'), findsOneWidget);
    expect(find.text('Copy'), findsOneWidget);
    await tapText(t, 'Done');
    expect(find.text('Show Cards'), findsOneWidget);
    await tapText(t, 'Show Cards');
    expect(find.text('1 of 8'), findsOneWidget);
  });

  testWidgets('add, edit and delete your own line', (t) async {
    final (state, _) = await start(t, typicalBook());
    await tapText(t, 'Bank');
    await tapText(t, 'Add Your Own Line');
    await tapText(t, 'Save');
    expect(find.text('New Line'), findsOneWidget, reason: 'Save is disabled');
    await enter(t, 'Kann ich das Konto auch online eröffnen?');
    await t.enterText(
      find.byType(CupertinoTextField).at(1),
      'Can I open the account online too?',
    );
    await tapText(t, 'Save');
    final line = state.book.custom.single;
    expect(line.situationId, 'bank');
    expect(line.meaning, 'Can I open the account online too?');
    await holdRich(t, richText('Kann ich das Konto auch online'));
    await t.pumpAndSettle();
    await tapText(t, 'Edit Line');
    await enter(t, 'Kann ich das Konto online eröffnen?');
    await tapText(t, 'Save');
    expect(
      state.book.custom.single.german,
      'Kann ich das Konto online eröffnen?',
    );
    await holdRich(t, richText('Kann ich das Konto online'));
    await t.pumpAndSettle();
    await tapText(t, 'Delete Line');
    await tapText(t, 'Delete Line');
    expect(state.book.custom, isEmpty);
  });

  testWidgets('hide a built-in line and show it again', (t) async {
    final (state, _) = await start(t, typicalBook());
    await tapText(t, 'Bank');
    await holdRich(t, richText('Welche Gebühren'));
    await t.pumpAndSettle();
    await tapText(t, 'Hide Line');
    expect(state.book.hidden, {'bank:6'});
    expect(richText('Welche Gebühren'), findsNothing);
    await tapText(t, 'Show 1 Hidden Line');
    expect(state.book.hidden, isEmpty);
    expect(richText('Welche Gebühren'), findsOneWidget);
  });

  testWidgets('copy from the line menu', (t) async {
    String? clip;
    t.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          clip = (call.arguments as Map)['text'] as String?;
        }
        return null;
      },
    );
    await start(t, typicalBook());
    await tapText(t, 'Krankenkasse');
    await holdRich(t, richText('Meine Versichertennummer'));
    await t.pumpAndSettle();
    await tapText(t, 'Copy');
    expect(clip, 'Meine Versichertennummer ist T482193765.');
  });

  testWidgets('birth date: set and remove', (t) async {
    final (state, _) = await start(t);
    await t.tap(find.byIcon(CupertinoIcons.person_crop_circle).first);
    await t.pumpAndSettle();
    await tapText(t, 'Date of Birth');
    await tapText(t, 'Done');
    expect(state.book.birthDate, DateTime(2000));
    expect(find.text('Jan 1, 2000'), findsOneWidget);
    await tapText(t, 'Date of Birth');
    await tapText(t, 'Remove Date of Birth');
    expect(state.book.birthDate, isNull);
  });

  testWidgets('clearing a detail removes it', (t) async {
    final (state, _) = await start(t, typicalBook());
    await t.tap(find.byIcon(CupertinoIcons.person_crop_circle).first);
    await t.pumpAndSettle();
    await tapText(t, 'Phone');
    await enter(t, '');
    await tapText(t, 'Save');
    expect(state.book.detail(Slot.phone), isNull);
  });

  testWidgets('cancel asks before throwing away edits', (t) async {
    final (state, _) = await start(t, typicalBook());
    await t.tap(find.byIcon(CupertinoIcons.person_crop_circle).first);
    await t.pumpAndSettle();
    await tapText(t, 'Email');
    await enter(t, 'x@y.de');
    await tapText(t, 'Cancel');
    await tapText(t, 'Keep Editing');
    expect(find.text('Save'), findsOneWidget);
    await tapText(t, 'Cancel');
    await tapText(t, 'Discard Changes');
    expect(state.book.detail(Slot.email), 'arda.ertuerk@posteo.de');
  });

  testWidgets('hiding every line removes the cards action', (t) async {
    var book = typicalBook();
    for (final l in situationById('vermieter')!.lines) {
      book = book.hide(l.id);
    }
    await start(t, book);
    await tapText(t, 'Vermieter');
    expect(find.textContaining('No lines here'), findsOneWidget);
    expect(find.text('Show Cards'), findsNothing);
    await tapText(t, 'Show 7 Hidden Lines');
    expect(find.text('Show Cards'), findsOneWidget);
  });

  testWidgets('own lines are shown exactly as typed', (t) async {
    await start(
      t,
      typicalBook().addLine('bank', 'Mein Code ist {name}.', 'Code {ref}'),
    );
    await tapText(t, 'Bank');
    await t.scrollUntilVisible(
      find.textContaining('Mein Code ist {name}.', findRichText: true),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Code {ref}'), findsOneWidget);
  });

  testWidgets('VoiceOver reads the German part of a line in German', (t) async {
    await start(t, typicalBook());
    await tapText(t, 'Bürgeramt');
    final tile = t.widget<Semantics>(
      find.byWidgetPredicate(
        (w) =>
            w is Semantics &&
            (w.properties.attributedLabel?.string.startsWith(
                  'Guten Tag, ich habe um 10:40 Uhr einen Termin.',
                ) ??
                false),
      ),
    );
    final label = tile.properties.attributedLabel!;
    expect(label.string, contains('\nHello, I have an appointment at 10:40.'));
    final attr = label.attributes.single as LocaleStringAttribute;
    expect(attr.locale, const Locale('de', 'DE'));
    expect(attr.range.end, label.string.indexOf('\n'));
  });

  testWidgets('load error banner can be dismissed', (t) async {
    t.view.physicalSize = const Size(440, 956) * 3;
    t.view.devicePixelRatio = 3;
    addTearDown(t.view.reset);
    final state = await AppState.load(MemoryStorage('broken'));
    await t.pumpWidget(SagbarApp(state: state, locale: const Locale('en')));
    await t.pumpAndSettle();
    expect(find.textContaining('could not be read'), findsOneWidget);
    await tapText(t, 'OK');
    expect(find.textContaining('could not be read'), findsNothing);
  });

  testWidgets('German and Turkish: German lines stay, meanings follow', (
    t,
  ) async {
    for (final (locale, tab, meaning) in [
      ('de', 'Situationen', 'Hello, I have an appointment at 10:40.'),
      ('tr', 'Durumlar', 'Merhaba, saat 10:40 için randevum var.'),
    ]) {
      final state = AppState(MemoryStorage(), book: typicalBook());
      await t.pumpWidget(SagbarApp(state: state, locale: Locale(locale)));
      await t.pumpAndSettle();
      expect(find.text(tab), findsWidgets);
      await tapText(t, 'Bürgeramt');
      expect(richText('ich habe um 10:40 Uhr einen Termin'), findsOneWidget);
      expect(richText(meaning), findsOneWidget);
      await t.pumpWidget(const SizedBox());
    }
  });
}
