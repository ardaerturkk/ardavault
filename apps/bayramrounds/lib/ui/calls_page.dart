import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../model/book.dart';
import '../model/occasion.dart';
import '../state/app_state.dart';
import 'format.dart';
import 'names.dart';
import 'person_edit_page.dart';
import 'round_page.dart';
import 'widgets.dart';

/// Today's date on the device, from the app's clock.
DateTime todayOf(AppState state) => dateOnly(state.now().toLocal());

class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final book = state.book;
    final l = context.l;
    final today = todayOf(state);
    final open = book.openOn(today);
    final upcoming = book.upcomingFrom(today);
    final past = book.pastBefore(today);
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(largeTitle: Text(l.tabCalls)),
          const SliverToBoxAdapter(child: ProblemBanner()),
          if (book.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyState(
                icon: CupertinoIcons.phone,
                title: l.emptyCallsTitle,
                body: _emptyBody(context, today),
                primaryLabel: l.addPerson,
                onPrimary: () => openPersonEditor(context),
              ),
            )
          else
            SliverSafeArea(
              top: false,
              sliver: SliverList.list(
                children: [
                  if (open.isNotEmpty)
                    CupertinoListSection.insetGrouped(
                      header: Text(l.sectionNow),
                      children: [
                        for (final o in open)
                          _OpenTile(occasion: o, today: today),
                      ],
                    ),
                  CupertinoListSection.insetGrouped(
                    header: Text(l.sectionUpcoming),
                    footer: FooterText(
                      l.datesFooter(lastBayramYear.toString()),
                    ),
                    children: [
                      if (upcoming.isEmpty)
                        CupertinoListTile(
                          padding: tilePadding,
                          title: RowText(
                            l.noUpcoming,
                            color: CupertinoColors.secondaryLabel.resolveFrom(
                              context,
                            ),
                          ),
                        ),
                      for (final o in upcoming)
                        _UpcomingTile(occasion: o, today: today),
                    ],
                  ),
                  if (past.isNotEmpty)
                    CupertinoListSection.insetGrouped(
                      header: Text(l.sectionEarlier),
                      children: [for (final o in past) _PastTile(occasion: o)],
                    ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _emptyBody(BuildContext context, DateTime today) {
    final l = context.l;
    final next = [
      for (var y = today.year; y <= today.year + 1; y++)
        ...occasionsInYear(y),
    ].where((o) => o.isBayram && daysBetween(today, o.end) >= 0).firstOrNull;
    if (next == null) return l.emptyPeopleBody;
    return l.emptyCallsBody(kindName(l, next.kind), plainDate(l, next.start));
  }
}

void openRound(BuildContext context, Occasion o) => Navigator.of(context).push(
  CupertinoPageRoute<void>(builder: (_) => RoundPage(occasion: o)),
);

class _OpenTile extends StatelessWidget {
  const _OpenTile({required this.occasion, required this.today});
  final Occasion occasion;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final book = AppScope.of(context).book;
    final l = context.l;
    final total = book.participants(occasion).length;
    final done = book.reachedCount(occasion);
    final secondary = CupertinoColors.secondaryLabel.resolveFrom(context);
    return CupertinoListTile(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 14, 14, 14),
      leadingSize: 44,
      leadingToTitle: 14,
      leading: ProgressRing(done: done, total: total, size: 44),
      title: Text(
        occasionName(l, occasion, book),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        '${phaseLabel(l, occasion, today)}\n${l.reachedOf(done, total)}',
        maxLines: 6,
        style: TextStyle(color: secondary),
      ),
      trailing: const CupertinoListTileChevron(),
      onTap: () => openRound(context, occasion),
    );
  }
}

class _UpcomingTile extends StatelessWidget {
  const _UpcomingTile({required this.occasion, required this.today});
  final Occasion occasion;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final book = AppScope.of(context).book;
    final l = context.l;
    final count = book.participants(occasion).length;
    return CupertinoListTile(
      padding: tilePadding,
      leadingSize: 40,
      leadingToTitle: 14,
      leading: DateBadge(date: occasion.start),
      title: RowText(occasionName(l, occasion, book), maxLines: 3),
      subtitle: Text(
        '${occasionDates(l, occasion)}\n'
        '${phaseLabel(l, occasion, today)} · ${l.peopleCount(count)}',
        maxLines: 6,
      ),
      trailing: const CupertinoListTileChevron(),
      onTap: () => openRound(context, occasion),
    );
  }
}

class _PastTile extends StatelessWidget {
  const _PastTile({required this.occasion});
  final Occasion occasion;

  @override
  Widget build(BuildContext context) {
    final book = AppScope.of(context).book;
    final l = context.l;
    final total = book.participants(occasion).length;
    final done = book.reachedCount(occasion);
    final name = occasion.kind == OccasionKind.birthday
        ? occasionName(l, occasion, book)
        : l.occasionYear(
            occasionName(l, occasion, book),
            occasion.year.toString(),
          );
    return CupertinoListTile(
      padding: tilePadding,
      leadingSize: 40,
      leadingToTitle: 14,
      leading: ProgressRing(done: done, total: total, size: 30),
      title: RowText(name, maxLines: 3),
      subtitle: Text(
        '${plainDate(l, occasion.start)} · ${l.reachedOf(done, total)}',
        maxLines: 4,
      ),
      trailing: const CupertinoListTileChevron(),
      onTap: () => openRound(context, occasion),
    );
  }
}

/// A small calendar leaf: month above, day below.
class DateBadge extends StatelessWidget {
  const DateBadge({super.key, required this.date});
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final month = DateFormat.MMM(l.localeName).format(date).toUpperCase();
    return ExcludeSemantics(
      child: MediaQuery.withClampedTextScaling(
        maxScaleFactor: 1.3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              month.replaceAll('.', ''),
              maxLines: 1,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: accent.resolveFrom(context),
              ),
            ),
            Text(
              '${date.day}',
              maxLines: 1,
              style: TextStyle(
                fontSize: 22,
                height: 1.1,
                fontFeatures: const [FontFeature.tabularFigures()],
                color: CupertinoColors.label.resolveFrom(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// How much of a round is done, as a ring in the accent color.
class ProgressRing extends StatelessWidget {
  const ProgressRing({
    super.key,
    required this.done,
    required this.total,
    this.size = 30,
  });
  final int done;
  final int total;
  final double size;

  @override
  Widget build(BuildContext context) {
    final complete = total > 0 && done >= total;
    return ExcludeSemantics(
      child: SizedBox.square(
        dimension: size,
        child: complete
            ? Icon(
                CupertinoIcons.checkmark_circle_fill,
                size: size,
                color: accent.resolveFrom(context),
              )
            : CustomPaint(
                painter: _RingPainter(
                  fraction: total == 0 ? 0 : done / total,
                  track: CupertinoColors.systemFill.resolveFrom(context),
                  fill: accent.resolveFrom(context),
                ),
              ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.fraction,
    required this.track,
    required this.fill,
  });
  final double fraction;
  final Color track;
  final Color fill;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.width / 9;
    final rect = (Offset.zero & size).deflate(stroke / 2 + 1);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, 0, math.pi * 2, false, paint..color = track);
    if (fraction > 0) {
      canvas.drawArc(
        rect,
        -math.pi / 2,
        math.pi * 2 * fraction,
        false,
        paint..color = fill,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.fraction != fraction || old.track != track || old.fill != fill;
}
