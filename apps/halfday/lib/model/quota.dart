/// The counting rules: how shifts become full and half days, how many days
/// are left in a calendar year, and when a planned schedule runs out.
library;

import 'book.dart';
import 'day.dart';

enum DayStatus { full, half, notCounted }

/// How a date counts, given the minutes worked in counted jobs that day.
DayStatus statusForMinutes(int countedMinutes, int halfDayMaxMinutes) {
  if (countedMinutes <= 0) return DayStatus.notCounted;
  return countedMinutes > halfDayMaxMinutes ? DayStatus.full : DayStatus.half;
}

/// Half-day units: a full day uses 2, a half day 1.
int halvesOf(DayStatus s) => switch (s) {
  DayStatus.full => 2,
  DayStatus.half => 1,
  DayStatus.notCounted => 0,
};

/// Minutes in counted jobs per date, optionally only in [year].
Map<Day, int> countedMinutesByDay(Book book, {int? year}) {
  final out = <Day, int>{};
  for (final s in book.shifts) {
    if (year != null && s.date.year != year) continue;
    if (!book.counts(s)) continue;
    out[s.date] = (out[s.date] ?? 0) + s.minutes;
  }
  return out;
}

int countedMinutesOn(Book book, Day day) {
  var total = 0;
  for (final s in book.shifts) {
    if (s.date == day && book.counts(s)) total += s.minutes;
  }
  return total;
}

DayStatus dayStatus(Book book, Day day) =>
    statusForMinutes(countedMinutesOn(book, day), book.settings.halfDayMaxMinutes);

class YearUsage {
  const YearUsage({
    required this.year,
    required this.fullDays,
    required this.halfDays,
    required this.limitHalves,
    this.upcomingDays = 0,
  });

  final int year;
  final int fullDays;
  final int halfDays;
  final int limitHalves;

  /// Counted dates after today (logged ahead as planned work).
  final int upcomingDays;

  int get usedHalves => fullDays * 2 + halfDays;
  int get leftHalves => limitHalves - usedHalves;

  /// Full-day equivalents: 21.5 means 21 full days and one half day.
  double get used => usedHalves / 2;
  double get left => leftHalves / 2;
  double get limit => limitHalves / 2;
  bool get isOver => leftHalves < 0;

  /// Share of the limit used, 0..1 (clamped).
  double get fraction =>
      limitHalves <= 0 ? 1 : (usedHalves / limitHalves).clamp(0.0, 1.0);
}

YearUsage yearUsage(Book book, int year, {Day? today}) {
  var full = 0;
  var half = 0;
  var upcoming = 0;
  countedMinutesByDay(book, year: year).forEach((day, minutes) {
    final s = statusForMinutes(minutes, book.settings.halfDayMaxMinutes);
    if (s == DayStatus.full) full++;
    if (s == DayStatus.half) half++;
    if (today != null && s != DayStatus.notCounted && day.isAfter(today)) {
      upcoming++;
    }
  });
  return YearUsage(
    year: year,
    fullDays: full,
    halfDays: half,
    limitHalves: book.settings.fullDayLimit * 2,
    upcomingDays: upcoming,
  );
}

/// Minutes in every job (counted or not) in the Monday-to-Sunday week that
/// contains [day].
int weekMinutes(Book book, Day day) {
  final start = day.weekStart;
  final end = start.plus(6);
  var total = 0;
  for (final s in book.shifts) {
    if (!s.date.isBefore(start) && !s.date.isAfter(end)) total += s.minutes;
  }
  return total;
}

bool hasMinijob(Book book) => book.jobs.any((j) => j.kind == JobKind.minijob);

/// Pay in cents from Minijob shifts in the given month. Jobs without an
/// hourly rate add nothing.
int minijobCents(Book book, int year, int month) {
  var cents = 0.0;
  for (final s in book.shifts) {
    if (s.date.year != year || s.date.month != month) continue;
    final job = book.job(s.jobId);
    if (job == null || job.kind != JobKind.minijob) continue;
    cents += (job.rateCents ?? 0) * s.minutes / 60;
  }
  return cents.round();
}

class PlanInput {
  const PlanInput({
    required this.start,
    this.weeks = 8,
    this.daysPerWeek = 5,
    this.minutesPerDay = 8 * 60,
    this.jobId,
  });

  final Day start;
  final int weeks;

  /// 1 = Mondays only, 5 = Monday to Friday, 7 = every day.
  final int daysPerWeek;
  final int minutesPerDay;
  final String? jobId;

  int get workDays => weeks * daysPerWeek;

  PlanInput copyWith({
    Day? start,
    int? weeks,
    int? daysPerWeek,
    int? minutesPerDay,
    String? jobId,
  }) => PlanInput(
    start: start ?? this.start,
    weeks: weeks ?? this.weeks,
    daysPerWeek: daysPerWeek ?? this.daysPerWeek,
    minutesPerDay: minutesPerDay ?? this.minutesPerDay,
    jobId: jobId ?? this.jobId,
  );
}

/// The work days of a plan: from [PlanInput.start], every date whose weekday
/// is within the first "days per week" days (Monday first), until weeks x
/// days dates are placed.
List<Day> planDays(PlanInput p) {
  final out = <Day>[];
  if (p.daysPerWeek < 1 || p.weeks < 1) return out;
  var d = p.start;
  while (out.length < p.workDays) {
    if (d.weekday <= p.daysPerWeek) out.add(d);
    d = d.plus(1);
  }
  return out;
}

class PlanYear {
  const PlanYear({
    required this.year,
    required this.addedHalves,
    required this.leftHalves,
    this.reachedOn,
    this.overFrom,
    this.lastDayWithin,
  });

  final int year;

  /// Half-day units the plan adds on top of what is logged.
  final int addedHalves;

  /// Left in the year after the plan (negative when over).
  final int leftHalves;

  /// The first date on which used days reach the limit, if they do.
  final Day? reachedOn;

  /// The first date on which used days go over the limit, if they do.
  final Day? overFrom;

  /// The last planned date that still fits, when the plan goes over.
  final Day? lastDayWithin;

  bool get isOver => leftHalves < 0;
}

class PlanResult {
  const PlanResult({
    required this.days,
    required this.counts,
    required this.years,
  });

  final List<Day> days;

  /// False when the plan's job is not counted (university job).
  final bool counts;

  /// One entry per calendar year the plan touches, in order.
  final List<PlanYear> years;

  /// The first year in which the plan reaches or goes over the limit.
  PlanYear? get firstLimitYear {
    for (final y in years) {
      if (y.reachedOn != null) return y;
    }
    return null;
  }
}

PlanResult runPlan(Book book, PlanInput p) {
  final days = planDays(p);
  final job = book.job(p.jobId);
  final counts = job?.kind.counts ?? true;
  final threshold = book.settings.halfDayMaxMinutes;
  final limit = book.settings.fullDayLimit * 2;
  final planned = days.toSet();
  final years = <PlanYear>[];
  for (final year in {for (final d in days) d.year}) {
    final minutes = countedMinutesByDay(book, year: year);
    var added = 0;
    if (counts) {
      for (final d in days) {
        if (d.year != year) continue;
        final before = statusForMinutes(minutes[d] ?? 0, threshold);
        minutes[d] = (minutes[d] ?? 0) + p.minutesPerDay;
        added += halvesOf(statusForMinutes(minutes[d]!, threshold)) -
            halvesOf(before);
      }
    }
    final dates = minutes.keys.toList()..sort();
    var used = 0;
    Day? reached;
    Day? over;
    Day? lastWithin;
    for (final d in dates) {
      used += halvesOf(statusForMinutes(minutes[d]!, threshold));
      if (reached == null && used >= limit) reached = d;
      if (over == null && used > limit) over = d;
      if (over == null && planned.contains(d)) lastWithin = d;
    }
    years.add(
      PlanYear(
        year: year,
        addedHalves: added,
        leftHalves: limit - used,
        reachedOn: reached,
        overFrom: over,
        lastDayWithin: over == null ? null : lastWithin,
      ),
    );
  }
  return PlanResult(days: days, counts: counts, years: years);
}
