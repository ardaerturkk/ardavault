@Tags(['golden'])
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paperpath/app.dart';
import 'package:paperpath/model/plan.dart';
import 'package:paperpath/state/app_state.dart';
import 'package:paperpath/state/storage.dart';
import 'package:paperpath/ui/document_page.dart';
import 'package:paperpath/ui/documents_page.dart';
import 'package:paperpath/ui/step_edit_page.dart';
import 'package:paperpath/ui/step_page.dart';
import 'package:paperpath/ui/steps_page.dart';

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

Future<void> push(WidgetTester t, Widget page, {bool docsTab = false}) async {
  final anchor = docsTab ? find.byType(DocumentsPage) : find.byType(StepsPage);
  await Navigator.of(t.element(anchor))
      .push(CupertinoPageRoute<void>(builder: (_) => page));
}

Future<void> openDocsTab(WidgetTester t) async {
  await t.tap(find.byIcon(CupertinoIcons.doc_on_doc).first);
  await t.pumpAndSettle();
}

class Scenario {
  const Scenario(this.name, this.plan, {this.action, this.loadFailed = false});
  final String name;
  final Plan Function() plan;
  final Action? action;
  final bool loadFailed;
}

final scenarios = <Scenario>[
  Scenario('steps_empty', () => const Plan()),
  const Scenario('steps_typical', typicalPlan),
  const Scenario('steps_heavy', heavyPlan),
  const Scenario('steps_finished', finishedPlan),
  Scenario('steps_error', () => const Plan(), loadFailed: true),
  Scenario(
    'move_in_sheet',
    () => const Plan(),
    action: (t) async {
      await t.tap(find.text('Add Germany Starter Steps'));
      await t.pumpAndSettle();
    },
  ),
  Scenario(
    'step_ready',
    typicalPlan,
    action: (t) async {
      unawaitedPush(t, const StepPage(stepId: 's:anmeldung'));
      await t.pumpAndSettle();
    },
  ),
  Scenario(
    'step_waiting',
    typicalPlan,
    action: (t) async {
      unawaitedPush(t, const StepPage(stepId: 's:residencePermit'));
      await t.pumpAndSettle();
    },
  ),
  Scenario(
    'step_done',
    typicalPlan,
    action: (t) async {
      unawaitedPush(t, const StepPage(stepId: 's:signLease'));
      await t.pumpAndSettle();
    },
  ),
  Scenario(
    'step_edit',
    typicalPlan,
    action: (t) async {
      final plan = typicalPlan();
      final ctx = t.element(find.byType(StepsPage));
      // Not awaited: the editor route completes only when it closes.
      // ignore: unawaited_futures
      openStepEditor(ctx, step: plan.step('s:bank'));
      await t.pumpAndSettle();
    },
  ),
  Scenario('docs_empty', () => const Plan(), action: openDocsTab),
  const Scenario('docs_typical', typicalPlan, action: openDocsTab),
  Scenario(
    'doc_detail',
    typicalPlan,
    action: (t) async {
      await openDocsTab(t);
      unawaitedPush(
        t,
        const DocumentPage(docId: 'd:registration'),
        docsTab: true,
      );
      await t.pumpAndSettle();
    },
  ),
];

void unawaitedPush(WidgetTester t, Widget page, {bool docsTab = false}) {
  // The route future completes on pop; the golden is taken while it is open.
  // ignore: unawaited_futures
  push(t, page, docsTab: docsTab);
}

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
  final state = AppState(MemoryStorage(), plan: s.plan(), now: () => demoToday)
    ..loadFailed = s.loadFailed;
  await t.pumpWidget(PaperpathApp(state: state, locale: locale));
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
              find.byType(PaperpathApp),
              matchesGoldenFile('goldens/${s.name}_$variant.png'),
            );
          });
        }
      }
    }
  }

  // Longest translations at the tightest size.
  for (final locale in ['de', 'tr']) {
    for (final name in ['steps_typical', 'step_waiting', 'docs_typical']) {
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
          find.byType(PaperpathApp),
          matchesGoldenFile('goldens/${name}_${locale}_small_light_2x.png'),
        );
      });
    }
  }
}
