@Tags(['screenshots'])
library;

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:halfday/app.dart';
import 'package:halfday/model/day.dart';
import 'package:halfday/model/quota.dart';
import 'package:halfday/state/app_state.dart';
import 'package:halfday/state/storage.dart';
import 'package:halfday/ui/shift_edit_page.dart';

import 'support/demo.dart';
import 'support/fonts.dart';

/// Fallback App Store screenshots at the 6.9-inch size (1320x2868), written
/// to `store/screenshots/<locale>/`, then flattened (no alpha) by
/// `scripts/store_screenshots.sh <app>`.
void main() {
  const size = Size(440, 956);
  const dpr = 3.0;

  Future<void> capture(WidgetTester t, String path) async {
    await t.pumpAndSettle();
    final boundary = t.renderObject<RenderRepaintBoundary>(
      find.byType(RepaintBoundary).first,
    );
    await t.runAsync(() async {
      final image = await boundary.toImage(pixelRatio: dpr);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      final file = File(path)..createSync(recursive: true);
      file.writeAsBytesSync(bytes!.buffer.asUint8List());
    });
  }

  for (final locale in ['en-US', 'de-DE', 'tr']) {
    testWidgets('store screenshots $locale', (t) async {
      await loadTestFonts();
      t.view.physicalSize = size * dpr;
      t.view.devicePixelRatio = dpr;
      t.view.padding = const FakeViewPadding(top: 62 * dpr, bottom: 34 * dpr);
      addTearDown(t.view.reset);
      final state = AppState(
        MemoryStorage(),
        book: typicalBook(),
        now: () => demoToday,
      );
      // A summer-job sized plan that runs out before the year ends.
      state.planInput = PlanInput(
        start: Day(2026, 9, 28),
        weeks: 20,
        jobId: 'j1',
      );
      await t.pumpWidget(
        RepaintBoundary(
          child: HalfdayApp(
            state: state,
            locale: Locale(locale.split('-').first),
          ),
        ),
      );
      final dir = '../../apps/halfday/store/screenshots/$locale';
      await capture(t, '$dir/1_overview.png');

      final shift = state.book.shifts.firstWhere(
        (s) => s.note == 'Sprint review',
      );
      // ignore: unawaited_futures
      openShiftEditor(
        t.element(find.byType(CupertinoTabScaffold)),
        shift: shift,
      );
      await capture(t, '$dir/2_shift.png');
      Navigator.of(t.element(find.byType(ShiftEditPage))).pop();
      await t.pumpAndSettle();

      await t.tap(find.byIcon(shiftsIcon).first);
      await capture(t, '$dir/3_shifts.png');

      await t.tap(find.byIcon(planIcon).first);
      await capture(t, '$dir/4_plan.png');

      await t.tap(find.byIcon(settingsIcon).first);
      await capture(t, '$dir/5_settings.png');
    });
  }
}
