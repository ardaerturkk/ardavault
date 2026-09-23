import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../model/plan.dart';
import '../state/app_state.dart';
import 'document_edit_page.dart';
import 'names.dart';
import 'step_page.dart';
import 'widgets.dart';

class DocumentPage extends StatelessWidget {
  const DocumentPage({super.key, required this.docId, this.previousTitle});
  final String docId;

  /// Label for the back button, like "Documents".
  final String? previousTitle;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final plan = state.plan;
    final l = context.l;
    final doc = plan.doc(docId);
    if (doc == null) {
      leaveDeletedPage(context);
      return const CupertinoPageScaffold(child: SizedBox.shrink());
    }
    final theme = CupertinoTheme.of(context).textTheme;
    final secondary = CupertinoColors.secondaryLabel.resolveFrom(context);
    final neededBy = plan.stepsNeeding(doc.id);
    final from = plan.stepsProducing(doc.id);

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: previousTitle,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => openDocumentEditor(context, doc: doc),
          child: Text(l.edit),
        ),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Text(
                docName(l, doc),
                style: theme.navLargeTitleTextStyle.copyWith(fontSize: 28),
              ),
            ),
            if (doc.note.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: Text(
                  doc.note,
                  style: theme.textStyle.copyWith(
                    fontSize: 15,
                    color: secondary,
                  ),
                ),
              ),
            CupertinoListSection.insetGrouped(
              children: [
                MergeSemantics(
                  child: CupertinoListTile(
                    padding: tilePadding,
                    leading: docIcon(context, doc.have),
                    title: RowText(l.inHand, maxLines: 2),
                    trailing: CupertinoSwitch(
                      value: doc.have,
                      activeTrackColor: accent,
                      onChanged: (v) {
                        unawaited(HapticFeedback.selectionClick());
                        state.update(plan.withDoc(doc.copyWith(have: v)));
                      },
                    ),
                  ),
                ),
              ],
            ),
            if (from.isNotEmpty)
              CupertinoListSection.insetGrouped(
                header: Text(l.comesFromHeader),
                children: [for (final s in from) _StepLink(step: s)],
              ),
            if (neededBy.isNotEmpty)
              CupertinoListSection.insetGrouped(
                header: Text(l.neededFor),
                children: [for (final s in neededBy) _StepLink(step: s)],
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _StepLink extends StatelessWidget {
  const _StepLink({required this.step});
  final PathStep step;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final done = step.done;
    return CupertinoListTile(
      padding: tilePadding,
      leading: stepStatusIcon(
        context,
        AppScope.of(context).plan.statusOf(step),
      ),
      title: RowText(
        stepTitle(l, step),
        color: done
            ? CupertinoColors.secondaryLabel.resolveFrom(context)
            : null,
      ),
      trailing: const CupertinoListTileChevron(),
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute<void>(
          builder: (_) =>
              StepPage(stepId: step.id, previousTitle: l.tabDocuments),
        ),
      ),
    );
  }
}
