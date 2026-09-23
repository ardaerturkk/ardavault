@Tags(['screenshots'])
library;

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paperpath/app.dart';
import 'package:paperpath/state/app_state.dart';
import 'package:paperpath/state/storage.dart';
import 'package:paperpath/ui/document_page.dart';
import 'package:paperpath/ui/documents_page.dart';
import 'package:paperpath/ui/step_page.dart';
import 'package:paperpath/ui/steps_page.dart';

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
        plan: typicalPlan(),
        now: () => demoToday,
      );
      await t.pumpWidget(
        RepaintBoundary(
          child: PaperpathApp(
            state: state,
            locale: Locale(locale.split('-').first),
          ),
        ),
      );
      final dir = '../../apps/paperpath/store/screenshots/$locale';
      await capture(t, '$dir/1_steps.png');

      final stepsCtx = t.element(find.byType(StepsPage));
      // ignore: unawaited_futures
      Navigator.of(stepsCtx).push(
        CupertinoPageRoute<void>(
          builder: (_) => const StepPage(stepId: 's:anmeldung'),
        ),
      );
      await capture(t, '$dir/2_step.png');

      // ignore: unawaited_futures
      Navigator.of(stepsCtx).push(
        CupertinoPageRoute<void>(
          builder: (_) => const StepPage(stepId: 's:residencePermit'),
        ),
      );
      await capture(t, '$dir/3_waiting.png');

      await t.tap(find.byIcon(CupertinoIcons.doc_on_doc).first);
      await capture(t, '$dir/4_documents.png');

      // ignore: unawaited_futures
      Navigator.of(t.element(find.byType(DocumentsPage))).push(
        CupertinoPageRoute<void>(
          builder: (_) => const DocumentPage(docId: 'd:registration'),
        ),
      );
      await capture(t, '$dir/5_document.png');
    });
  }
}
