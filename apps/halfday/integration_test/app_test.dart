import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:halfday/app.dart';
import 'package:halfday/l10n/app_localizations.dart';
import 'package:halfday/model/book.dart';
import 'package:halfday/model/day.dart';
import 'package:halfday/state/app_state.dart';
import 'package:halfday/state/storage.dart';
import 'package:integration_test/integration_test.dart';

import '../test/support/demo.dart';

const locale = String.fromEnvironment('SCREENSHOT_LOCALE', defaultValue: 'en');

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> shot(WidgetTester t, String name) async {
    await t.pumpAndSettle();
    await binding.takeScreenshot('${locale}_$name');
  }

  testWidgets('real storage: a change survives a reload', (t) async {
    final storage = FileStorage();
    final state = await AppState.load(storage);
    final (withJob, jobId) = state.book.addJob(
      (id) => Job(id: id, name: 'Probe'),
    );
    state.update(
      withJob
          .addShift(
            (id) => Shift(
              id: id,
              jobId: jobId,
              date: Day(2026, 3, 29),
              minutes: 270,
            ),
          )
          .$1,
    );
    await state.flush();
    final again = await AppState.load(storage);
    expect(again.book.jobs.any((j) => j.name == 'Probe'), isTrue);
    expect(again.book.shifts.single.date, Day(2026, 3, 29));
    again.update(const Book());
    await again.flush();
  });

  testWidgets('screenshots and the main flow', (t) async {
    final state = AppState(
      MemoryStorage(),
      book: typicalBook(),
      now: () => demoToday,
    );
    await t.pumpWidget(HalfdayApp(state: state, locale: const Locale(locale)));
    await t.pumpAndSettle();
    final l = lookupAppLocalizations(const Locale(locale));

    await shot(t, '1_overview');

    final before = state.book.shifts.length;
    await t.tap(find.text(l.logShift).last);
    await t.pumpAndSettle();
    await shot(t, '2_log_shift');
    await t.tap(find.text(l.save));
    await t.pumpAndSettle();
    expect(state.book.shifts, hasLength(before + 1));

    await t.tap(find.byIcon(shiftsIcon).first);
    await shot(t, '3_shifts');

    await t.tap(find.byIcon(planIcon).first);
    await shot(t, '4_plan');

    await t.tap(find.byIcon(settingsIcon).first);
    await shot(t, '5_settings');
  });
}
