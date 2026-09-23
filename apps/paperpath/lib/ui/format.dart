import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../model/plan.dart';

enum DueTone { normal, soon, overdue }

/// "Due in 3 days", "2 days overdue", "Due 24 Dec". Null when there is no
/// deadline.
(String, DueTone)? dueLabel(AppLocalizations l, DateTime? due, DateTime today) {
  if (due == null) return null;
  final days = dateOnly(due).difference(dateOnly(today)).inDays;
  if (days < 0) return (l.overdue(-days), DueTone.overdue);
  if (days == 0) return (l.dueToday, DueTone.soon);
  if (days == 1) return (l.dueTomorrow, DueTone.soon);
  if (days <= 14) {
    return (l.dueInDays(days), days <= 3 ? DueTone.soon : DueTone.normal);
  }
  return (l.dueOn(shortDate(l, due)), DueTone.normal);
}

String shortDate(AppLocalizations l, DateTime d) =>
    DateFormat.MMMd(l.localeName).format(d);

String longDate(AppLocalizations l, DateTime d) =>
    DateFormat.yMMMd(l.localeName).format(d);

String dateTime(AppLocalizations l, DateTime d) =>
    '${DateFormat.MMMEd(l.localeName).format(d)}, '
    '${DateFormat.Hm(l.localeName).format(d)}';

/// "Needs Passport" or "Needs Passport and 2 more".
String? needsLabel(AppLocalizations l, List<String> missingNames) {
  if (missingNames.isEmpty) return null;
  if (missingNames.length == 1) return l.needsOne(missingNames.first);
  return l.needsMany(missingNames.first, missingNames.length - 1);
}
