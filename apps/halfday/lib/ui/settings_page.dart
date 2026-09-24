import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../model/book.dart';
import '../state/app_state.dart';
import 'format.dart';
import 'how_page.dart';
import 'job_edit_page.dart';
import 'number_edit_page.dart';
import 'widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final book = state.book;
    final settings = book.settings;
    final year = state.today.year;
    final l = context.l;
    final accentColor = accent.resolveFrom(context);
    void save(Settings s) => state.update(state.book.copyWith(settings: s));
    void edit(NumberEditPage page) => unawaited(
      Navigator.of(context)
          .push(CupertinoPageRoute<void>(builder: (_) => page)),
    );
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(largeTitle: Text(l.tabSettings)),
          const SliverToBoxAdapter(child: ProblemBanner()),
          SliverSafeArea(
            top: false,
            sliver: SliverList.list(
              children: [
                CupertinoListSection.insetGrouped(
                  header: Text(l.jobs),
                  children: [
                    for (final j in book.jobs)
                      CupertinoListTile(
                        padding: tilePadding,
                        leading: Icon(
                          CupertinoIcons.briefcase,
                          color: j.kind.counts
                              ? accentColor
                              : CupertinoColors.secondaryLabel.resolveFrom(
                                  context,
                                ),
                        ),
                        title: RowText(j.name),
                        subtitle: Text(
                          [
                            jobKindLabel(l, j.kind),
                            if (j.kind == JobKind.minijob &&
                                j.rateCents != null)
                              '${euroText(l, j.rateCents!)} / ${l.hoursValue('').trim()}',
                          ].join('  ·  '),
                          maxLines: 3,
                        ),
                        trailing: const CupertinoListTileChevron(),
                        onTap: () => openJobEditor(context, job: j),
                      ),
                    CupertinoListTile(
                      padding: tilePadding,
                      leading: Icon(CupertinoIcons.add, color: accentColor),
                      title: RowText(l.addJob, color: accentColor),
                      onTap: () => openJobEditor(context),
                    ),
                  ],
                ),
                CupertinoListSection.insetGrouped(
                  header: Text(l.limits),
                  footer: FooterText(l.limitsFooter),
                  children: [
                    ValueTile(
                      label: l.fullDaysPerYear,
                      value: numberText(l, settings.fullDayLimit),
                      onTap: () => edit(
                        NumberEditPage(
                          title: l.fullDaysPerYear,
                          initial: settings.fullDayLimit.toDouble(),
                          max: 366,
                          help: l.fullDaysHelp,
                          onSave: (v) => save(
                            state.book.settings.copyWith(
                              fullDayLimit: v.round(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ValueTile(
                      label: l.halfDayUpTo,
                      value: hoursText(l, settings.halfDayMaxMinutes),
                      onTap: () => edit(
                        NumberEditPage(
                          title: l.halfDayUpTo,
                          initial: settings.halfDayMaxMinutes / 60,
                          decimals: true,
                          max: 24,
                          unit: l.hoursValue('').trim(),
                          help: l.halfDayHelp,
                          onSave: (v) => save(
                            state.book.settings.copyWith(
                              halfDayMaxMinutes: (v * 60).round(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ValueTile(
                      label: l.hoursPerWeek,
                      value: wholeHoursText(l, settings.weeklyHourLimit),
                      onTap: () => edit(
                        NumberEditPage(
                          title: l.hoursPerWeek,
                          initial: settings.weeklyHourLimit.toDouble(),
                          max: 168,
                          unit: l.hoursValue('').trim(),
                          help: l.weeklyHelp,
                          onSave: (v) => save(
                            state.book.settings.copyWith(
                              weeklyHourLimit: v.round(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ValueTile(
                      label: l.minijobLimitIn('$year'),
                      value: euroText(l, settings.minijobLimitFor(year) * 100),
                      onTap: () => edit(
                        NumberEditPage(
                          title: l.minijobLimitIn('$year'),
                          initial: settings.minijobLimitFor(year).toDouble(),
                          max: 100000,
                          unit: '€',
                          help: l.minijobHelp('$year'),
                          onSave: (v) => save(
                            state.book.settings.withMinijobLimit(
                              year,
                              v.round(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (!settings.isTypical)
                  CupertinoListSection.insetGrouped(
                    children: [
                      CupertinoListTile(
                        padding: tilePadding,
                        title: RowText(l.restoreTypical, color: accentColor),
                        onTap: () async {
                          final ok = await confirmDelete(
                            context,
                            message: l.restoreTypicalConfirm,
                            action: l.restoreTypical,
                            destructive: false,
                          );
                          if (ok) save(const Settings());
                        },
                      ),
                    ],
                  ),
                CupertinoListSection.insetGrouped(
                  children: [
                    CupertinoListTile(
                      padding: tilePadding,
                      leading: Icon(
                        CupertinoIcons.info_circle,
                        color: accentColor,
                      ),
                      title: RowText(l.howItCounts),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () => Navigator.of(context).push(
                        CupertinoPageRoute<void>(
                          builder: (_) => const HowPage(),
                        ),
                      ),
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
