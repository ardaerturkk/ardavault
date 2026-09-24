import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:halfday/app.dart';
import 'package:halfday/model/book.dart';
import 'package:halfday/model/day.dart';
import 'package:halfday/model/quota.dart';
import 'package:halfday/state/app_state.dart';
import 'package:halfday/state/storage.dart';

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
  await t.pumpWidget(HalfdayApp(state: state, locale: const Locale('en')));
  await t.pumpAndSettle();
  return (state, storage);
}

Future<void> tapText(WidgetTester t, String text) async {
  final f = find.text(text).last;
  await t.ensureVisible(f);
  await t.pumpAndSettle();
  await t.tap(f);
  await t.pumpAndSettle();
}

Future<void> openTab(WidgetTester t, IconData icon) async {
  await t.tap(find.byIcon(icon).first);
  await t.pumpAndSettle();
}

void main() {
  testWidgets('first shift: add a job on the way and see the count drop', (
    t,
  ) async {
    final (state, storage) = await start(t);
    expect(find.text('140'), findsOneWidget);
    expect(find.text('days left in 2026'), findsOneWidget);
    await tapText(t, 'Log Shift');
    expect(find.text('New Shift'), findsOneWidget);
    expect(find.text('Thu, Sep 24, 2026'), findsOneWidget);
    await tapText(t, 'Add a Job');
    await t.enterText(find.byType(CupertinoTextField).first, 'Cafe Luna');
    await tapText(t, 'Minijob');
    await t.enterText(find.byType(CupertinoTextField).last, '13,50');
    await t.pumpAndSettle();
    await tapText(t, 'Save');
    expect(find.text('Cafe Luna'), findsOneWidget);
    // The default is 4 hours: a half day.
    expect(find.text('Counts as a half day'), findsOneWidget);
    await tapText(t, 'Save');
    expect(find.text('139.5'), findsOneWidget);
    expect(find.text('0 full days, 1 half day'), findsOneWidget);
    final shift = state.book.shifts.single;
    expect(shift.date, Day(2026, 9, 24));
    expect(shift.minutes, 240);
    expect(state.book.jobs.single.rateCents, 1350);
    expect(find.text('Minijob Pay in September'), findsOneWidget);
    expect(find.text('€54 of €603'), findsOneWidget);
    expect(find.text('4 of 20 h'), findsOneWidget);
    expect(find.text('0.5 of 140 days used'), findsOneWidget);
    await state.flush();
    expect(jsonDecode(storage.contents!), isA<Map<String, Object?>>());
  });

  testWidgets('the editor shows how the day counts with other shifts', (
    t,
  ) async {
    await start(t, typicalBook());
    await openTab(t, shiftsIcon);
    expect(find.text('September 2026'), findsOneWidget);
    await tapText(t, 'Wed, Sep 23');
    expect(find.text('Edit Shift'), findsOneWidget);
    expect(find.text('Counts as a full day'), findsOneWidget);
    expect(
      find.text('Together with 1 other shift that day: 5.5 h'),
      findsOneWidget,
    );
  });

  testWidgets('a university job shift is not counted', (t) async {
    final (state, _) = await start(t, typicalBook());
    final before = yearUsage(state.book, 2026).usedHalves;
    await tapText(t, 'Log Shift');
    await tapText(t, 'Nordlicht Software');
    await tapText(t, 'Tutor, Computer Science');
    expect(find.text('Not counted: university job'), findsOneWidget);
    await tapText(t, 'Save');
    expect(yearUsage(state.book, 2026).usedHalves, before);
    expect(state.book.lastJobId, 'j3');
  });

  testWidgets('deleting a shift asks first and gives the day back', (t) async {
    final (state, _) = await start(t, typicalBook());
    await openTab(t, shiftsIcon);
    await tapText(t, 'Tue, Sep 29');
    await tapText(t, 'Delete Shift');
    await tapText(t, 'Cancel');
    expect(state.book.shifts.any((s) => s.date == Day(2026, 9, 29)), isTrue);
    await tapText(t, 'Delete Shift');
    await tapText(t, 'Delete Shift');
    expect(state.book.shifts.any((s) => s.date == Day(2026, 9, 29)), isFalse);
    expect(find.text('Shifts'), findsWidgets);
  });

  testWidgets('cancelling a changed editor asks before discarding', (t) async {
    final (state, _) = await start(t, typicalBook());
    final count = state.book.shifts.length;
    await tapText(t, 'Log Shift');
    await tapText(t, 'Cancel');
    // Nothing changed: it just closes.
    expect(find.text('New Shift'), findsNothing);
    await tapText(t, 'Log Shift');
    await t.enterText(find.byType(CupertinoTextField).last, 'Inventory');
    await tapText(t, 'Cancel');
    await tapText(t, 'Keep Editing');
    expect(find.text('New Shift'), findsOneWidget);
    await tapText(t, 'Cancel');
    await tapText(t, 'Discard Changes');
    expect(find.text('New Shift'), findsNothing);
    expect(state.book.shifts, hasLength(count));
  });

  testWidgets('a plan that fits, then added as shifts', (t) async {
    final (state, _) = await start(t, typicalBook());
    final count = state.book.shifts.length;
    await openTab(t, planIcon);
    expect(find.text('Fits Within the Limit'), findsOneWidget);
    expect(
      find.text('16.5 days left in 2026 after this plan.'),
      findsOneWidget,
    );
    expect(find.text('Fri, Sep 25, 2026'), findsOneWidget);
    expect(find.text('5 (Mon to Fri)'), findsOneWidget);
    await tapText(t, 'Add as Shifts');
    expect(
      find.text('40 shifts for Nordlicht Software will be added to your log.'),
      findsOneWidget,
    );
    await tapText(t, 'Add 40 Shifts');
    expect(find.text('40 shifts added'), findsOneWidget);
    await tapText(t, 'OK');
    expect(state.book.shifts, hasLength(count + 40));
  });

  testWidgets('a plan that goes over shows the run-out date', (t) async {
    await start(t, heavyBook());
    await openTab(t, planIcon);
    expect(find.text('Over the Limit from Tue, Oct 6'), findsOneWidget);
    expect(
      find.textContaining(
        'Your last planned day within the limit is Mon, '
        'Oct 5, 2026.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('changing the plan: fewer weeks fit', (t) async {
    await start(t, heavyBook());
    await openTab(t, planIcon);
    await tapText(t, 'Weeks');
    await t.drag(find.text('8').last, const Offset(0, 600));
    await t.pumpAndSettle();
    await tapText(t, 'Done');
    expect(find.text('Fits Within the Limit'), findsOneWidget);
  });

  testWidgets('limits are editable and can be restored', (t) async {
    final (state, _) = await start(t, typicalBook());
    await openTab(t, settingsIcon);
    await tapText(t, 'Full Days per Year');
    await t.enterText(find.byType(CupertinoTextField), '0');
    await t.pumpAndSettle();
    expect(find.text('Enter a number greater than zero.'), findsOneWidget);
    await t.enterText(find.byType(CupertinoTextField), '40');
    await tapText(t, 'Save');
    expect(state.book.settings.fullDayLimit, 40);
    await openTab(t, overviewIcon);
    expect(find.text('days over the limit in 2026'), findsOneWidget);
    await openTab(t, settingsIcon);
    await tapText(t, 'Half Day Up To');
    await t.enterText(find.byType(CupertinoTextField), '4,5');
    await tapText(t, 'Save');
    expect(state.book.settings.halfDayMaxMinutes, 270);
    await tapText(t, 'Restore Typical Values');
    await tapText(t, 'Restore Typical Values');
    expect(state.book.settings.isTypical, isTrue);
    expect(find.text('Restore Typical Values'), findsNothing);
  });

  testWidgets('deleting a job says how many shifts go with it', (t) async {
    final (state, _) = await start(t, typicalBook());
    await openTab(t, settingsIcon);
    await tapText(t, 'Tutor, Computer Science');
    await tapText(t, 'Delete Job');
    expect(
      find.text('This job and its 14 shifts will be deleted.'),
      findsOneWidget,
    );
    await tapText(t, 'Delete Job');
    expect(state.book.job('j3'), isNull);
    expect(state.book.shifts.any((s) => s.jobId == 'j3'), isFalse);
  });

  testWidgets('the rules page explains with the current values', (t) async {
    await start(t);
    await openTab(t, settingsIcon);
    await tapText(t, 'How Halfday Counts');
    expect(find.textContaining('More than 4 h is a full day'), findsOneWidget);
    await t.scrollUntilVisible(find.text('Not Legal Advice'), 200);
    expect(find.text('Not Legal Advice'), findsOneWidget);
  });

  testWidgets('German and Turkish number formats', (t) async {
    t.view.physicalSize = const Size(440, 956) * 3;
    t.view.devicePixelRatio = 3;
    addTearDown(t.view.reset);
    final state = AppState(
      MemoryStorage(),
      book: typicalBook(),
      now: () => demoToday,
    );
    await t.pumpWidget(HalfdayApp(state: state, locale: const Locale('de')));
    await t.pumpAndSettle();
    expect(find.text('55,5'), findsOneWidget);
    expect(find.text('Tage übrig in 2026'), findsOneWidget);
    await t.pumpWidget(HalfdayApp(state: state, locale: const Locale('tr')));
    await t.pumpAndSettle();
    expect(find.text('55,5'), findsOneWidget);
  });
}
