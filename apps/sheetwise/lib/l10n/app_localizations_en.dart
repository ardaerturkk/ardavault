// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sheetwise';

  @override
  String get courses => 'Courses';

  @override
  String get addCourse => 'Add Course';

  @override
  String get emptyTitle => 'No Courses Yet';

  @override
  String get emptyBody =>
      'Add a course with the admission rule from its course page. After each graded sheet, you see what you still need.';

  @override
  String get listFooter =>
      'Most urgent first. Based on the rules you entered; the course page has the final word.';

  @override
  String get loadFailed =>
      'Your saved courses could not be read. A copy was kept, and nothing was overwritten.';

  @override
  String get saveFailed =>
      'Your last change could not be saved. Sheetwise tries again with the next change.';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get edit => 'Edit';

  @override
  String get all => 'All';

  @override
  String get increase => 'Increase';

  @override
  String get decrease => 'Decrease';

  @override
  String get discardChanges => 'Discard Changes';

  @override
  String get keepEditing => 'Keep Editing';

  @override
  String get statusAdmitted => 'Admitted';

  @override
  String get statusOutOfReach => 'Out of reach';

  @override
  String get statusNoSheets => 'No sheets yet';

  @override
  String statusNeedPoints(String points, String max) {
    return 'Need $points of $max per sheet';
  }

  @override
  String statusNeedShare(String percent) {
    return 'Need $percent per sheet';
  }

  @override
  String statusPresentations(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count presentations left',
      one: '1 presentation left',
    );
    return '$_temp0';
  }

  @override
  String sheetsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sheets left',
      one: '1 sheet left',
      zero: 'No sheets left',
    );
    return '$_temp0';
  }

  @override
  String sheetName(int number) {
    return 'Sheet $number';
  }

  @override
  String extraSheetName(int number) {
    return 'Extra Sheet $number';
  }

  @override
  String heroPerSheetOf(int count, String max) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'of $max points on each of the $count remaining sheets',
      one: 'of $max points on the last remaining sheet',
    );
    return '$_temp0';
  }

  @override
  String heroPerSheetShare(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'of the points on each of the $count remaining sheets',
      one: 'of the points on the last remaining sheet',
    );
    return '$_temp0';
  }

  @override
  String get heroAdmitted => 'Admitted';

  @override
  String get heroAdmittedBody =>
      'Every condition of the rule you entered is met.';

  @override
  String get heroOutOfReach => 'Out of Reach';

  @override
  String outOfReachPoints(String points) {
    return 'Even full points on every remaining sheet would leave you $points points short.';
  }

  @override
  String outOfReachSheets(int possible, String percent, int required) {
    return 'Only $possible sheets can still reach $percent, and $required must.';
  }

  @override
  String heroPresentationsBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'more presentations needed. Your points are enough.',
      one: 'more presentation needed. Your points are enough.',
    );
    return '$_temp0';
  }

  @override
  String get heroNoSheets => 'No Sheets Yet';

  @override
  String get heroNoSheetsBody =>
      'Add the sheets of this course to see where you stand.';

  @override
  String pointsSoFar(String counted, String total) {
    return '$counted of $total points';
  }

  @override
  String pointsNeeded(String needed) {
    return '$needed needed';
  }

  @override
  String sheetsPassedSoFar(int passed, int required, String percent) {
    return '$passed of $required sheets at $percent or more';
  }

  @override
  String skipNeedPoints(String sheet, String points, String max) {
    return 'If you skip $sheet: $points of $max on each other sheet.';
  }

  @override
  String skipNeedShare(String sheet, String percent) {
    return 'If you skip $sheet: $percent on each other sheet.';
  }

  @override
  String skipOutOfReach(String sheet) {
    return 'Skipping $sheet would put admission out of reach.';
  }

  @override
  String skipNoCost(String sheet) {
    return 'Skipping $sheet would cost you nothing.';
  }

  @override
  String enterSheet(String sheet) {
    return 'Enter $sheet';
  }

  @override
  String get ruleHeader => 'Admission Rule';

  @override
  String rulePercentAll(String percent) {
    return '$percent of all points';
  }

  @override
  String rulePercentBest(String percent, int count) {
    return '$percent of the best $count sheets';
  }

  @override
  String rulePoints(String points) {
    return '$points points';
  }

  @override
  String rulePointsBest(String points, int count) {
    return '$points points from the best $count sheets';
  }

  @override
  String ruleMinAll(String percent) {
    return '$percent on every sheet';
  }

  @override
  String ruleMinCount(String percent, int count) {
    return '$percent on at least $count sheets';
  }

  @override
  String get presentations => 'Presentations';

  @override
  String valueOf(String value, String total) {
    return '$value of $total';
  }

  @override
  String get ruleFooter =>
      'Based on the rule you entered. The course page has the final word.';

  @override
  String get met => 'Met';

  @override
  String get notMetYet => 'Not met yet';

  @override
  String bonusFrom(String percent) {
    return 'Bonus from $percent';
  }

  @override
  String get bonusReached => 'Reached';

  @override
  String get addPresentation => 'Add Presentation';

  @override
  String get removePresentation => 'Remove Presentation';

  @override
  String get sheetsHeader => 'Sheets';

  @override
  String get sheetOpen => 'Not graded yet';

  @override
  String get sheetMissed => 'Not handed in';

  @override
  String get sheetExcused => 'Excused';

  @override
  String get addSheet => 'Add Sheet';

  @override
  String get addExtraSheet => 'Add Extra Sheet';

  @override
  String get addSheetMessage =>
      'Points on an extra sheet count, but its maximum does not add to the total.';

  @override
  String get noteHeader => 'Note';

  @override
  String get points => 'Points';

  @override
  String ofMax(String max) {
    return 'of $max';
  }

  @override
  String get resultHeader => 'Result';

  @override
  String get stateGraded => 'Graded';

  @override
  String get stateOpen => 'Not Graded Yet';

  @override
  String get stateMissed => 'Not Handed In';

  @override
  String get stateExcused => 'Excused';

  @override
  String get resultFooter =>
      'A sheet not handed in counts as zero. An excused sheet leaves the total.';

  @override
  String get maxPoints => 'Maximum Points';

  @override
  String get extraSheet => 'Extra Sheet';

  @override
  String get extraFooter =>
      'Points on an extra sheet count, but its maximum does not add to the total.';

  @override
  String get whatIfHeader => 'What If';

  @override
  String get whatIfSkip => 'If You Skip This Sheet';

  @override
  String whatIfNeedPoints(String points, String max) {
    return 'You would need $points of $max on each other remaining sheet.';
  }

  @override
  String whatIfNeedShare(String percent) {
    return 'You would need $percent on each other remaining sheet.';
  }

  @override
  String get whatIfOut => 'Admission would be out of reach.';

  @override
  String get whatIfAdmitted => 'You would still be admitted.';

  @override
  String get whatIfEnough => 'Your points would still be enough.';

  @override
  String get whatIfFooter => 'Nothing is saved; this only shows the numbers.';

  @override
  String get deleteSheet => 'Delete Sheet';

  @override
  String get deleteSheetConfirm => 'Delete this sheet and its result?';

  @override
  String get pointsInvalid => 'Enter the points, for example 7.5.';

  @override
  String get newCourse => 'New Course';

  @override
  String get editCourse => 'Edit Course';

  @override
  String get courseName => 'Course Name';

  @override
  String get courseNameHint => 'For example Linear Algebra';

  @override
  String get sheetCount => 'Number of Sheets';

  @override
  String get pointsPerSheet => 'Points per Sheet';

  @override
  String get sheetsFooterNew =>
      'Not sure yet? Take your best guess. You can add or remove sheets later.';

  @override
  String get sheetsFooterEdit =>
      'Sheets with a result are never removed here; delete them one by one.';

  @override
  String get presetsHeader => 'Common Rules';

  @override
  String presetHalf(String percent) {
    return '$percent of All Points';
  }

  @override
  String presetHalfAndMinimum(String percent, String minimum) {
    return '$percent of All Points, $minimum per Sheet';
  }

  @override
  String presetHalfOfBest(String percent) {
    return '$percent of the Best Sheets, 2 Dropped';
  }

  @override
  String presetMostSheets(String percent) {
    return '$percent on All but 2 Sheets';
  }

  @override
  String get presetsFooter =>
      'Pick the closest one, then adjust the details below.';

  @override
  String get neededKind => 'Total';

  @override
  String get kindPercent => 'Share';

  @override
  String get kindPoints => 'Points';

  @override
  String get kindNone => 'None';

  @override
  String get shareOfPoints => 'Share of Points';

  @override
  String get pointsNeededField => 'Points Needed';

  @override
  String get bestOnly => 'Only the Best Sheets Count';

  @override
  String get bestCount => 'Sheets Counted';

  @override
  String get minEach => 'Minimum on Each Sheet';

  @override
  String get minPercent => 'Share per Sheet';

  @override
  String get minCount => 'Sheets That Must Reach It';

  @override
  String get presentationsSwitch => 'Presentations';

  @override
  String get presentationsNeeded => 'Presentations Needed';

  @override
  String get ruleEditorFooter =>
      'Copy the rule from your course page. A sheet not handed in counts as zero; an excused sheet leaves the total.';

  @override
  String get noConditionFooter => 'Choose at least one condition.';

  @override
  String get invalidFooter =>
      'Some numbers are not valid. Shares go up to 100.';

  @override
  String get bonusHeader => 'Exam Bonus';

  @override
  String get addBonusTier => 'Add Bonus Tier';

  @override
  String get bonusFooter =>
      'If good exercise results earn a bonus in the exam, add each tier.';

  @override
  String get bonusTierTitle => 'Bonus Tier';

  @override
  String get bonusFromField => 'From';

  @override
  String get bonusLabelField => 'Bonus';

  @override
  String get bonusLabelHint => 'For example 0.3 grade step';

  @override
  String get bonusTierFooter =>
      'The share of the counted points this bonus needs.';

  @override
  String get deleteBonusTier => 'Delete Bonus Tier';

  @override
  String get noteHint => 'Tutor, group, where points are posted';

  @override
  String get deleteCourse => 'Delete Course';

  @override
  String get deleteCourseConfirm => 'Delete this course and all its sheets?';
}
