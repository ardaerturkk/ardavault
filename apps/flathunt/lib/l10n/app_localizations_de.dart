// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Flatboard';

  @override
  String get tabFlats => 'Wohnungen';

  @override
  String get tabCompare => 'Vergleich';

  @override
  String get stageInterested => 'Interessant';

  @override
  String get stageMessaged => 'Angeschrieben';

  @override
  String get stageViewing => 'Besichtigung';

  @override
  String get stageApplied => 'Beworben';

  @override
  String get stageAccepted => 'Zusage';

  @override
  String get stageDeclined => 'Absage';

  @override
  String get actionMessaged => 'Als angeschrieben markieren';

  @override
  String get actionViewing => 'Besichtigung eintragen';

  @override
  String get actionApplied => 'Als beworben markieren';

  @override
  String get actionAnswer => 'Antwort eintragen';

  @override
  String get answerQuestion => 'Hast du die Wohnung bekommen?';

  @override
  String get answerAccepted => 'Zusage';

  @override
  String get answerDeclined => 'Absage';

  @override
  String get sourceWgGesucht => 'WG-Gesucht';

  @override
  String get sourceKleinanzeigen => 'Kleinanzeigen';

  @override
  String get sourceImmoscout => 'ImmoScout24';

  @override
  String get sourceFacebook => 'Facebook-Gruppe';

  @override
  String get sourceStudentenwerk => 'Studentenwerk';

  @override
  String get sourceFriends => 'Freunde';

  @override
  String get sourceOther => 'Andere';

  @override
  String get emptyFlatsTitle => 'Noch keine Wohnungen';

  @override
  String get emptyFlatsBody =>
      'Trag jede Wohnung ein, die dir gefällt, egal von welcher Seite oder Gruppe. Dann schiebst du sie weiter, wenn du schreibst, besichtigst und dich bewirbst.';

  @override
  String get addFlat => 'Wohnung hinzufügen';

  @override
  String warmShort(String amount) {
    return '$amount warm';
  }

  @override
  String sizeShort(String size) {
    return '$size m²';
  }

  @override
  String viewingOn(String date) {
    return 'Besichtigung $date';
  }

  @override
  String viewedOn(String date) {
    return 'Besichtigt $date';
  }

  @override
  String get noViewingTime => 'Noch kein Termin';

  @override
  String addedOn(String date) {
    return 'Hinzugefügt $date';
  }

  @override
  String messagedOn(String date) {
    return 'Angeschrieben $date';
  }

  @override
  String appliedOn(String date) {
    return 'Beworben $date';
  }

  @override
  String acceptedOn(String date) {
    return 'Zusage $date';
  }

  @override
  String declinedOn(String date) {
    return 'Absage $date';
  }

  @override
  String get stage => 'Status';

  @override
  String get viewing => 'Besichtigung';

  @override
  String get notSet => 'Nicht festgelegt';

  @override
  String get rent => 'Miete';

  @override
  String get warmRent => 'Warmmiete';

  @override
  String get coldRent => 'Kaltmiete';

  @override
  String get size => 'Größe';

  @override
  String get perSqm => 'Warm pro m²';

  @override
  String get rentFooter => 'Die Warmmiete enthält Heizung und Nebenkosten.';

  @override
  String get listing => 'Anzeige';

  @override
  String get source => 'Quelle';

  @override
  String get link => 'Link';

  @override
  String get copyLink => 'Link kopieren';

  @override
  String get linkCopied => 'Link kopiert.';

  @override
  String get district => 'Stadtteil';

  @override
  String get notes => 'Notizen';

  @override
  String get checksHeader => 'Sicherheitscheck';

  @override
  String get checkViewed => 'Du hast die Wohnung persönlich gesehen';

  @override
  String get checkNoPrepay =>
      'Keine Kaution und keine Miete vor Besichtigung und unterschriebenem Vertrag';

  @override
  String get checkAccountInName =>
      'Zahlung nur per Überweisung an den Vermieter, nicht ins Ausland und nicht über Bargeld-Transferdienste';

  @override
  String get checkIdLater =>
      'Ausweiskopie erst, wenn der Vertrag unterschriftsreif ist';

  @override
  String get checkPlausible =>
      'Die Miete passt zu Lage und Größe und liegt nicht weit unter ähnlichen Wohnungen';

  @override
  String get checksFooter =>
      'Hake jeden Punkt ab, sobald du ihn geprüft hast. Stimmt einer nicht, halte inne und frag beim Studentenwerk oder beim Mieterverein vor Ort nach, bevor du zahlst oder Unterlagen schickst.';

  @override
  String get semCheckHint => 'Markiert diesen Punkt als geprüft';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get newFlat => 'Neue Wohnung';

  @override
  String get editFlat => 'Wohnung bearbeiten';

  @override
  String get title => 'Titel';

  @override
  String get titleHint => 'Zum Beispiel: Zimmer nahe Campus';

  @override
  String get linkHint => 'Link zur Anzeige einfügen';

  @override
  String get optional => 'Optional';

  @override
  String get districtHint => 'Zum Beispiel: Gaarden';

  @override
  String get notesHint => 'Kontakt, Fragen, was mitbringen';

  @override
  String get deleteFlat => 'Wohnung löschen';

  @override
  String get deleteFlatConfirm =>
      'Diese Wohnung wird von deiner Liste entfernt.';

  @override
  String get invalidAmount =>
      'Beträge wie 480 oder 480,50 und eine Größe wie 18 oder 18,5 eingeben.';

  @override
  String get save => 'Sichern';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get done => 'Fertig';

  @override
  String get ok => 'OK';

  @override
  String get discardChanges => 'Änderungen verwerfen';

  @override
  String get keepEditing => 'Weiter bearbeiten';

  @override
  String get viewingTime => 'Besichtigungstermin';

  @override
  String get setTimeLater => 'Termin später eintragen';

  @override
  String get removeViewing => 'Termin entfernen';

  @override
  String get perMonthSeg => 'Pro Monat';

  @override
  String get perSqmSeg => 'Pro m²';

  @override
  String get compareEmptyTitle => 'Noch nichts zu vergleichen';

  @override
  String get compareEmptyBody =>
      'Trag bei deinen Wohnungen die Warmmiete ein, dann siehst du sie nebeneinander, die günstigste zuerst.';

  @override
  String get compareFooter =>
      'Die günstigste zuerst. Absagen sind nicht dabei.';

  @override
  String get notCompared => 'Nicht verglichen';

  @override
  String get missingWarm => 'Warmmiete fehlt';

  @override
  String get missingSize => 'Größe fehlt';

  @override
  String get missingBoth => 'Warmmiete und Größe fehlen';

  @override
  String get cheapest => 'Am günstigsten';

  @override
  String moreThanCheapest(String amount) {
    return '$amount mehr';
  }

  @override
  String get chooseStage =>
      'Diese Wohnung in einen anderen Status verschieben.';

  @override
  String get loadFailed =>
      'Deine gespeicherten Wohnungen konnten nicht gelesen werden, deshalb wurde eine neue Liste begonnen. Die alte Datei ist noch auf diesem iPhone.';

  @override
  String get saveFailed =>
      'Deine letzte Änderung konnte nicht gesichert werden. Gib etwas Speicher frei und versuch es noch einmal.';

  @override
  String get addRent => 'Miete und Größe eintragen';

  @override
  String get sizeSqmLabel => 'Größe in m²';
}
