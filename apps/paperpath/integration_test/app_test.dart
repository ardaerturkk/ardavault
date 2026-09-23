import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:paperpath/app.dart';
import 'package:paperpath/l10n/app_localizations.dart';
import 'package:paperpath/model/plan.dart';
import 'package:paperpath/state/app_state.dart';
import 'package:paperpath/state/storage.dart';
import 'package:paperpath/ui/names.dart';

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
    state.update(state.plan.addDoc((id) => Doc(id: id, name: 'Probe')));
    await state.flush();
    final again = await AppState.load(storage);
    expect(again.plan.docs.any((d) => d.name == 'Probe'), isTrue);
    again.update(const Plan());
    await again.flush();
  });

  testWidgets('screenshots and the main flow', (t) async {
    final state = AppState(
      MemoryStorage(),
      plan: typicalPlan(),
      now: () => demoToday,
    );
    await t.pumpWidget(
      PaperpathApp(state: state, locale: const Locale(locale)),
    );
    await t.pumpAndSettle();
    final l = lookupAppLocalizations(const Locale(locale));

    await shot(t, '1_steps');

    await t.tap(find.text(stepTitle(l, state.plan.step('s:anmeldung')!)));
    await shot(t, '2_step_ready');

    await t.tap(find.text(l.markDone));
    await t.pumpAndSettle();
    expect(state.plan.doc('d:registration')!.have, isTrue);
    await shot(t, '3_step_done');

    await t.pageBack();
    await t.pumpAndSettle();
    await t.tap(find.byIcon(CupertinoIcons.doc_on_doc).first);
    await shot(t, '4_documents');

    await t.tap(find.text(docName(l, state.plan.doc('d:registration')!)));
    await shot(t, '5_document');
  });
}
