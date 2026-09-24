import 'package:flutter/cupertino.dart';

import '../model/book.dart';
import '../model/quota.dart';
import '../state/app_state.dart';
import 'format.dart';
import 'shift_edit_page.dart';
import 'widgets.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final book = state.book;
    final l = context.l;
    final today = state.today;
    final settings = book.settings;
    final usage = yearUsage(book, today.year, today: today);
    final week = weekMinutes(book, today);
    final weekOver = week > settings.weeklyHourLimit * 60;
    final red = CupertinoColors.systemRed.resolveFrom(context);
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(l.tabOverview),
            trailing: AddButton(
              label: l.logShift,
              onPressed: () => openShiftEditor(context),
            ),
          ),
          const SliverToBoxAdapter(child: ProblemBanner()),
          SliverSafeArea(
            top: false,
            sliver: SliverList.list(
              children: [
                CupertinoListSection.insetGrouped(
                  footer: FooterText(
                    book.isEmpty
                        ? l.overviewFirstHint(
                            hoursText(l, settings.halfDayMaxMinutes),
                          )
                        : (settings.fullDayLimit == Settings.typicalFullDayLimit
                              ? l.heroFooter
                              : l.customLimitFooter)(
                            numberText(l, settings.fullDayLimit),
                            numberText(l, settings.fullDayLimit * 2),
                          ),
                  ),
                  children: [_Hero(usage: usage)],
                ),
                if (!book.isEmpty)
                  CupertinoListSection.insetGrouped(
                    header: Text(l.sectionThisWeek),
                    footer: FooterText(l.weekFooter),
                    children: [
                      ValueTile(
                        leading: Icon(
                          CupertinoIcons.clock,
                          color: accent.resolveFrom(context),
                        ),
                        label: l.hoursThisWeek,
                        value: l.ofValue(
                          numberText(l, week / 60),
                          wholeHoursText(l, settings.weeklyHourLimit),
                        ),
                        valueColor: weekOver ? red : null,
                      ),
                      if (hasMinijob(book))
                        Builder(
                          builder: (context) {
                            final pay = minijobCents(
                              book,
                              today.year,
                              today.month,
                            );
                            final limit =
                                settings.minijobLimitFor(today.year) * 100;
                            return ValueTile(
                              leading: Icon(
                                CupertinoIcons.money_euro_circle,
                                color: accent.resolveFrom(context),
                              ),
                              label: l.minijobPayIn(monthName(l, today)),
                              value: l.ofValue(
                                euroText(l, pay),
                                euroText(l, limit),
                              ),
                              valueColor: pay > limit ? red : null,
                            );
                          },
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
}

/// The big number: days left this year, with a quiet bar and the split.
class _Hero extends StatelessWidget {
  const _Hero({required this.usage});
  final YearUsage usage;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final theme = CupertinoTheme.of(context).textTheme;
    final secondary = CupertinoColors.secondaryLabel.resolveFrom(context);
    final color = usage.isOver
        ? CupertinoColors.systemRed.resolveFrom(context)
        : accent.resolveFrom(context);
    final number = numberText(l, usage.isOver ? -usage.left : usage.left);
    final label = usage.isOver
        ? l.daysOverIn('${usage.year}')
        : l.daysLeftIn('${usage.year}');
    final small = theme.textStyle.copyWith(fontSize: 15, color: secondary);
    // The number is already huge: let it grow a little with the text size,
    // not all the way.
    final numberScaler = MediaQuery.textScalerOf(context)
        .clamp(maxScaleFactor: 1.35);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MergeSemantics(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    number,
                    textScaler: numberScaler,
                    style: theme.navLargeTitleTextStyle.copyWith(
                      fontSize: 64,
                      height: 1.1,
                      fontWeight: FontWeight.w700,
                      color: color,
                      fontFeatures: tabular,
                    ),
                  ),
                ),
                Text(
                  label,
                  style: theme.textStyle.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 14),
                _Bar(fraction: usage.fraction, color: color),
                const SizedBox(height: 10),
                Text(
                  l.usedOfLimit(
                    numberText(l, usage.used),
                    numberText(l, usage.limit),
                  ),
                  style: small.copyWith(fontFeatures: tabular),
                ),
                Text(
                  l.fullAndHalf(usage.fullDays, usage.halfDays),
                  style: small.copyWith(fontFeatures: tabular),
                ),
                if (usage.upcomingDays > 0)
                  Text(l.upcomingIncluded(usage.upcomingDays), style: small),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CupertinoButton.filled(
            onPressed: () => openShiftEditor(context),
            child: Text(l.logShift, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.fraction, required this.color});
  final double fraction;
  final Color color;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: SizedBox(
        height: 6,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: ColoredBox(
                color: CupertinoColors.systemFill.resolveFrom(context),
              ),
            ),
            FractionallySizedBox(
              widthFactor: fraction,
              heightFactor: 1,
              child: ColoredBox(color: color),
            ),
          ],
        ),
      ),
    ),
  );
}
