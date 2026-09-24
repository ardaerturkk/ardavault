// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Sheetwise';

  @override
  String get courses => 'Kurse';

  @override
  String get addCourse => 'Kurs hinzufügen';

  @override
  String get emptyTitle => 'Noch keine Kurse';

  @override
  String get emptyBody =>
      'Füge einen Kurs mit der Zulassungsregel von seiner Kursseite hinzu. Nach jedem korrigierten Blatt siehst du, was dir noch fehlt.';

  @override
  String get listFooter =>
      'Das Dringendste zuerst. Grundlage sind die Regeln, die du eingegeben hast; verbindlich ist die Kursseite.';

  @override
  String get loadFailed =>
      'Deine gespeicherten Kurse konnten nicht gelesen werden. Eine Kopie wurde aufbewahrt, nichts wurde überschrieben.';

  @override
  String get saveFailed =>
      'Deine letzte Änderung konnte nicht gespeichert werden. Sheetwise versucht es bei der nächsten Änderung erneut.';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get save => 'Sichern';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get all => 'Alle';

  @override
  String get increase => 'Erhöhen';

  @override
  String get decrease => 'Verringern';

  @override
  String get discardChanges => 'Änderungen verwerfen';

  @override
  String get keepEditing => 'Weiter bearbeiten';

  @override
  String get statusAdmitted => 'Zugelassen';

  @override
  String get statusOutOfReach => 'Nicht mehr erreichbar';

  @override
  String get statusNoSheets => 'Noch keine Blätter';

  @override
  String statusNeedPoints(String points, String max) {
    return '$points von $max pro Blatt nötig';
  }

  @override
  String statusNeedShare(String percent) {
    return '$percent pro Blatt nötig';
  }

  @override
  String statusPresentations(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Noch $count-mal Vorrechnen',
      one: 'Noch 1 Vorrechnen',
    );
    return '$_temp0';
  }

  @override
  String sheetsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Noch $count Blätter',
      one: 'Noch 1 Blatt',
      zero: 'Keine Blätter mehr',
    );
    return '$_temp0';
  }

  @override
  String sheetName(int number) {
    return 'Blatt $number';
  }

  @override
  String extraSheetName(int number) {
    return 'Zusatzblatt $number';
  }

  @override
  String heroPerSheetOf(int count, String max) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'von $max Punkten auf jedem der $count restlichen Blätter',
      one: 'von $max Punkten auf dem letzten Blatt',
    );
    return '$_temp0';
  }

  @override
  String heroPerSheetShare(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'der Punkte auf jedem der $count restlichen Blätter',
      one: 'der Punkte auf dem letzten Blatt',
    );
    return '$_temp0';
  }

  @override
  String get heroAdmitted => 'Zugelassen';

  @override
  String get heroAdmittedBody =>
      'Alle Bedingungen der eingegebenen Regel sind erfüllt.';

  @override
  String get heroOutOfReach => 'Nicht mehr erreichbar';

  @override
  String outOfReachPoints(String points) {
    return 'Selbst mit voller Punktzahl auf allen restlichen Blättern fehlen dir $points Punkte.';
  }

  @override
  String outOfReachSheets(int possible, String percent, int required) {
    return 'Nur noch $possible Blätter können $percent erreichen, nötig sind $required.';
  }

  @override
  String heroPresentationsBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vorrechnen fehlen noch. Deine Punkte reichen.',
      one: 'Vorrechnen fehlt noch. Deine Punkte reichen.',
    );
    return '$_temp0';
  }

  @override
  String get heroNoSheets => 'Noch keine Blätter';

  @override
  String get heroNoSheetsBody =>
      'Füge die Blätter dieses Kurses hinzu, um zu sehen, wo du stehst.';

  @override
  String pointsSoFar(String counted, String total) {
    return '$counted von $total Punkten';
  }

  @override
  String pointsNeeded(String needed) {
    return '$needed nötig';
  }

  @override
  String sheetsPassedSoFar(int passed, int required, String percent) {
    return '$passed von $required Blättern mit mindestens $percent';
  }

  @override
  String skipNeedPoints(String sheet, String points, String max) {
    return 'Lässt du $sheet aus: $points von $max auf jedem anderen Blatt.';
  }

  @override
  String skipNeedShare(String sheet, String percent) {
    return 'Lässt du $sheet aus: $percent auf jedem anderen Blatt.';
  }

  @override
  String skipOutOfReach(String sheet) {
    return 'Lässt du $sheet aus, ist die Zulassung nicht mehr erreichbar.';
  }

  @override
  String skipNoCost(String sheet) {
    return '$sheet auszulassen würde dich nichts kosten.';
  }

  @override
  String enterSheet(String sheet) {
    return '$sheet eintragen';
  }

  @override
  String get ruleHeader => 'Zulassungsregel';

  @override
  String rulePercentAll(String percent) {
    return '$percent aller Punkte';
  }

  @override
  String rulePercentBest(String percent, int count) {
    return '$percent der besten $count Blätter';
  }

  @override
  String rulePoints(String points) {
    return '$points Punkte';
  }

  @override
  String rulePointsBest(String points, int count) {
    return '$points Punkte aus den besten $count Blättern';
  }

  @override
  String ruleMinAll(String percent) {
    return '$percent auf jedem Blatt';
  }

  @override
  String ruleMinCount(String percent, int count) {
    return '$percent auf mindestens $count Blättern';
  }

  @override
  String get presentations => 'Vorrechnen';

  @override
  String valueOf(String value, String total) {
    return '$value von $total';
  }

  @override
  String get ruleFooter =>
      'Grundlage ist die Regel, die du eingegeben hast. Verbindlich ist die Kursseite.';

  @override
  String get met => 'Erfüllt';

  @override
  String get notMetYet => 'Noch nicht erfüllt';

  @override
  String bonusFrom(String percent) {
    return 'Bonus ab $percent';
  }

  @override
  String get bonusReached => 'Erreicht';

  @override
  String get addPresentation => 'Vorrechnen hinzufügen';

  @override
  String get removePresentation => 'Vorrechnen entfernen';

  @override
  String get sheetsHeader => 'Blätter';

  @override
  String get sheetOpen => 'Noch nicht korrigiert';

  @override
  String get sheetMissed => 'Nicht abgegeben';

  @override
  String get sheetExcused => 'Entschuldigt';

  @override
  String get addSheet => 'Blatt hinzufügen';

  @override
  String get addExtraSheet => 'Zusatzblatt hinzufügen';

  @override
  String get addSheetMessage =>
      'Punkte auf einem Zusatzblatt zählen, seine Höchstpunktzahl erhöht die Gesamtpunktzahl aber nicht.';

  @override
  String get noteHeader => 'Notiz';

  @override
  String get points => 'Punkte';

  @override
  String ofMax(String max) {
    return 'von $max';
  }

  @override
  String get resultHeader => 'Ergebnis';

  @override
  String get stateGraded => 'Korrigiert';

  @override
  String get stateOpen => 'Noch nicht korrigiert';

  @override
  String get stateMissed => 'Nicht abgegeben';

  @override
  String get stateExcused => 'Entschuldigt';

  @override
  String get resultFooter =>
      'Ein nicht abgegebenes Blatt zählt mit null Punkten. Ein entschuldigtes Blatt fällt aus der Gesamtpunktzahl heraus.';

  @override
  String get maxPoints => 'Höchstpunktzahl';

  @override
  String get extraSheet => 'Zusatzblatt';

  @override
  String get extraFooter =>
      'Punkte auf einem Zusatzblatt zählen, seine Höchstpunktzahl erhöht die Gesamtpunktzahl aber nicht.';

  @override
  String get whatIfHeader => 'Was wäre, wenn';

  @override
  String get whatIfSkip => 'Wenn du dieses Blatt auslässt';

  @override
  String whatIfNeedPoints(String points, String max) {
    return 'Du bräuchtest $points von $max auf jedem anderen restlichen Blatt.';
  }

  @override
  String whatIfNeedShare(String percent) {
    return 'Du bräuchtest $percent auf jedem anderen restlichen Blatt.';
  }

  @override
  String get whatIfOut => 'Die Zulassung wäre nicht mehr erreichbar.';

  @override
  String get whatIfAdmitted => 'Du wärst trotzdem zugelassen.';

  @override
  String get whatIfEnough => 'Deine Punkte würden trotzdem reichen.';

  @override
  String get whatIfFooter =>
      'Nichts wird gespeichert; hier siehst du nur die Zahlen.';

  @override
  String get deleteSheet => 'Blatt löschen';

  @override
  String get deleteSheetConfirm => 'Dieses Blatt und sein Ergebnis löschen?';

  @override
  String get pointsInvalid => 'Gib die Punkte ein, zum Beispiel 7,5.';

  @override
  String get newCourse => 'Neuer Kurs';

  @override
  String get editCourse => 'Kurs bearbeiten';

  @override
  String get courseName => 'Kursname';

  @override
  String get courseNameHint => 'Zum Beispiel Lineare Algebra';

  @override
  String get sheetCount => 'Anzahl der Blätter';

  @override
  String get pointsPerSheet => 'Punkte pro Blatt';

  @override
  String get sheetsFooterNew =>
      'Noch nicht sicher? Schätze einfach. Du kannst später Blätter hinzufügen oder entfernen.';

  @override
  String get sheetsFooterEdit =>
      'Blätter mit Ergebnis werden hier nie entfernt; lösche sie einzeln.';

  @override
  String get presetsHeader => 'Übliche Regeln';

  @override
  String presetHalf(String percent) {
    return '$percent aller Punkte';
  }

  @override
  String presetHalfAndMinimum(String percent, String minimum) {
    return '$percent aller Punkte, $minimum pro Blatt';
  }

  @override
  String presetHalfOfBest(String percent) {
    return '$percent der besten Blätter, 2 Streichblätter';
  }

  @override
  String presetMostSheets(String percent) {
    return '$percent auf allen Blättern bis auf 2';
  }

  @override
  String get presetsFooter =>
      'Wähle die passendste und passe die Details unten an.';

  @override
  String get neededKind => 'Gesamt';

  @override
  String get kindPercent => 'Anteil';

  @override
  String get kindPoints => 'Punkte';

  @override
  String get kindNone => 'Keine';

  @override
  String get shareOfPoints => 'Anteil der Punkte';

  @override
  String get pointsNeededField => 'Nötige Punkte';

  @override
  String get bestOnly => 'Nur die besten Blätter zählen';

  @override
  String get bestCount => 'Gezählte Blätter';

  @override
  String get minEach => 'Minimum pro Blatt';

  @override
  String get minPercent => 'Anteil pro Blatt';

  @override
  String get minCount => 'So viele Blätter müssen es schaffen';

  @override
  String get presentationsSwitch => 'Vorrechnen';

  @override
  String get presentationsNeeded => 'Wie oft vorrechnen';

  @override
  String get ruleEditorFooter =>
      'Übernimm die Regel von deiner Kursseite. Ein nicht abgegebenes Blatt zählt mit null Punkten, ein entschuldigtes fällt heraus.';

  @override
  String get noConditionFooter => 'Wähle mindestens eine Bedingung.';

  @override
  String get invalidFooter =>
      'Einige Zahlen sind ungültig. Anteile gehen bis 100.';

  @override
  String get bonusHeader => 'Klausurbonus';

  @override
  String get addBonusTier => 'Bonusstufe hinzufügen';

  @override
  String get bonusFooter =>
      'Gibt es für gute Übungsergebnisse einen Bonus in der Klausur, trage jede Stufe ein.';

  @override
  String get bonusTierTitle => 'Bonusstufe';

  @override
  String get bonusFromField => 'Ab';

  @override
  String get bonusLabelField => 'Bonus';

  @override
  String get bonusLabelHint => 'Zum Beispiel eine Notenstufe';

  @override
  String get bonusTierFooter =>
      'Der Anteil der gezählten Punkte, den dieser Bonus braucht.';

  @override
  String get deleteBonusTier => 'Bonusstufe löschen';

  @override
  String get noteHint => 'Tutor, Gruppe, wo die Punkte stehen';

  @override
  String get deleteCourse => 'Kurs löschen';

  @override
  String get deleteCourseConfirm => 'Diesen Kurs mit allen Blättern löschen?';
}
