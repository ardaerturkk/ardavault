// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Sagbar';

  @override
  String get tabSituations => 'Situationen';

  @override
  String get tabMe => 'Meine Angaben';

  @override
  String get startTitle => 'Einmal deine Angaben eintragen';

  @override
  String get startBody =>
      'Dein Name, deine Adresse und deine Nummern stehen dann direkt in jedem deutschen Satz.';

  @override
  String get startButton => 'Angaben eintragen';

  @override
  String get situationsFooter =>
      'Alltagssätze für Schalter und Telefon. Sie sind keine Rechtsberatung.';

  @override
  String appointmentOn(String date) {
    return 'Termin $date';
  }

  @override
  String get fillMissing => 'Fehlende Angaben ergänzen';

  @override
  String missingList(String names) {
    return 'Fehlt: $names';
  }

  @override
  String get visitHeader => 'Dieser Termin';

  @override
  String get appointment => 'Termin';

  @override
  String get removeAppointment => 'Termin entfernen';

  @override
  String get refFooter =>
      'Die Nummer aus deinem Brief oder deiner Terminbestätigung.';

  @override
  String get notSet => 'Nicht festgelegt';

  @override
  String get linesHeader => 'Sätze';

  @override
  String get linesFooter =>
      'Tippe auf einen Satz, um ihn groß zu zeigen. Halte ihn gedrückt, um ihn zu kopieren oder auszublenden.';

  @override
  String get noLines =>
      'Hier sind keine Sätze. Füge eigene hinzu oder blende die ausgeblendeten wieder ein.';

  @override
  String get addLine => 'Eigenen Satz hinzufügen';

  @override
  String showHidden(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ausgeblendete Sätze zeigen',
      one: '1 ausgeblendeten Satz zeigen',
    );
    return '$_temp0';
  }

  @override
  String get showCards => 'Als Karten zeigen';

  @override
  String get yourLine => 'Eigener Satz';

  @override
  String get copy => 'Kopieren';

  @override
  String get copied => 'Kopiert';

  @override
  String get hideLine => 'Satz ausblenden';

  @override
  String get editLine => 'Satz bearbeiten';

  @override
  String get deleteLine => 'Satz löschen';

  @override
  String get deleteLineConfirm => 'Dieser Satz wird gelöscht.';

  @override
  String get newLine => 'Neuer Satz';

  @override
  String get germanLabel => 'Deutsch';

  @override
  String get germanHint => 'Was du sagen möchtest, auf Deutsch';

  @override
  String get meaningLabel => 'Bedeutung';

  @override
  String get meaningHint => 'Was es bedeutet (optional)';

  @override
  String get lineEditorFooter =>
      'Schreib den Satz so, wie du ihn sagen möchtest. In eigene Sätze werden deine Angaben nicht eingesetzt.';

  @override
  String cardOf(int index, int total) {
    return '$index von $total';
  }

  @override
  String get previousLine => 'Vorheriger Satz';

  @override
  String get nextLine => 'Nächster Satz';

  @override
  String get aboutYou => 'Persönliches';

  @override
  String get contact => 'Kontakt';

  @override
  String get numbers => 'Nummern';

  @override
  String get meFooter =>
      'Nur auf diesem iPhone gespeichert. Sagbar setzt sie in deine deutschen Sätze ein.';

  @override
  String get fieldName => 'Vollständiger Name';

  @override
  String get fieldBirthDate => 'Geburtsdatum';

  @override
  String get fieldAddress => 'Adresse';

  @override
  String get fieldPhone => 'Telefon';

  @override
  String get fieldEmail => 'E-Mail';

  @override
  String get fieldInsurer => 'Krankenkasse';

  @override
  String get fieldInsuranceNumber => 'Versichertennummer';

  @override
  String get fieldStudentId => 'Matrikelnummer';

  @override
  String get fieldTime => 'Terminzeit';

  @override
  String get fieldDate => 'Termindatum';

  @override
  String get hintName => 'Wie in deinem Reisepass';

  @override
  String get hintAddress => 'Straße und Hausnummer, PLZ und Ort';

  @override
  String get hintPhone => 'Deine Handynummer';

  @override
  String get hintEmail => 'name@beispiel.de';

  @override
  String get hintInsurer => 'Zum Beispiel TK oder AOK';

  @override
  String get hintInsuranceNumber => 'Auf deiner Gesundheitskarte';

  @override
  String get hintStudentId => 'Auf deinem Studierendenausweis';

  @override
  String get footerName =>
      'Für Sätze wie „Mein Name ist …“ und zum Buchstabieren.';

  @override
  String get footerAddress =>
      'Schreib sie wie in Deutschland üblich: Holtenauer Straße 12, 24105 Kiel.';

  @override
  String get removeBirthDate => 'Geburtsdatum entfernen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get save => 'Sichern';

  @override
  String get done => 'Fertig';

  @override
  String get ok => 'OK';

  @override
  String get discardChanges => 'Änderungen verwerfen';

  @override
  String get keepEditing => 'Weiter bearbeiten';

  @override
  String listAnd(String first, String last) {
    return '$first und $last';
  }

  @override
  String get loadFailed =>
      'Deine gespeicherten Angaben konnten nicht gelesen werden. Eine Kopie wurde aufbewahrt, Sagbar startet leer.';

  @override
  String get saveFailed =>
      'Die letzte Änderung konnte nicht gesichert werden. Sagbar versucht es bei der nächsten Änderung erneut.';

  @override
  String get semLineHint => 'Zeigt den Satz in großer Schrift';

  @override
  String semMissing(String name) {
    return 'fehlt: $name';
  }
}
