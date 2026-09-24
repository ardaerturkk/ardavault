import 'package:flutter/cupertino.dart';

import '../state/app_state.dart';
import 'format.dart';
import 'widgets.dart';

/// Plain explanation of the counting rules and their limits.
class HowPage extends StatelessWidget {
  const HowPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final settings = AppScope.of(context).book.settings;
    final half = hoursText(l, settings.halfDayMaxMinutes);
    final week = wholeHoursText(l, settings.weeklyHourLimit);
    final theme = CupertinoTheme.of(context).textTheme;
    Widget part(String title, String body) => CupertinoListSection.insetGrouped(
      header: Text(title),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
          child: Text(body, style: theme.textStyle.copyWith(fontSize: 15)),
        ),
      ],
    );
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(middle: Text(l.howItCounts)),
      child: SafeArea(
        child: ListView(
          children: [
            part(l.howFullHalfTitle, l.howFullHalfBody(half)),
            part(l.howNotCountedTitle, l.howNotCountedBody),
            part(l.howWeekTitle, l.howWeekBody(week)),
            part(l.howOtherTitle, l.howOtherBody),
            part(l.howLegalTitle, l.howLegalBody),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
