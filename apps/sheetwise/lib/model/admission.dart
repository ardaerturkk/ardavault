/// The arithmetic of exam admission. Everything here is pure and derived
/// from a [Course]; nothing is stored.
///
/// Semantics, in plain words:
/// - Regular sheets that are not excused form the total. Excused sheets
///   leave it; sheets not handed in count as zero.
/// - With "best n", the n regular sheets that help most count (the ones
///   furthest above the required share). All others are dropped.
/// - Points from extra sheets always count; their maximum never adds to
///   the total.
/// - The minimum per sheet is a separate condition: at least k regular
///   sheets (k = every counted sheet unless stated) must reach the given
///   share of their own points.
/// - "Needed per remaining sheet" is the smallest equal share of every open
///   sheet that meets all conditions.
library;

import 'dart:math' as math;

import 'course.dart';

/// Tolerance for comparing points: 57.5 of 57.5 must pass even after
/// floating-point arithmetic.
const _eps = 1e-6;

enum Verdict {
  /// Every condition is met with the grades entered so far.
  admitted,

  /// Not yet, but the open sheets can still get there.
  possible,

  /// Even full points on every open sheet would not be enough.
  outOfReach,

  /// There are no sheets to count yet.
  noSheets,
}

class Admission {
  const Admission._({
    required this.verdict,
    required this.hasTotal,
    required this.counted,
    required this.countedMax,
    required this.needed,
    required this.missing,
    required this.pointsOk,
    required this.pointsPossible,
    required this.hasSheetMin,
    required this.passed,
    required this.passesRequired,
    required this.sheetsPossible,
    required this.presentationsDone,
    required this.presentationsRequired,
    required this.fraction,
    required this.openSheets,
    required this.bonusReached,
    required this.nextBonus,
    required this.nextBonusFraction,
  });

  final Verdict verdict;

  /// The rule has a condition on the total.
  final bool hasTotal;

  /// Points that count right now (best n plus extra sheets).
  final double counted;

  /// The total the share refers to (maximum of the counted sheets).
  final double countedMax;

  /// Points needed for the total condition; null without one.
  final double? needed;

  /// Points still missing for the total condition (zero when met).
  final double missing;

  final bool pointsOk;
  final bool pointsPossible;

  final bool hasSheetMin;

  /// Sheets that reached the minimum share so far.
  final int passed;

  /// Sheets that must reach it.
  final int passesRequired;
  final bool sheetsPossible;

  final int presentationsDone;
  final int presentationsRequired;

  /// Share of every open sheet still needed (0 to 1). Null when admitted
  /// or out of reach. Zero when only presentations are missing.
  final double? fraction;

  /// Open sheets that can still earn points (maximum above zero).
  final List<Sheet> openSheets;

  final BonusTier? bonusReached;

  /// The lowest bonus tier not reached yet.
  final BonusTier? nextBonus;

  /// Share of every open sheet needed for [nextBonus]; null when it is out
  /// of reach.
  final double? nextBonusFraction;

  bool get sheetsOk => passed >= passesRequired;
  bool get presentationsOk => presentationsDone >= presentationsRequired;
  bool get admitted => verdict == Verdict.admitted;

  /// Current share of the total, 0 to 1 (can pass 1 with extra points).
  double get share => countedMax <= 0 ? 0 : counted / countedMax;

  /// Only presentations stand between the student and admission.
  bool get onlyPresentationsLeft =>
      verdict == Verdict.possible && pointsOk && sheetsOk && !presentationsOk;

  /// The maximum shared by every open sheet, or null when they differ (or
  /// none is open). Then "7.5 of 10 per sheet" can be said; otherwise a
  /// share.
  double? get sameMax {
    if (openSheets.isEmpty) return null;
    final m = openSheets.first.max;
    return openSheets.every((s) => s.max == m) ? m : null;
  }
}

/// Points needed on a sheet of [max] points at [fraction], rounded up to a
/// tenth so the app never says less than is needed.
double pointsOn(double fraction, double max) {
  final raw = fraction * max;
  final up = (raw * 10 - 1e-7).ceilToDouble() / 10;
  return math.min(max, math.max(0, up));
}

/// Whole percent, rounded up: "72 %" means at least 72 % is enough.
double percentUp(double fraction) =>
    math.max(0, (fraction * 100 - 1e-7).ceilToDouble());

/// Whole-tenth percent, rounded down: "49.9 %" is never shown as "50 %".
double percentDown(double fraction) =>
    (fraction * 1000 + 1e-7).floorToDouble() / 10;

class _Pick {
  const _Pick(this.points, this.max, this.margin);
  final double points;
  final double max;
  final double margin;
}

/// Picks the n sheets with the largest margin (points minus the required
/// share of their maximum) and sums them.
_Pick _pick(
  List<Sheet> sheets,
  int n,
  double share,
  double Function(Sheet) pointsOf,
) {
  final items = [
    for (final s in sheets)
      (points: pointsOf(s), max: s.max, margin: pointsOf(s) - share * s.max),
  ];
  // Larger margin first; on a tie, the larger sheet (a bigger basis only
  // helps once the share is met, and keeps results stable).
  items.sort((a, b) {
    final c = b.margin.compareTo(a.margin);
    return c != 0 ? c : b.max.compareTo(a.max);
  });
  var points = 0.0;
  var max = 0.0;
  var margin = 0.0;
  for (final it in items.take(n)) {
    points += it.points;
    max += it.max;
    margin += it.margin;
  }
  return _Pick(points, max, margin);
}

/// One condition on the total: share of the counted total ([share], 0-1)
/// or a fixed number of points ([target]).
class _Goal {
  const _Goal.share(this.share) : target = 0;
  const _Goal.points(this.target) : share = 0;
  final double share;
  final double target;
}

class _Setup {
  _Setup(Course c)
    : counting = [
        for (final s in c.regular)
          if (s.state != SheetState.excused) s,
      ],
      extras = [
        for (final s in c.extras)
          if (s.state != SheetState.excused) s,
      ] {
    final best = c.rule.bestOf;
    n = best == null ? counting.length : math.min(best, counting.length);
  }

  final List<Sheet> counting;
  final List<Sheet> extras;
  late final int n;

  /// Margin over [goal] if every open sheet scores [f] of its maximum.
  double margin(_Goal goal, double f) {
    double pointsOf(Sheet s) => s.isOpen ? f * s.max : s.earned;
    final pick = _pick(counting, n, goal.share, pointsOf);
    var extra = 0.0;
    for (final s in extras) {
      extra += pointsOf(s);
    }
    return pick.margin + extra - goal.target;
  }

  bool ok(_Goal goal, double f) => margin(goal, f) >= -_eps;

  /// Smallest equal share of every open sheet that meets [goal]; null when
  /// even full points are not enough.
  double? fractionFor(_Goal goal) {
    if (ok(goal, 0)) return 0;
    if (!ok(goal, 1)) return null;
    var lo = 0.0;
    var hi = 1.0;
    // Search without the tolerance so the result is never below the true
    // share: shown numbers are rounded up from here.
    for (var i = 0; i < 60; i++) {
      final mid = (lo + hi) / 2;
      if (margin(goal, mid) >= -1e-12) {
        hi = mid;
      } else {
        lo = mid;
      }
    }
    return hi;
  }
}

Admission evaluate(Course c) {
  final rule = c.rule;
  final setup = _Setup(c);

  final _Goal? goal = switch (rule.kind) {
    TotalKind.percent => _Goal.share(rule.value / 100),
    TotalKind.points => _Goal.points(rule.value),
    TotalKind.none => null,
  };

  // What counts now, with open sheets at zero.
  final now = _pick(setup.counting, setup.n, goal?.share ?? 0, (s) => s.earned);
  var extraNow = 0.0;
  for (final s in setup.extras) {
    extraNow += s.earned;
  }
  final counted = now.points + extraNow;
  final countedMax = now.max;

  double? needed;
  var missing = 0.0;
  var pointsOk = true;
  var pointsPossible = true;
  double? pointsFraction = 0;
  if (goal != null) {
    needed = rule.kind == TotalKind.percent
        ? goal.share * countedMax
        : goal.target;
    missing = math.max(0, -setup.margin(goal, 0));
    if (missing <= _eps) missing = 0;
    pointsOk = setup.ok(goal, 0);
    pointsFraction = setup.fractionFor(goal);
    pointsPossible = pointsFraction != null;
  }

  // Minimum per sheet.
  final minShare = rule.minSheetPercent == null
      ? null
      : rule.minSheetPercent! / 100;
  final eligible = [
    for (final s in setup.counting)
      if (s.max > 0) s,
  ];
  var passed = 0;
  var openEligible = 0;
  var required = 0;
  if (minShare != null) {
    for (final s in eligible) {
      if (s.isOpen) {
        openEligible++;
      } else if (s.state == SheetState.graded &&
          s.earned >= minShare * s.max - _eps) {
        passed++;
      }
    }
    required =
        rule.minSheetCount ??
        (rule.bestOf == null
            ? eligible.length
            : math.min(rule.bestOf!, eligible.length));
  }
  final sheetsOk = passed >= required;
  final sheetsPossible = passed + openEligible >= required;

  final presentationsOk = c.presentationsDone >= rule.presentations;

  final openSheets = [
    for (final s in [...setup.counting, ...setup.extras])
      if (s.isOpen && s.max > 0) s,
  ];

  final noSheets =
      setup.counting.every((s) => s.max <= 0) &&
      setup.extras.isEmpty &&
      (goal != null || minShare != null);

  final Verdict verdict;
  double? fraction;
  if (noSheets) {
    verdict = Verdict.noSheets;
  } else if (pointsOk && sheetsOk && presentationsOk) {
    verdict = Verdict.admitted;
  } else if (!pointsPossible || !sheetsPossible) {
    verdict = Verdict.outOfReach;
  } else {
    verdict = Verdict.possible;
    fraction = math.max(
      pointsOk ? 0 : pointsFraction!,
      sheetsOk ? 0 : minShare!,
    );
  }

  // Bonus tiers, as shares of the counted total.
  BonusTier? reached;
  BonusTier? next;
  double? nextFraction;
  if (!noSheets) {
    final tiers = [...rule.bonus]
      ..sort((a, b) => a.percent.compareTo(b.percent));
    for (final t in tiers) {
      final g = _Goal.share(t.percent / 100);
      if (setup.ok(g, 0)) {
        reached = t;
      } else {
        next = t;
        nextFraction = setup.fractionFor(g);
        break;
      }
    }
  }

  return Admission._(
    verdict: verdict,
    hasTotal: goal != null,
    counted: counted,
    countedMax: countedMax,
    needed: needed,
    missing: missing,
    pointsOk: pointsOk,
    pointsPossible: pointsPossible,
    hasSheetMin: minShare != null,
    passed: passed,
    passesRequired: required,
    sheetsPossible: sheetsPossible,
    presentationsDone: c.presentationsDone,
    presentationsRequired: rule.presentations,
    fraction: fraction,
    openSheets: openSheets,
    bonusReached: reached,
    nextBonus: next,
    nextBonusFraction: nextFraction,
  );
}

/// What if [sheetId] is not handed in? Nothing is saved.
Admission evaluateSkipping(Course c, String sheetId) {
  final s = c.sheet(sheetId);
  if (s == null) return evaluate(c);
  return evaluate(c.withSheet(s.copyWith(state: SheetState.missed)));
}

/// Most at risk first: out of reach, then the highest share still needed,
/// then admitted. Ties by name.
List<Course> byRisk(List<Course> courses) {
  final ranked = [for (final c in courses) (c, evaluate(c))];
  int rank(Admission a) => switch (a.verdict) {
    Verdict.outOfReach => 0,
    Verdict.possible => 1,
    Verdict.noSheets => 2,
    Verdict.admitted => 3,
  };
  ranked.sort((x, y) {
    final r = rank(x.$2).compareTo(rank(y.$2));
    if (r != 0) return r;
    final f = (y.$2.fraction ?? 0).compareTo(x.$2.fraction ?? 0);
    if (f != 0) return f;
    return x.$1.name.toLowerCase().compareTo(y.$1.name.toLowerCase());
  });
  return [for (final r in ranked) r.$1];
}
