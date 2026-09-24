import 'package:flutter_test/flutter_test.dart';
import 'package:sheetwise/model/admission.dart';
import 'package:sheetwise/model/course.dart';

/// Builds a course from a compact list: a number is a graded sheet, 'o' is
/// open, 'x' not handed in, 'e' excused. Every sheet has [max] points.
Course course(
  List<Object> sheets, {
  Rule rule = const Rule(),
  double max = 10,
  List<Object> extras = const [],
  int presentations = 0,
}) {
  var i = 0;
  Sheet make(Object o, {bool extra = false}) {
    final id = 's${i++}';
    return switch (o) {
      final num p => Sheet(
        id: id,
        max: max,
        points: p.toDouble(),
        state: SheetState.graded,
        extra: extra,
      ),
      'o' => Sheet(id: id, max: max, extra: extra),
      'x' => Sheet(id: id, max: max, state: SheetState.missed, extra: extra),
      'e' => Sheet(id: id, max: max, state: SheetState.excused, extra: extra),
      _ => throw ArgumentError(o),
    };
  }

  return Course(
    id: 'c',
    name: 'Test',
    sheets: [
      for (final s in sheets) make(s),
      for (final s in extras) make(s, extra: true),
    ],
    rule: rule,
    presentationsDone: presentations,
  );
}

Sheet sheet(String id, double max, [double? points]) => points == null
    ? Sheet(id: id, max: max)
    : Sheet(id: id, max: max, points: points, state: SheetState.graded);

void main() {
  group('share of all points', () {
    test('fresh course: half of every sheet', () {
      final a = evaluate(course(['o', 'o', 'o', 'o']));
      expect(a.verdict, Verdict.possible);
      expect(a.fraction, closeTo(0.5, 1e-9));
      expect(a.needed, 20);
      expect(a.missing, 20);
      expect(a.counted, 0);
      expect(pointsOn(a.fraction!, 10), 5);
      expect(a.sameMax, 10);
    });

    test('good start lowers the need per remaining sheet', () {
      // 12 sheets of 10, need 60. 5 graded with 43 points: 17 in 7 sheets.
      final a = evaluate(
        course([9, 8, 10, 7, 9, 'o', 'o', 'o', 'o', 'o', 'o', 'o']),
      );
      expect(a.counted, 43);
      expect(a.missing, 17);
      expect(a.fraction! * 70, closeTo(17, 1e-6));
      // 17 / 7 = 2.428...: rounded up, never down.
      expect(pointsOn(a.fraction!, 10), 2.5);
    });

    test('exactly on the threshold counts as admitted', () {
      final a = evaluate(course([5, 5, 5, 5]));
      expect(a.verdict, Verdict.admitted);
      expect(a.missing, 0);
    });

    test('half a point short is not admitted', () {
      final a = evaluate(course([5, 5, 5, 4.5]));
      expect(a.verdict, Verdict.outOfReach);
      expect(a.missing, closeTo(0.5, 1e-9));
    });

    test('admitted early: the remaining sheets are not needed', () {
      final a = evaluate(course([10, 10, 10, 'o', 'o', 'o']));
      expect(a.verdict, Verdict.admitted);
      expect(a.fraction, isNull);
    });

    test('out of reach when full points on every open sheet fall short', () {
      final a = evaluate(course([0, 0, 0, 1, 'o']));
      expect(a.verdict, Verdict.outOfReach);
      expect(a.pointsPossible, isFalse);
      expect(a.fraction, isNull);
    });

    test('needing every remaining point is still possible', () {
      final a = evaluate(course([0, 0, 'o', 'o', 'o', 'o']));
      // Need 30 of 60, 40 open: 75 %.
      expect(a.verdict, Verdict.possible);
      expect(pointsOn(a.fraction!, 10), 7.5);
      final b = evaluate(course([0, 0, 0, 'o', 'o', 'o']));
      expect(b.verdict, Verdict.possible);
      expect(pointsOn(b.fraction!, 10), 10);
    });

    test('odd totals: 50 % of 115 needs 57.5', () {
      final c = Course(
        id: 'c',
        name: 'x',
        sheets: [
          sheet('a', 15, 10),
          for (var i = 0; i < 5; i++) sheet('b$i', 20, i < 2 ? 12 : null),
        ],
      );
      final a = evaluate(c);
      expect(a.needed, 57.5);
      expect(a.missing, closeTo(23.5, 1e-9));
      // Open: three sheets of 20 = 60; 23.5 / 60 = 39.17 %.
      expect(a.fraction, closeTo(23.5 / 60, 1e-9));
      expect(pointsOn(a.fraction!, 20), 7.9);
    });

    test('percentages that are not exact in binary still compare right', () {
      // 33.3 % of 30 = 9.99: 9.99 points is enough, 9.98 is not.
      const rule = Rule(value: 33.3);
      expect(evaluate(course([3.33, 3.33, 3.33], rule: rule)).admitted, isTrue);
      expect(
        evaluate(course([3.33, 3.33, 3.32], rule: rule)).admitted,
        isFalse,
      );
      // 0.1 + 0.2 style sums.
      expect(
        evaluate(course([0.1, 0.2, 0.0], rule: const Rule(value: 1), max: 10))
            .admitted,
        isTrue,
      );
    });

    test('sheets not handed in count as zero', () {
      final a = evaluate(course([10, 'x', 'o', 'o']));
      expect(a.counted, 10);
      expect(a.needed, 20);
      expect(a.fraction! * 20, closeTo(10, 1e-6));
    });

    test('excused sheets leave the total', () {
      final a = evaluate(course([6, 'e', 'o', 'o']));
      expect(a.countedMax, 30);
      expect(a.needed, 15);
      expect(a.missing, 9);
      expect(pointsOn(a.fraction!, 10), 4.5);
    });

    test('points above the maximum (bonus tasks) count', () {
      final a = evaluate(course([12, 'o']));
      expect(a.counted, 12);
      expect(a.verdict, Verdict.admitted);
      expect(a.share, closeTo(0.6, 1e-9));
    });

    test('sheets of different sizes: the need is a share', () {
      final c = Course(
        id: 'c',
        name: 'x',
        sheets: [sheet('a', 10, 5), sheet('b', 20), sheet('c', 30)],
      );
      final a = evaluate(c);
      // Need 30, have 5: 25 of 50 open = 50 %.
      expect(a.sameMax, isNull);
      expect(percentUp(a.fraction!), 50);
    });

    test('zero-point sheets change nothing', () {
      final c = Course(
        id: 'c',
        name: 'x',
        sheets: [
          sheet('p', 0, 0),
          sheet('q', 0),
          sheet('a', 10, 5),
          sheet('b', 10),
        ],
      );
      final a = evaluate(c);
      expect(a.countedMax, 20);
      expect(a.needed, 10);
      expect(a.openSheets.map((s) => s.id), ['b']);
      expect(pointsOn(a.fraction!, 10), 5);
    });

    test('a rule of zero percent is met at once', () {
      final a = evaluate(course(['o', 'o'], rule: const Rule(value: 0)));
      expect(a.verdict, Verdict.admitted);
    });

    test('100 percent needs every point', () {
      final a = evaluate(course([10, 'o'], rule: const Rule(value: 100)));
      expect(pointsOn(a.fraction!, 10), 10);
      expect(
        evaluate(course([9.5, 'o'], rule: const Rule(value: 100))).verdict,
        Verdict.outOfReach,
      );
    });
  });

  group('fixed points', () {
    const rule = Rule(kind: TotalKind.points, value: 60);

    test('needs the stated points no matter the total', () {
      final a = evaluate(course([10, 10, 'o', 'o', 'o', 'o'], rule: rule));
      expect(a.needed, 60);
      expect(a.missing, 40);
      expect(pointsOn(a.fraction!, 10), 10);
    });

    test('more than all points is out of reach from the start', () {
      final a = evaluate(course(['o', 'o', 'o', 'o', 'o'], rule: rule));
      expect(a.verdict, Verdict.outOfReach);
    });

    test('reached', () {
      expect(
        evaluate(course([10, 10, 10, 10, 10, 10, 'o'], rule: rule)).admitted,
        isTrue,
      );
    });
  });

  group('best n of m', () {
    const best10 = Rule(bestOf: 10);

    test('the worst sheets are dropped', () {
      // 12 sheets, best 10 count: total 100, need 50.
      final a = evaluate(
        course([0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5], rule: best10),
      );
      expect(a.countedMax, 100);
      expect(a.counted, 50);
      expect(a.verdict, Verdict.admitted);
    });

    test('without the drop the same grades would fail', () {
      final a = evaluate(course([0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5]));
      expect(a.verdict, Verdict.outOfReach);
    });

    test('open sheets can replace bad ones', () {
      // Two zeros so far; with 10 open and best 10 of 12, the zeros drop.
      final a = evaluate(
        course([0, 0, for (var i = 0; i < 10; i++) 'o'], rule: best10),
      );
      expect(a.verdict, Verdict.possible);
      expect(a.fraction, closeTo(0.5, 1e-9));
    });

    test('skipping one sheet costs nothing while drops remain', () {
      final c = course([6, 6, 'o', 'o', 'o', 'o'], rule: const Rule(bestOf: 5));
      final a = evaluate(c);
      // Best 5 of 6: need 25. Have 12; open sheets: 13 more. Four open,
      // best five counted: the equal share f solves 12 + 3f*10 = 25 when
      // the lowest open sheet is dropped: f = 13/30.
      expect(a.fraction, closeTo(13 / 30, 1e-6));
      final skip = evaluateSkipping(c, c.nextOpen!.id);
      expect(skip.fraction, closeTo(13 / 30, 1e-6));
      // Skipping two costs points.
      final skip2 = evaluate(
        c
            .withSheet(c.sheets[2].copyWith(state: SheetState.missed))
            .withSheet(c.sheets[3].copyWith(state: SheetState.missed)),
      );
      expect(skip2.fraction, closeTo(13 / 20, 1e-6));
    });

    test('ties: equal sheets give the same result whichever is dropped', () {
      final a = evaluate(course([7, 7, 7, 3, 3], rule: const Rule(bestOf: 4)));
      expect(a.counted, 24);
      expect(a.countedMax, 40);
    });

    test('best n larger than the number of sheets counts all', () {
      final a = evaluate(course([5, 5, 'o'], rule: const Rule(bestOf: 10)));
      expect(a.countedMax, 30);
      expect(a.needed, 15);
    });

    test('excused sheets shrink the pool, not n', () {
      final a = evaluate(
        course([8, 'e', 'e', 2, 'o'], rule: const Rule(bestOf: 3)),
      );
      // Pool: 8, 2, open. Best 3 = all three: total 30, need 15.
      expect(a.countedMax, 30);
      expect(a.missing, 5);
      expect(pointsOn(a.fraction!, 10), 5);
    });

    test('different sizes: drops the sheet that helps least', () {
      // Best 2 of 3 at 50 %: sheet a 4/20 (-6), b 5/10 (0), c 9/10 (+4).
      final c = Course(
        id: 'c',
        name: 'x',
        rule: const Rule(bestOf: 2),
        sheets: [sheet('a', 20, 4), sheet('b', 10, 5), sheet('c', 10, 9)],
      );
      final a = evaluate(c);
      expect(a.countedMax, 20);
      expect(a.counted, 14);
      expect(a.admitted, isTrue);
    });

    test('fixed points with best n picks the most points', () {
      final a = evaluate(
        course([
          2,
          9,
          8,
          'o',
        ], rule: const Rule(kind: TotalKind.points, value: 25, bestOf: 3)),
      );
      // Now: 9 + 8 + 2 (the open sheet still counts as zero).
      expect(a.counted, 19);
      expect(a.missing, 6);
      // Open sheet must bring 8 so that 9 + 8 + 8 = 25.
      expect(pointsOn(a.fraction!, 10), 8);
    });
  });

  group('minimum per sheet', () {
    const rule = Rule(minSheetPercent: 30);

    test('every sheet must reach it', () {
      final a = evaluate(course([10, 10, 2, 'o'], rule: rule));
      expect(a.passed, 2);
      expect(a.passesRequired, 4);
      expect(a.verdict, Verdict.outOfReach);
      expect(a.pointsOk, isTrue);
    });

    test('the minimum raises the need when points alone would be less', () {
      final a = evaluate(course([10, 10, 10, 'o'], rule: rule));
      // Points: already 30 of 40 needed 20. The last sheet still needs 30 %.
      expect(a.pointsOk, isTrue);
      expect(a.verdict, Verdict.possible);
      expect(pointsOn(a.fraction!, 10), 3);
    });

    test('exactly the minimum passes', () {
      final a = evaluate(course([3, 10, 'o'], rule: rule));
      expect(a.passed, 2);
    });

    test('a sheet not handed in fails the minimum', () {
      final a = evaluate(course([10, 'x', 'o'], rule: rule));
      expect(a.verdict, Verdict.outOfReach);
      expect(a.sheetsPossible, isFalse);
    });

    test('excused sheets are not required', () {
      final a = evaluate(course([10, 'e', 5], rule: rule));
      expect(a.passesRequired, 2);
      expect(a.admitted, isTrue);
    });

    test('with best n, only n sheets must reach it', () {
      final a = evaluate(
        course([
          10,
          10,
          10,
          0,
        ], rule: const Rule(bestOf: 3, minSheetPercent: 30)),
      );
      expect(a.passesRequired, 3);
      expect(a.admitted, isTrue);
    });

    test('at least k sheets, without a total', () {
      const r = Rule(
        kind: TotalKind.none,
        minSheetPercent: 50,
        minSheetCount: 3,
      );
      final a = evaluate(course([6, 2, 'o', 'o'], rule: r));
      expect(a.hasTotal, isFalse);
      expect(a.passed, 1);
      expect(a.passesRequired, 3);
      expect(a.verdict, Verdict.possible);
      expect(pointsOn(a.fraction!, 10), 5);
      final b = evaluate(course([6, 2, 1, 'o'], rule: r));
      expect(b.verdict, Verdict.outOfReach);
      final c = evaluate(course([6, 5, 1, 7], rule: r));
      expect(c.admitted, isTrue);
    });

    test('zero-point sheets are never required', () {
      final c = Course(
        id: 'c',
        name: 'x',
        rule: rule,
        sheets: [sheet('p', 0, 0), sheet('a', 10, 5)],
      );
      final a = evaluate(c);
      expect(a.passesRequired, 1);
      expect(a.admitted, isTrue);
    });

    test('extra sheets do not count for the minimum', () {
      final a = evaluate(course([5], extras: [0], rule: rule));
      expect(a.passesRequired, 1);
      expect(a.admitted, isTrue);
    });
  });

  group('extra sheets', () {
    test('their points count, their maximum does not', () {
      final a = evaluate(course([4, 4], extras: [2]));
      expect(a.countedMax, 20);
      expect(a.counted, 10);
      expect(a.admitted, isTrue);
    });

    test('an open extra sheet is a chance too', () {
      final a = evaluate(course([0, 0, 0, 'o'], extras: ['o']));
      // Need 20 of 40; open: one regular and one extra sheet of 10.
      expect(a.verdict, Verdict.possible);
      expect(a.openSheets, hasLength(2));
      expect(pointsOn(a.fraction!, 10), 10);
    });

    test('extras with best n are never dropped', () {
      final a = evaluate(
        course([10, 0, 0], extras: [5], rule: const Rule(bestOf: 2)),
      );
      expect(a.counted, 15);
      expect(a.countedMax, 20);
    });

    test('excused extra sheets are ignored', () {
      final a = evaluate(course([4, 4], extras: ['e']));
      expect(a.openSheets, isEmpty);
      expect(a.verdict, Verdict.outOfReach);
    });
  });

  group('presentations', () {
    const rule = Rule(presentations: 2);

    test('points are enough but a presentation is missing', () {
      final a = evaluate(course([10, 10], rule: rule, presentations: 1));
      expect(a.verdict, Verdict.possible);
      expect(a.onlyPresentationsLeft, isTrue);
      expect(a.fraction, 0);
    });

    test('all done', () {
      final a = evaluate(course([10, 10], rule: rule, presentations: 2));
      expect(a.admitted, isTrue);
    });

    test('presentations never make it out of reach', () {
      final a = evaluate(course([10, 10, 'o'], rule: rule));
      expect(a.verdict, Verdict.possible);
    });

    test('only presentations', () {
      const r = Rule(kind: TotalKind.none, presentations: 1);
      expect(evaluate(course(['o'], rule: r)).verdict, Verdict.possible);
      expect(
        evaluate(course(['o'], rule: r, presentations: 1)).admitted,
        isTrue,
      );
    });
  });

  group('bonus tiers', () {
    const rule = Rule(
      bonus: [
        BonusTier(percent: 90, label: '1.0 step'),
        BonusTier(percent: 75, label: '0.3 step'),
      ],
    );

    test('next tier and the share it needs', () {
      final a = evaluate(course([8, 8, 'o', 'o'], rule: rule));
      expect(a.bonusReached, isNull);
      expect(a.nextBonus!.percent, 75);
      // 30 of 40 needed, 16 in: 14 of 20.
      expect(pointsOn(a.nextBonusFraction!, 10), 7);
    });

    test('reached tier and the next one', () {
      final a = evaluate(course([10, 10, 10, 'o'], rule: rule));
      expect(a.bonusReached!.percent, 75);
      expect(a.nextBonus!.percent, 90);
      // 36 needed, 30 in.
      expect(pointsOn(a.nextBonusFraction!, 10), 6);
    });

    test('a tier out of reach has no share', () {
      final a = evaluate(course([2, 2, 10, 'o'], rule: rule));
      expect(a.nextBonus!.percent, 75);
      expect(a.nextBonusFraction, isNull);
    });

    test('all tiers reached', () {
      final a = evaluate(course([10, 10, 10, 10], rule: rule));
      expect(a.bonusReached!.percent, 90);
      expect(a.nextBonus, isNull);
    });

    test('tiers use the same best-n total', () {
      final a = evaluate(
        course([
          9,
          9,
          9,
          0,
        ], rule: const Rule(bestOf: 3, bonus: [BonusTier(percent: 90)])),
      );
      expect(a.bonusReached, isNotNull);
    });
  });

  group('no sheets', () {
    test('an empty course says so instead of "admitted"', () {
      expect(evaluate(course([])).verdict, Verdict.noSheets);
      expect(evaluate(course(['e', 'e'])).verdict, Verdict.noSheets);
    });
  });

  group('rule changed mid-semester', () {
    test('grades stay, the verdict follows the new rule', () {
      final c = course([6, 6, 6, 'o', 'o', 'o']);
      expect(pointsOn(evaluate(c).fraction!, 10), 4);
      final stricter = c.copyWith(rule: const Rule(value: 60));
      expect(pointsOn(evaluate(stricter).fraction!, 10), 6);
      final dropped = c.copyWith(rule: const Rule(value: 60, bestOf: 5));
      // Best 5 of 6: need 30, have 18: 12 in 2 of 3 open sheets. Equal
      // share over 3 open with one dropped: 18 + 2f*10 = 30, f = 0.6.
      expect(pointsOn(evaluate(dropped).fraction!, 10), 6);
      expect(stricter.sheets, c.sheets);
    });

    test('adding a minimum per sheet can flip admitted to out of reach', () {
      final c = course([10, 10, 1, 10]);
      expect(evaluate(c).admitted, isTrue);
      final strict = c.copyWith(rule: const Rule(minSheetPercent: 20));
      expect(evaluate(strict).verdict, Verdict.outOfReach);
    });
  });

  group('rounding for display', () {
    test('points round up to a tenth, never above the maximum', () {
      expect(pointsOn(0.72, 10), 7.2);
      expect(pointsOn(0.7201, 10), 7.3);
      expect(pointsOn(0.7, 10), 7);
      expect(pointsOn(1, 7.25), 7.25);
      expect(pointsOn(0, 10), 0);
    });

    test('needed percent rounds up, current percent rounds down', () {
      expect(percentUp(0.501), 51);
      expect(percentUp(0.5), 50);
      expect(percentDown(0.4999), 49.9);
      expect(percentDown(0.5), 50);
      expect(percentDown(1 / 3), 33.3);
    });
  });

  group('risk order', () {
    test('out of reach first, then highest need, admitted last', () {
      final lost = course([0, 0, 0, 'o']).copyWith(name: 'Lost');
      final hard = course([2, 'o', 'o']).copyWith(name: 'Hard');
      final easy = course([9, 'o', 'o']).copyWith(name: 'Easy');
      final done = course([10, 10]).copyWith(name: 'Done');
      expect(byRisk([done, easy, lost, hard]).map((c) => c.name), [
        'Lost',
        'Hard',
        'Easy',
        'Done',
      ]);
    });
  });
}
