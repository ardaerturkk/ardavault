import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Sheetwise'**
  String get appTitle;

  /// No description provided for @courses.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get courses;

  /// No description provided for @addCourse.
  ///
  /// In en, this message translates to:
  /// **'Add Course'**
  String get addCourse;

  /// No description provided for @emptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No Courses Yet'**
  String get emptyTitle;

  /// No description provided for @emptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add a course with the admission rule from its course page. After each graded sheet, you see what you still need.'**
  String get emptyBody;

  /// No description provided for @listFooter.
  ///
  /// In en, this message translates to:
  /// **'Most urgent first. Based on the rules you entered; the course page has the final word.'**
  String get listFooter;

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Your saved courses could not be read. A copy was kept, and nothing was overwritten.'**
  String get loadFailed;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Your last change could not be saved. Sheetwise tries again with the next change.'**
  String get saveFailed;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @increase.
  ///
  /// In en, this message translates to:
  /// **'Increase'**
  String get increase;

  /// No description provided for @decrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease'**
  String get decrease;

  /// No description provided for @discardChanges.
  ///
  /// In en, this message translates to:
  /// **'Discard Changes'**
  String get discardChanges;

  /// No description provided for @keepEditing.
  ///
  /// In en, this message translates to:
  /// **'Keep Editing'**
  String get keepEditing;

  /// No description provided for @statusAdmitted.
  ///
  /// In en, this message translates to:
  /// **'Admitted'**
  String get statusAdmitted;

  /// No description provided for @statusOutOfReach.
  ///
  /// In en, this message translates to:
  /// **'Out of reach'**
  String get statusOutOfReach;

  /// No description provided for @statusNoSheets.
  ///
  /// In en, this message translates to:
  /// **'No sheets yet'**
  String get statusNoSheets;

  /// No description provided for @statusNeedPoints.
  ///
  /// In en, this message translates to:
  /// **'Need {points} of {max} per sheet'**
  String statusNeedPoints(String points, String max);

  /// No description provided for @statusNeedShare.
  ///
  /// In en, this message translates to:
  /// **'Need {percent} per sheet'**
  String statusNeedShare(String percent);

  /// No description provided for @statusPresentations.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 presentation left} other{{count} presentations left}}'**
  String statusPresentations(int count);

  /// No description provided for @sheetsLeft.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No sheets left} =1{1 sheet left} other{{count} sheets left}}'**
  String sheetsLeft(int count);

  /// No description provided for @sheetName.
  ///
  /// In en, this message translates to:
  /// **'Sheet {number}'**
  String sheetName(int number);

  /// No description provided for @extraSheetName.
  ///
  /// In en, this message translates to:
  /// **'Extra Sheet {number}'**
  String extraSheetName(int number);

  /// No description provided for @heroPerSheetOf.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{of {max} points on the last remaining sheet} other{of {max} points on each of the {count} remaining sheets}}'**
  String heroPerSheetOf(int count, String max);

  /// No description provided for @heroPerSheetShare.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{of the points on the last remaining sheet} other{of the points on each of the {count} remaining sheets}}'**
  String heroPerSheetShare(int count);

  /// No description provided for @heroAdmitted.
  ///
  /// In en, this message translates to:
  /// **'Admitted'**
  String get heroAdmitted;

  /// No description provided for @heroAdmittedBody.
  ///
  /// In en, this message translates to:
  /// **'Every condition of the rule you entered is met.'**
  String get heroAdmittedBody;

  /// No description provided for @heroOutOfReach.
  ///
  /// In en, this message translates to:
  /// **'Out of Reach'**
  String get heroOutOfReach;

  /// No description provided for @outOfReachPoints.
  ///
  /// In en, this message translates to:
  /// **'Even full points on every remaining sheet would leave you {points} points short.'**
  String outOfReachPoints(String points);

  /// No description provided for @outOfReachSheets.
  ///
  /// In en, this message translates to:
  /// **'Only {possible} sheets can still reach {percent}, and {required} must.'**
  String outOfReachSheets(int possible, String percent, int required);

  /// No description provided for @heroPresentationsBody.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{more presentation needed. Your points are enough.} other{more presentations needed. Your points are enough.}}'**
  String heroPresentationsBody(int count);

  /// No description provided for @heroNoSheets.
  ///
  /// In en, this message translates to:
  /// **'No Sheets Yet'**
  String get heroNoSheets;

  /// No description provided for @heroNoSheetsBody.
  ///
  /// In en, this message translates to:
  /// **'Add the sheets of this course to see where you stand.'**
  String get heroNoSheetsBody;

  /// No description provided for @pointsSoFar.
  ///
  /// In en, this message translates to:
  /// **'{counted} of {total} points'**
  String pointsSoFar(String counted, String total);

  /// No description provided for @pointsNeeded.
  ///
  /// In en, this message translates to:
  /// **'{needed} needed'**
  String pointsNeeded(String needed);

  /// No description provided for @sheetsPassedSoFar.
  ///
  /// In en, this message translates to:
  /// **'{passed} of {required} sheets at {percent} or more'**
  String sheetsPassedSoFar(int passed, int required, String percent);

  /// No description provided for @skipNeedPoints.
  ///
  /// In en, this message translates to:
  /// **'If you skip {sheet}: {points} of {max} on each other sheet.'**
  String skipNeedPoints(String sheet, String points, String max);

  /// No description provided for @skipNeedShare.
  ///
  /// In en, this message translates to:
  /// **'If you skip {sheet}: {percent} on each other sheet.'**
  String skipNeedShare(String sheet, String percent);

  /// No description provided for @skipOutOfReach.
  ///
  /// In en, this message translates to:
  /// **'Skipping {sheet} would put admission out of reach.'**
  String skipOutOfReach(String sheet);

  /// No description provided for @skipNoCost.
  ///
  /// In en, this message translates to:
  /// **'Skipping {sheet} would cost you nothing.'**
  String skipNoCost(String sheet);

  /// No description provided for @enterSheet.
  ///
  /// In en, this message translates to:
  /// **'Enter {sheet}'**
  String enterSheet(String sheet);

  /// No description provided for @ruleHeader.
  ///
  /// In en, this message translates to:
  /// **'Admission Rule'**
  String get ruleHeader;

  /// No description provided for @rulePercentAll.
  ///
  /// In en, this message translates to:
  /// **'{percent} of all points'**
  String rulePercentAll(String percent);

  /// No description provided for @rulePercentBest.
  ///
  /// In en, this message translates to:
  /// **'{percent} of the best {count} sheets'**
  String rulePercentBest(String percent, int count);

  /// No description provided for @rulePoints.
  ///
  /// In en, this message translates to:
  /// **'{points} points'**
  String rulePoints(String points);

  /// No description provided for @rulePointsBest.
  ///
  /// In en, this message translates to:
  /// **'{points} points from the best {count} sheets'**
  String rulePointsBest(String points, int count);

  /// No description provided for @ruleMinAll.
  ///
  /// In en, this message translates to:
  /// **'{percent} on every sheet'**
  String ruleMinAll(String percent);

  /// No description provided for @ruleMinCount.
  ///
  /// In en, this message translates to:
  /// **'{percent} on at least {count} sheets'**
  String ruleMinCount(String percent, int count);

  /// No description provided for @presentations.
  ///
  /// In en, this message translates to:
  /// **'Presentations'**
  String get presentations;

  /// No description provided for @valueOf.
  ///
  /// In en, this message translates to:
  /// **'{value} of {total}'**
  String valueOf(String value, String total);

  /// No description provided for @ruleFooter.
  ///
  /// In en, this message translates to:
  /// **'Based on the rule you entered. The course page has the final word.'**
  String get ruleFooter;

  /// No description provided for @met.
  ///
  /// In en, this message translates to:
  /// **'Met'**
  String get met;

  /// No description provided for @notMetYet.
  ///
  /// In en, this message translates to:
  /// **'Not met yet'**
  String get notMetYet;

  /// No description provided for @bonusFrom.
  ///
  /// In en, this message translates to:
  /// **'Bonus from {percent}'**
  String bonusFrom(String percent);

  /// No description provided for @bonusReached.
  ///
  /// In en, this message translates to:
  /// **'Reached'**
  String get bonusReached;

  /// No description provided for @addPresentation.
  ///
  /// In en, this message translates to:
  /// **'Add Presentation'**
  String get addPresentation;

  /// No description provided for @removePresentation.
  ///
  /// In en, this message translates to:
  /// **'Remove Presentation'**
  String get removePresentation;

  /// No description provided for @sheetsHeader.
  ///
  /// In en, this message translates to:
  /// **'Sheets'**
  String get sheetsHeader;

  /// No description provided for @sheetOpen.
  ///
  /// In en, this message translates to:
  /// **'Not graded yet'**
  String get sheetOpen;

  /// No description provided for @sheetMissed.
  ///
  /// In en, this message translates to:
  /// **'Not handed in'**
  String get sheetMissed;

  /// No description provided for @sheetExcused.
  ///
  /// In en, this message translates to:
  /// **'Excused'**
  String get sheetExcused;

  /// No description provided for @addSheet.
  ///
  /// In en, this message translates to:
  /// **'Add Sheet'**
  String get addSheet;

  /// No description provided for @addExtraSheet.
  ///
  /// In en, this message translates to:
  /// **'Add Extra Sheet'**
  String get addExtraSheet;

  /// No description provided for @addSheetMessage.
  ///
  /// In en, this message translates to:
  /// **'Points on an extra sheet count, but its maximum does not add to the total.'**
  String get addSheetMessage;

  /// No description provided for @noteHeader.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get noteHeader;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @ofMax.
  ///
  /// In en, this message translates to:
  /// **'of {max}'**
  String ofMax(String max);

  /// No description provided for @resultHeader.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get resultHeader;

  /// No description provided for @stateGraded.
  ///
  /// In en, this message translates to:
  /// **'Graded'**
  String get stateGraded;

  /// No description provided for @stateOpen.
  ///
  /// In en, this message translates to:
  /// **'Not Graded Yet'**
  String get stateOpen;

  /// No description provided for @stateMissed.
  ///
  /// In en, this message translates to:
  /// **'Not Handed In'**
  String get stateMissed;

  /// No description provided for @stateExcused.
  ///
  /// In en, this message translates to:
  /// **'Excused'**
  String get stateExcused;

  /// No description provided for @resultFooter.
  ///
  /// In en, this message translates to:
  /// **'A sheet not handed in counts as zero. An excused sheet leaves the total.'**
  String get resultFooter;

  /// No description provided for @maxPoints.
  ///
  /// In en, this message translates to:
  /// **'Maximum Points'**
  String get maxPoints;

  /// No description provided for @extraSheet.
  ///
  /// In en, this message translates to:
  /// **'Extra Sheet'**
  String get extraSheet;

  /// No description provided for @extraFooter.
  ///
  /// In en, this message translates to:
  /// **'Points on an extra sheet count, but its maximum does not add to the total.'**
  String get extraFooter;

  /// No description provided for @whatIfHeader.
  ///
  /// In en, this message translates to:
  /// **'What If'**
  String get whatIfHeader;

  /// No description provided for @whatIfSkip.
  ///
  /// In en, this message translates to:
  /// **'If You Skip This Sheet'**
  String get whatIfSkip;

  /// No description provided for @whatIfNeedPoints.
  ///
  /// In en, this message translates to:
  /// **'You would need {points} of {max} on each other remaining sheet.'**
  String whatIfNeedPoints(String points, String max);

  /// No description provided for @whatIfNeedShare.
  ///
  /// In en, this message translates to:
  /// **'You would need {percent} on each other remaining sheet.'**
  String whatIfNeedShare(String percent);

  /// No description provided for @whatIfOut.
  ///
  /// In en, this message translates to:
  /// **'Admission would be out of reach.'**
  String get whatIfOut;

  /// No description provided for @whatIfAdmitted.
  ///
  /// In en, this message translates to:
  /// **'You would still be admitted.'**
  String get whatIfAdmitted;

  /// No description provided for @whatIfEnough.
  ///
  /// In en, this message translates to:
  /// **'Your points would still be enough.'**
  String get whatIfEnough;

  /// No description provided for @whatIfFooter.
  ///
  /// In en, this message translates to:
  /// **'Nothing is saved; this only shows the numbers.'**
  String get whatIfFooter;

  /// No description provided for @deleteSheet.
  ///
  /// In en, this message translates to:
  /// **'Delete Sheet'**
  String get deleteSheet;

  /// No description provided for @deleteSheetConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this sheet and its result?'**
  String get deleteSheetConfirm;

  /// No description provided for @pointsInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter the points, for example 7.5.'**
  String get pointsInvalid;

  /// No description provided for @newCourse.
  ///
  /// In en, this message translates to:
  /// **'New Course'**
  String get newCourse;

  /// No description provided for @editCourse.
  ///
  /// In en, this message translates to:
  /// **'Edit Course'**
  String get editCourse;

  /// No description provided for @courseName.
  ///
  /// In en, this message translates to:
  /// **'Course Name'**
  String get courseName;

  /// No description provided for @courseNameHint.
  ///
  /// In en, this message translates to:
  /// **'For example Linear Algebra'**
  String get courseNameHint;

  /// No description provided for @sheetCount.
  ///
  /// In en, this message translates to:
  /// **'Number of Sheets'**
  String get sheetCount;

  /// No description provided for @pointsPerSheet.
  ///
  /// In en, this message translates to:
  /// **'Points per Sheet'**
  String get pointsPerSheet;

  /// No description provided for @sheetsFooterNew.
  ///
  /// In en, this message translates to:
  /// **'Not sure yet? Take your best guess. You can add or remove sheets later.'**
  String get sheetsFooterNew;

  /// No description provided for @sheetsFooterEdit.
  ///
  /// In en, this message translates to:
  /// **'Sheets with a result are never removed here; delete them one by one.'**
  String get sheetsFooterEdit;

  /// No description provided for @presetsHeader.
  ///
  /// In en, this message translates to:
  /// **'Common Rules'**
  String get presetsHeader;

  /// No description provided for @presetHalf.
  ///
  /// In en, this message translates to:
  /// **'{percent} of All Points'**
  String presetHalf(String percent);

  /// No description provided for @presetHalfAndMinimum.
  ///
  /// In en, this message translates to:
  /// **'{percent} of All Points, {minimum} per Sheet'**
  String presetHalfAndMinimum(String percent, String minimum);

  /// No description provided for @presetHalfOfBest.
  ///
  /// In en, this message translates to:
  /// **'{percent} of the Best Sheets, 2 Dropped'**
  String presetHalfOfBest(String percent);

  /// No description provided for @presetMostSheets.
  ///
  /// In en, this message translates to:
  /// **'{percent} on All but 2 Sheets'**
  String presetMostSheets(String percent);

  /// No description provided for @presetsFooter.
  ///
  /// In en, this message translates to:
  /// **'Pick the closest one, then adjust the details below.'**
  String get presetsFooter;

  /// No description provided for @neededKind.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get neededKind;

  /// No description provided for @kindPercent.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get kindPercent;

  /// No description provided for @kindPoints.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get kindPoints;

  /// No description provided for @kindNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get kindNone;

  /// No description provided for @shareOfPoints.
  ///
  /// In en, this message translates to:
  /// **'Share of Points'**
  String get shareOfPoints;

  /// No description provided for @pointsNeededField.
  ///
  /// In en, this message translates to:
  /// **'Points Needed'**
  String get pointsNeededField;

  /// No description provided for @bestOnly.
  ///
  /// In en, this message translates to:
  /// **'Only the Best Sheets Count'**
  String get bestOnly;

  /// No description provided for @bestCount.
  ///
  /// In en, this message translates to:
  /// **'Sheets Counted'**
  String get bestCount;

  /// No description provided for @minEach.
  ///
  /// In en, this message translates to:
  /// **'Minimum on Each Sheet'**
  String get minEach;

  /// No description provided for @minPercent.
  ///
  /// In en, this message translates to:
  /// **'Share per Sheet'**
  String get minPercent;

  /// No description provided for @minCount.
  ///
  /// In en, this message translates to:
  /// **'Sheets That Must Reach It'**
  String get minCount;

  /// No description provided for @presentationsSwitch.
  ///
  /// In en, this message translates to:
  /// **'Presentations'**
  String get presentationsSwitch;

  /// No description provided for @presentationsNeeded.
  ///
  /// In en, this message translates to:
  /// **'Presentations Needed'**
  String get presentationsNeeded;

  /// No description provided for @ruleEditorFooter.
  ///
  /// In en, this message translates to:
  /// **'Copy the rule from your course page. A sheet not handed in counts as zero; an excused sheet leaves the total.'**
  String get ruleEditorFooter;

  /// No description provided for @noConditionFooter.
  ///
  /// In en, this message translates to:
  /// **'Choose at least one condition.'**
  String get noConditionFooter;

  /// No description provided for @invalidFooter.
  ///
  /// In en, this message translates to:
  /// **'Some numbers are not valid. Shares go up to 100.'**
  String get invalidFooter;

  /// No description provided for @bonusHeader.
  ///
  /// In en, this message translates to:
  /// **'Exam Bonus'**
  String get bonusHeader;

  /// No description provided for @addBonusTier.
  ///
  /// In en, this message translates to:
  /// **'Add Bonus Tier'**
  String get addBonusTier;

  /// No description provided for @bonusFooter.
  ///
  /// In en, this message translates to:
  /// **'If good exercise results earn a bonus in the exam, add each tier.'**
  String get bonusFooter;

  /// No description provided for @bonusTierTitle.
  ///
  /// In en, this message translates to:
  /// **'Bonus Tier'**
  String get bonusTierTitle;

  /// No description provided for @bonusFromField.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get bonusFromField;

  /// No description provided for @bonusLabelField.
  ///
  /// In en, this message translates to:
  /// **'Bonus'**
  String get bonusLabelField;

  /// No description provided for @bonusLabelHint.
  ///
  /// In en, this message translates to:
  /// **'For example 0.3 grade step'**
  String get bonusLabelHint;

  /// No description provided for @bonusTierFooter.
  ///
  /// In en, this message translates to:
  /// **'The share of the counted points this bonus needs.'**
  String get bonusTierFooter;

  /// No description provided for @deleteBonusTier.
  ///
  /// In en, this message translates to:
  /// **'Delete Bonus Tier'**
  String get deleteBonusTier;

  /// No description provided for @noteHint.
  ///
  /// In en, this message translates to:
  /// **'Tutor, group, where points are posted'**
  String get noteHint;

  /// No description provided for @deleteCourse.
  ///
  /// In en, this message translates to:
  /// **'Delete Course'**
  String get deleteCourse;

  /// No description provided for @deleteCourseConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this course and all its sheets?'**
  String get deleteCourseConfirm;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
