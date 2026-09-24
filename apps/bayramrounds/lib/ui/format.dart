import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../model/book.dart';
import '../model/occasion.dart';

/// "Sun, 16 May 2027"
String longDate(AppLocalizations l, DateTime d) =>
    DateFormat.yMMMEd(l.localeName).format(d);

/// "Sun, 16 May"
String weekdayDate(AppLocalizations l, DateTime d) =>
    DateFormat.MMMEd(l.localeName).format(d);

/// "16 May 2027"
String plainDate(AppLocalizations l, DateTime d) =>
    DateFormat.yMMMd(l.localeName).format(d);

/// "10:40" or "10:40 AM", following the device's 12/24-hour setting.
String clock(AppLocalizations l, DateTime d, {required bool use24h}) =>
    (use24h ? DateFormat.Hm(l.localeName) : DateFormat.jm(l.localeName))
        .format(d);

/// The dates of an occasion: one day, or "Sun, 16 May to Wed, 19 May 2027".
String occasionDates(AppLocalizations l, Occasion o) {
  if (o.days == 1) return longDate(l, o.start);
  return l.dateRange(weekdayDate(l, o.start), longDate(l, o.end));
}

/// Where the round stands today: "Day 2 of 4", "Starts tomorrow", ...
String phaseLabel(AppLocalizations l, Occasion o, DateTime today) =>
    switch (o.phaseOn(today)) {
      Phase.upcoming => l.inDays(daysBetween(today, o.start)),
      Phase.eve => o.isBayram ? l.arefeToday : l.startsTomorrow,
      Phase.during =>
        o.days == 1 ? l.today : l.dayOf(o.dayNumber(today), o.days),
      Phase.after => l.endedYesterday,
      Phase.past => plainDate(l, o.start),
    };

/// When a tick was made: time only on the same day, else date and time.
String tickWhen(
  AppLocalizations l,
  DateTime at,
  DateTime today, {
  required bool use24h,
}) {
  final local = at.toLocal();
  final t = clock(l, local, use24h: use24h);
  if (daysBetween(local, today) == 0) return t;
  return '${DateFormat.MMMd(l.localeName).format(local)}, $t';
}

String reachStatus(AppLocalizations l, Reach r, String when) => switch (r) {
  Reach.called => l.statusCalled(when),
  Reach.messaged => l.statusMessaged(when),
  Reach.visited => l.statusVisited(when),
};
