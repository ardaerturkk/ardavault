import 'package:halfday/model/book.dart';
import 'package:halfday/model/day.dart';

/// "Today" for every golden and screenshot: Thursday, 24 September 2026.
final demoToday = DateTime(2026, 9, 24, 10);

const _jobs = [
  Job(id: 'j1', name: 'Nordlicht Software'),
  Job(
    id: 'j2',
    name: 'Café Hafenblick',
    kind: JobKind.minijob,
    rateCents: 1390,
  ),
  Job(id: 'j3', name: 'Tutor, Computer Science', kind: JobKind.university),
];

Book _book(List<Shift Function(String id)> shifts, {Settings? settings}) =>
    Book(
      jobs: _jobs,
      settings: settings ?? const Settings(),
      nextId: 10,
    ).addShifts(shifts).copyWith(lastJobId: 'j1');

Shift Function(String) _s(String job, Day d, int minutes, [String note = '']) =>
    (id) => Shift(id: id, jobId: job, date: d, minutes: minutes, note: note);

/// Every date from [from] to [to] (inclusive) whose weekday is in [days].
Iterable<Day> _dates(Day from, Day to, Set<int> days) sync* {
  for (var d = from; !d.isAfter(to); d = d.plus(1)) {
    if (days.contains(d.weekday)) yield d;
  }
}

/// Part-time at a software company twice a week, Saturday cafe shifts,
/// tutoring at the university; one day with two shifts, one upcoming shift.
Book typicalBook() => _book([
  for (final d in _dates(Day(2026, 1, 13), Day(2026, 9, 22), {2, 4}))
    _s('j1', d, 6 * 60),
  for (final d in _dates(Day(2026, 6, 6), Day(2026, 9, 19), {6}))
    _s('j2', d, 210),
  for (final d in _dates(Day(2026, 4, 15), Day(2026, 7, 15), {3}))
    _s('j3', d, 120),
  _s('j2', Day(2026, 9, 21), 150),
  _s('j2', Day(2026, 9, 23), 180),
  _s('j1', Day(2026, 9, 23), 150, 'Sprint review'),
  _s('j1', Day(2026, 9, 24), 6 * 60),
  _s('j1', Day(2026, 9, 29), 6 * 60),
]);

/// Almost out of days, and a busy week and month.
Book heavyBook() => _book([
  for (final d in _dates(Day(2026, 1, 5), Day(2026, 9, 18), {1, 2, 3}))
    _s('j1', d, 8 * 60),
  for (final d in _dates(Day(2026, 1, 10), Day(2026, 9, 19), {6}))
    _s('j2', d, 4 * 60),
  _s('j2', Day(2026, 9, 21), 5 * 60, 'Covered for a colleague'),
  _s('j2', Day(2026, 9, 22), 5 * 60),
  _s('j3', Day(2026, 9, 23), 4 * 60),
  _s('j1', Day(2026, 9, 24), 8 * 60),
]);

/// Over the limit, after the limit was lowered.
Book overBook() => typicalBook().copyWith(
  settings: const Settings().copyWith(fullDayLimit: 80),
);
