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
  /// **'Paperpath'**
  String get appTitle;

  /// No description provided for @tabSteps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get tabSteps;

  /// No description provided for @tabDocuments.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get tabDocuments;

  /// No description provided for @sectionReady.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get sectionReady;

  /// No description provided for @sectionWaiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting'**
  String get sectionWaiting;

  /// No description provided for @sectionDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get sectionDone;

  /// No description provided for @readyFooter.
  ///
  /// In en, this message translates to:
  /// **'You have everything these steps need.'**
  String get readyFooter;

  /// No description provided for @needsOne.
  ///
  /// In en, this message translates to:
  /// **'Needs {doc}'**
  String needsOne(String doc);

  /// No description provided for @needsMany.
  ///
  /// In en, this message translates to:
  /// **'Needs {doc} and {count, plural, =1{1 more} other{{count} more}}'**
  String needsMany(String doc, int count);

  /// No description provided for @dueToday.
  ///
  /// In en, this message translates to:
  /// **'Due today'**
  String get dueToday;

  /// No description provided for @dueTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Due tomorrow'**
  String get dueTomorrow;

  /// No description provided for @dueInDays.
  ///
  /// In en, this message translates to:
  /// **'Due in {count, plural, =1{1 day} other{{count} days}}'**
  String dueInDays(int count);

  /// No description provided for @dueOn.
  ///
  /// In en, this message translates to:
  /// **'Due {date}'**
  String dueOn(String date);

  /// No description provided for @overdue.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day overdue} other{{count} days overdue}}'**
  String overdue(int count);

  /// No description provided for @appointmentOn.
  ///
  /// In en, this message translates to:
  /// **'Appointment {date}'**
  String appointmentOn(String date);

  /// No description provided for @movedIn.
  ///
  /// In en, this message translates to:
  /// **'Move-In Date'**
  String get movedIn;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not Set'**
  String get notSet;

  /// No description provided for @starterFooter.
  ///
  /// In en, this message translates to:
  /// **'Deadlines like the Anmeldung count from this day. Rules differ by city, so check your office\'s website.'**
  String get starterFooter;

  /// No description provided for @emptyStepsTitle.
  ///
  /// In en, this message translates to:
  /// **'No Steps Yet'**
  String get emptyStepsTitle;

  /// No description provided for @emptyStepsBody.
  ///
  /// In en, this message translates to:
  /// **'Start with the usual paperwork for moving to Germany. You can change any step.'**
  String get emptyStepsBody;

  /// No description provided for @addStarter.
  ///
  /// In en, this message translates to:
  /// **'Add Germany Starter Steps'**
  String get addStarter;

  /// No description provided for @addOwnStep.
  ///
  /// In en, this message translates to:
  /// **'Add Your Own Step'**
  String get addOwnStep;

  /// No description provided for @moveInQuestion.
  ///
  /// In en, this message translates to:
  /// **'When Do You Move In?'**
  String get moveInQuestion;

  /// No description provided for @moveInHelp.
  ///
  /// In en, this message translates to:
  /// **'Deadlines like the Anmeldung count from this day.'**
  String get moveInHelp;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @addStep.
  ///
  /// In en, this message translates to:
  /// **'Add Step'**
  String get addStep;

  /// No description provided for @addDocument.
  ///
  /// In en, this message translates to:
  /// **'Add Document'**
  String get addDocument;

  /// No description provided for @bring.
  ///
  /// In en, this message translates to:
  /// **'Bring'**
  String get bring;

  /// No description provided for @bringFooter.
  ///
  /// In en, this message translates to:
  /// **'Tap a document once you have it. Bring originals and a copy.'**
  String get bringFooter;

  /// No description provided for @nothingToBring.
  ///
  /// In en, this message translates to:
  /// **'Nothing to bring'**
  String get nothingToBring;

  /// No description provided for @youGet.
  ///
  /// In en, this message translates to:
  /// **'You Get'**
  String get youGet;

  /// No description provided for @dates.
  ///
  /// In en, this message translates to:
  /// **'Dates'**
  String get dates;

  /// No description provided for @deadline.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get deadline;

  /// No description provided for @appointment.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get appointment;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @markDone.
  ///
  /// In en, this message translates to:
  /// **'Mark as Done'**
  String get markDone;

  /// No description provided for @markNotDone.
  ///
  /// In en, this message translates to:
  /// **'Mark as Not Done'**
  String get markNotDone;

  /// No description provided for @removeDeadline.
  ///
  /// In en, this message translates to:
  /// **'Remove Deadline'**
  String get removeDeadline;

  /// No description provided for @removeAppointment.
  ///
  /// In en, this message translates to:
  /// **'Remove Appointment'**
  String get removeAppointment;

  /// No description provided for @inHand.
  ///
  /// In en, this message translates to:
  /// **'In Hand'**
  String get inHand;

  /// No description provided for @missing.
  ///
  /// In en, this message translates to:
  /// **'Missing'**
  String get missing;

  /// No description provided for @neededForCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Not needed by open steps} =1{Needed for 1 open step} other{Needed for {count} open steps}}'**
  String neededForCount(int count);

  /// No description provided for @comesFrom.
  ///
  /// In en, this message translates to:
  /// **'From: {step}'**
  String comesFrom(String step);

  /// No description provided for @neededFor.
  ///
  /// In en, this message translates to:
  /// **'Needed For'**
  String get neededFor;

  /// No description provided for @comesFromHeader.
  ///
  /// In en, this message translates to:
  /// **'Comes From'**
  String get comesFromHeader;

  /// No description provided for @emptyDocsTitle.
  ///
  /// In en, this message translates to:
  /// **'No Documents Yet'**
  String get emptyDocsTitle;

  /// No description provided for @emptyDocsBody.
  ///
  /// In en, this message translates to:
  /// **'Add the papers you already have, like your passport.'**
  String get emptyDocsBody;

  /// No description provided for @newStep.
  ///
  /// In en, this message translates to:
  /// **'New Step'**
  String get newStep;

  /// No description provided for @editStep.
  ///
  /// In en, this message translates to:
  /// **'Edit Step'**
  String get editStep;

  /// No description provided for @newDocument.
  ///
  /// In en, this message translates to:
  /// **'New Document'**
  String get newDocument;

  /// No description provided for @editDocument.
  ///
  /// In en, this message translates to:
  /// **'Edit Document'**
  String get editDocument;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @stepTitleHint.
  ///
  /// In en, this message translates to:
  /// **'For example: Register Your Address'**
  String get stepTitleHint;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @docNameHint.
  ///
  /// In en, this message translates to:
  /// **'For example: Passport'**
  String get docNameHint;

  /// No description provided for @notesHint.
  ///
  /// In en, this message translates to:
  /// **'Where to go, what to ask'**
  String get notesHint;

  /// No description provided for @needs.
  ///
  /// In en, this message translates to:
  /// **'Bring'**
  String get needs;

  /// No description provided for @givesYou.
  ///
  /// In en, this message translates to:
  /// **'You Get'**
  String get givesYou;

  /// No description provided for @noneChosen.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get noneChosen;

  /// No description provided for @deleteStep.
  ///
  /// In en, this message translates to:
  /// **'Delete Step'**
  String get deleteStep;

  /// No description provided for @deleteDocument.
  ///
  /// In en, this message translates to:
  /// **'Delete Document'**
  String get deleteDocument;

  /// No description provided for @deleteStepConfirm.
  ///
  /// In en, this message translates to:
  /// **'This step will be removed from your plan.'**
  String get deleteStepConfirm;

  /// No description provided for @deleteDocConfirm.
  ///
  /// In en, this message translates to:
  /// **'This document will also be removed from every step.'**
  String get deleteDocConfirm;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Your last change could not be saved. Free up some storage and try again.'**
  String get saveFailed;

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Your saved plan could not be read, so a new plan was started. The old file is still on this iPhone.'**
  String get loadFailed;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @received.
  ///
  /// In en, this message translates to:
  /// **'You now have {docs}.'**
  String received(String docs);

  /// No description provided for @semToggleHint.
  ///
  /// In en, this message translates to:
  /// **'Marks the document as in hand or missing'**
  String get semToggleHint;

  /// No description provided for @docPassport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get docPassport;

  /// No description provided for @docVisa.
  ///
  /// In en, this message translates to:
  /// **'Visa (National D Visa)'**
  String get docVisa;

  /// No description provided for @docAdmission.
  ///
  /// In en, this message translates to:
  /// **'Admission Letter (Zulassungsbescheid)'**
  String get docAdmission;

  /// No description provided for @docBlockedAccount.
  ///
  /// In en, this message translates to:
  /// **'Blocked Account Confirmation (Sperrkonto)'**
  String get docBlockedAccount;

  /// No description provided for @docPhoto.
  ///
  /// In en, this message translates to:
  /// **'Biometric Photo'**
  String get docPhoto;

  /// No description provided for @docRentalContract.
  ///
  /// In en, this message translates to:
  /// **'Rental Contract (Mietvertrag)'**
  String get docRentalContract;

  /// No description provided for @docLandlordConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Landlord Confirmation (Wohnungsgeberbestätigung)'**
  String get docLandlordConfirmation;

  /// No description provided for @docRegistration.
  ///
  /// In en, this message translates to:
  /// **'Registration Certificate (Meldebescheinigung)'**
  String get docRegistration;

  /// No description provided for @docInsurance.
  ///
  /// In en, this message translates to:
  /// **'Health Insurance Certificate'**
  String get docInsurance;

  /// No description provided for @docEnrollment.
  ///
  /// In en, this message translates to:
  /// **'Enrollment Certificate (Immatrikulationsbescheinigung)'**
  String get docEnrollment;

  /// No description provided for @docBankAccount.
  ///
  /// In en, this message translates to:
  /// **'German Bank Account (IBAN)'**
  String get docBankAccount;

  /// No description provided for @docTaxId.
  ///
  /// In en, this message translates to:
  /// **'Tax ID Letter (Steuer-ID)'**
  String get docTaxId;

  /// No description provided for @docBroadcastNumber.
  ///
  /// In en, this message translates to:
  /// **'Broadcasting Fee Number (Rundfunkbeitrag)'**
  String get docBroadcastNumber;

  /// No description provided for @docResidencePermit.
  ///
  /// In en, this message translates to:
  /// **'Residence Permit Card (eAT)'**
  String get docResidencePermit;

  /// No description provided for @stepSignLease.
  ///
  /// In en, this message translates to:
  /// **'Sign the Lease'**
  String get stepSignLease;

  /// No description provided for @stepSignLeaseNote.
  ///
  /// In en, this message translates to:
  /// **'Ask your landlord for the Wohnungsgeberbestätigung as well. The Anmeldung needs it.'**
  String get stepSignLeaseNote;

  /// No description provided for @stepAnmeldung.
  ///
  /// In en, this message translates to:
  /// **'Register Your Address (Anmeldung)'**
  String get stepAnmeldung;

  /// No description provided for @stepAnmeldungNote.
  ///
  /// In en, this message translates to:
  /// **'At the Bürgeramt, usually within 14 days of moving in. Book the appointment early.'**
  String get stepAnmeldungNote;

  /// No description provided for @stepInsurance.
  ///
  /// In en, this message translates to:
  /// **'Get Health Insurance'**
  String get stepInsurance;

  /// No description provided for @stepInsuranceNote.
  ///
  /// In en, this message translates to:
  /// **'The insurer reports you to the university. Keep your own certificate for the Ausländerbehörde.'**
  String get stepInsuranceNote;

  /// No description provided for @stepEnroll.
  ///
  /// In en, this message translates to:
  /// **'Enroll at the University'**
  String get stepEnroll;

  /// No description provided for @stepEnrollNote.
  ///
  /// In en, this message translates to:
  /// **'Pay the semester fee first. The semester ticket usually comes with it.'**
  String get stepEnrollNote;

  /// No description provided for @stepBank.
  ///
  /// In en, this message translates to:
  /// **'Open a Bank Account'**
  String get stepBank;

  /// No description provided for @stepBankNote.
  ///
  /// In en, this message translates to:
  /// **'Some online banks do not ask for the Meldebescheinigung.'**
  String get stepBankNote;

  /// No description provided for @stepBlockedPayout.
  ///
  /// In en, this message translates to:
  /// **'Start Blocked Account Payouts'**
  String get stepBlockedPayout;

  /// No description provided for @stepBlockedPayoutNote.
  ///
  /// In en, this message translates to:
  /// **'Give your blocked account provider your new IBAN so the monthly payout can start.'**
  String get stepBlockedPayoutNote;

  /// No description provided for @stepTaxId.
  ///
  /// In en, this message translates to:
  /// **'Receive Your Tax ID'**
  String get stepTaxId;

  /// No description provided for @stepTaxIdNote.
  ///
  /// In en, this message translates to:
  /// **'Arrives by post a few weeks after the Anmeldung. You need it for a job.'**
  String get stepTaxIdNote;

  /// No description provided for @stepBroadcastFee.
  ///
  /// In en, this message translates to:
  /// **'Register for the Broadcasting Fee'**
  String get stepBroadcastFee;

  /// No description provided for @stepBroadcastFeeNote.
  ///
  /// In en, this message translates to:
  /// **'One fee per flat. If a flatmate already pays, note their contribution number.'**
  String get stepBroadcastFeeNote;

  /// No description provided for @stepPhoto.
  ///
  /// In en, this message translates to:
  /// **'Get Biometric Photos'**
  String get stepPhoto;

  /// No description provided for @stepPhotoNote.
  ///
  /// In en, this message translates to:
  /// **'Photo booths and photo shops take them. Get a few extra.'**
  String get stepPhotoNote;

  /// No description provided for @stepResidencePermit.
  ///
  /// In en, this message translates to:
  /// **'Apply for a Residence Permit'**
  String get stepResidencePermit;

  /// No description provided for @stepResidencePermitNote.
  ///
  /// In en, this message translates to:
  /// **'At the Ausländerbehörde, before your visa ends. Set the deadline to your visa\'s end date; appointments can take weeks.'**
  String get stepResidencePermitNote;

  /// No description provided for @confirmDoneMissing.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 document is still missing.} other{{count} documents are still missing.}} Mark as done anyway?'**
  String confirmDoneMissing(int count);

  /// No description provided for @stepDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get stepDone;

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

  /// No description provided for @allDone.
  ///
  /// In en, this message translates to:
  /// **'All steps are done.'**
  String get allDone;

  /// No description provided for @listAnd.
  ///
  /// In en, this message translates to:
  /// **'{first} and {last}'**
  String listAnd(String first, String last);
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
