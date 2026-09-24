import 'package:flutter/cupertino.dart';

import '../model/board.dart';
import '../state/app_state.dart';
import 'flat_edit_page.dart';
import 'flat_page.dart';
import 'format.dart';
import 'widgets.dart';

/// Sections run from the flats furthest along to the newest, so answers,
/// applications and viewings come first. Declined flats sit at the end.
const sectionOrder = [
  Stage.accepted,
  Stage.applied,
  Stage.viewing,
  Stage.messaged,
  Stage.interested,
  Stage.declined,
];

class FlatsPage extends StatelessWidget {
  const FlatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final board = AppScope.of(context).board;
    final l = context.l;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(l.tabFlats),
            trailing: board.isEmpty
                ? null
                : AddButton(
                    label: l.addFlat,
                    onPressed: () => openFlatEditor(context),
                  ),
          ),
          const SliverToBoxAdapter(child: ProblemBanner()),
          if (board.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyState(
                icon: CupertinoIcons.house,
                title: l.emptyFlatsTitle,
                body: l.emptyFlatsBody,
                primaryLabel: l.addFlat,
                onPrimary: () => openFlatEditor(context),
              ),
            )
          else
            SliverSafeArea(
              top: false,
              sliver: SliverList.list(
                children: [
                  for (final stage in sectionOrder)
                    if (board.inStage(stage) case final flats
                        when flats.isNotEmpty)
                      CupertinoListSection.insetGrouped(
                        header: Text(stageName(l, stage)),
                        children: [for (final f in flats) FlatTile(flat: f)],
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

/// One flat in a list: title, then the viewing time (in the Viewing
/// section) and warm rent, size and district.
class FlatTile extends StatelessWidget {
  const FlatTile({super.key, required this.flat, this.previousTitle});
  final Flat flat;
  final String? previousTitle;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final l = context.l;
    final f = flat;
    final secondary = CupertinoColors.secondaryLabel.resolveFrom(context);

    final parts = <InlineSpan>[];
    void add(String text, [TextStyle? style]) {
      if (parts.isNotEmpty) parts.add(const TextSpan(text: '  ·  '));
      parts.add(TextSpan(text: text, style: style));
    }

    if (f.stage == Stage.viewing) {
      final upcoming = f.viewing != null && !f.viewing!.isBefore(state.now());
      add(
        stageLine(
          l,
          f,
          state.now(),
          use24h: MediaQuery.alwaysUse24HourFormatOf(context),
        ),
        upcoming ? TextStyle(color: accent.resolveFrom(context)) : null,
      );
    }
    if (f.warmCents case final w?) {
      add(l.warmShort(money(l, w)), const TextStyle(fontFeatures: tabular));
    }
    if (f.sizeSqm case final s?) {
      add(
        l.sizeShort(sizeNumber(l, s)),
        const TextStyle(fontFeatures: tabular),
      );
    }
    if (f.district.isNotEmpty) add(f.district);
    if (parts.isEmpty) add(sourceName(l, f.source));

    return CupertinoListTile(
      padding: tilePadding,
      title: RowText(
        f.title,
        maxLines: 3,
        color: f.stage == Stage.declined ? secondary : null,
      ),
      subtitle: Text.rich(
        TextSpan(children: parts),
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const CupertinoListTileChevron(),
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute<void>(
          builder: (_) => FlatPage(
            flatId: f.id,
            previousTitle: previousTitle ?? l.tabFlats,
          ),
        ),
      ),
    );
  }
}
