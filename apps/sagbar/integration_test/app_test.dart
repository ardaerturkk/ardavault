import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sagbar/app.dart';
import 'package:sagbar/l10n/app_localizations.dart';
import 'package:sagbar/model/content.dart';
import 'package:sagbar/state/app_state.dart';
import 'package:sagbar/state/storage.dart';

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
    final before = state.book;
    state.update(state.book.withDetail(Slot.phone, 'Probe 123'));
    await state.flush();
    final again = await AppState.load(storage);
    expect(again.book.detail(Slot.phone), 'Probe 123');
    again.update(before);
    await again.flush();
  });

  testWidgets('screenshots and the main flow', (t) async {
    final state = AppState(
      MemoryStorage(),
      book: typicalBook(),
      now: () => demoToday,
    );
    await t.pumpWidget(SagbarApp(state: state, locale: const Locale(locale)));
    await t.pumpAndSettle();
    final l = lookupAppLocalizations(const Locale(locale));

    await shot(t, '1_situations');

    await t.tap(find.text('Bürgeramt'));
    await shot(t, '2_situation');

    await t.tap(find.text(l.showCards));
    await t.pumpAndSettle();
    expect(find.text(l.cardOf(1, 8)), findsOneWidget);
    await t.tap(find.bySemanticsLabel(l.nextLine));
    await t.pumpAndSettle();
    await t.tap(find.bySemanticsLabel(l.nextLine));
    await t.pumpAndSettle();
    await t.tap(find.bySemanticsLabel(l.nextLine));
    await shot(t, '3_card');

    await t.tap(find.text(l.done));
    await t.pumpAndSettle();
    await t.pageBack();
    await t.pumpAndSettle();
    await t.tap(find.byIcon(CupertinoIcons.person_crop_circle).first);
    await shot(t, '4_details');
  });
}
