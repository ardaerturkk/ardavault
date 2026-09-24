import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:halfday/model/book.dart';
import 'package:halfday/model/day.dart';
import 'package:halfday/state/app_state.dart';
import 'package:halfday/state/storage.dart';

Book withJob(Book b, String name) =>
    b.addJob((id) => Job(id: id, name: name)).$1;

void main() {
  test('first launch starts empty with typical limits', () async {
    final s = await AppState.load(MemoryStorage());
    expect(s.book.isEmpty, isTrue);
    expect(s.book.settings.isTypical, isTrue);
    expect(s.loadFailed, isFalse);
  });

  test('changes are saved and read back', () async {
    final storage = MemoryStorage();
    final s = await AppState.load(storage);
    var b = withJob(s.book, 'Cafe');
    b = b
        .addShift(
          (id) => Shift(
            id: id,
            jobId: b.jobs.single.id,
            date: Day(2026, 9, 23),
            minutes: 210,
            note: 'Late',
          ),
        )
        .$1;
    b = b.copyWith(settings: b.settings.withMinijobLimit(2028, 650));
    s.update(b);
    await s.flush();
    final again = await AppState.load(storage);
    final shift = again.book.shifts.single;
    expect(shift.date, Day(2026, 9, 23));
    expect(shift.minutes, 210);
    expect(shift.note, 'Late');
    expect(again.book.lastJobId, shift.jobId);
    expect(again.book.settings.minijobLimitFor(2028), 650);
    expect(again.book.nextId, b.nextId);
  });

  test('an unreadable file is kept aside and the app still starts', () async {
    final storage = MemoryStorage('{not json');
    final s = await AppState.load(storage);
    expect(s.loadFailed, isTrue);
    expect(storage.setAside, '{not json');
    expect(s.book.isEmpty, isTrue);
    s.dismissLoadError();
    expect(s.loadFailed, isFalse);
  });

  test('if the bad file cannot be moved aside, nothing overwrites it', () async {
    final storage = MemoryStorage('{bad')..failSetAside = true;
    final s = await AppState.load(storage);
    s.update(withJob(s.book, 'A'));
    await s.flush();
    expect(storage.contents, '{bad');
    expect(s.saveFailed, isTrue);
  });

  test('a read error also sets the file aside', () async {
    final storage = MemoryStorage('{"shifts":[]}')..failReads = true;
    final s = await AppState.load(storage);
    expect(s.loadFailed, isTrue);
    expect(storage.setAside, '{"shifts":[]}');
  });

  test('a failed save is reported and cleared by the next good save', () async {
    final storage = MemoryStorage()..failWrites = true;
    final s = await AppState.load(storage);
    s.update(withJob(s.book, 'A'));
    await s.flush();
    expect(s.saveFailed, isTrue);
    storage.failWrites = false;
    s.update(withJob(s.book, 'B'));
    await s.flush();
    expect(s.saveFailed, isFalse);
    expect((jsonDecode(storage.contents!) as Map)['jobs'], hasLength(2));
  });

  test('a file without an id counter continues after the highest id', () {
    final b = Book.fromJson({
      'jobs': [
        {'id': 'j7', 'name': 'A'},
      ],
      'shifts': [
        {'id': 's12', 'jobId': 'j7', 'date': '2026-01-02', 'minutes': 60},
      ],
    });
    expect(b.nextId, 13);
    expect(b.settings.fullDayLimit, 140);
  });

  test('broken limits fall back to typical values', () {
    final s = Settings.fromJson({'fullDayLimit': 0, 'weeklyHourLimit': -3});
    expect(s.fullDayLimit, 140);
    expect(s.weeklyHourLimit, 20);
    expect(s.minijobLimitFor(2027), 633);
  });

  test('deleting a job removes its shifts', () {
    var b = withJob(const Book(), 'A');
    b = withJob(b, 'B');
    for (final j in b.jobs) {
      b = b
          .addShift(
            (id) =>
                Shift(id: id, jobId: j.id, date: Day(2026, 1, 5), minutes: 60),
          )
          .$1;
    }
    final a = b.jobs.first.id;
    expect(b.shiftCountFor(a), 1);
    b = b.removeJob(a);
    expect(b.jobs, hasLength(1));
    expect(b.shifts.single.jobId, isNot(a));
  });

  test('the plan starts tomorrow with the last job', () {
    final b = withJob(const Book(), 'Cafe');
    final s = AppState(
      MemoryStorage(),
      book: b,
      now: () => DateTime(2026, 12, 31, 23, 30),
    );
    expect(s.planInput.start, Day(2027, 1, 1));
    expect(s.planInput.jobId, b.jobs.single.id);
  });

  test('FileStorage writes atomically into its directory', () async {
    final dir = await Directory.systemTemp.createTemp('hd');
    addTearDown(() => dir.delete(recursive: true));
    final f = FileStorage(dir);
    expect(await f.read(), isNull);
    await f.write('{"a":1}');
    await f.write('{"a":2}');
    expect(await f.read(), '{"a":2}');
    await f.setAsideUnreadable();
    expect(await f.read(), isNull);
    expect(dir.listSync().single.path, contains('unreadable'));
  });
}
