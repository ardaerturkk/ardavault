// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Bayramlaşma';

  @override
  String get tabCalls => 'Calls';

  @override
  String get tabPeople => 'People';

  @override
  String get kindRamazan => 'Ramazan Bayramı';

  @override
  String get kindKurban => 'Kurban Bayramı';

  @override
  String get kindNewYear => 'New Year';

  @override
  String get kindMothersDay => 'Mother\'s Day';

  @override
  String get kindFathersDayTr => 'Father\'s Day in Turkey';

  @override
  String get kindVatertag => 'Father\'s Day in Germany';

  @override
  String get kindBirthday => 'Birthday';

  @override
  String birthdayOf(String name) {
    return '$name\'s Birthday';
  }

  @override
  String occasionYear(String occasion, String year) {
    return '$occasion $year';
  }

  @override
  String get kindMothersDayNote =>
      'Second Sunday of May, in Turkey and in Germany';

  @override
  String get kindFathersDayTrNote => 'Third Sunday of June';

  @override
  String get kindVatertagNote => 'Ascension Day';

  @override
  String get circleElders => 'Elders';

  @override
  String get circleFamily => 'Family';

  @override
  String get circleFriends => 'Friends';

  @override
  String hijriShawwal(int day, int year) {
    return '$day Shawwal $year';
  }

  @override
  String hijriDhuAlHijjah(int day, int year) {
    return '$day Dhu al-Hijjah $year';
  }

  @override
  String get startsTomorrow => 'Starts tomorrow';

  @override
  String get arefeToday => 'Arefe today, starts tomorrow';

  @override
  String dayOf(int day, int total) {
    return 'Day $day of $total';
  }

  @override
  String get today => 'Today';

  @override
  String get endedYesterday => 'Ended yesterday';

  @override
  String inDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return 'In $_temp0';
  }

  @override
  String reachedOf(int done, int total) {
    return '$done of $total reached';
  }

  @override
  String peopleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count people',
      one: '1 person',
    );
    return '$_temp0';
  }

  @override
  String leftCount(int count) {
    return '$count left';
  }

  @override
  String get sectionNow => 'Now';

  @override
  String get sectionUpcoming => 'Coming Up';

  @override
  String get sectionEarlier => 'Earlier';

  @override
  String datesFooter(String year) {
    return 'Bayram dates follow Diyanet\'s calendar and are included through $year.';
  }

  @override
  String get noUpcoming => 'Nothing else in the next twelve months.';

  @override
  String get emptyCallsTitle => 'Who Do You Call First?';

  @override
  String emptyCallsBody(String occasion, String date) {
    return 'Add the people you call on Bayram, elders first. Next up: $occasion, $date.';
  }

  @override
  String get addPerson => 'Add Person';

  @override
  String get sectionReached => 'Reached';

  @override
  String get allReached => 'Everyone is reached.';

  @override
  String opensOn(String date) {
    return 'You can tick people off from $date.';
  }

  @override
  String get nobodyInRound => 'Nobody is in this round any more.';

  @override
  String timeIn(String time, String city) {
    return '$time in $city';
  }

  @override
  String get nightThere => 'Night there';

  @override
  String get pickCalled => 'Called';

  @override
  String get pickMessaged => 'Messaged';

  @override
  String get pickVisited => 'Visited';

  @override
  String statusCalled(String when) {
    return 'Called $when';
  }

  @override
  String statusMessaged(String when) {
    return 'Messaged $when';
  }

  @override
  String statusVisited(String when) {
    return 'Visited $when';
  }

  @override
  String get markNotReached => 'Mark as Not Reached';

  @override
  String get addNote => 'Add Note';

  @override
  String get editNote => 'Edit Note';

  @override
  String get noteHint => 'Asked about exams';

  @override
  String get showNumber => 'Show Number';

  @override
  String get copyNumber => 'Copy Number';

  @override
  String get copied => 'Copied';

  @override
  String get numberHelp => 'Call from the Phone app or your messenger.';

  @override
  String markCalledFor(String name) {
    return 'Mark $name as called';
  }

  @override
  String unmarkFor(String name) {
    return 'Mark $name as not reached';
  }

  @override
  String get reorder => 'Order';

  @override
  String get reorderTitle => 'Order';

  @override
  String get reorderFooter =>
      'Drag to choose who comes first. Every round follows this order.';

  @override
  String dragToReorder(String name) {
    return 'Drag to reorder $name';
  }

  @override
  String get eldersFooter => 'Elders come first in every round.';

  @override
  String get emptyPeopleTitle => 'No People Yet';

  @override
  String get emptyPeopleBody =>
      'Start with the elders you call first on Bayram morning.';

  @override
  String get newPerson => 'New Person';

  @override
  String get editPerson => 'Edit Person';

  @override
  String get edit => 'Edit';

  @override
  String get name => 'Name';

  @override
  String get nameHint => 'Name, like Hasan Amca';

  @override
  String get relation => 'Relation';

  @override
  String get relationHint => 'Relation, like uncle (optional)';

  @override
  String get phone => 'Phone';

  @override
  String get phoneHint => 'Phone number (optional)';

  @override
  String get circle => 'Circle';

  @override
  String get city => 'City';

  @override
  String get birthday => 'Birthday';

  @override
  String get noneSet => 'None';

  @override
  String get removeBirthday => 'Remove Birthday';

  @override
  String get callOn => 'Call On';

  @override
  String get callOnFooter => 'Their birthday is added when you set one.';

  @override
  String get deletePerson => 'Delete Person';

  @override
  String deletePersonMessage(String name) {
    return 'Delete $name? Their ticks in past rounds are deleted too.';
  }

  @override
  String get delete => 'Delete';

  @override
  String get searchCities => 'Search';

  @override
  String get regionTurkey => 'Turkey';

  @override
  String get regionGermany => 'Germany';

  @override
  String get regionElsewhere => 'Elsewhere';

  @override
  String get anyTown => 'Any other town';

  @override
  String get cityFooter =>
      'Turkey and Germany each have one time zone, so the country is enough.';

  @override
  String get noCityFound =>
      'No city found. Pick the country or a city nearby with the same time.';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get done => 'Done';

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
      'Your saved list could not be read, so a new one was started. The old file is still on this iPhone.';

  @override
  String dateRange(String from, String to) {
    return '$from to $to';
  }

  @override
  String arefeOn(String date) {
    return 'Arefe $date';
  }

  @override
  String turnsAge(int age) {
    return 'Turns $age';
  }
}
