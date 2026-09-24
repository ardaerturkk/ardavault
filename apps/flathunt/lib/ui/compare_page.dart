import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../model/board.dart';
import '../state/app_state.dart';
import 'flat_edit_page.dart';
import 'flat_page.dart';
import 'format.dart';
import 'widgets.dart';

class ComparePage extends StatefulWidget {
  const ComparePage({super.key, this.initialBy = CompareBy.month});

  /// For goldens: which comparison to show first.
  final CompareBy initialBy;

  @override
  State<ComparePage> createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
  late CompareBy _by = widget.initialBy;

  @override
  Widget build(BuildContext context) {
    final board = AppScope.of(context).board;
    final l = context.l;
    final (ranked, missing) = board.compare(_by);
    final nothing = ranked.isEmpty && missing.isEmpty;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(largeTitle: Text(l.tabCompare)),
          const SliverToBoxAdapter(child: ProblemBanner()),
          if (nothing)
            SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyState(
                icon: CupertinoIcons.chart_bar,
                title: l.compareEmptyTitle,
                body: l.compareEmptyBody,
                primaryLabel: l.addFlat,
                onPrimary: () => openFlatEditor(context),
              ),
            )
          else
            SliverSafeArea(
              top: false,
              sliver: SliverList.list(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                    child: SizedBox(
                      width: double.infinity,
                      child: CupertinoSlidingSegmentedControl<CompareBy>(
                        groupValue: _by,
                        children: {
                          CompareBy.month: _Segment(l.perMonthSeg),
                          CompareBy.sqm: _Segment(l.perSqmSeg),
                        },
                        onValueChanged: (v) {
                          if (v == null) return;
                          unawaited(HapticFeedback.selectionClick());
                          setState(() => _by = v);
                        },
                      ),
                    ),
                  ),
                  if (ranked.isNotEmpty)
                    CupertinoListSection.insetGrouped(
                      footer: FooterText(l.compareFooter),
                      children: [
                        for (final f in ranked)
                          _RankTile(flat: f, ranked: ranked, by: _by),
                      ],
                    ),
                  if (missing.isNotEmpty)
                    CupertinoListSection.insetGrouped(
                      header: Text(l.notCompared),
                      children: [
                        for (final f in missing)
                          CupertinoListTile(
                            padding: tilePadding,
                            title: RowText(f.title, maxLines: 3),
                            subtitle: Text(_missingText(l, f), maxLines: 3),
                            trailing: const CupertinoListTileChevron(),
                            onTap: () => _open(context, f),
                          ),
                      ],
                    ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _missingText(AppLocalizations l, Flat f) {
    final noWarm = f.warmCents == null;
    final noSize = f.sizeSqm == null;
    if (_by == CompareBy.sqm && noWarm && noSize) return l.missingBoth;
    if (noWarm) return l.missingWarm;
    return l.missingSize;
  }
}

void _open(BuildContext context, Flat f) => Navigator.of(context).push(
  CupertinoPageRoute<void>(
    builder: (_) => FlatPage(flatId: f.id, previousTitle: context.l.tabCompare),
  ),
);

class _Segment extends StatelessWidget {
  const _Segment(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: Text(text, textAlign: TextAlign.center, maxLines: 2),
  );
}

/// A flat in the comparison: the value, how much more than the cheapest,
/// and a thin bar in proportion to the most expensive.
class _RankTile extends StatelessWidget {
  const _RankTile({required this.flat, required this.ranked, required this.by});
  final Flat flat;
  final List<Flat> ranked;
  final CompareBy by;

  double _value(Flat f) => switch (by) {
    CompareBy.month => f.warmCents!.toDouble(),
    CompareBy.sqm => f.warmPerSqmCents!,
  };

  String _format(BuildContext context, double cents) => switch (by) {
    CompareBy.month => money(context.l, cents.round()),
    CompareBy.sqm => moneyExact(context.l, cents),
  };

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final value = _value(flat);
    final cheapest = _value(ranked.first);
    final most = _value(ranked.last);
    final first = identical(flat, ranked.first);
    final large = isLargeText(context);
    final accentColor = accent.resolveFrom(context);
    final valueText = Text(
      _format(context, value),
      maxLines: 1,
      style: TextStyle(
        fontFeatures: tabular,
        fontWeight: FontWeight.w600,
        color: first ? accentColor : CupertinoColors.label.resolveFrom(context),
      ),
    );
    // Round per m² differences to cents before deciding they are equal.
    final diff = (value - cheapest).round();
    final String relation = diff <= 0
        ? l.cheapest
        : l.moreThanCheapest(_format(context, diff.toDouble()));
    final info = [
      relation,
      stageName(l, flat.stage),
      if (flat.district.isNotEmpty) flat.district,
    ].join('  ·  ');
    final fraction = most <= 0 ? 1.0 : (value / most).clamp(0.04, 1.0);

    return CupertinoListTile(
      padding: tilePadding,
      title: large
          ? RowText(flat.title, maxLines: 3)
          : Row(
              children: [
                Expanded(child: RowText(flat.title, maxLines: 2)),
                const SizedBox(width: 12),
                valueText,
              ],
            ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (large) ...[valueText, const SizedBox(height: 2)],
          Text(info, maxLines: 3, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 8),
          ExcludeSemantics(
            child: FractionallySizedBox(
              widthFactor: fraction,
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: first
                      ? accentColor
                      : CupertinoColors.systemGrey3.resolveFrom(context),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          const SizedBox(height: 2),
        ],
      ),
      trailing: const CupertinoListTileChevron(),
      onTap: () => _open(context, flat),
    );
  }
}
