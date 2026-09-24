import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../model/book.dart';
import '../model/day.dart';
import '../model/quota.dart';
import '../state/app_state.dart';
import 'format.dart';
import 'job_edit_page.dart';
import 'widgets.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final book = state.book;
    final l = context.l;
    var input = state.planInput;
    // The planned job may have been deleted meanwhile.
    final job = book.job(input.jobId) ?? book.defaultJob;
    if (job?.id != input.jobId) input = input.copyWith(jobId: job?.id);
    final result = runPlan(book, input);
    final accentColor = accent.resolveFrom(context);
    void set(PlanInput p) => state.planInput = p;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(largeTitle: Text(l.tabPlan)),
          const SliverToBoxAdapter(child: ProblemBanner()),
          SliverSafeArea(
            top: false,
            sliver: SliverList.list(
              children: [
                CupertinoListSection.insetGrouped(
                  header: Text(l.planSchedule),
                  children: [
                    ValueTile(
                      leading: Icon(
                        CupertinoIcons.calendar,
                        color: accentColor,
                      ),
                      label: l.planStart,
                      value: longDate(l, input.start),
                      onTap: () async {
                        final pick = await pickDate(
                          context,
                          title: l.planStart,
                          initial: input.start.toLocal(),
                        );
                        if (pick?.date == null) return;
                        set(input.copyWith(start: Day.of(pick!.date!)));
                      },
                    ),
                    ValueTile(
                      leading: Icon(CupertinoIcons.repeat, color: accentColor),
                      label: l.planWeeks,
                      value: numberText(l, input.weeks),
                      onTap: () async {
                        final i = await pickFromWheel(
                          context,
                          title: l.planWeeks,
                          count: 52,
                          initial: input.weeks - 1,
                          label: (i) => numberText(l, i + 1),
                        );
                        if (i != null) set(input.copyWith(weeks: i + 1));
                      },
                    ),
                    ValueTile(
                      leading: Icon(
                        CupertinoIcons.square_grid_3x2,
                        color: accentColor,
                      ),
                      label: l.planDaysPerWeek,
                      value: _daysLabel(context, input.daysPerWeek),
                      onTap: () async {
                        final i = await pickFromWheel(
                          context,
                          title: l.planDaysPerWeek,
                          count: 7,
                          initial: input.daysPerWeek - 1,
                          label: (i) => _daysLabel(context, i + 1),
                        );
                        if (i != null) set(input.copyWith(daysPerWeek: i + 1));
                      },
                    ),
                    ValueTile(
                      leading: Icon(CupertinoIcons.clock, color: accentColor),
                      label: l.planHoursPerDay,
                      value: hoursText(l, input.minutesPerDay),
                      onTap: () async {
                        final m = await pickDuration(
                          context,
                          title: l.planHoursPerDay,
                          initialMinutes: input.minutesPerDay,
                        );
                        if (m != null && m > 0) {
                          set(input.copyWith(minutesPerDay: m));
                        }
                      },
                    ),
                    if (job == null)
                      CupertinoListTile(
                        padding: tilePadding,
                        leading: Icon(CupertinoIcons.add, color: accentColor),
                        title: RowText(l.addAJob, color: accentColor),
                        onTap: () async {
                          final id = await openJobEditor(context);
                          if (id != null) set(input.copyWith(jobId: id));
                        },
                      )
                    else
                      ValueTile(
                        leading: Icon(
                          CupertinoIcons.briefcase,
                          color: accentColor,
                        ),
                        label: l.job,
                        value: job.name,
                        onTap: () async {
                          final id = await pickJob(context, selected: job.id);
                          if (id != null) set(input.copyWith(jobId: id));
                        },
                      ),
                  ],
                ),
                _ResultSection(result: result, input: input),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                  child: SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      onPressed: job == null
                          ? null
                          : () => _addAsShifts(context, input, job, result),
                      child: Text(l.addAsShifts, textAlign: TextAlign.center),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
                  child: FooterText(
                    job == null ? l.planNeedsJob : l.planFooter,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// "5 (Mon to Fri)"; "1 (Mon)".
  static String _daysLabel(BuildContext context, int days) {
    final l = context.l;
    final first = weekdayShort(l, 1);
    if (days == 1) return '${numberText(l, 1)} ($first)';
    return l.weekdaySpan(numberText(l, days), first, weekdayShort(l, days));
  }

  Future<void> _addAsShifts(
    BuildContext context,
    PlanInput input,
    Job job,
    PlanResult result,
  ) async {
    final l = context.l;
    final count = result.days.length;
    final ok = await confirmDelete(
      context,
      message: l.addShiftsConfirm(count, job.name),
      action: l.addShiftsAction(count),
      destructive: false,
    );
    if (!ok || !context.mounted) return;
    final state = AppScope.read(context);
    state.update(
      state.book.addShifts([
        for (final d in result.days)
          (id) => Shift(
            id: id,
            jobId: job.id,
            date: d,
            minutes: input.minutesPerDay,
          ),
      ]),
    );
    unawaited(HapticFeedback.lightImpact());
    await showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(l.shiftsAdded(count)),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: Text(l.ok),
          ),
        ],
      ),
    );
  }
}

class _ResultSection extends StatelessWidget {
  const _ResultSection({required this.result, required this.input});
  final PlanResult result;
  final PlanInput input;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final theme = CupertinoTheme.of(context).textTheme;
    final red = CupertinoColors.systemRed.resolveFrom(context);
    final limitYear = result.firstLimitYear;
    final String title;
    final String body;
    Color? color;
    if (!result.counts) {
      title = l.planNotCountedTitle;
      body = l.planNotCountedBody;
    } else if (limitYear != null && limitYear.isOver) {
      color = red;
      title = limitYear.lastDayWithin == null
          ? l.planUsedUpTitle('${limitYear.year}')
          : l.planOverTitle(shortDate(l, limitYear.overFrom!));
      final over = daysText(l, -limitYear.leftHalves);
      body = limitYear.lastDayWithin == null
          ? l.planOverBodyNoLast('${limitYear.year}', over)
          : l.planOverBody(
              longDate(l, limitYear.lastDayWithin!),
              over,
              '${limitYear.year}',
            );
    } else if (limitYear != null) {
      title = l.planReachedTitle;
      body = l.planReachedBody(
        '${limitYear.year}',
        longDate(l, limitYear.reachedOn!),
      );
    } else {
      final first = result.years.first;
      title = l.planFitsTitle;
      body = l.planFitsBody(daysText(l, first.leftHalves), '${first.year}');
    }
    final added = result.years.fold(0, (s, y) => s + y.addedHalves);
    return CupertinoListSection.insetGrouped(
      children: [
        MergeSemantics(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: theme.navTitleTextStyle.copyWith(
                    fontSize: 20,
                    color: color ?? accent.resolveFrom(context),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: theme.textStyle.copyWith(
                    fontSize: 15,
                    color: CupertinoColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
              ],
            ),
          ),
        ),
        ValueTile(
          label: l.planWorkDays,
          value: numberText(l, result.days.length),
        ),
        if (result.counts)
          ValueTile(label: l.planAdds, value: daysText(l, added)),
        ValueTile(label: l.planLastDay, value: longDate(l, result.days.last)),
        if (result.counts)
          for (final y in result.years)
            ValueTile(
              label: l.leftAfterIn('${y.year}'),
              value: y.isOver
                  ? l.daysOver(daysText(l, -y.leftHalves))
                  : daysText(l, y.leftHalves),
              valueColor: y.isOver ? red : null,
            ),
      ],
    );
  }
}
