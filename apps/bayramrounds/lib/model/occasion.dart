/// Occasions: the days a round opens for. Bayram dates come from a bundled
/// table (Diyanet's calendar, cross-checked); family days are computed from
/// their rules. All dates are plain calendar dates (local midnight).
library;

DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// Whole calendar days from [a] to [b]. Counted in UTC so clock changes
/// never shift the result.
int daysBetween(DateTime a, DateTime b) => DateTime.utc(
  b.year,
  b.month,
  b.day,
).difference(DateTime.utc(a.year, a.month, a.day)).inDays;

enum OccasionKind {
  ramazanBayrami,
  kurbanBayrami,
  newYear,
  mothersDay,
  fathersDayTr,
  vatertagDe,
  birthday,
}

/// Kinds a person can be part of, in the order the editor lists them.
/// Birthdays follow from the person's birthday instead.
const choosableKinds = [
  OccasionKind.ramazanBayrami,
  OccasionKind.kurbanBayrami,
  OccasionKind.newYear,
  OccasionKind.mothersDay,
  OccasionKind.fathersDayTr,
  OccasionKind.vatertagDe,
];

/// Month in the Hijri calendar, for the label under a Bayram.
enum HijriMonth { shawwal, dhuAlHijjah }

class HijriDate {
  const HijriDate(this.day, this.month, this.year);
  final int day;
  final HijriMonth month;
  final int year;
}

/// First days of Ramazan and Kurban Bayramı as published in Diyanet's
/// "Dini Günler" lists, each cross-checked with a second source (see
/// SPEC.md). Years that could not be confirmed twice are left out.
final Map<int, ({DateTime ramazan, DateTime kurban, int hijri})>
bayramFirstDays = {
  2026: (
    ramazan: DateTime(2026, 3, 20),
    kurban: DateTime(2026, 5, 27),
    hijri: 1447,
  ),
  2027: (
    ramazan: DateTime(2027, 3, 9),
    kurban: DateTime(2027, 5, 16),
    hijri: 1448,
  ),
  2028: (
    ramazan: DateTime(2028, 2, 26),
    kurban: DateTime(2028, 5, 5),
    hijri: 1449,
  ),
  2029: (
    ramazan: DateTime(2029, 2, 15),
    kurban: DateTime(2029, 4, 24),
    hijri: 1450,
  ),
};

final int firstBayramYear = bayramFirstDays.keys.reduce(
  (a, b) => a < b ? a : b,
);
final int lastBayramYear = bayramFirstDays.keys.reduce(
  (a, b) => a > b ? a : b,
);

/// Easter Sunday (Gregorian), anonymous Gregorian algorithm (Meeus).
DateTime easterSunday(int year) {
  final a = year % 19;
  final b = year ~/ 100;
  final c = year % 100;
  final d = b ~/ 4;
  final e = b % 4;
  final f = (b + 8) ~/ 25;
  final g = (b - f + 1) ~/ 3;
  final h = (19 * a + b - d - g + 15) % 30;
  final i = c ~/ 4;
  final k = c % 4;
  final l = (32 + 2 * e + 2 * i - h - k) % 7;
  final m = (a + 11 * h + 22 * l) ~/ 451;
  final month = (h + l - 7 * m + 114) ~/ 31;
  final day = (h + l - 7 * m + 114) % 31 + 1;
  return DateTime(year, month, day);
}

/// The [n]th Sunday (1-based) of [month] in [year].
DateTime nthSunday(int year, int month, int n) {
  final first = DateTime(year, month);
  final toSunday = (DateTime.sunday - first.weekday) % 7;
  return DateTime(year, month, 1 + toSunday + 7 * (n - 1));
}

/// Mother's Day: second Sunday of May, in Turkey and in Germany.
DateTime mothersDay(int year) => nthSunday(year, 5, 2);

/// Babalar Günü in Turkey: third Sunday of June.
DateTime fathersDayTurkey(int year) => nthSunday(year, 6, 3);

/// Vatertag in Germany: Ascension Day, Easter Sunday plus 39 days.
DateTime vatertagGermany(int year) {
  final e = easterSunday(year);
  return DateTime(e.year, e.month, e.day + 39);
}

/// A birthday in [year]; 29 February falls on 28 February in other years.
DateTime birthdayIn(int year, int month, int day) {
  if (month == 2 && day == 29) {
    final leap = DateTime(year, 2, 29).month == 2;
    return DateTime(year, 2, leap ? 29 : 28);
  }
  return DateTime(year, month, day);
}

enum Phase { upcoming, eve, during, after, past }

class Occasion {
  Occasion({
    required this.kind,
    required DateTime start,
    this.days = 1,
    this.hijri,
    this.personId,
  }) : start = dateOnly(start);

  final OccasionKind kind;
  final DateTime start;

  /// How many days it lasts: 3 for Ramazan Bayramı, 4 for Kurban Bayramı.
  final int days;
  final HijriDate? hijri;

  /// Set for birthdays: whose birthday it is.
  final String? personId;

  int get year => start.year;
  DateTime get end => DateTime(start.year, start.month, start.day + days - 1);

  /// The day before: arefe for a Bayram.
  DateTime get eve => DateTime(start.year, start.month, start.day - 1);

  bool get isBayram =>
      kind == OccasionKind.ramazanBayrami || kind == OccasionKind.kurbanBayrami;

  /// Stable key for the round's saved ticks.
  String get key => personId == null
      ? '${kind.name}-$year'
      : '${kind.name}-$personId-$year';

  /// Where [today] sits: the round opens the day before and stays open one
  /// day after the last day, for the late calls.
  Phase phaseOn(DateTime today) {
    final toStart = daysBetween(today, start);
    final fromEnd = daysBetween(end, today);
    if (toStart > 1) return Phase.upcoming;
    if (toStart == 1) return Phase.eve;
    if (fromEnd <= 0) return Phase.during;
    if (fromEnd == 1) return Phase.after;
    return Phase.past;
  }

  /// 1-based day of the occasion on [today], when it is on.
  int dayNumber(DateTime today) => daysBetween(start, today) + 1;
}

/// The occasions shared by everyone in [year], sorted by date. Bayrams only
/// for years in the table.
List<Occasion> occasionsInYear(int year) {
  final b = bayramFirstDays[year];
  final list = [
    Occasion(kind: OccasionKind.newYear, start: DateTime(year)),
    if (b != null) ...[
      Occasion(
        kind: OccasionKind.ramazanBayrami,
        start: b.ramazan,
        days: 3,
        hijri: HijriDate(1, HijriMonth.shawwal, b.hijri),
      ),
      Occasion(
        kind: OccasionKind.kurbanBayrami,
        start: b.kurban,
        days: 4,
        hijri: HijriDate(10, HijriMonth.dhuAlHijjah, b.hijri),
      ),
    ],
    Occasion(kind: OccasionKind.mothersDay, start: mothersDay(year)),
    Occasion(kind: OccasionKind.fathersDayTr, start: fathersDayTurkey(year)),
    Occasion(kind: OccasionKind.vatertagDe, start: vatertagGermany(year)),
  ]..sort((a, b) => a.start.compareTo(b.start));
  return list;
}
