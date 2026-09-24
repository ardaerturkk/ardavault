import 'package:flutter/cupertino.dart';

import '../model/content.dart';
import '../state/app_state.dart';
import 'names.dart';
import 'situation_page.dart';
import 'widgets.dart';

IconData situationIcon(String id) => switch (id) {
  'basics' => CupertinoIcons.chat_bubble_2,
  'buergeramt' => CupertinoIcons.building_2_fill,
  'auslaenderbehoerde' => CupertinoIcons.globe,
  'bank' => CupertinoIcons.creditcard,
  'krankenkasse' => CupertinoIcons.heart,
  'arztpraxis' => CupertinoIcons.bandage,
  'vermieter' => CupertinoIcons.house,
  'hochschule' => CupertinoIcons.book,
  _ => CupertinoIcons.text_bubble,
};

class SituationsPage extends StatelessWidget {
  const SituationsPage({super.key, required this.onOpenMe});

  /// Switches to the My Details tab.
  final VoidCallback onOpenMe;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final l = context.l;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(largeTitle: Text(l.tabSituations)),
          const SliverToBoxAdapter(child: ProblemBanner()),
          SliverSafeArea(
            top: false,
            sliver: SliverList.list(
              children: [
                if (!state.book.hasProfile) _StartSection(onStart: onOpenMe),
                CupertinoListSection.insetGrouped(
                  footer: FooterText(l.situationsFooter),
                  children: [
                    for (final s in situations) SituationTile(situation: s),
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
}

/// Teaches the first action: fill in your details once.
class _StartSection extends StatelessWidget {
  const _StartSection({required this.onStart});
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final theme = CupertinoTheme.of(context).textTheme;
    return CupertinoListSection.insetGrouped(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l.startTitle,
                style: theme.textStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                l.startBody,
                style: theme.textStyle.copyWith(
                  fontSize: 15,
                  color: CupertinoColors.secondaryLabel.resolveFrom(context),
                ),
              ),
              const SizedBox(height: 16),
              PrimaryButton(onPressed: onStart, label: l.startButton),
            ],
          ),
        ),
      ],
    );
  }
}

class SituationTile extends StatelessWidget {
  const SituationTile({super.key, required this.situation});
  final Situation situation;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final appt = AppScope.of(context).book.visit(situation.id).appointment;
    final secondary = CupertinoColors.secondaryLabel.resolveFrom(context);
    return CupertinoListTile(
      padding: tilePadding,
      leading: Icon(
        situationIcon(situation.id),
        color: accent.resolveFrom(context),
      ),
      title: RowText(situation.german),
      subtitle: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: situation.purpose(l.localeName)),
            if (appt != null) ...[
              const TextSpan(text: '\n'),
              TextSpan(
                text: l.appointmentOn(
                  appointmentText(
                    l,
                    appt,
                    use24h: MediaQuery.alwaysUse24HourFormatOf(context),
                  ),
                ),
                style: TextStyle(color: accent.resolveFrom(context)),
              ),
            ],
          ],
        ),
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: secondary, fontSize: 15),
      ),
      trailing: const CupertinoListTileChevron(),
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute<void>(
          builder: (_) => SituationPage(
            situationId: situation.id,
            previousTitle: l.tabSituations,
          ),
        ),
      ),
    );
  }
}
