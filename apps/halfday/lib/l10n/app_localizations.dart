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
  /// **'Halfday'**
  String get appTitle;

  /// No description provided for @tabOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get tabOverview;

  /// No description provided for @tabShifts.
  ///
  /// In en, this message translates to:
  /// **'Shifts'**
  String get tabShifts;

  /// No description provided for @tabPlan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get tabPlan;

  /// No description provided for @tabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tabSettings;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

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

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Your last change could not be saved. Free up some storage and try again.'**
  String get saveFailed;

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Your saved shifts could not be read, so Halfday started empty. The old file is still on this iPhone.'**
  String get loadFailed;

  /// No description provided for @daysLeftIn.
  ///
  /// In en, this message translates to:
  /// **'days left in {year}'**
  String daysLeftIn(String year);

  /// No description provided for @daysOverIn.
  ///
  /// In en, this message translates to:
  /// **'days over the limit in {year}'**
  String daysOverIn(String year);

  /// No description provided for @usedOfLimit.
  ///
  /// In en, this message translates to:
  /// **'{used} of {limit} days used'**
  String usedOfLimit(String used, String limit);

  /// No description provided for @fullAndHalf.
  ///
  /// In en, this message translates to:
  /// **'{full, plural, =1{1 full day} other{{full} full days}}, {half, plural, =1{1 half day} other{{half} half days}}'**
  String fullAndHalf(int full, int half);

  /// No description provided for @upcomingIncluded.
  ///
  /// In en, this message translates to:
  /// **'Includes {count, plural, =1{1 upcoming day} other{{count} upcoming days}}'**
  String upcomingIncluded(int count);

  /// No description provided for @logShift.
  ///
  /// In en, this message translates to:
  /// **'Log Shift'**
  String get logShift;

  /// No description provided for @overviewFirstHint.
  ///
  /// In en, this message translates to:
  /// **'Each shift becomes a full day (more than {hours}) or a half day. Shifts at the university can be left out.'**
  String overviewFirstHint(String hours);

  /// No description provided for @heroFooter.
  ///
  /// In en, this message translates to:
  /// **'Typical rule: {full} full or {half} half days a year. Your residence permit and the Ausländerbehörde decide.'**
  String heroFooter(String full, String half);

  /// No description provided for @customLimitFooter.
  ///
  /// In en, this message translates to:
  /// **'Your limit: {full} full or {half} half days a year, set in Settings. Your residence permit and the Ausländerbehörde decide.'**
  String customLimitFooter(String full, String half);

  /// No description provided for @sectionThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get sectionThisWeek;

  /// No description provided for @hoursThisWeek.
  ///
  /// In en, this message translates to:
  /// **'Hours This Week'**
  String get hoursThisWeek;

  /// No description provided for @ofValue.
  ///
  /// In en, this message translates to:
  /// **'{used} of {limit}'**
  String ofValue(String used, String limit);

  /// No description provided for @minijobPayIn.
  ///
  /// In en, this message translates to:
  /// **'Minijob Pay in {month}'**
  String minijobPayIn(String month);

  /// No description provided for @weekFooter.
  ///
  /// In en, this message translates to:
  /// **'Hours in all jobs, Monday to Sunday. The weekly limit matters during the lecture period.'**
  String get weekFooter;

  /// No description provided for @overWeekLimit.
  ///
  /// In en, this message translates to:
  /// **'Over the weekly limit'**
  String get overWeekLimit;

  /// No description provided for @overMinijobLimit.
  ///
  /// In en, this message translates to:
  /// **'Over the Minijob limit'**
  String get overMinijobLimit;

  /// No description provided for @hoursValue.
  ///
  /// In en, this message translates to:
  /// **'{hours} h'**
  String hoursValue(String hours);

  /// No description provided for @oneDay.
  ///
  /// In en, this message translates to:
  /// **'1 day'**
  String get oneDay;

  /// No description provided for @daysValue.
  ///
  /// In en, this message translates to:
  /// **'{days} days'**
  String daysValue(String days);

  /// No description provided for @noShiftsTitle.
  ///
  /// In en, this message translates to:
  /// **'No Shifts Yet'**
  String get noShiftsTitle;

  /// No description provided for @noShiftsBody.
  ///
  /// In en, this message translates to:
  /// **'Log a shift and it appears here by month, marked as a full or half day.'**
  String get noShiftsBody;

  /// No description provided for @statusFull.
  ///
  /// In en, this message translates to:
  /// **'Full Day'**
  String get statusFull;

  /// No description provided for @statusHalf.
  ///
  /// In en, this message translates to:
  /// **'Half Day'**
  String get statusHalf;

  /// No description provided for @statusNotCounted.
  ///
  /// In en, this message translates to:
  /// **'Not Counted'**
  String get statusNotCounted;

  /// No description provided for @dayTotal.
  ///
  /// In en, this message translates to:
  /// **'{hours} that day'**
  String dayTotal(String hours);

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @newShift.
  ///
  /// In en, this message translates to:
  /// **'New Shift'**
  String get newShift;

  /// No description provided for @editShift.
  ///
  /// In en, this message translates to:
  /// **'Edit Shift'**
  String get editShift;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @job.
  ///
  /// In en, this message translates to:
  /// **'Job'**
  String get job;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hours;

  /// No description provided for @addAJob.
  ///
  /// In en, this message translates to:
  /// **'Add a Job'**
  String get addAJob;

  /// No description provided for @countsFull.
  ///
  /// In en, this message translates to:
  /// **'Counts as a full day'**
  String get countsFull;

  /// No description provided for @countsHalf.
  ///
  /// In en, this message translates to:
  /// **'Counts as a half day'**
  String get countsHalf;

  /// No description provided for @countsNotUniversity.
  ///
  /// In en, this message translates to:
  /// **'Not counted: university job'**
  String get countsNotUniversity;

  /// No description provided for @countsZero.
  ///
  /// In en, this message translates to:
  /// **'Set the hours worked'**
  String get countsZero;

  /// No description provided for @withOtherShifts.
  ///
  /// In en, this message translates to:
  /// **'Together with {count, plural, =1{1 other shift} other{{count} other shifts}} that day: {hours}'**
  String withOtherShifts(int count, String hours);

  /// No description provided for @halfDayRule.
  ///
  /// In en, this message translates to:
  /// **'More than {hours} is a full day.'**
  String halfDayRule(String hours);

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @noteHint.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get noteHint;

  /// No description provided for @deleteShift.
  ///
  /// In en, this message translates to:
  /// **'Delete Shift'**
  String get deleteShift;

  /// No description provided for @deleteShiftConfirm.
  ///
  /// In en, this message translates to:
  /// **'This shift will be removed from your count.'**
  String get deleteShiftConfirm;

  /// No description provided for @jobs.
  ///
  /// In en, this message translates to:
  /// **'Jobs'**
  String get jobs;

  /// No description provided for @newJob.
  ///
  /// In en, this message translates to:
  /// **'New Job'**
  String get newJob;

  /// No description provided for @editJob.
  ///
  /// In en, this message translates to:
  /// **'Edit Job'**
  String get editJob;

  /// No description provided for @jobNameHint.
  ///
  /// In en, this message translates to:
  /// **'Job name'**
  String get jobNameHint;

  /// No description provided for @jobType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get jobType;

  /// No description provided for @kindRegular.
  ///
  /// In en, this message translates to:
  /// **'Regular Job'**
  String get kindRegular;

  /// No description provided for @kindRegularInfo.
  ///
  /// In en, this message translates to:
  /// **'Counts toward the day limit.'**
  String get kindRegularInfo;

  /// No description provided for @kindMinijob.
  ///
  /// In en, this message translates to:
  /// **'Minijob'**
  String get kindMinijob;

  /// No description provided for @kindMinijobInfo.
  ///
  /// In en, this message translates to:
  /// **'Counts toward the day limit. Pay is checked against the monthly Minijob limit.'**
  String get kindMinijobInfo;

  /// No description provided for @kindUniversity.
  ///
  /// In en, this message translates to:
  /// **'University Job'**
  String get kindUniversity;

  /// No description provided for @kindUniversityInfo.
  ///
  /// In en, this message translates to:
  /// **'Student assistant or tutor at a university. Usually not counted.'**
  String get kindUniversityInfo;

  /// No description provided for @hourlyPay.
  ///
  /// In en, this message translates to:
  /// **'Hourly Pay'**
  String get hourlyPay;

  /// No description provided for @hourlyPayHint.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get hourlyPayHint;

  /// No description provided for @hourlyPayFooter.
  ///
  /// In en, this message translates to:
  /// **'Used only to check the monthly Minijob limit.'**
  String get hourlyPayFooter;

  /// No description provided for @deleteJob.
  ///
  /// In en, this message translates to:
  /// **'Delete Job'**
  String get deleteJob;

  /// No description provided for @deleteJobConfirm.
  ///
  /// In en, this message translates to:
  /// **'This job will be deleted.'**
  String get deleteJobConfirm;

  /// No description provided for @deleteJobWithShifts.
  ///
  /// In en, this message translates to:
  /// **'This job and {count, plural, =1{its 1 shift} other{its {count} shifts}} will be deleted.'**
  String deleteJobWithShifts(int count);

  /// No description provided for @addJob.
  ///
  /// In en, this message translates to:
  /// **'Add Job'**
  String get addJob;

  /// No description provided for @planSchedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get planSchedule;

  /// No description provided for @planStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get planStart;

  /// No description provided for @planWeeks.
  ///
  /// In en, this message translates to:
  /// **'Weeks'**
  String get planWeeks;

  /// No description provided for @planDaysPerWeek.
  ///
  /// In en, this message translates to:
  /// **'Days per Week'**
  String get planDaysPerWeek;

  /// No description provided for @planHoursPerDay.
  ///
  /// In en, this message translates to:
  /// **'Hours per Day'**
  String get planHoursPerDay;

  /// No description provided for @weekdaySpan.
  ///
  /// In en, this message translates to:
  /// **'{count} ({first} to {last})'**
  String weekdaySpan(String count, String first, String last);

  /// No description provided for @planOverTitle.
  ///
  /// In en, this message translates to:
  /// **'Over the Limit from {date}'**
  String planOverTitle(String date);

  /// No description provided for @planOverBody.
  ///
  /// In en, this message translates to:
  /// **'Your last planned day within the limit is {date}. The plan goes {days} over in {year}.'**
  String planOverBody(String date, String days, String year);

  /// No description provided for @planOverBodyNoLast.
  ///
  /// In en, this message translates to:
  /// **'The limit for {year} is already used up. The plan goes {days} over.'**
  String planOverBodyNoLast(String year, String days);

  /// No description provided for @planUsedUpTitle.
  ///
  /// In en, this message translates to:
  /// **'No Days Left in {year}'**
  String planUsedUpTitle(String year);

  /// No description provided for @daysOver.
  ///
  /// In en, this message translates to:
  /// **'{days} over'**
  String daysOver(String days);

  /// No description provided for @planReachedTitle.
  ///
  /// In en, this message translates to:
  /// **'Uses Every Day Left'**
  String get planReachedTitle;

  /// No description provided for @planReachedBody.
  ///
  /// In en, this message translates to:
  /// **'The limit for {year} is reached on {date}. No days are left after that.'**
  String planReachedBody(String year, String date);

  /// No description provided for @planFitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Fits Within the Limit'**
  String get planFitsTitle;

  /// No description provided for @planFitsBody.
  ///
  /// In en, this message translates to:
  /// **'{days} left in {year} after this plan.'**
  String planFitsBody(String days, String year);

  /// No description provided for @planNotCountedTitle.
  ///
  /// In en, this message translates to:
  /// **'Not Counted'**
  String get planNotCountedTitle;

  /// No description provided for @planNotCountedBody.
  ///
  /// In en, this message translates to:
  /// **'University jobs do not count toward the day limit.'**
  String get planNotCountedBody;

  /// No description provided for @planWorkDays.
  ///
  /// In en, this message translates to:
  /// **'Work Days'**
  String get planWorkDays;

  /// No description provided for @planAdds.
  ///
  /// In en, this message translates to:
  /// **'Adds'**
  String get planAdds;

  /// No description provided for @planLastDay.
  ///
  /// In en, this message translates to:
  /// **'Last Day'**
  String get planLastDay;

  /// No description provided for @leftAfterIn.
  ///
  /// In en, this message translates to:
  /// **'Left in {year}'**
  String leftAfterIn(String year);

  /// No description provided for @addAsShifts.
  ///
  /// In en, this message translates to:
  /// **'Add as Shifts'**
  String get addAsShifts;

  /// No description provided for @addShiftsConfirm.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 shift} other{{count} shifts}} for {job} will be added to your log.'**
  String addShiftsConfirm(int count, String job);

  /// No description provided for @addShiftsAction.
  ///
  /// In en, this message translates to:
  /// **'Add {count, plural, =1{1 Shift} other{{count} Shifts}}'**
  String addShiftsAction(int count);

  /// No description provided for @planFooter.
  ///
  /// In en, this message translates to:
  /// **'A what-if schedule. Nothing is saved until you add it as shifts. Planned hours add to shifts already logged on the same day.'**
  String get planFooter;

  /// No description provided for @planNeedsJob.
  ///
  /// In en, this message translates to:
  /// **'Add a job in Settings to save a plan as shifts.'**
  String get planNeedsJob;

  /// No description provided for @shiftsAdded.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 shift added} other{{count} shifts added}}'**
  String shiftsAdded(int count);

  /// No description provided for @limits.
  ///
  /// In en, this message translates to:
  /// **'Limits'**
  String get limits;

  /// No description provided for @fullDaysPerYear.
  ///
  /// In en, this message translates to:
  /// **'Full Days per Year'**
  String get fullDaysPerYear;

  /// No description provided for @halfDayUpTo.
  ///
  /// In en, this message translates to:
  /// **'Half Day Up To'**
  String get halfDayUpTo;

  /// No description provided for @hoursPerWeek.
  ///
  /// In en, this message translates to:
  /// **'Hours per Week'**
  String get hoursPerWeek;

  /// No description provided for @minijobLimitIn.
  ///
  /// In en, this message translates to:
  /// **'Minijob Limit {year}'**
  String minijobLimitIn(String year);

  /// No description provided for @limitsFooter.
  ///
  /// In en, this message translates to:
  /// **'Typical values for students from outside the EU, as of 2026. The rules changed in 2024 and can change again. Your residence permit and the Ausländerbehörde decide.'**
  String get limitsFooter;

  /// No description provided for @restoreTypical.
  ///
  /// In en, this message translates to:
  /// **'Restore Typical Values'**
  String get restoreTypical;

  /// No description provided for @restoreTypicalConfirm.
  ///
  /// In en, this message translates to:
  /// **'All limits go back to the typical values as of 2026. Your shifts stay as they are.'**
  String get restoreTypicalConfirm;

  /// No description provided for @howItCounts.
  ///
  /// In en, this message translates to:
  /// **'How Halfday Counts'**
  String get howItCounts;

  /// No description provided for @fullDaysHelp.
  ///
  /// In en, this message translates to:
  /// **'Half days are allowed at twice this number.'**
  String get fullDaysHelp;

  /// No description provided for @halfDayHelp.
  ///
  /// In en, this message translates to:
  /// **'A day with more hours than this counts as a full day. Shifts on the same day are added up.'**
  String get halfDayHelp;

  /// No description provided for @weeklyHelp.
  ///
  /// In en, this message translates to:
  /// **'Shown on the overview. During the lecture period, more hours can affect your student status.'**
  String get weeklyHelp;

  /// No description provided for @minijobHelp.
  ///
  /// In en, this message translates to:
  /// **'Monthly pay limit for a Minijob in {year}. Later years use this value until you set theirs.'**
  String minijobHelp(String year);

  /// No description provided for @valueInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a number greater than zero.'**
  String get valueInvalid;

  /// No description provided for @howFullHalfTitle.
  ///
  /// In en, this message translates to:
  /// **'Full and Half Days'**
  String get howFullHalfTitle;

  /// No description provided for @howFullHalfBody.
  ///
  /// In en, this message translates to:
  /// **'Halfday adds up the hours of all counted jobs on each date. More than {hours} is a full day, up to {hours} is a half day. The count runs per calendar year and starts again on 1 January. Days left are shown in full days: 118.5 means 118 full days and one half day.'**
  String howFullHalfBody(String hours);

  /// No description provided for @howNotCountedTitle.
  ///
  /// In en, this message translates to:
  /// **'Not Counted'**
  String get howNotCountedTitle;

  /// No description provided for @howNotCountedBody.
  ///
  /// In en, this message translates to:
  /// **'Jobs marked University Job are not counted, because student assistant and tutor jobs at a university usually are not. Vacation and sick days are not counted either: just do not log them.'**
  String get howNotCountedBody;

  /// No description provided for @howWeekTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly Hours'**
  String get howWeekTitle;

  /// No description provided for @howWeekBody.
  ///
  /// In en, this message translates to:
  /// **'During the lecture period, working more than {hours} a week can affect your student status, for example for health insurance. Halfday shows the hours; it does not judge them.'**
  String howWeekBody(String hours);

  /// No description provided for @howOtherTitle.
  ///
  /// In en, this message translates to:
  /// **'Another Method'**
  String get howOtherTitle;

  /// No description provided for @howOtherBody.
  ///
  /// In en, this message translates to:
  /// **'Some Ausländerbehörden also accept counting regular part-time work as 2.5 days per week. Halfday does not calculate this; ask your office if it applies to you.'**
  String get howOtherBody;

  /// No description provided for @howLegalTitle.
  ///
  /// In en, this message translates to:
  /// **'Not Legal Advice'**
  String get howLegalTitle;

  /// No description provided for @howLegalBody.
  ///
  /// In en, this message translates to:
  /// **'Halfday counts what you enter using typical rules. Your residence permit, its supplementary sheet and your Ausländerbehörde decide what applies to you.'**
  String get howLegalBody;
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
