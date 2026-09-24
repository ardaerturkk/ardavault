@Tags(['golden'])
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:halfday/app.dart';
import 'package:halfday/model/book.dart';
import 'package:halfday/state/app_state.dart';
import 'package:halfday/state/storage.dart';
import 'package:halfday/ui/how_page.dart';
import 'package:halfday/ui/job_edit_page.dart';
import 'package:halfday/ui/settings_page.dart';
import 'package:halfday/ui/shift_edit_page.dart';

import 'support/demo.dart';
import 'support/fonts.dart';

class Device {
  const Device(this.name, this.size, this.top, this.bottom);
  final String name;
  final Size size;
  final double top;
  final double bottom;
}

const small = Device('small', Size(375, 667), 20, 0);
const large = Device('large', Size(440, 956), 62, 34);
const dpr = 2.0;

typedef Action = Future<void> Function(WidgetTester t);

Action tab(IconData icon) => (t) async {
  await t.tap(find.byIcon(icon).first);
  await t.pumpAndSettle();
};

/// Opens a page or editor without waiting for it to close.
void open(WidgetTester t, Future<Object?> Function(BuildContext) show) {
  final ctx = t.element(find.byType(CupertinoTabScaffold));
  // ignore: unawaited_futures
  show(ctx);
}

class Scenario {
  const Scenario(this.name, this.book, {this.action, this.loadFailed = false});
  final String name;
  final Book Function() book;
  final Action? action;
  final bool loadFailed;
}

Book empty() => const Book();

final scenarios = <Scenario>[
  const Scenario('overview_empty', empty),
  const Scenario('overview_typical', typicalBook),
  const Scenario('overview_heavy', heavyBook),
  const Scenario('overview_over', overBook),
  const Scenario('overview_error', typicalBook, loadFailed: true),
  Scenario('shifts_empty', empty, action: tab(shiftsIcon)),
  Scenario('shifts_typical', typicalBook, action: tab(shiftsIcon)),
  Scenario(
    'shift_new_no_job',
    empty,
    action: (t) async {
      open(t, openShiftEditor);
      await t.pumpAndSettle();
    },
  ),
  Scenario(
    'shift_edit',
    typicalBook,
    action: (t) async {
      final b = typicalBook();
      final shift = b.shifts.firstWhere((s) => s.note == 'Sprint review');
      open(t, (ctx) => openShiftEditor(ctx, shift: shift));
      await t.pumpAndSettle();
    },
  ),
  Scenario(
    'job_edit',
    typicalBook,
    action: (t) async {
      final job = typicalBook().job('j2');
      open(t, (ctx) => openJobEditor(ctx, job: job));
      await t.pumpAndSettle();
    },
  ),
  Scenario('plan_empty', empty, action: tab(planIcon)),
  Scenario('plan_fits', typicalBook, action: tab(planIcon)),
  Scenario('plan_over', heavyBook, action: tab(planIcon)),
  Scenario('plan_used_up', overBook, action: tab(planIcon)),
  Scenario('settings_typical', typicalBook, action: tab(settingsIcon)),
  Scenario('settings_changed', overBook, action: tab(settingsIcon)),
  Scenario(
    'how_it_counts',
    typicalBook,
    action: (t) async {
      await tab(settingsIcon)(t);
      final ctx = t.element(find.byType(SettingsPage));
      // ignore: unawaited_futures
      Navigator.of(ctx)
          .push(CupertinoPageRoute<void>(builder: (_) => const HowPage()));
      await t.pumpAndSettle();
    },
  ),
];

Future<void> pumpScenario(
  WidgetTester t,
  Scenario s, {
  required Device device,
  required Brightness brightness,
  required double scale,
  Locale locale = const Locale('en'),
}) async {
  await loadTestFonts();
  t.view.physicalSize = device.size * dpr;
  t.view.devicePixelRatio = dpr;
  t.view.padding = FakeViewPadding(
    top: device.top * dpr,
    bottom: device.bottom * dpr,
  );
  t.platformDispatcher.platformBrightnessTestValue = brightness;
  t.platformDispatcher.textScaleFactorTestValue = scale;
  addTearDown(t.view.reset);
  addTearDown(t.platformDispatcher.clearAllTestValues);
  final state = AppState(MemoryStorage(), book: s.book(), now: () => demoToday)
    ..loadFailed = s.loadFailed;
  await t.pumpWidget(HalfdayApp(state: state, locale: locale));
  await t.pumpAndSettle();
  await s.action?.call(t);
}

/// Only these scenarios run with `--dart-define=ONLY=a,b` (quick iteration).
const only = String.fromEnvironment('ONLY');

void main() {
  final picked = only.isEmpty ? null : only.split(',').toSet();
  for (final s in scenarios) {
    if (picked != null && !picked.contains(s.name)) continue;
    for (final device in [small, large]) {
      for (final brightness in Brightness.values) {
        for (final scale in [1.0, 2.0]) {
          final variant =
              '${device.name}_${brightness.name}_${scale.toStringAsFixed(0)}x';
          testWidgets('${s.name} $variant', (t) async {
            await pumpScenario(
              t,
              s,
              device: device,
              brightness: brightness,
              scale: scale,
            );
            await expectLater(
              find.byType(HalfdayApp),
              matchesGoldenFile('goldens/${s.name}_$variant.png'),
            );
          });
        }
      }
    }
  }

  // Longest translations at the tightest size.
  for (final locale in ['de', 'tr']) {
    for (final name in [
      'overview_typical',
      'shifts_typical',
      'shift_edit',
      'plan_over',
      'settings_typical',
    ]) {
      if (picked != null && !picked.contains(name)) continue;
      testWidgets('$name $locale small 2x', (t) async {
        final s = scenarios.firstWhere((x) => x.name == name);
        await pumpScenario(
          t,
          s,
          device: small,
          brightness: Brightness.light,
          scale: 2,
          locale: Locale(locale),
        );
        await expectLater(
          find.byType(HalfdayApp),
          matchesGoldenFile('goldens/${name}_${locale}_small_light_2x.png'),
        );
      });
    }
  }
}
