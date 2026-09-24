@Tags(['screenshots'])
library;

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flathunt/app.dart';
import 'package:flathunt/l10n/app_localizations.dart';
import 'package:flathunt/state/app_state.dart';
import 'package:flathunt/state/storage.dart';
import 'package:flathunt/ui/flat_page.dart';
import 'package:flathunt/ui/flats_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

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
      final lang = locale.split('-').first;
      final state = AppState(
        MemoryStorage(),
        board: typicalBoard(lang),
        now: () => demoToday,
      );
      await t.pumpWidget(
        RepaintBoundary(
          child: FlatboardApp(state: state, locale: Locale(lang)),
        ),
      );
      final l = lookupAppLocalizations(Locale(lang));
      final dir = '../../apps/flathunt/store/screenshots/$locale';
      await capture(t, '$dir/1_flats.png');

      final flatsCtx = t.element(find.byType(FlatsPage));
      // ignore: unawaited_futures
      Navigator.of(flatsCtx).push(
        CupertinoPageRoute<void>(
          builder: (_) => FlatPage(flatId: 'f1', previousTitle: l.tabFlats),
        ),
      );
      await capture(t, '$dir/2_flat.png');

      await t.scrollUntilVisible(
        find.text(l.checksHeader),
        300,
        scrollable: find.byType(Scrollable).last,
      );
      await t.drag(find.byType(Scrollable).last, const Offset(0, -200));
      await capture(t, '$dir/3_checks.png');

      await t.tap(find.byIcon(CupertinoIcons.chart_bar).first);
      await capture(t, '$dir/4_compare.png');

      await t.tap(find.text(l.perSqmSeg));
      await capture(t, '$dir/5_compare_sqm.png');
    });
  }
}
