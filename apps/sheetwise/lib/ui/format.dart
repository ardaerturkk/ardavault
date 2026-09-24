import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../model/admission.dart';
import '../model/course.dart';

/// 7.5, 7,5, 1,234.25: at most two decimals, grouped like the locale.
String numberText(AppLocalizations l, num n) =>
    NumberFormat('#,##0.##', l.localeName).format(n);

/// A number for an input field: no grouping, locale decimal mark.
String fieldNumber(AppLocalizations l, num n) =>
    NumberFormat('0.##', l.localeName).format(n);

/// 50 %, 50%, %50 with at most one decimal. [percent] is 0 to 100.
String percentText(AppLocalizations l, num percent) {
  final f = NumberFormat.percentPattern(l.localeName)
    ..maximumFractionDigits = 1
    ..minimumFractionDigits = 0;
  return f.format(percent / 100);
}

/// Parses "13,5" or "13.5" (and "4") to a number; null if not a number.
double? parseDecimal(String s) {
  final t = s.trim().replaceAll(' ', '').replaceAll(',', '.');
  if (t.isEmpty || !RegExp(r'^\d*\.?\d*$').hasMatch(t) || t == '.') {
    return null;
  }
  return double.tryParse(t);
}

String sheetName(AppLocalizations l, Course c, Sheet s) => s.extra
    ? l.extraSheetName(c.numberOf(s))
    : l.sheetName(c.numberOf(s));

/// The one line a course row shows under its name.
String verdictLine(AppLocalizations l, Admission a) => switch (a.verdict) {
  Verdict.admitted => l.statusAdmitted,
  Verdict.outOfReach => l.statusOutOfReach,
  Verdict.noSheets => l.statusNoSheets,
  Verdict.possible when a.onlyPresentationsLeft => l.statusPresentations(
    a.presentationsRequired - a.presentationsDone,
  ),
  Verdict.possible => needPerSheet(l, a.fraction!, a.sameMax),
};

/// "Need 7.2 of 10 per sheet" or "Need 72 % per sheet".
String needPerSheet(AppLocalizations l, double fraction, double? sameMax) =>
    sameMax == null
    ? l.statusNeedShare(percentText(l, percentUp(fraction)))
    : l.statusNeedPoints(
        numberText(l, pointsOn(fraction, sameMax)),
        numberText(l, sameMax),
      );

/// "8.5 of 10", "Not graded yet", "Not handed in", "Excused".
String sheetValue(AppLocalizations l, Sheet s) => switch (s.state) {
  SheetState.graded => l.valueOf(numberText(l, s.earned), numberText(l, s.max)),
  SheetState.open => l.sheetOpen,
  SheetState.missed => l.sheetMissed,
  SheetState.excused => l.sheetExcused,
};

/// "50 % of all points", "60 points from the best 10 sheets".
String? totalRuleText(AppLocalizations l, Rule r, int sheetCount) {
  final best = r.bestOf != null && r.bestOf! < sheetCount ? r.bestOf : null;
  return switch (r.kind) {
    TotalKind.none => null,
    TotalKind.percent =>
      best == null
          ? l.rulePercentAll(percentText(l, r.value))
          : l.rulePercentBest(percentText(l, r.value), best),
    TotalKind.points =>
      best == null
          ? l.rulePoints(numberText(l, r.value))
          : l.rulePointsBest(numberText(l, r.value), best),
  };
}

/// "30 % on every sheet" or "50 % on at least 10 sheets".
String? minRuleText(AppLocalizations l, Rule r, int sheetCount) {
  final m = r.minSheetPercent;
  if (m == null) return null;
  final best = r.bestOf != null && r.bestOf! < sheetCount ? r.bestOf : null;
  final count = r.minSheetCount ?? best;
  return count == null
      ? l.ruleMinAll(percentText(l, m))
      : l.ruleMinCount(percentText(l, m), count);
}
