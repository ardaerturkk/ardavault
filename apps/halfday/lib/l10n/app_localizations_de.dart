// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Halfday';

  @override
  String get tabOverview => 'Übersicht';

  @override
  String get tabShifts => 'Schichten';

  @override
  String get tabPlan => 'Planen';

  @override
  String get tabSettings => 'Einstellungen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get done => 'Fertig';

  @override
  String get save => 'Sichern';

  @override
  String get ok => 'OK';

  @override
  String get discardChanges => 'Änderungen verwerfen';

  @override
  String get keepEditing => 'Weiter bearbeiten';

  @override
  String get saveFailed =>
      'Deine letzte Änderung konnte nicht gesichert werden. Gib etwas Speicher frei und versuche es erneut.';

  @override
  String get loadFailed =>
      'Deine gesicherten Schichten konnten nicht gelesen werden, deshalb startet Halfday leer. Die alte Datei ist noch auf diesem iPhone.';

  @override
  String daysLeftIn(String year) {
    return 'Tage übrig in $year';
  }

  @override
  String daysOverIn(String year) {
    return 'Tage über dem Limit in $year';
  }

  @override
  String usedOfLimit(String limit, String used) {
    return '$used von $limit Tagen genutzt';
  }

  @override
  String fullAndHalf(int full, int half) {
    String _temp0 = intl.Intl.pluralLogic(
      full,
      locale: localeName,
      other: '$full ganze Tage',
      one: '1 ganzer Tag',
    );
    String _temp1 = intl.Intl.pluralLogic(
      half,
      locale: localeName,
      other: '$half halbe Tage',
      one: '1 halber Tag',
    );
    return '$_temp0, $_temp1';
  }

  @override
  String upcomingIncluded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count geplanter Tage',
      one: '1 geplantem Tag',
    );
    return 'Inklusive $_temp0';
  }

  @override
  String get logShift => 'Schicht eintragen';

  @override
  String overviewFirstHint(String hours) {
    return 'Jede Schicht wird zu einem ganzen Tag (mehr als $hours) oder einem halben Tag. Jobs an der Uni können ausgenommen werden.';
  }

  @override
  String heroFooter(String full, String half) {
    return 'Übliche Regel: $full ganze oder $half halbe Tage im Jahr. Maßgeblich sind deine Aufenthaltserlaubnis und die Ausländerbehörde.';
  }

  @override
  String get sectionThisWeek => 'Diese Woche';

  @override
  String get hoursThisWeek => 'Stunden diese Woche';

  @override
  String ofValue(String limit, String used) {
    return '$used von $limit';
  }

  @override
  String minijobPayIn(String month) {
    return 'Minijob-Lohn im $month';
  }

  @override
  String get weekFooter =>
      'Stunden in allen Jobs, Montag bis Sonntag. Die Wochengrenze zählt in der Vorlesungszeit.';

  @override
  String get overWeekLimit => 'Über der Wochengrenze';

  @override
  String get overMinijobLimit => 'Über der Minijob-Grenze';

  @override
  String hoursValue(String hours) {
    return '$hours Std.';
  }

  @override
  String get oneDay => '1 Tag';

  @override
  String daysValue(String days) {
    return '$days Tage';
  }

  @override
  String get noShiftsTitle => 'Noch keine Schichten';

  @override
  String get noShiftsBody =>
      'Trag eine Schicht ein. Sie erscheint hier nach Monat, als ganzer oder halber Tag markiert.';

  @override
  String get statusFull => 'Ganzer Tag';

  @override
  String get statusHalf => 'Halber Tag';

  @override
  String get statusNotCounted => 'Zählt nicht';

  @override
  String dayTotal(String hours) {
    return '$hours an dem Tag';
  }

  @override
  String get upcoming => 'Geplant';

  @override
  String get newShift => 'Neue Schicht';

  @override
  String get editShift => 'Schicht bearbeiten';

  @override
  String get date => 'Datum';

  @override
  String get job => 'Job';

  @override
  String get hours => 'Stunden';

  @override
  String get addAJob => 'Job hinzufügen';

  @override
  String get countsFull => 'Zählt als ganzer Tag';

  @override
  String get countsHalf => 'Zählt als halber Tag';

  @override
  String get countsNotUniversity => 'Zählt nicht: Job an der Uni';

  @override
  String get countsZero => 'Stell die gearbeiteten Stunden ein';

  @override
  String withOtherShifts(int count, String hours) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count weiteren Schichten',
      one: '1 weiteren Schicht',
    );
    return 'Zusammen mit $_temp0 an dem Tag: $hours';
  }

  @override
  String halfDayRule(String hours) {
    return 'Mehr als $hours ist ein ganzer Tag.';
  }

  @override
  String get note => 'Notiz';

  @override
  String get noteHint => 'Notiz (optional)';

  @override
  String get deleteShift => 'Schicht löschen';

  @override
  String get deleteShiftConfirm =>
      'Diese Schicht wird aus deiner Zählung entfernt.';

  @override
  String get jobs => 'Jobs';

  @override
  String get newJob => 'Neuer Job';

  @override
  String get editJob => 'Job bearbeiten';

  @override
  String get jobNameHint => 'Name des Jobs';

  @override
  String get jobType => 'Art';

  @override
  String get kindRegular => 'Normaler Job';

  @override
  String get kindRegularInfo => 'Zählt zum Tageslimit.';

  @override
  String get kindMinijob => 'Minijob';

  @override
  String get kindMinijobInfo =>
      'Zählt zum Tageslimit. Der Lohn wird mit der monatlichen Minijob-Grenze verglichen.';

  @override
  String get kindUniversity => 'Job an der Uni';

  @override
  String get kindUniversityInfo =>
      'Studentische Hilfskraft oder Tutor an einer Hochschule. Zählt meist nicht.';

  @override
  String get hourlyPay => 'Stundenlohn';

  @override
  String get hourlyPayHint => 'Betrag';

  @override
  String get hourlyPayFooter =>
      'Wird nur für die monatliche Minijob-Grenze verwendet.';

  @override
  String get deleteJob => 'Job löschen';

  @override
  String get deleteJobConfirm => 'Dieser Job wird gelöscht.';

  @override
  String deleteJobWithShifts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'seine $count Schichten',
      one: 'seine 1 Schicht',
    );
    return 'Dieser Job und $_temp0 werden gelöscht.';
  }

  @override
  String get addJob => 'Job hinzufügen';

  @override
  String get planSchedule => 'Zeitplan';

  @override
  String get planStart => 'Beginn';

  @override
  String get planWeeks => 'Wochen';

  @override
  String get planDaysPerWeek => 'Tage pro Woche';

  @override
  String get planHoursPerDay => 'Stunden pro Tag';

  @override
  String weekdaySpan(String count, String first, String last) {
    return '$count ($first bis $last)';
  }

  @override
  String planOverTitle(String date) {
    return 'Über dem Limit ab $date';
  }

  @override
  String planOverBody(String date, String days, String year) {
    return 'Dein letzter geplanter Tag im Limit ist der $date. Der Plan liegt $year um $days darüber.';
  }

  @override
  String planOverBodyNoLast(String days, String year) {
    return 'Das Limit für $year ist schon aufgebraucht. Der Plan liegt $days darüber.';
  }

  @override
  String get planReachedTitle => 'Nutzt alle übrigen Tage';

  @override
  String planReachedBody(String date, String year) {
    return 'Das Limit für $year ist am $date erreicht. Danach sind keine Tage mehr übrig.';
  }

  @override
  String get planFitsTitle => 'Passt ins Limit';

  @override
  String planFitsBody(String days, String year) {
    return 'Nach diesem Plan bleiben $year noch $days.';
  }

  @override
  String get planNotCountedTitle => 'Zählt nicht';

  @override
  String get planNotCountedBody =>
      'Jobs an der Uni zählen nicht zum Tageslimit.';

  @override
  String get planWorkDays => 'Arbeitstage';

  @override
  String get planAdds => 'Kommt hinzu';

  @override
  String get planLastDay => 'Letzter Tag';

  @override
  String leftAfterIn(String year) {
    return 'Übrig $year';
  }

  @override
  String get addAsShifts => 'Als Schichten eintragen';

  @override
  String addShiftsConfirm(int count, String job) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Schichten',
      one: '1 Schicht',
    );
    return '$_temp0 für $job werden eingetragen.';
  }

  @override
  String addShiftsAction(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Schichten',
      one: '1 Schicht',
    );
    return '$_temp0 eintragen';
  }

  @override
  String get planFooter =>
      'Ein Was-wäre-wenn-Plan. Nichts wird gesichert, bis du ihn als Schichten einträgst. Geplante Stunden kommen zu Schichten am selben Tag hinzu.';

  @override
  String get planNeedsJob =>
      'Füge in den Einstellungen einen Job hinzu, um den Plan als Schichten einzutragen.';

  @override
  String shiftsAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Schichten eingetragen',
      one: '1 Schicht eingetragen',
    );
    return '$_temp0';
  }

  @override
  String get limits => 'Grenzen';

  @override
  String get fullDaysPerYear => 'Ganze Tage pro Jahr';

  @override
  String get halfDayUpTo => 'Halber Tag bis';

  @override
  String get hoursPerWeek => 'Stunden pro Woche';

  @override
  String minijobLimitIn(String year) {
    return 'Minijob-Grenze $year';
  }

  @override
  String get limitsFooter =>
      'Übliche Werte für Studierende aus Nicht-EU-Staaten, Stand 2026. Die Regeln haben sich 2024 geändert und können sich wieder ändern. Maßgeblich sind deine Aufenthaltserlaubnis und die Ausländerbehörde.';

  @override
  String get restoreTypical => 'Übliche Werte wiederherstellen';

  @override
  String get restoreTypicalConfirm =>
      'Alle Grenzen werden auf die üblichen Werte von 2026 zurückgesetzt. Deine Schichten bleiben unverändert.';

  @override
  String get howItCounts => 'So zählt Halfday';

  @override
  String get fullDaysHelp => 'Halbe Tage sind doppelt so viele erlaubt.';

  @override
  String get halfDayHelp =>
      'Ein Tag mit mehr Stunden zählt als ganzer Tag. Schichten am selben Tag werden addiert.';

  @override
  String get weeklyHelp =>
      'Wird in der Übersicht gezeigt. In der Vorlesungszeit können mehr Stunden deinen Studierendenstatus berühren.';

  @override
  String minijobHelp(String year) {
    return 'Monatliche Verdienstgrenze für einen Minijob $year. Spätere Jahre übernehmen diesen Wert, bis du ihren einträgst.';
  }

  @override
  String get valueInvalid => 'Gib eine Zahl größer als null ein.';

  @override
  String get howFullHalfTitle => 'Ganze und halbe Tage';

  @override
  String howFullHalfBody(String hours) {
    return 'Halfday addiert die Stunden aller gezählten Jobs pro Datum. Mehr als $hours ist ein ganzer Tag, bis $hours ein halber Tag. Gezählt wird pro Kalenderjahr, ab 1. Januar beginnt es neu. Übrige Tage werden in ganzen Tagen gezeigt: 118,5 heißt 118 ganze Tage und ein halber Tag.';
  }

  @override
  String get howNotCountedTitle => 'Was nicht zählt';

  @override
  String get howNotCountedBody =>
      'Jobs mit der Art Job an der Uni zählen nicht, weil Hilfskraft- und Tutorjobs an Hochschulen meist nicht zählen. Urlaubs- und Krankheitstage zählen auch nicht: trag sie einfach nicht ein.';

  @override
  String get howWeekTitle => 'Wochenstunden';

  @override
  String howWeekBody(String hours) {
    return 'In der Vorlesungszeit können mehr als $hours pro Woche deinen Studierendenstatus berühren, etwa bei der Krankenversicherung. Halfday zeigt die Stunden, bewertet sie aber nicht.';
  }

  @override
  String get howOtherTitle => 'Eine andere Methode';

  @override
  String get howOtherBody =>
      'Manche Ausländerbehörden rechnen regelmäßige Teilzeitarbeit auch als 2,5 Tage pro Woche. Halfday berechnet das nicht; frag deine Behörde, ob das für dich gilt.';

  @override
  String get howLegalTitle => 'Keine Rechtsberatung';

  @override
  String get howLegalBody =>
      'Halfday zählt, was du einträgst, nach üblichen Regeln. Was für dich gilt, entscheiden deine Aufenthaltserlaubnis, ihr Zusatzblatt und deine Ausländerbehörde.';
}
