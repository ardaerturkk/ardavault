import 'package:flutter/cupertino.dart';

import '../model/plan.dart';
import '../state/app_state.dart';
import 'document_edit_page.dart';
import 'document_page.dart';
import 'names.dart';
import 'widgets.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final plan = AppScope.of(context).plan;
    final l = context.l;
    final missing = [
      for (final d in plan.docs)
        if (!d.have) d,
    ];
    final have = [
      for (final d in plan.docs)
        if (d.have) d,
    ];
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(l.tabDocuments),
            trailing: plan.docs.isEmpty
                ? null
                : AddButton(
                    label: l.addDocument,
                    onPressed: () => openDocumentEditor(context),
                  ),
          ),
          const SliverToBoxAdapter(child: ProblemBanner()),
          if (plan.docs.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyState(
                icon: CupertinoIcons.doc_on_doc,
                title: l.emptyDocsTitle,
                body: l.emptyDocsBody,
                primaryLabel: l.addDocument,
                onPrimary: () => openDocumentEditor(context),
              ),
            )
          else
            SliverSafeArea(
              top: false,
              sliver: SliverList.list(
                children: [
                  if (missing.isNotEmpty)
                    CupertinoListSection.insetGrouped(
                      header: Text(l.missing),
                      children: [for (final d in missing) DocTile(doc: d)],
                    ),
                  if (have.isNotEmpty)
                    CupertinoListSection.insetGrouped(
                      header: Text(l.inHand),
                      children: [for (final d in have) DocTile(doc: d)],
                    ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class DocTile extends StatelessWidget {
  const DocTile({super.key, required this.doc});
  final Doc doc;

  @override
  Widget build(BuildContext context) {
    final plan = AppScope.of(context).plan;
    final l = context.l;
    final from = plan.stepsProducing(doc.id);
    final openNeeds = [
      for (final s in plan.stepsNeeding(doc.id))
        if (!s.done) s,
    ];
    final subtitle = !doc.have && from.isNotEmpty
        ? l.comesFrom(stepTitle(l, from.first))
        : l.neededForCount(openNeeds.length);
    return CupertinoListTile(
      padding: tilePadding,
      leading: docIcon(context, doc.have),
      title: RowText(docName(l, doc)),
      subtitle: Text(subtitle, maxLines: 3, overflow: TextOverflow.ellipsis),
      trailing: const CupertinoListTileChevron(),
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute<void>(
          builder: (_) =>
              DocumentPage(docId: doc.id, previousTitle: l.tabDocuments),
        ),
      ),
    );
  }
}
