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
  /// **'Bayramlaşma'**
  String get appTitle;

  /// No description provided for @tabCalls.
  ///
  /// In en, this message translates to:
  /// **'Calls'**
  String get tabCalls;

  /// No description provided for @tabPeople.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get tabPeople;

  /// No description provided for @kindRamazan.
  ///
  /// In en, this message translates to:
  /// **'Ramazan Bayramı'**
  String get kindRamazan;

  /// No description provided for @kindKurban.
  ///
  /// In en, this message translates to:
  /// **'Kurban Bayramı'**
  String get kindKurban;

  /// No description provided for @kindNewYear.
  ///
  /// In en, this message translates to:
  /// **'New Year'**
  String get kindNewYear;

  /// No description provided for @kindMothersDay.
  ///
  /// In en, this message translates to:
  /// **'Mother\'s Day'**
  String get kindMothersDay;

  /// No description provided for @kindFathersDayTr.
  ///
  /// In en, this message translates to:
  /// **'Father\'s Day in Turkey'**
  String get kindFathersDayTr;

  /// No description provided for @kindVatertag.
  ///
  /// In en, this message translates to:
  /// **'Father\'s Day in Germany'**
  String get kindVatertag;

  /// No description provided for @kindBirthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get kindBirthday;

  /// No description provided for @birthdayOf.
  ///
  /// In en, this message translates to:
  /// **'{name}\'s Birthday'**
  String birthdayOf(String name);

  /// No description provided for @occasionYear.
  ///
  /// In en, this message translates to:
  /// **'{occasion} {year}'**
  String occasionYear(String occasion, String year);

  /// No description provided for @kindMothersDayNote.
  ///
  /// In en, this message translates to:
  /// **'Second Sunday of May, in Turkey and in Germany'**
  String get kindMothersDayNote;

  /// No description provided for @kindFathersDayTrNote.
  ///
  /// In en, this message translates to:
  /// **'Third Sunday of June'**
  String get kindFathersDayTrNote;

  /// No description provided for @kindVatertagNote.
  ///
  /// In en, this message translates to:
  /// **'Ascension Day'**
  String get kindVatertagNote;

  /// No description provided for @circleElders.
  ///
  /// In en, this message translates to:
  /// **'Elders'**
  String get circleElders;

  /// No description provided for @circleFamily.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get circleFamily;

  /// No description provided for @circleFriends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get circleFriends;

  /// No description provided for @hijriShawwal.
  ///
  /// In en, this message translates to:
  /// **'{day} Shawwal {year}'**
  String hijriShawwal(int day, int year);

  /// No description provided for @hijriDhuAlHijjah.
  ///
  /// In en, this message translates to:
  /// **'{day} Dhu al-Hijjah {year}'**
  String hijriDhuAlHijjah(int day, int year);

  /// No description provided for @startsTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Starts tomorrow'**
  String get startsTomorrow;

  /// No description provided for @arefeToday.
  ///
  /// In en, this message translates to:
  /// **'Arefe today, starts tomorrow'**
  String get arefeToday;

  /// No description provided for @dayOf.
  ///
  /// In en, this message translates to:
  /// **'Day {day} of {total}'**
  String dayOf(int day, int total);

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @endedYesterday.
  ///
  /// In en, this message translates to:
  /// **'Ended yesterday'**
  String get endedYesterday;

  /// No description provided for @inDays.
  ///
  /// In en, this message translates to:
  /// **'In {count, plural, =1{1 day} other{{count} days}}'**
  String inDays(int count);

  /// No description provided for @reachedOf.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} reached'**
  String reachedOf(int done, int total);

  /// No description provided for @peopleCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 person} other{{count} people}}'**
  String peopleCount(int count);

  /// No description provided for @leftCount.
  ///
  /// In en, this message translates to:
  /// **'{count} left'**
  String leftCount(int count);

  /// No description provided for @sectionNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get sectionNow;

  /// No description provided for @sectionUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Coming Up'**
  String get sectionUpcoming;

  /// No description provided for @sectionEarlier.
  ///
  /// In en, this message translates to:
  /// **'Earlier'**
  String get sectionEarlier;

  /// No description provided for @datesFooter.
  ///
  /// In en, this message translates to:
  /// **'Bayram dates follow Diyanet\'s calendar and are included through {year}.'**
  String datesFooter(String year);

  /// No description provided for @noUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Nothing else in the next twelve months.'**
  String get noUpcoming;

  /// No description provided for @emptyCallsTitle.
  ///
  /// In en, this message translates to:
  /// **'Who Do You Call First?'**
  String get emptyCallsTitle;

  /// No description provided for @emptyCallsBody.
  ///
  /// In en, this message translates to:
  /// **'Add the people you call on Bayram, elders first. Next up: {occasion}, {date}.'**
  String emptyCallsBody(String occasion, String date);

  /// No description provided for @addPerson.
  ///
  /// In en, this message translates to:
  /// **'Add Person'**
  String get addPerson;

  /// No description provided for @sectionReached.
  ///
  /// In en, this message translates to:
  /// **'Reached'**
  String get sectionReached;

  /// No description provided for @allReached.
  ///
  /// In en, this message translates to:
  /// **'Everyone is reached.'**
  String get allReached;

  /// No description provided for @opensOn.
  ///
  /// In en, this message translates to:
  /// **'You can tick people off from {date}.'**
  String opensOn(String date);

  /// No description provided for @nobodyInRound.
  ///
  /// In en, this message translates to:
  /// **'Nobody is in this round any more.'**
  String get nobodyInRound;

  /// No description provided for @timeIn.
  ///
  /// In en, this message translates to:
  /// **'{time} in {city}'**
  String timeIn(String time, String city);

  /// No description provided for @nightThere.
  ///
  /// In en, this message translates to:
  /// **'Night there'**
  String get nightThere;

  /// No description provided for @pickCalled.
  ///
  /// In en, this message translates to:
  /// **'Called'**
  String get pickCalled;

  /// No description provided for @pickMessaged.
  ///
  /// In en, this message translates to:
  /// **'Messaged'**
  String get pickMessaged;

  /// No description provided for @pickVisited.
  ///
  /// In en, this message translates to:
  /// **'Visited'**
  String get pickVisited;

  /// No description provided for @statusCalled.
  ///
  /// In en, this message translates to:
  /// **'Called {when}'**
  String statusCalled(String when);

  /// No description provided for @statusMessaged.
  ///
  /// In en, this message translates to:
  /// **'Messaged {when}'**
  String statusMessaged(String when);

  /// No description provided for @statusVisited.
  ///
  /// In en, this message translates to:
  /// **'Visited {when}'**
  String statusVisited(String when);

  /// No description provided for @markNotReached.
  ///
  /// In en, this message translates to:
  /// **'Mark as Not Reached'**
  String get markNotReached;

  /// No description provided for @addNote.
  ///
  /// In en, this message translates to:
  /// **'Add Note'**
  String get addNote;

  /// No description provided for @editNote.
  ///
  /// In en, this message translates to:
  /// **'Edit Note'**
  String get editNote;

  /// No description provided for @noteHint.
  ///
  /// In en, this message translates to:
  /// **'Asked about exams'**
  String get noteHint;

  /// No description provided for @showNumber.
  ///
  /// In en, this message translates to:
  /// **'Show Number'**
  String get showNumber;

  /// No description provided for @copyNumber.
  ///
  /// In en, this message translates to:
  /// **'Copy Number'**
  String get copyNumber;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @numberHelp.
  ///
  /// In en, this message translates to:
  /// **'Call from the Phone app or your messenger.'**
  String get numberHelp;

  /// No description provided for @markCalledFor.
  ///
  /// In en, this message translates to:
  /// **'Mark {name} as called'**
  String markCalledFor(String name);

  /// No description provided for @unmarkFor.
  ///
  /// In en, this message translates to:
  /// **'Mark {name} as not reached'**
  String unmarkFor(String name);

  /// No description provided for @reorder.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get reorder;

  /// No description provided for @reorderTitle.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get reorderTitle;

  /// No description provided for @reorderFooter.
  ///
  /// In en, this message translates to:
  /// **'Drag to choose who comes first. Every round follows this order.'**
  String get reorderFooter;

  /// No description provided for @dragToReorder.
  ///
  /// In en, this message translates to:
  /// **'Drag to reorder {name}'**
  String dragToReorder(String name);

  /// No description provided for @eldersFooter.
  ///
  /// In en, this message translates to:
  /// **'Elders come first in every round.'**
  String get eldersFooter;

  /// No description provided for @emptyPeopleTitle.
  ///
  /// In en, this message translates to:
  /// **'No People Yet'**
  String get emptyPeopleTitle;

  /// No description provided for @emptyPeopleBody.
  ///
  /// In en, this message translates to:
  /// **'Start with the elders you call first on Bayram morning.'**
  String get emptyPeopleBody;

  /// No description provided for @newPerson.
  ///
  /// In en, this message translates to:
  /// **'New Person'**
  String get newPerson;

  /// No description provided for @editPerson.
  ///
  /// In en, this message translates to:
  /// **'Edit Person'**
  String get editPerson;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Name, like Hasan Amca'**
  String get nameHint;

  /// No description provided for @relation.
  ///
  /// In en, this message translates to:
  /// **'Relation'**
  String get relation;

  /// No description provided for @relationHint.
  ///
  /// In en, this message translates to:
  /// **'Relation, like uncle (optional)'**
  String get relationHint;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @phoneHint.
  ///
  /// In en, this message translates to:
  /// **'Phone number (optional)'**
  String get phoneHint;

  /// No description provided for @circle.
  ///
  /// In en, this message translates to:
  /// **'Circle'**
  String get circle;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get birthday;

  /// No description provided for @noneSet.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get noneSet;

  /// No description provided for @removeBirthday.
  ///
  /// In en, this message translates to:
  /// **'Remove Birthday'**
  String get removeBirthday;

  /// No description provided for @callOn.
  ///
  /// In en, this message translates to:
  /// **'Call On'**
  String get callOn;

  /// No description provided for @callOnFooter.
  ///
  /// In en, this message translates to:
  /// **'Their birthday is added when you set one.'**
  String get callOnFooter;

  /// No description provided for @deletePerson.
  ///
  /// In en, this message translates to:
  /// **'Delete Person'**
  String get deletePerson;

  /// No description provided for @deletePersonMessage.
  ///
  /// In en, this message translates to:
  /// **'Delete {name}? Their ticks in past rounds are deleted too.'**
  String deletePersonMessage(String name);

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @searchCities.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchCities;

  /// No description provided for @regionTurkey.
  ///
  /// In en, this message translates to:
  /// **'Turkey'**
  String get regionTurkey;

  /// No description provided for @regionGermany.
  ///
  /// In en, this message translates to:
  /// **'Germany'**
  String get regionGermany;

  /// No description provided for @regionElsewhere.
  ///
  /// In en, this message translates to:
  /// **'Elsewhere'**
  String get regionElsewhere;

  /// No description provided for @anyTown.
  ///
  /// In en, this message translates to:
  /// **'Any other town'**
  String get anyTown;

  /// No description provided for @cityFooter.
  ///
  /// In en, this message translates to:
  /// **'Turkey and Germany each have one time zone, so the country is enough.'**
  String get cityFooter;

  /// No description provided for @noCityFound.
  ///
  /// In en, this message translates to:
  /// **'No city found. Pick the country or a city nearby with the same time.'**
  String get noCityFound;

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

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

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
  /// **'Your saved list could not be read, so a new one was started. The old file is still on this iPhone.'**
  String get loadFailed;

  /// No description provided for @dateRange.
  ///
  /// In en, this message translates to:
  /// **'{from} to {to}'**
  String dateRange(String from, String to);

  /// No description provided for @arefeOn.
  ///
  /// In en, this message translates to:
  /// **'Arefe {date}'**
  String arefeOn(String date);

  /// No description provided for @turnsAge.
  ///
  /// In en, this message translates to:
  /// **'Turns {age}'**
  String turnsAge(int age);
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
