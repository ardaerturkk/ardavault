import 'package:flutter_test/flutter_test.dart';
import 'package:halfday/model/book.dart';
import 'package:halfday/model/day.dart';
import 'package:halfday/model/quota.dart';

Book bookWith(List<(String date, int minutes, String job)> shifts) {
  var b = const Book(
    jobs: [
      Job(id: 'cafe', name: 'Cafe'),
      Job(id: 'uni', name: 'Tutor', kind: JobKind.university),
      Job(id: 'mini', name: 'Shop', kind: JobKind.minijob, rateCents: 1350),
    ],
  );
  for (final (date, minutes, job) in shifts) {
    b = b
        .addShift(
          (id) => Shift(
            id: id,
            jobId: job,
            date: Day.parse(date),
            minutes: minutes,
          ),
        )
        .$1;
  }
  return b;
}

void main() {
  group('Day', () {
    test('parses and prints yyyy-mm-dd', () {
      expect(Day.parse('2026-03-09').toString(), '2026-03-09');
      expect(Day(2026, 1, 1), Day.parse('2026-01-01'));
    });

    test('adds calendar days across DST and year ends', () {
      // Europe/Berlin springs forward on 29 March 2026, back on 25 October.
      expect(Day(2026, 3, 28).plus(1), Day(2026, 3, 29));
      expect(Day(2026, 3, 29).plus(1), Day(2026, 3, 30));
      expect(Day(2026, 10, 24).plus(2), Day(2026, 10, 26));
      expect(Day(2026, 12, 31).plus(1), Day(2027, 1, 1));
      expect(Day(2028, 2, 28).plus(1), Day(2028, 2, 29));
      expect(Day(2027, 1, 1).plus(-1), Day(2026, 12, 31));
      expect(Day(2026, 3, 1).daysUntil(Day(2026, 4, 1)), 31);
      expect(Day(2026, 10, 1).daysUntil(Day(2026, 11, 1)), 31);
    });

    test('local dates map to the same calendar day', () {
      expect(Day.of(DateTime(2026, 3, 29, 0, 30)), Day(2026, 3, 29));
      expect(Day.of(DateTime(2026, 12, 31, 23, 59)), Day(2026, 12, 31));
      expect(Day(2026, 10, 25).toLocal(), DateTime(2026, 10, 25));
    });

    test('weeks start on Monday, also across New Year', () {
      expect(Day(2026, 9, 23).weekStart, Day(2026, 9, 21));
      expect(Day(2026, 9, 21).weekStart, Day(2026, 9, 21));
      expect(Day(2026, 9, 27).weekStart, Day(2026, 9, 21));
      expect(Day(2027, 1, 1).weekStart, Day(2026, 12, 28));
    });
  });

  group('day status', () {
    test('more than 4 hours is a full day, up to 4 a half day', () {
      expect(statusForMinutes(0, 240), DayStatus.notCounted);
      expect(statusForMinutes(1, 240), DayStatus.half);
      expect(statusForMinutes(240, 240), DayStatus.half);
      expect(statusForMinutes(241, 240), DayStatus.full);
    });

    test('shifts on the same date are added up', () {
      final b = bookWith([
        ('2026-09-23', 180, 'cafe'),
        ('2026-09-23', 180, 'mini'),
      ]);
      expect(dayStatus(b, Day(2026, 9, 23)), DayStatus.full);
    });

    test('university jobs do not count', () {
      final b = bookWith([
        ('2026-09-23', 480, 'uni'),
        ('2026-09-24', 180, 'uni'),
        ('2026-09-24', 60, 'cafe'),
      ]);
      expect(dayStatus(b, Day(2026, 9, 23)), DayStatus.notCounted);
      expect(dayStatus(b, Day(2026, 9, 24)), DayStatus.half);
    });

    test('shifts of a deleted job count, to be safe', () {
      final b = bookWith([('2026-09-23', 300, 'cafe')]);
      final orphan = b.copyWith(jobs: const []);
      expect(dayStatus(orphan, Day(2026, 9, 23)), DayStatus.full);
    });

    test('an edited threshold changes the count', () {
      final b = bookWith([('2026-09-23', 270, 'cafe')]);
      expect(dayStatus(b, Day(2026, 9, 23)), DayStatus.full);
      final b2 = b.copyWith(
        settings: b.settings.copyWith(halfDayMaxMinutes: 300),
      );
      expect(dayStatus(b2, Day(2026, 9, 23)), DayStatus.half);
    });
  });

  group('year usage', () {
    test('counts full and half days per calendar year', () {
      final b = bookWith([
        ('2025-12-31', 480, 'cafe'),
        ('2026-01-01', 480, 'cafe'),
        ('2026-01-02', 120, 'cafe'),
        ('2026-01-03', 120, 'uni'),
        ('2026-12-31', 200, 'cafe'),
        ('2027-01-01', 200, 'cafe'),
      ]);
      final u = yearUsage(b, 2026);
      expect(u.fullDays, 1);
      expect(u.halfDays, 2);
      expect(u.used, 2.0);
      expect(u.left, 138.0);
      expect(yearUsage(b, 2025).used, 1.0);
      expect(yearUsage(b, 2027).used, 0.5);
    });

    test('left can go below zero and reports over', () {
      var b = bookWith([]);
      b = b.copyWith(settings: b.settings.copyWith(fullDayLimit: 2));
      b = b.addShifts([
        for (final d in ['2026-05-04', '2026-05-05', '2026-05-06'])
          (id) =>
              Shift(id: id, jobId: 'cafe', date: Day.parse(d), minutes: 300),
      ]);
      final u = yearUsage(b, 2026);
      expect(u.left, -1.0);
      expect(u.isOver, isTrue);
      expect(u.fraction, 1.0);
    });

    test('counts later dates as upcoming', () {
      final b = bookWith([
        ('2026-09-22', 300, 'cafe'),
        ('2026-09-23', 300, 'cafe'),
        ('2026-09-24', 300, 'cafe'),
        ('2026-09-25', 300, 'uni'),
      ]);
      expect(yearUsage(b, 2026, today: Day(2026, 9, 23)).upcomingDays, 1);
    });
  });

  group('week and month', () {
    test('week hours include every job, Monday to Sunday', () {
      final b = bookWith([
        ('2026-09-20', 600, 'cafe'), // Sunday before
        ('2026-09-21', 240, 'cafe'),
        ('2026-09-23', 150, 'uni'),
        ('2026-09-27', 60, 'mini'),
        ('2026-09-28', 600, 'cafe'), // next Monday
      ]);
      expect(weekMinutes(b, Day(2026, 9, 24)), 450);
    });

    test('a week spanning New Year adds both sides', () {
      final b = bookWith([
        ('2026-12-30', 240, 'cafe'),
        ('2027-01-02', 120, 'cafe'),
      ]);
      expect(weekMinutes(b, Day(2027, 1, 1)), 360);
    });

    test('Minijob pay per month from the hourly rate', () {
      final b = bookWith([
        ('2026-09-01', 90, 'mini'),
        ('2026-09-30', 60, 'mini'),
        ('2026-10-01', 600, 'mini'),
        ('2026-09-15', 600, 'cafe'),
      ]);
      // 2.5 h x 13.50 EUR = 33.75 EUR
      expect(minijobCents(b, 2026, 9), 3375);
      expect(hasMinijob(b), isTrue);
    });

    test('Minijob limit falls back to the latest earlier year', () {
      const s = Settings();
      expect(s.minijobLimitFor(2026), 603);
      expect(s.minijobLimitFor(2027), 633);
      expect(s.minijobLimitFor(2030), 633);
      expect(s.minijobLimitFor(2020), 603);
      expect(s.withMinijobLimit(2028, 650).minijobLimitFor(2029), 650);
    });
  });

  group('plan', () {
    test('places weeks x days work days from the start date', () {
      // Wednesday 23 Sep 2026, Monday to Friday, 2 weeks: 10 dates.
      final days = planDays(PlanInput(start: Day(2026, 9, 23), weeks: 2));
      expect(days, hasLength(10));
      expect(days.first, Day(2026, 9, 23));
      expect(days.last, Day(2026, 10, 6));
      expect(days.every((d) => d.weekday <= 5), isTrue);
    });

    test('reports the date the limit is reached and the overrun', () {
      var b = bookWith([('2026-01-05', 300, 'cafe')]);
      b = b.copyWith(settings: b.settings.copyWith(fullDayLimit: 5));
      // 4 full days left. Plan: Mon-Fri from Mon 3 Aug, 1 week, 8 h.
      final r = runPlan(
        b,
        PlanInput(start: Day(2026, 8, 3), weeks: 1, jobId: 'cafe'),
      );
      final y = r.years.single;
      expect(y.addedHalves, 10);
      expect(y.reachedOn, Day(2026, 8, 6));
      expect(y.overFrom, Day(2026, 8, 7));
      expect(y.lastDayWithin, Day(2026, 8, 6));
      expect(y.leftHalves, -2);
      expect(r.firstLimitYear, y);
    });

    test('a plan that fits leaves the rest of the year', () {
      final b = bookWith([('2026-01-05', 300, 'cafe')]);
      final r = runPlan(
        b,
        PlanInput(
          start: Day(2026, 8, 3),
          weeks: 4,
          daysPerWeek: 3,
          minutesPerDay: 240,
          jobId: 'cafe',
        ),
      );
      final y = r.years.single;
      expect(y.addedHalves, 12);
      expect(y.leftHalves, 280 - 2 - 12);
      expect(y.reachedOn, isNull);
      expect(r.firstLimitYear, isNull);
    });

    test('planned hours add to shifts already logged that day', () {
      final b = bookWith([('2026-08-03', 180, 'cafe')]);
      final r = runPlan(
        b,
        PlanInput(
          start: Day(2026, 8, 3),
          weeks: 1,
          daysPerWeek: 1,
          minutesPerDay: 120,
          jobId: 'cafe',
        ),
      );
      // A half day becomes a full day: one more half-day unit.
      expect(r.years.single.addedHalves, 1);
    });

    test('a plan over New Year counts each year on its own', () {
      var b = bookWith([]);
      b = b.copyWith(settings: b.settings.copyWith(fullDayLimit: 3));
      final r = runPlan(
        b,
        PlanInput(start: Day(2026, 12, 28), weeks: 2, jobId: 'cafe'),
      );
      expect(r.years.map((y) => y.year), [2026, 2027]);
      final y26 = r.years.first;
      final y27 = r.years.last;
      // 28-31 Dec: 4 full days against a limit of 3.
      expect(y26.addedHalves, 8);
      expect(y26.reachedOn, Day(2026, 12, 30));
      expect(y26.overFrom, Day(2026, 12, 31));
      // 1 Jan (Fri) and 4-8 Jan: 6 days.
      expect(y27.addedHalves, 12);
      expect(y27.reachedOn, Day(2027, 1, 5));
      expect(r.firstLimitYear, y26);
    });

    test('a university job plan adds nothing', () {
      final b = bookWith([]);
      final r = runPlan(
        b,
        PlanInput(start: Day(2026, 8, 3), weeks: 30, jobId: 'uni'),
      );
      expect(r.counts, isFalse);
      expect(r.years.every((y) => y.addedHalves == 0), isTrue);
      expect(r.firstLimitYear, isNull);
    });
  });
}
