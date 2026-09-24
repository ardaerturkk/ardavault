import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../model/book.dart';
import '../model/day.dart';

/// 118.5, 118,5: at most one decimal, grouped like the locale.
String numberText(AppLocalizations l, num n) =>
    NumberFormat('#,##0.##', l.localeName).format(n);

/// "3.5 h", "3,5 Std.", "3,5 sa".
String hoursText(AppLocalizations l, int minutes) =>
    l.hoursValue(numberText(l, minutes / 60));

/// Whole hours as "20 h".
String wholeHoursText(AppLocalizations l, int hours) =>
    l.hoursValue(numberText(l, hours));

/// Full-day equivalents from half-day units: "1 day", "12.5 days".
String daysText(AppLocalizations l, int halves) =>
    halves == 2 ? l.oneDay : l.daysValue(numberText(l, halves / 2));

/// Euros with cents only when there are any.
String euroText(AppLocalizations l, int cents) => NumberFormat.simpleCurrency(
  locale: l.localeName,
  name: 'EUR',
  decimalDigits: cents % 100 == 0 ? 0 : 2,
).format(cents / 100);

/// "Wed, Sep 23".
String shortDate(AppLocalizations l, Day d) =>
    DateFormat.MMMEd(l.localeName).format(d.toLocal());

/// "Wed, Sep 23, 2026".
String longDate(AppLocalizations l, Day d) =>
    DateFormat.yMMMEd(l.localeName).format(d.toLocal());

/// "September 2026".
String monthYear(AppLocalizations l, Day d) =>
    DateFormat.yMMMM(l.localeName).format(d.toLocal());

/// "September", in the form that stands after "in".
String monthName(AppLocalizations l, Day d) =>
    DateFormat.MMMM(l.localeName).format(d.toLocal());

/// Short weekday name for Monday = 1 ... Sunday = 7.
String weekdayShort(AppLocalizations l, int weekday) =>
    // 5 January 2026 is a Monday.
    DateFormat.E(l.localeName).format(DateTime(2026, 1, 4 + weekday));

String jobKindLabel(AppLocalizations l, JobKind k) => switch (k) {
  JobKind.regular => l.kindRegular,
  JobKind.minijob => l.kindMinijob,
  JobKind.university => l.kindUniversity,
};

String jobKindInfo(AppLocalizations l, JobKind k) => switch (k) {
  JobKind.regular => l.kindRegularInfo,
  JobKind.minijob => l.kindMinijobInfo,
  JobKind.university => l.kindUniversityInfo,
};

/// Parses "13,50" or "13.50" (and "4") to a number; null if not a number.
double? parseDecimal(String s) {
  final t = s.trim().replaceAll(' ', '').replaceAll(',', '.');
  if (t.isEmpty) return null;
  return double.tryParse(t);
}
