import 'course.dart';

/// Common admission rules, as starting points in the course editor.
enum Preset {
  /// 50 % of all points.
  half,

  /// 50 % of all points and 30 % on each sheet.
  halfAndMinimum,

  /// 50 % of the points of the best sheets; the two worst are dropped.
  halfOfBest,

  /// 50 % on all sheets but two (no total).
  mostSheets,
}

/// The rule for [preset] in a course with [sheetCount] sheets.
Rule presetRule(Preset preset, int sheetCount) {
  final minusTwo = sheetCount > 2 ? sheetCount - 2 : sheetCount;
  return switch (preset) {
    Preset.half => const Rule(),
    Preset.halfAndMinimum => const Rule(minSheetPercent: 30),
    Preset.halfOfBest => Rule(bestOf: minusTwo),
    Preset.mostSheets => Rule(
      kind: TotalKind.none,
      minSheetPercent: 50,
      minSheetCount: minusTwo,
    ),
  };
}

/// The preset [rule] matches exactly, ignoring presentations and bonus
/// tiers; null when it is a rule of its own.
Preset? presetOf(Rule rule, int sheetCount) {
  for (final p in Preset.values) {
    final r = presetRule(p, sheetCount);
    if (r == rule.copyWith(presentations: 0, bonus: const [])) return p;
  }
  return null;
}
