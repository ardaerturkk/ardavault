import 'package:flutter/cupertino.dart';

import '../model/book.dart';
import '../model/quota.dart';
import '../state/app_state.dart';
import 'format.dart';
import 'shift_edit_page.dart';
import 'widgets.dart';

class ShiftsPage extends StatelessWidget {
  const ShiftsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final book = AppScope.of(context).book;
    final l = context.l;
    // Newest first; shifts on one date keep the order they were logged in.
    final sorted = [...book.shifts]..sort((a, b) => b.date.compareTo(a.date));
    final months = <(int, int), List<Shift>>{};
    for (final s in sorted) {
      (months[(s.date.year, s.date.month)] ??= []).add(s);
    }
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(l.tabShifts),
            trailing: book.shifts.isEmpty
                ? null
                : AddButton(
                    label: l.logShift,
                    onPressed: () => openShiftEditor(context),
                  ),
          ),
          const SliverToBoxAdapter(child: ProblemBanner()),
          if (book.shifts.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyState(
                icon: CupertinoIcons.circle_lefthalf_fill,
                title: l.noShiftsTitle,
                body: l.noShiftsBody,
                primaryLabel: l.logShift,
                onPrimary: () => openShiftEditor(context),
              ),
            )
          else
            SliverSafeArea(
              top: false,
              sliver: SliverList.list(
                children: [
                  for (final shifts in months.values)
                    CupertinoListSection.insetGrouped(
                      header: Text(monthYear(l, shifts.first.date)),
                      children: [for (final s in shifts) ShiftTile(shift: s)],
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

class ShiftTile extends StatelessWidget {
  const ShiftTile({super.key, required this.shift});
  final Shift shift;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final book = state.book;
    final l = context.l;
    final counts = book.counts(shift);
    final status = counts ? dayStatus(book, shift.date) : DayStatus.notCounted;
    final statusText = switch (status) {
      DayStatus.full => l.statusFull,
      DayStatus.half => l.statusHalf,
      DayStatus.notCounted => l.statusNotCounted,
    };
    final sameDay = [
      for (final s in book.shifts)
        if (s.date == shift.date && book.counts(s)) s,
    ];
    final large = isLargeText(context);
    // Job name on its own line; the numbers below it.
    final parts = [
      hoursText(l, shift.minutes),
      if (counts && sameDay.length > 1)
        l.dayTotal(hoursText(l, sameDay.fold(0, (sum, s) => sum + s.minutes))),
      if (shift.date.isAfter(state.today)) l.upcoming,
      if (large) statusText,
    ];
    return CupertinoListTile(
      padding: tilePadding,
      leading: dayStatusIcon(context, status),
      title: RowText(shortDate(l, shift.date)),
      subtitle: Text(
        [
          book.job(shift.jobId)?.name ?? '',
          parts.join('  ·  '),
        ].where((p) => p.isNotEmpty).join('\n'),
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontFeatures: tabular),
      ),
      additionalInfo: large ? null : Text(statusText),
      trailing: const CupertinoListTileChevron(),
      onTap: () => openShiftEditor(context, shift: shift),
    );
  }
}
