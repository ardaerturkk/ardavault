@Tags(['golden'])
library;

import 'package:flathunt/app.dart';
import 'package:flathunt/l10n/app_localizations.dart';
import 'package:flathunt/model/board.dart';
import 'package:flathunt/state/app_state.dart';
import 'package:flathunt/state/storage.dart';
import 'package:flathunt/ui/flat_edit_page.dart';
import 'package:flathunt/ui/flat_page.dart';
import 'package:flathunt/ui/flats_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

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

Future<void> openCompareTab(WidgetTester t) async {
  await t.tap(find.byIcon(CupertinoIcons.chart_bar).first);
  await t.pumpAndSettle();
}

/// Opens a flat's page on the Flats tab. The route future completes on
/// pop; the golden is taken while it is open.
Action openFlat(String id) => (t) async {
  // ignore: unawaited_futures
  Navigator.of(t.element(find.byType(FlatsPage))).push(
    CupertinoPageRoute<void>(
      builder: (c) =>
          FlatPage(flatId: id, previousTitle: AppLocalizations.of(c).tabFlats),
    ),
  );
  await t.pumpAndSettle();
};

Action openEditor(String? id) => (t) async {
  final ctx = t.element(find.byType(FlatsPage));
  final flat = id == null ? null : AppScopeFinder.board(t).flat(id);
  // ignore: unawaited_futures
  openFlatEditor(ctx, flat: flat);
  await t.pumpAndSettle();
};

class AppScopeFinder {
  static Board board(WidgetTester t) =>
      AppScope.read(t.element(find.byType(FlatsPage))).board;
}

class Scenario {
  const Scenario(this.name, this.board, {this.action, this.loadFailed = false});
  final String name;
  final Board Function(String locale) board;
  final Action? action;
  final bool loadFailed;
}

Board _empty(String _) => const Board();
Board _heavy(String _) => heavyBoard();

final scenarios = <Scenario>[
  const Scenario('flats_empty', _empty),
  const Scenario('flats_typical', typicalBoard),
  const Scenario('flats_heavy', _heavy),
  const Scenario('flats_error', _empty, loadFailed: true),
  Scenario('flat_viewing', typicalBoard, action: openFlat('f1')),
  Scenario('flat_applied', typicalBoard, action: openFlat('f2')),
  Scenario('flat_bare', typicalBoard, action: openFlat('f8')),
  Scenario(
    'flat_stage_sheet',
    typicalBoard,
    action: (t) async {
      await openFlat('f3')(t);
      await t.tap(find.text('Stage'));
      await t.pumpAndSettle();
    },
  ),
  Scenario(
    'flat_viewing_picker',
    typicalBoard,
    action: (t) async {
      await openFlat('f3')(t);
      await t.tap(find.text('Schedule Viewing'));
      await t.pumpAndSettle();
    },
  ),
  Scenario('edit_new', _empty, action: openEditor(null)),
  Scenario('edit_existing', typicalBoard, action: openEditor('f1')),
  Scenario(
    'edit_invalid',
    typicalBoard,
    action: (t) async {
      await openEditor('f3')(t);
      await t.enterText(find.text('395'), '39x');
      await t.pumpAndSettle();
    },
  ),
  const Scenario('compare_empty', _empty, action: openCompareTab),
  const Scenario('compare_month', typicalBoard, action: openCompareTab),
  Scenario(
    'compare_sqm',
    typicalBoard,
    action: (t) async {
      await openCompareTab(t);
      // Tap the second segment: the right half of the control.
      final box = t.getRect(
        find.byType(CupertinoSlidingSegmentedControl<CompareBy>),
      );
      await t.tapAt(Offset(box.right - box.width / 4, box.center.dy));
      await t.pumpAndSettle();
    },
  ),
  const Scenario('compare_heavy', _heavy, action: openCompareTab),
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
  final board = s.board(locale.languageCode);
  final state = AppState(MemoryStorage(), board: board, now: () => demoToday)
    ..loadFailed = s.loadFailed;
  await t.pumpWidget(FlatboardApp(state: state, locale: locale));
  await t.pumpAndSettle();
  await s.action?.call(t);
}

void main() {
  for (final s in scenarios) {
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
              find.byType(FlatboardApp),
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
      'flats_typical',
      'flat_viewing',
      'edit_existing',
      'compare_month',
    ]) {
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
          find.byType(FlatboardApp),
          matchesGoldenFile('goldens/${name}_${locale}_small_light_2x.png'),
        );
      });
    }
  }
}
