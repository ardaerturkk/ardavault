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
  /// **'Sagbar'**
  String get appTitle;

  /// No description provided for @tabSituations.
  ///
  /// In en, this message translates to:
  /// **'Situations'**
  String get tabSituations;

  /// No description provided for @tabMe.
  ///
  /// In en, this message translates to:
  /// **'My Details'**
  String get tabMe;

  /// No description provided for @startTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Your Details Once'**
  String get startTitle;

  /// No description provided for @startBody.
  ///
  /// In en, this message translates to:
  /// **'Your name, address and numbers go straight into every German line.'**
  String get startBody;

  /// No description provided for @startButton.
  ///
  /// In en, this message translates to:
  /// **'Add My Details'**
  String get startButton;

  /// No description provided for @situationsFooter.
  ///
  /// In en, this message translates to:
  /// **'Everyday phrases for the counter and the phone. They are not legal advice.'**
  String get situationsFooter;

  /// No description provided for @appointmentOn.
  ///
  /// In en, this message translates to:
  /// **'Appointment {date}'**
  String appointmentOn(String date);

  /// No description provided for @fillMissing.
  ///
  /// In en, this message translates to:
  /// **'Fill In Missing Details'**
  String get fillMissing;

  /// No description provided for @missingList.
  ///
  /// In en, this message translates to:
  /// **'Missing: {names}'**
  String missingList(String names);

  /// No description provided for @visitHeader.
  ///
  /// In en, this message translates to:
  /// **'This Visit'**
  String get visitHeader;

  /// No description provided for @appointment.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get appointment;

  /// No description provided for @removeAppointment.
  ///
  /// In en, this message translates to:
  /// **'Remove Appointment'**
  String get removeAppointment;

  /// No description provided for @refFooter.
  ///
  /// In en, this message translates to:
  /// **'The number from your letter or booking confirmation.'**
  String get refFooter;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not Set'**
  String get notSet;

  /// No description provided for @linesHeader.
  ///
  /// In en, this message translates to:
  /// **'Lines'**
  String get linesHeader;

  /// No description provided for @linesFooter.
  ///
  /// In en, this message translates to:
  /// **'Tap a line to show it in large type. Touch and hold to copy or hide it.'**
  String get linesFooter;

  /// No description provided for @noLines.
  ///
  /// In en, this message translates to:
  /// **'No lines here. Add your own or show the hidden ones.'**
  String get noLines;

  /// No description provided for @addLine.
  ///
  /// In en, this message translates to:
  /// **'Add Your Own Line'**
  String get addLine;

  /// No description provided for @showHidden.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Show 1 Hidden Line} other{Show {count} Hidden Lines}}'**
  String showHidden(int count);

  /// No description provided for @showCards.
  ///
  /// In en, this message translates to:
  /// **'Show Cards'**
  String get showCards;

  /// No description provided for @yourLine.
  ///
  /// In en, this message translates to:
  /// **'Your line'**
  String get yourLine;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @hideLine.
  ///
  /// In en, this message translates to:
  /// **'Hide Line'**
  String get hideLine;

  /// No description provided for @editLine.
  ///
  /// In en, this message translates to:
  /// **'Edit Line'**
  String get editLine;

  /// No description provided for @deleteLine.
  ///
  /// In en, this message translates to:
  /// **'Delete Line'**
  String get deleteLine;

  /// No description provided for @deleteLineConfirm.
  ///
  /// In en, this message translates to:
  /// **'This line will be deleted.'**
  String get deleteLineConfirm;

  /// No description provided for @newLine.
  ///
  /// In en, this message translates to:
  /// **'New Line'**
  String get newLine;

  /// No description provided for @germanLabel.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get germanLabel;

  /// No description provided for @germanHint.
  ///
  /// In en, this message translates to:
  /// **'What you want to say, in German'**
  String get germanHint;

  /// No description provided for @meaningLabel.
  ///
  /// In en, this message translates to:
  /// **'Meaning'**
  String get meaningLabel;

  /// No description provided for @meaningHint.
  ///
  /// In en, this message translates to:
  /// **'What it means (optional)'**
  String get meaningHint;

  /// No description provided for @lineEditorFooter.
  ///
  /// In en, this message translates to:
  /// **'Write it the way you want to say it. Your details are not filled into your own lines.'**
  String get lineEditorFooter;

  /// No description provided for @cardOf.
  ///
  /// In en, this message translates to:
  /// **'{index} of {total}'**
  String cardOf(int index, int total);

  /// No description provided for @previousLine.
  ///
  /// In en, this message translates to:
  /// **'Previous Line'**
  String get previousLine;

  /// No description provided for @nextLine.
  ///
  /// In en, this message translates to:
  /// **'Next Line'**
  String get nextLine;

  /// No description provided for @aboutYou.
  ///
  /// In en, this message translates to:
  /// **'About You'**
  String get aboutYou;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @numbers.
  ///
  /// In en, this message translates to:
  /// **'Numbers'**
  String get numbers;

  /// No description provided for @meFooter.
  ///
  /// In en, this message translates to:
  /// **'Stored only on this iPhone. Sagbar fills these into your German lines.'**
  String get meFooter;

  /// No description provided for @fieldName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fieldName;

  /// No description provided for @fieldBirthDate.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get fieldBirthDate;

  /// No description provided for @fieldAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get fieldAddress;

  /// No description provided for @fieldPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get fieldPhone;

  /// No description provided for @fieldEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get fieldEmail;

  /// No description provided for @fieldInsurer.
  ///
  /// In en, this message translates to:
  /// **'Health Insurer'**
  String get fieldInsurer;

  /// No description provided for @fieldInsuranceNumber.
  ///
  /// In en, this message translates to:
  /// **'Insurance Number'**
  String get fieldInsuranceNumber;

  /// No description provided for @fieldStudentId.
  ///
  /// In en, this message translates to:
  /// **'Student Number'**
  String get fieldStudentId;

  /// No description provided for @fieldTime.
  ///
  /// In en, this message translates to:
  /// **'Appointment Time'**
  String get fieldTime;

  /// No description provided for @fieldDate.
  ///
  /// In en, this message translates to:
  /// **'Appointment Date'**
  String get fieldDate;

  /// No description provided for @hintName.
  ///
  /// In en, this message translates to:
  /// **'As in your passport'**
  String get hintName;

  /// No description provided for @hintAddress.
  ///
  /// In en, this message translates to:
  /// **'Street and number, postcode and city'**
  String get hintAddress;

  /// No description provided for @hintPhone.
  ///
  /// In en, this message translates to:
  /// **'Your mobile number'**
  String get hintPhone;

  /// No description provided for @hintEmail.
  ///
  /// In en, this message translates to:
  /// **'name@example.com'**
  String get hintEmail;

  /// No description provided for @hintInsurer.
  ///
  /// In en, this message translates to:
  /// **'For example TK or AOK'**
  String get hintInsurer;

  /// No description provided for @hintInsuranceNumber.
  ///
  /// In en, this message translates to:
  /// **'On your health insurance card'**
  String get hintInsuranceNumber;

  /// No description provided for @hintStudentId.
  ///
  /// In en, this message translates to:
  /// **'On your student ID card'**
  String get hintStudentId;

  /// No description provided for @footerName.
  ///
  /// In en, this message translates to:
  /// **'Used in lines like “Mein Name ist …” and spelled out letter by letter.'**
  String get footerName;

  /// No description provided for @footerAddress.
  ///
  /// In en, this message translates to:
  /// **'Write it the German way: Holtenauer Straße 12, 24105 Kiel.'**
  String get footerAddress;

  /// No description provided for @removeBirthDate.
  ///
  /// In en, this message translates to:
  /// **'Remove Date of Birth'**
  String get removeBirthDate;

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

  /// No description provided for @listAnd.
  ///
  /// In en, this message translates to:
  /// **'{first} and {last}'**
  String listAnd(String first, String last);

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Your saved details could not be read. A copy was kept, and Sagbar started empty.'**
  String get loadFailed;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'The last change could not be saved. Sagbar will try again with the next change.'**
  String get saveFailed;

  /// No description provided for @semLineHint.
  ///
  /// In en, this message translates to:
  /// **'Shows the line in large type'**
  String get semLineHint;

  /// No description provided for @semMissing.
  ///
  /// In en, this message translates to:
  /// **'missing: {name}'**
  String semMissing(String name);
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
