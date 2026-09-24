@Tags(['golden'])
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sagbar/app.dart';
import 'package:sagbar/model/book.dart';
import 'package:sagbar/model/content.dart';
import 'package:sagbar/state/app_state.dart';
import 'package:sagbar/state/storage.dart';
import 'package:sagbar/ui/card_page.dart';
import 'package:sagbar/ui/field_edit_page.dart';
import 'package:sagbar/ui/line_edit_page.dart';
import 'package:sagbar/ui/me_page.dart';
import 'package:sagbar/ui/situation_page.dart';
import 'package:sagbar/ui/situations_page.dart';

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

BuildContext home(WidgetTester t) => t.element(find.byType(SituationsPage));

Future<void> openMeTab(WidgetTester t) async {
  await t.tap(find.byIcon(CupertinoIcons.person_crop_circle).first);
  await t.pumpAndSettle();
}

Action openSituation(String id) => (t) async {
  // The route completes on pop; the golden is taken while it is open.
  // ignore: unawaited_futures
  Navigator.of(home(t)).push(
    CupertinoPageRoute<void>(
      builder: (_) =>
          SituationPage(situationId: id, previousTitle: 'Situations'),
    ),
  );
  await t.pumpAndSettle();
};

Action openCard(String id, int index) => (t) async {
  // ignore: unawaited_futures
  openCards(home(t), situation: situationById(id)!, index: index);
  await t.pumpAndSettle();
};

class Scenario {
  const Scenario(this.name, this.book, {this.action, this.loadFailed = false});
  final String name;
  final Book Function() book;
  final Action? action;
  final bool loadFailed;
}

Book empty() => const Book();

Book vermieterHidden() {
  var b = typicalBook();
  for (final l in situationById('vermieter')!.lines) {
    b = b.hide(l.id);
  }
  return b;
}

final scenarios = <Scenario>[
  const Scenario('situations_empty', empty),
  const Scenario('situations_typical', typicalBook),
  const Scenario('situations_error', empty, loadFailed: true),
  const Scenario('me_empty', empty, action: openMeTab),
  const Scenario('me_typical', typicalBook, action: openMeTab),
  const Scenario('me_heavy', heavyBook, action: openMeTab),
  Scenario(
    'situation_typical',
    typicalBook,
    action: openSituation('buergeramt'),
  ),
  Scenario(
    'situation_partial',
    partialBook,
    action: openSituation('buergeramt'),
  ),
  Scenario('situation_heavy', heavyBook, action: openSituation('buergeramt')),
  Scenario(
    'situation_nolines',
    vermieterHidden,
    action: openSituation('vermieter'),
  ),
  Scenario('card_typical', typicalBook, action: openCard('buergeramt', 3)),
  Scenario(
    'card_missing',
    partialBook,
    action: openCard('auslaenderbehoerde', 1),
  ),
  Scenario('card_heavy', heavyBook, action: openCard('buergeramt', 6)),
  Scenario(
    'line_menu',
    typicalBook,
    action: (t) async {
      await openSituation('bank')(t);
      await t.ensureVisible(find.byType(LineTile).at(1));
      await t.pumpAndSettle();
      await t.longPress(find.byType(LineTile).at(1));
      await t.pumpAndSettle();
    },
  ),
  Scenario(
    'line_edit',
    heavyBook,
    action: (t) async {
      final b = heavyBook();
      // ignore: unawaited_futures
      openLineEditor(
        home(t),
        situation: situationById('buergeramt')!,
        line: b.custom.first,
      );
      await t.pumpAndSettle();
    },
  ),
  Scenario(
    'field_edit',
    typicalBook,
    action: (t) async {
      await openMeTab(t);
      // ignore: unawaited_futures
      editDetail(t.element(find.byType(MePage)), Slot.address);
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
  await t.pumpWidget(SagbarApp(state: state, locale: locale));
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
              find.byType(SagbarApp),
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
      'situations_empty',
      'situation_typical',
      'me_typical',
      'card_typical',
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
          find.byType(SagbarApp),
          matchesGoldenFile('goldens/${name}_${locale}_small_light_2x.png'),
        );
      });
    }
  }
}
