import 'package:flathunt/app.dart';
import 'package:flathunt/l10n/app_localizations.dart';
import 'package:flathunt/model/board.dart';
import 'package:flathunt/state/app_state.dart';
import 'package:flathunt/state/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
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
    final now = DateTime.now();
    state.update(
      state.board.add(
        (id) => Flat(id: id, title: 'Probe', stageSince: now, createdAt: now),
      ),
    );
    await state.flush();
    final again = await AppState.load(storage);
    expect(again.board.flats.any((f) => f.title == 'Probe'), isTrue);
    again.update(const Board());
    await again.flush();
  });

  testWidgets('screenshots and the main flow', (t) async {
    final state = AppState(
      MemoryStorage(),
      // The locale comes from --dart-define; it is only 'en' by default.
      // ignore: avoid_redundant_argument_values
      board: typicalBoard(locale),
      now: () => demoToday,
    );
    await t.pumpWidget(
      FlatboardApp(state: state, locale: const Locale(locale)),
    );
    await t.pumpAndSettle();
    final l = lookupAppLocalizations(const Locale(locale));

    await shot(t, '1_flats');

    await t.tap(find.text(state.board.flat('f1')!.title));
    await shot(t, '2_flat');

    await t.tap(find.text(l.actionApplied));
    await t.pumpAndSettle();
    expect(state.board.flat('f1')!.stage, Stage.applied);
    await shot(t, '3_applied');

    await t.pageBack();
    await t.pumpAndSettle();
    await t.tap(find.byIcon(CupertinoIcons.chart_bar).first);
    await shot(t, '4_compare');

    await t.tap(find.text(l.perSqmSeg));
    await shot(t, '5_compare_sqm');
  });
}
