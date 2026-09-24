// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Bayramlaşma';

  @override
  String get tabCalls => 'Anrufe';

  @override
  String get tabPeople => 'Personen';

  @override
  String get kindRamazan => 'Ramazan Bayramı';

  @override
  String get kindKurban => 'Kurban Bayramı';

  @override
  String get kindNewYear => 'Neujahr';

  @override
  String get kindMothersDay => 'Muttertag';

  @override
  String get kindFathersDayTr => 'Vatertag in der Türkei';

  @override
  String get kindVatertag => 'Vatertag';

  @override
  String get kindBirthday => 'Geburtstag';

  @override
  String birthdayOf(String name) {
    return 'Geburtstag von $name';
  }

  @override
  String occasionYear(String occasion, String year) {
    return '$occasion $year';
  }

  @override
  String get kindMothersDayNote =>
      'Zweiter Sonntag im Mai, in der Türkei und in Deutschland';

  @override
  String get kindFathersDayTrNote => 'Dritter Sonntag im Juni';

  @override
  String get kindVatertagNote => 'Christi Himmelfahrt';

  @override
  String get circleElders => 'Ältere';

  @override
  String get circleFamily => 'Familie';

  @override
  String get circleFriends => 'Freunde';

  @override
  String hijriShawwal(int day, int year) {
    return '$day. Schawwal $year';
  }

  @override
  String hijriDhuAlHijjah(int day, int year) {
    return '$day. Dhu l-Hiddscha $year';
  }

  @override
  String get startsTomorrow => 'Beginnt morgen';

  @override
  String get arefeToday => 'Heute Arefe, morgen geht es los';

  @override
  String dayOf(int day, int total) {
    return 'Tag $day von $total';
  }

  @override
  String get today => 'Heute';

  @override
  String get endedYesterday => 'Gestern zu Ende gegangen';

  @override
  String inDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tagen',
      one: '1 Tag',
    );
    return 'In $_temp0';
  }

  @override
  String reachedOf(int done, int total) {
    return '$done von $total erreicht';
  }

  @override
  String peopleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Personen',
      one: '1 Person',
    );
    return '$_temp0';
  }

  @override
  String leftCount(int count) {
    return 'Noch $count';
  }

  @override
  String get sectionNow => 'Jetzt';

  @override
  String get sectionUpcoming => 'Demnächst';

  @override
  String get sectionEarlier => 'Frühere Runden';

  @override
  String datesFooter(String year) {
    return 'Die Bayram-Daten folgen dem Kalender der Diyanet und sind bis $year enthalten.';
  }

  @override
  String get noUpcoming =>
      'In den nächsten zwölf Monaten steht nichts weiter an.';

  @override
  String get emptyCallsTitle => 'Wen rufst du zuerst an?';

  @override
  String emptyCallsBody(String occasion, String date) {
    return 'Füge die Menschen hinzu, die du zum Bayram anrufst, die Älteren zuerst. Als Nächstes: $occasion, $date.';
  }

  @override
  String get addPerson => 'Person hinzufügen';

  @override
  String get sectionReached => 'Erreicht';

  @override
  String get allReached => 'Alle sind erreicht.';

  @override
  String opensOn(String date) {
    return 'Ab $date kannst du abhaken.';
  }

  @override
  String get nobodyInRound => 'In dieser Runde ist niemand mehr.';

  @override
  String timeIn(String time, String city) {
    return '$time in $city';
  }

  @override
  String get nightThere => 'Dort ist Nacht';

  @override
  String get pickCalled => 'Angerufen';

  @override
  String get pickMessaged => 'Geschrieben';

  @override
  String get pickVisited => 'Besucht';

  @override
  String statusCalled(String when) {
    return 'Angerufen $when';
  }

  @override
  String statusMessaged(String when) {
    return 'Geschrieben $when';
  }

  @override
  String statusVisited(String when) {
    return 'Besucht $when';
  }

  @override
  String get markNotReached => 'Als nicht erreicht markieren';

  @override
  String get addNote => 'Notiz hinzufügen';

  @override
  String get editNote => 'Notiz bearbeiten';

  @override
  String get noteHint => 'Nach den Prüfungen gefragt';

  @override
  String get showNumber => 'Nummer zeigen';

  @override
  String get copyNumber => 'Nummer kopieren';

  @override
  String get copied => 'Kopiert';

  @override
  String get numberHelp => 'Ruf über die Telefon-App oder deinen Messenger an.';

  @override
  String markCalledFor(String name) {
    return '$name als angerufen markieren';
  }

  @override
  String unmarkFor(String name) {
    return '$name als nicht erreicht markieren';
  }

  @override
  String get reorder => 'Reihenfolge';

  @override
  String get reorderTitle => 'Reihenfolge';

  @override
  String get reorderFooter =>
      'Ziehen, um festzulegen, wer zuerst kommt. Jede Runde folgt dieser Reihenfolge.';

  @override
  String dragToReorder(String name) {
    return '$name verschieben';
  }

  @override
  String get eldersFooter => 'Die Älteren stehen in jeder Runde oben.';

  @override
  String get emptyPeopleTitle => 'Noch niemand';

  @override
  String get emptyPeopleBody =>
      'Beginne mit den Älteren, die du am Bayram-Morgen zuerst anrufst.';

  @override
  String get newPerson => 'Neue Person';

  @override
  String get editPerson => 'Person bearbeiten';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get name => 'Name';

  @override
  String get nameHint => 'Name, etwa Hasan Amca';

  @override
  String get relation => 'Beziehung';

  @override
  String get relationHint => 'Beziehung, etwa Onkel (optional)';

  @override
  String get phone => 'Telefon';

  @override
  String get phoneHint => 'Telefonnummer (optional)';

  @override
  String get circle => 'Gruppe';

  @override
  String get city => 'Ort';

  @override
  String get birthday => 'Geburtstag';

  @override
  String get noneSet => 'Keiner';

  @override
  String get removeBirthday => 'Geburtstag entfernen';

  @override
  String get callOn => 'Anrufen an';

  @override
  String get callOnFooter =>
      'Der Geburtstag kommt dazu, sobald du ihn einträgst.';

  @override
  String get deletePerson => 'Person löschen';

  @override
  String deletePersonMessage(String name) {
    return '$name löschen? Die Häkchen in früheren Runden werden auch gelöscht.';
  }

  @override
  String get delete => 'Löschen';

  @override
  String get searchCities => 'Suchen';

  @override
  String get regionTurkey => 'Türkei';

  @override
  String get regionGermany => 'Deutschland';

  @override
  String get regionElsewhere => 'Andere Orte';

  @override
  String get anyTown => 'Jeder andere Ort';

  @override
  String get cityFooter =>
      'Die Türkei und Deutschland haben je eine Zeitzone, das Land genügt also.';

  @override
  String get noCityFound =>
      'Kein Ort gefunden. Wähle das Land oder einen Ort in der Nähe mit derselben Uhrzeit.';

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
  String get saveFailed =>
      'Deine letzte Änderung konnte nicht gesichert werden. Gib etwas Speicher frei und versuche es erneut.';

  @override
  String get loadFailed =>
      'Deine gesicherte Liste konnte nicht gelesen werden, deshalb wurde eine neue begonnen. Die alte Datei ist noch auf diesem iPhone.';

  @override
  String dateRange(String from, String to) {
    return '$from bis $to';
  }

  @override
  String arefeOn(String date) {
    return 'Arefe $date';
  }

  @override
  String turnsAge(int age) {
    return 'Wird $age';
  }
}
