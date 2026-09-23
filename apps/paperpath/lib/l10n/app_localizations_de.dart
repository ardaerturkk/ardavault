// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Paperpath';

  @override
  String get tabSteps => 'Schritte';

  @override
  String get tabDocuments => 'Unterlagen';

  @override
  String get sectionReady => 'Bereit';

  @override
  String get sectionWaiting => 'Wartet';

  @override
  String get sectionDone => 'Erledigt';

  @override
  String get readyFooter => 'Für diese Schritte hast du alles beisammen.';

  @override
  String needsOne(String doc) {
    return 'Braucht $doc';
  }

  @override
  String needsMany(String doc, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count weitere',
      one: '1 weitere',
    );
    return 'Braucht $doc und $_temp0';
  }

  @override
  String get dueToday => 'Heute fällig';

  @override
  String get dueTomorrow => 'Morgen fällig';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tagen',
      one: '1 Tag',
    );
    return 'Fällig in $_temp0';
  }

  @override
  String dueOn(String date) {
    return 'Fällig am $date';
  }

  @override
  String overdue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage überfällig',
      one: '1 Tag überfällig',
    );
    return '$_temp0';
  }

  @override
  String appointmentOn(String date) {
    return 'Termin $date';
  }

  @override
  String get movedIn => 'Einzugsdatum';

  @override
  String get notSet => 'Nicht festgelegt';

  @override
  String get starterFooter =>
      'Fristen wie die Anmeldung zählen ab diesem Tag. Die Regeln sind je nach Stadt verschieden, prüfe die Website deines Amts.';

  @override
  String get emptyStepsTitle => 'Noch keine Schritte';

  @override
  String get emptyStepsBody =>
      'Beginne mit dem üblichen Papierkram für den Umzug nach Deutschland. Jeden Schritt kannst du ändern.';

  @override
  String get addStarter => 'Deutschland-Startschritte hinzufügen';

  @override
  String get addOwnStep => 'Eigenen Schritt hinzufügen';

  @override
  String get moveInQuestion => 'Wann ziehst du ein?';

  @override
  String get moveInHelp => 'Fristen wie die Anmeldung zählen ab diesem Tag.';

  @override
  String get continueLabel => 'Weiter';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get done => 'Fertig';

  @override
  String get save => 'Sichern';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get addStep => 'Schritt hinzufügen';

  @override
  String get addDocument => 'Unterlage hinzufügen';

  @override
  String get bring => 'Mitbringen';

  @override
  String get bringFooter =>
      'Tippe auf eine Unterlage, sobald du sie hast. Nimm Originale und eine Kopie mit.';

  @override
  String get nothingToBring => 'Nichts mitzubringen';

  @override
  String get youGet => 'Du bekommst';

  @override
  String get dates => 'Fristen und Termine';

  @override
  String get deadline => 'Frist';

  @override
  String get appointment => 'Termin';

  @override
  String get none => 'Keine';

  @override
  String get notes => 'Notizen';

  @override
  String get markDone => 'Als erledigt markieren';

  @override
  String get markNotDone => 'Als offen markieren';

  @override
  String get removeDeadline => 'Frist entfernen';

  @override
  String get removeAppointment => 'Termin entfernen';

  @override
  String get inHand => 'Vorhanden';

  @override
  String get missing => 'Fehlt';

  @override
  String neededForCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Für $count offene Schritte nötig',
      one: 'Für 1 offenen Schritt nötig',
      zero: 'Für keinen offenen Schritt nötig',
    );
    return '$_temp0';
  }

  @override
  String comesFrom(String step) {
    return 'Von: $step';
  }

  @override
  String get neededFor => 'Nötig für';

  @override
  String get comesFromHeader => 'Kommt von';

  @override
  String get emptyDocsTitle => 'Noch keine Unterlagen';

  @override
  String get emptyDocsBody =>
      'Füge die Papiere hinzu, die du schon hast, zum Beispiel deinen Pass.';

  @override
  String get newStep => 'Neuer Schritt';

  @override
  String get editStep => 'Schritt bearbeiten';

  @override
  String get newDocument => 'Neue Unterlage';

  @override
  String get editDocument => 'Unterlage bearbeiten';

  @override
  String get title => 'Titel';

  @override
  String get stepTitleHint => 'Zum Beispiel: Wohnsitz anmelden';

  @override
  String get name => 'Name';

  @override
  String get docNameHint => 'Zum Beispiel: Reisepass';

  @override
  String get notesHint => 'Wohin, was fragen';

  @override
  String get needs => 'Mitbringen';

  @override
  String get givesYou => 'Du bekommst';

  @override
  String get noneChosen => 'Keine';

  @override
  String get deleteStep => 'Schritt löschen';

  @override
  String get deleteDocument => 'Unterlage löschen';

  @override
  String get deleteStepConfirm =>
      'Dieser Schritt wird aus deinem Plan entfernt.';

  @override
  String get deleteDocConfirm =>
      'Diese Unterlage wird auch aus allen Schritten entfernt.';

  @override
  String get saveFailed =>
      'Deine letzte Änderung konnte nicht gesichert werden. Gib etwas Speicher frei und versuche es erneut.';

  @override
  String get loadFailed =>
      'Dein gesicherter Plan konnte nicht gelesen werden, deshalb wurde ein neuer Plan begonnen. Die alte Datei ist noch auf diesem iPhone.';

  @override
  String get ok => 'OK';

  @override
  String received(String docs) {
    return 'Du hast jetzt: $docs.';
  }

  @override
  String get semToggleHint =>
      'Markiert die Unterlage als vorhanden oder fehlend';

  @override
  String get docPassport => 'Reisepass';

  @override
  String get docVisa => 'Visum (nationales D-Visum)';

  @override
  String get docAdmission => 'Zulassungsbescheid';

  @override
  String get docBlockedAccount => 'Sperrkonto-Bestätigung';

  @override
  String get docPhoto => 'Biometrisches Passfoto';

  @override
  String get docRentalContract => 'Mietvertrag';

  @override
  String get docLandlordConfirmation => 'Wohnungsgeberbestätigung';

  @override
  String get docRegistration => 'Meldebescheinigung';

  @override
  String get docInsurance => 'Krankenversicherungsnachweis';

  @override
  String get docEnrollment => 'Immatrikulationsbescheinigung';

  @override
  String get docBankAccount => 'Deutsches Bankkonto (IBAN)';

  @override
  String get docTaxId => 'Brief mit Steuer-ID';

  @override
  String get docBroadcastNumber => 'Beitragsnummer (Rundfunkbeitrag)';

  @override
  String get docResidencePermit => 'Aufenthaltstitel (eAT)';

  @override
  String get stepSignLease => 'Mietvertrag unterschreiben';

  @override
  String get stepSignLeaseNote =>
      'Lass dir auch die Wohnungsgeberbestätigung geben. Die Anmeldung braucht sie.';

  @override
  String get stepAnmeldung => 'Wohnsitz anmelden';

  @override
  String get stepAnmeldungNote =>
      'Beim Bürgeramt, meist innerhalb von 14 Tagen nach dem Einzug. Buche den Termin früh.';

  @override
  String get stepInsurance => 'Krankenversicherung abschließen';

  @override
  String get stepInsuranceNote =>
      'Die Versicherung meldet dich bei der Hochschule. Behalte deinen eigenen Nachweis für die Ausländerbehörde.';

  @override
  String get stepEnroll => 'An der Uni einschreiben';

  @override
  String get stepEnrollNote =>
      'Zahle zuerst den Semesterbeitrag. Das Semesterticket ist meist dabei.';

  @override
  String get stepBank => 'Bankkonto eröffnen';

  @override
  String get stepBankNote =>
      'Manche Onlinebanken verlangen keine Meldebescheinigung.';

  @override
  String get stepBlockedPayout => 'Sperrkonto-Auszahlung starten';

  @override
  String get stepBlockedPayoutNote =>
      'Gib deinem Sperrkonto-Anbieter deine neue IBAN, damit die monatliche Auszahlung beginnt.';

  @override
  String get stepTaxId => 'Steuer-ID erhalten';

  @override
  String get stepTaxIdNote =>
      'Kommt einige Wochen nach der Anmeldung per Post. Du brauchst sie für einen Job.';

  @override
  String get stepBroadcastFee => 'Rundfunkbeitrag anmelden';

  @override
  String get stepBroadcastFeeNote =>
      'Ein Beitrag pro Wohnung. Zahlt schon jemand aus der WG, notiere dessen Beitragsnummer.';

  @override
  String get stepPhoto => 'Biometrische Fotos machen';

  @override
  String get stepPhotoNote =>
      'Gibt es im Fotoautomaten oder Fotoladen. Nimm ein paar mehr.';

  @override
  String get stepResidencePermit => 'Aufenthaltserlaubnis beantragen';

  @override
  String get stepResidencePermitNote =>
      'Bei der Ausländerbehörde, bevor dein Visum abläuft. Setze die Frist auf das Ende deines Visums, Termine dauern oft Wochen.';

  @override
  String confirmDoneMissing(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Unterlagen fehlen noch.',
      one: '1 Unterlage fehlt noch.',
    );
    return '$_temp0 Trotzdem als erledigt markieren?';
  }

  @override
  String get stepDone => 'Erledigt';

  @override
  String get discardChanges => 'Änderungen verwerfen';

  @override
  String get keepEditing => 'Weiter bearbeiten';
}
