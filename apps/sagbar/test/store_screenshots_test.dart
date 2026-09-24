@Tags(['screenshots'])
library;

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sagbar/app.dart';
import 'package:sagbar/model/content.dart';
import 'package:sagbar/state/app_state.dart';
import 'package:sagbar/state/storage.dart';
import 'package:sagbar/ui/card_page.dart';
import 'package:sagbar/ui/situation_page.dart';
import 'package:sagbar/ui/situations_page.dart';

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
      await t.pumpWidget(
        RepaintBoundary(
          child: SagbarApp(
            state: state,
            locale: Locale(locale.split('-').first),
          ),
        ),
      );
      final dir = '../../apps/sagbar/store/screenshots/$locale';
      final home = t.element(find.byType(SituationsPage));

      // ignore: unawaited_futures
      Navigator.of(home).push(
        CupertinoPageRoute<void>(
          builder: (_) => const SituationPage(situationId: 'buergeramt'),
        ),
      );
      await capture(t, '$dir/1_situation.png');

      // ignore: unawaited_futures
      openCards(home, situation: situationById('buergeramt')!, index: 3);
      await capture(t, '$dir/2_card.png');
      Navigator.of(t.element(find.byType(CardPage))).pop();
      await t.pumpAndSettle();
      Navigator.of(home).pop();
      await capture(t, '$dir/3_situations.png');

      // ignore: unawaited_futures
      Navigator.of(home).push(
        CupertinoPageRoute<void>(
          builder: (_) => const SituationPage(situationId: 'krankenkasse'),
        ),
      );
      await capture(t, '$dir/4_krankenkasse.png');
      Navigator.of(home).pop();
      await t.pumpAndSettle();

      await t.tap(find.byIcon(CupertinoIcons.person_crop_circle).first);
      await capture(t, '$dir/5_details.png');
    });
  }
}
