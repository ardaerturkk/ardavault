import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sheetwise/model/course.dart';
import 'package:sheetwise/model/presets.dart';

void main() {
  const rule = Rule(
    kind: TotalKind.points,
    value: 60,
    bestOf: 10,
    minSheetPercent: 30,
    minSheetCount: 8,
    presentations: 2,
    bonus: [BonusTier(percent: 80, label: '0.3 grade step')],
  );

  Book sample() {
    var (b, id) = const Book().addCourse(
      name: 'Analysis I',
      sheetCount: 3,
      max: 10,
      rule: rule,
      note: 'Tutor: Lena',
    );
    final c = b.course(id)!;
    b = b.withCourse(
      c
          .withSheet(c.sheets[0].graded(7.5))
          .withSheet(c.sheets[1].copyWith(state: SheetState.excused))
          .copyWith(presentationsDone: 1),
    );
    return b.addSheet(id, max: 5, extra: true).$1;
  }

  test('JSON round trip keeps everything', () {
    final b = sample();
    final again = Book.fromJson(
      (jsonDecode(jsonEncode(b.toJson())) as Map).cast<String, Object?>(),
    );
    expect(jsonEncode(again.toJson()), jsonEncode(b.toJson()));
    final c = again.courses.single;
    expect(c.rule, rule);
    expect(c.sheets[0].points, 7.5);
    expect(c.sheets[1].state, SheetState.excused);
    expect(c.sheets.last.extra, isTrue);
    expect(c.presentationsDone, 1);
    expect(c.note, 'Tutor: Lena');
  });

  test('a newer file version is refused rather than misread', () {
    expect(
      () => Book.fromJson({'version': 2, 'courses': <Object?>[]}),
      throwsFormatException,
    );
  });

  test('ids are never reused, even when the counter is missing', () {
    final json = sample().toJson()..remove('nextId');
    final b = Book.fromJson(json);
    final (b2, id) = b.addSheet(b.courses.single.id, max: 10);
    final ids = [for (final s in b2.courses.single.sheets) s.id];
    expect(ids.toSet(), hasLength(ids.length));
    expect(ids, contains(id));
  });

  test('regular and extra sheets are numbered separately', () {
    final c = sample().courses.single;
    expect(c.numberOf(c.sheets[2]), 3);
    expect(c.numberOf(c.sheets[3]), 1);
    expect(c.nextOpen!.id, c.sheets[2].id);
    expect(c.usualMax, 10);
  });

  test('grading and ungrading a sheet', () {
    const s = Sheet(id: 's', max: 10);
    final g = s.graded(4);
    expect(g.earned, 4);
    final back = g.copyWith(state: SheetState.open);
    expect(back.points, isNull);
    expect(back.earned, 0);
    expect(g.copyWith(state: SheetState.missed).earned, 0);
  });

  group('changing the number of sheets', () {
    test('adds sheets before the extra sheets', () {
      final b = sample();
      final c = b.courses.single;
      final grown = b.resizeCourse(c.id, 5, max: 12)!.courses.single;
      expect(grown.regular, hasLength(5));
      expect(grown.sheets.last.extra, isTrue);
      expect(grown.regular.last.max, 12);
    });

    test('removes open sheets from the end', () {
      final b = sample();
      final c = b.courses.single;
      final shrunk = b.resizeCourse(c.id, 2, max: 10)!.courses.single;
      expect(shrunk.regular, hasLength(2));
      expect(shrunk.extras, hasLength(1));
    });

    test('never removes a sheet with a result', () {
      final b = sample();
      expect(b.resizeCourse(b.courses.single.id, 1, max: 10), isNull);
    });
  });

  test('removing a course and a sheet', () {
    final b = sample();
    final c = b.courses.single;
    expect(
      b.removeSheet(c.id, c.sheets[0].id).courses.single.sheets,
      hasLength(3),
    );
    expect(b.removeCourse(c.id).isEmpty, isTrue);
  });

  group('presets', () {
    test('each preset is recognized again', () {
      for (final p in Preset.values) {
        expect(presetOf(presetRule(p, 12), 12), p);
      }
    });

    test('best of drops two sheets', () {
      expect(presetRule(Preset.halfOfBest, 12).bestOf, 10);
      expect(presetRule(Preset.mostSheets, 12).minSheetCount, 10);
      // Too few sheets to drop any.
      expect(presetRule(Preset.halfOfBest, 2).bestOf, 2);
    });

    test('presentations and bonus tiers do not hide the preset', () {
      final r = presetRule(
        Preset.half,
        12,
      ).copyWith(presentations: 1, bonus: const [BonusTier(percent: 80)]);
      expect(presetOf(r, 12), Preset.half);
      expect(presetOf(const Rule(value: 40), 12), isNull);
    });
  });
}
