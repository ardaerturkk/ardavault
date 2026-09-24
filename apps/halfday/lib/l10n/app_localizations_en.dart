// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Halfday';

  @override
  String get tabOverview => 'Overview';

  @override
  String get tabShifts => 'Shifts';

  @override
  String get tabPlan => 'Plan';

  @override
  String get tabSettings => 'Settings';

  @override
  String get cancel => 'Cancel';

  @override
  String get done => 'Done';

  @override
  String get save => 'Save';

  @override
  String get ok => 'OK';

  @override
  String get discardChanges => 'Discard Changes';

  @override
  String get keepEditing => 'Keep Editing';

  @override
  String get saveFailed =>
      'Your last change could not be saved. Free up some storage and try again.';

  @override
  String get loadFailed =>
      'Your saved shifts could not be read, so Halfday started empty. The old file is still on this iPhone.';

  @override
  String daysLeftIn(String year) {
    return 'days left in $year';
  }

  @override
  String daysOverIn(String year) {
    return 'days over the limit in $year';
  }

  @override
  String usedOfLimit(String limit, String used) {
    return '$used of $limit days used';
  }

  @override
  String fullAndHalf(int full, int half) {
    String _temp0 = intl.Intl.pluralLogic(
      full,
      locale: localeName,
      other: '$full full days',
      one: '1 full day',
    );
    String _temp1 = intl.Intl.pluralLogic(
      half,
      locale: localeName,
      other: '$half half days',
      one: '1 half day',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String upcomingIncluded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count upcoming days',
      one: '1 upcoming day',
    );
    return 'Includes $_temp0';
  }

  @override
  String get logShift => 'Log Shift';

  @override
  String overviewFirstHint(String hours) {
    return 'Each shift becomes a full day (more than $hours) or a half day. Shifts at the university can be left out.';
  }

  @override
  String heroFooter(String full, String half) {
    return 'Typical rule: $full full or $half half days a year. Your residence permit and the Ausländerbehörde decide.';
  }

  @override
  String get sectionThisWeek => 'This Week';

  @override
  String get hoursThisWeek => 'Hours This Week';

  @override
  String ofValue(String limit, String used) {
    return '$used of $limit';
  }

  @override
  String minijobPayIn(String month) {
    return 'Minijob Pay in $month';
  }

  @override
  String get weekFooter =>
      'Hours in all jobs, Monday to Sunday. The weekly limit matters during the lecture period.';

  @override
  String get overWeekLimit => 'Over the weekly limit';

  @override
  String get overMinijobLimit => 'Over the Minijob limit';

  @override
  String hoursValue(String hours) {
    return '$hours h';
  }

  @override
  String get oneDay => '1 day';

  @override
  String daysValue(String days) {
    return '$days days';
  }

  @override
  String get noShiftsTitle => 'No Shifts Yet';

  @override
  String get noShiftsBody =>
      'Log a shift and it appears here by month, marked as a full or half day.';

  @override
  String get statusFull => 'Full Day';

  @override
  String get statusHalf => 'Half Day';

  @override
  String get statusNotCounted => 'Not Counted';

  @override
  String dayTotal(String hours) {
    return '$hours that day';
  }

  @override
  String get upcoming => 'Upcoming';

  @override
  String get newShift => 'New Shift';

  @override
  String get editShift => 'Edit Shift';

  @override
  String get date => 'Date';

  @override
  String get job => 'Job';

  @override
  String get hours => 'Hours';

  @override
  String get addAJob => 'Add a Job';

  @override
  String get countsFull => 'Counts as a full day';

  @override
  String get countsHalf => 'Counts as a half day';

  @override
  String get countsNotUniversity => 'Not counted: university job';

  @override
  String get countsZero => 'Set the hours worked';

  @override
  String withOtherShifts(int count, String hours) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count other shifts',
      one: '1 other shift',
    );
    return 'Together with $_temp0 that day: $hours';
  }

  @override
  String halfDayRule(String hours) {
    return 'More than $hours is a full day.';
  }

  @override
  String get note => 'Note';

  @override
  String get noteHint => 'Note (optional)';

  @override
  String get deleteShift => 'Delete Shift';

  @override
  String get deleteShiftConfirm =>
      'This shift will be removed from your count.';

  @override
  String get jobs => 'Jobs';

  @override
  String get newJob => 'New Job';

  @override
  String get editJob => 'Edit Job';

  @override
  String get jobNameHint => 'Job name';

  @override
  String get jobType => 'Type';

  @override
  String get kindRegular => 'Regular Job';

  @override
  String get kindRegularInfo => 'Counts toward the day limit.';

  @override
  String get kindMinijob => 'Minijob';

  @override
  String get kindMinijobInfo =>
      'Counts toward the day limit. Pay is checked against the monthly Minijob limit.';

  @override
  String get kindUniversity => 'University Job';

  @override
  String get kindUniversityInfo =>
      'Student assistant or tutor at a university. Usually not counted.';

  @override
  String get hourlyPay => 'Hourly Pay';

  @override
  String get hourlyPayHint => 'Amount';

  @override
  String get hourlyPayFooter => 'Used only to check the monthly Minijob limit.';

  @override
  String get deleteJob => 'Delete Job';

  @override
  String get deleteJobConfirm => 'This job will be deleted.';

  @override
  String deleteJobWithShifts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'its $count shifts',
      one: 'its 1 shift',
    );
    return 'This job and $_temp0 will be deleted.';
  }

  @override
  String get addJob => 'Add Job';

  @override
  String get planSchedule => 'Schedule';

  @override
  String get planStart => 'Start';

  @override
  String get planWeeks => 'Weeks';

  @override
  String get planDaysPerWeek => 'Days per Week';

  @override
  String get planHoursPerDay => 'Hours per Day';

  @override
  String weekdaySpan(String count, String first, String last) {
    return '$count ($first to $last)';
  }

  @override
  String planOverTitle(String date) {
    return 'Over the Limit from $date';
  }

  @override
  String planOverBody(String date, String days, String year) {
    return 'Your last planned day within the limit is $date. The plan goes $days over in $year.';
  }

  @override
  String planOverBodyNoLast(String days, String year) {
    return 'The limit for $year is already used up. The plan goes $days over.';
  }

  @override
  String get planReachedTitle => 'Uses Every Day Left';

  @override
  String planReachedBody(String date, String year) {
    return 'The limit for $year is reached on $date. No days are left after that.';
  }

  @override
  String get planFitsTitle => 'Fits Within the Limit';

  @override
  String planFitsBody(String days, String year) {
    return '$days left in $year after this plan.';
  }

  @override
  String get planNotCountedTitle => 'Not Counted';

  @override
  String get planNotCountedBody =>
      'University jobs do not count toward the day limit.';

  @override
  String get planWorkDays => 'Work Days';

  @override
  String get planAdds => 'Adds';

  @override
  String get planLastDay => 'Last Day';

  @override
  String leftAfterIn(String year) {
    return 'Left in $year';
  }

  @override
  String get addAsShifts => 'Add as Shifts';

  @override
  String addShiftsConfirm(int count, String job) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count shifts',
      one: '1 shift',
    );
    return '$_temp0 for $job will be added to your log.';
  }

  @override
  String addShiftsAction(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Shifts',
      one: '1 Shift',
    );
    return 'Add $_temp0';
  }

  @override
  String get planFooter =>
      'A what-if schedule. Nothing is saved until you add it as shifts. Planned hours add to shifts already logged on the same day.';

  @override
  String get planNeedsJob => 'Add a job in Settings to save a plan as shifts.';

  @override
  String shiftsAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count shifts added',
      one: '1 shift added',
    );
    return '$_temp0';
  }

  @override
  String get limits => 'Limits';

  @override
  String get fullDaysPerYear => 'Full Days per Year';

  @override
  String get halfDayUpTo => 'Half Day Up To';

  @override
  String get hoursPerWeek => 'Hours per Week';

  @override
  String minijobLimitIn(String year) {
    return 'Minijob Limit $year';
  }

  @override
  String get limitsFooter =>
      'Typical values for students from outside the EU, as of 2026. The rules changed in 2024 and can change again. Your residence permit and the Ausländerbehörde decide.';

  @override
  String get restoreTypical => 'Restore Typical Values';

  @override
  String get restoreTypicalConfirm =>
      'All limits go back to the typical values as of 2026. Your shifts stay as they are.';

  @override
  String get howItCounts => 'How Halfday Counts';

  @override
  String get fullDaysHelp => 'Half days are allowed at twice this number.';

  @override
  String get halfDayHelp =>
      'A day with more hours than this counts as a full day. Shifts on the same day are added up.';

  @override
  String get weeklyHelp =>
      'Shown on the overview. During the lecture period, more hours can affect your student status.';

  @override
  String minijobHelp(String year) {
    return 'Monthly pay limit for a Minijob in $year. Later years use this value until you set theirs.';
  }

  @override
  String get valueInvalid => 'Enter a number greater than zero.';

  @override
  String get howFullHalfTitle => 'Full and Half Days';

  @override
  String howFullHalfBody(String hours) {
    return 'Halfday adds up the hours of all counted jobs on each date. More than $hours is a full day, up to $hours is a half day. The count runs per calendar year and starts again on 1 January. Days left are shown in full days: 118.5 means 118 full days and one half day.';
  }

  @override
  String get howNotCountedTitle => 'Not Counted';

  @override
  String get howNotCountedBody =>
      'Jobs marked University Job are not counted, because student assistant and tutor jobs at a university usually are not. Vacation and sick days are not counted either: just do not log them.';

  @override
  String get howWeekTitle => 'Weekly Hours';

  @override
  String howWeekBody(String hours) {
    return 'During the lecture period, working more than $hours a week can affect your student status, for example for health insurance. Halfday shows the hours; it does not judge them.';
  }

  @override
  String get howOtherTitle => 'Another Method';

  @override
  String get howOtherBody =>
      'Some Ausländerbehörden also accept counting regular part-time work as 2.5 days per week. Halfday does not calculate this; ask your office if it applies to you.';

  @override
  String get howLegalTitle => 'Not Legal Advice';

  @override
  String get howLegalBody =>
      'Halfday counts what you enter using typical rules. Your residence permit, its supplementary sheet and your Ausländerbehörde decide what applies to you.';
}
