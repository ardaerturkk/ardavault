// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Paperpath';

  @override
  String get tabSteps => 'Steps';

  @override
  String get tabDocuments => 'Documents';

  @override
  String get sectionReady => 'Ready';

  @override
  String get sectionWaiting => 'Waiting';

  @override
  String get sectionDone => 'Done';

  @override
  String get readyFooter => 'You have everything these steps need.';

  @override
  String needsOne(String doc) {
    return 'Needs $doc';
  }

  @override
  String needsMany(String doc, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count more',
      one: '1 more',
    );
    return 'Needs $doc and $_temp0';
  }

  @override
  String get dueToday => 'Due today';

  @override
  String get dueTomorrow => 'Due tomorrow';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return 'Due in $_temp0';
  }

  @override
  String dueOn(String date) {
    return 'Due $date';
  }

  @override
  String overdue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days overdue',
      one: '1 day overdue',
    );
    return '$_temp0';
  }

  @override
  String appointmentOn(String date) {
    return 'Appointment $date';
  }

  @override
  String get movedIn => 'Move-In Date';

  @override
  String get notSet => 'Not Set';

  @override
  String get starterFooter =>
      'Deadlines like the Anmeldung count from this day. Rules differ by city, so check your office\'s website.';

  @override
  String get emptyStepsTitle => 'No Steps Yet';

  @override
  String get emptyStepsBody =>
      'Start with the usual paperwork for moving to Germany. You can change any step.';

  @override
  String get addStarter => 'Add Germany Starter Steps';

  @override
  String get addOwnStep => 'Add Your Own Step';

  @override
  String get moveInQuestion => 'When Do You Move In?';

  @override
  String get moveInHelp => 'Deadlines like the Anmeldung count from this day.';

  @override
  String get continueLabel => 'Continue';

  @override
  String get cancel => 'Cancel';

  @override
  String get done => 'Done';

  @override
  String get save => 'Save';

  @override
  String get edit => 'Edit';

  @override
  String get addStep => 'Add Step';

  @override
  String get addDocument => 'Add Document';

  @override
  String get bring => 'Bring';

  @override
  String get bringFooter =>
      'Tap a document once you have it. Bring originals and a copy.';

  @override
  String get nothingToBring => 'Nothing to bring';

  @override
  String get youGet => 'You Get';

  @override
  String get dates => 'Dates';

  @override
  String get deadline => 'Deadline';

  @override
  String get appointment => 'Appointment';

  @override
  String get none => 'None';

  @override
  String get notes => 'Notes';

  @override
  String get markDone => 'Mark as Done';

  @override
  String get markNotDone => 'Mark as Not Done';

  @override
  String get removeDeadline => 'Remove Deadline';

  @override
  String get removeAppointment => 'Remove Appointment';

  @override
  String get inHand => 'In Hand';

  @override
  String get missing => 'Missing';

  @override
  String neededForCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Needed for $count open steps',
      one: 'Needed for 1 open step',
      zero: 'Not needed by open steps',
    );
    return '$_temp0';
  }

  @override
  String comesFrom(String step) {
    return 'From: $step';
  }

  @override
  String get neededFor => 'Needed For';

  @override
  String get comesFromHeader => 'Comes From';

  @override
  String get emptyDocsTitle => 'No Documents Yet';

  @override
  String get emptyDocsBody =>
      'Add the papers you already have, like your passport.';

  @override
  String get newStep => 'New Step';

  @override
  String get editStep => 'Edit Step';

  @override
  String get newDocument => 'New Document';

  @override
  String get editDocument => 'Edit Document';

  @override
  String get title => 'Title';

  @override
  String get stepTitleHint => 'For example: Register Your Address';

  @override
  String get name => 'Name';

  @override
  String get docNameHint => 'For example: Passport';

  @override
  String get notesHint => 'Where to go, what to ask';

  @override
  String get needs => 'Bring';

  @override
  String get givesYou => 'You Get';

  @override
  String get noneChosen => 'None';

  @override
  String get deleteStep => 'Delete Step';

  @override
  String get deleteDocument => 'Delete Document';

  @override
  String get deleteStepConfirm => 'This step will be removed from your plan.';

  @override
  String get deleteDocConfirm =>
      'This document will also be removed from every step.';

  @override
  String get saveFailed =>
      'Your last change could not be saved. Free up some storage and try again.';

  @override
  String get loadFailed =>
      'Your saved plan could not be read, so a new plan was started. The old file is still on this iPhone.';

  @override
  String get ok => 'OK';

  @override
  String received(String docs) {
    return 'You now have $docs.';
  }

  @override
  String get semToggleHint => 'Marks the document as in hand or missing';

  @override
  String get docPassport => 'Passport';

  @override
  String get docVisa => 'Visa (National D Visa)';

  @override
  String get docAdmission => 'Admission Letter (Zulassungsbescheid)';

  @override
  String get docBlockedAccount => 'Blocked Account Confirmation (Sperrkonto)';

  @override
  String get docPhoto => 'Biometric Photo';

  @override
  String get docRentalContract => 'Rental Contract (Mietvertrag)';

  @override
  String get docLandlordConfirmation =>
      'Landlord Confirmation (Wohnungsgeberbestätigung)';

  @override
  String get docRegistration => 'Registration Certificate (Meldebescheinigung)';

  @override
  String get docInsurance => 'Health Insurance Certificate';

  @override
  String get docEnrollment =>
      'Enrollment Certificate (Immatrikulationsbescheinigung)';

  @override
  String get docBankAccount => 'German Bank Account (IBAN)';

  @override
  String get docTaxId => 'Tax ID Letter (Steuer-ID)';

  @override
  String get docBroadcastNumber => 'Broadcasting Fee Number (Rundfunkbeitrag)';

  @override
  String get docResidencePermit => 'Residence Permit Card (eAT)';

  @override
  String get stepSignLease => 'Sign the Lease';

  @override
  String get stepSignLeaseNote =>
      'Ask your landlord for the Wohnungsgeberbestätigung as well. The Anmeldung needs it.';

  @override
  String get stepAnmeldung => 'Register Your Address (Anmeldung)';

  @override
  String get stepAnmeldungNote =>
      'At the Bürgeramt, usually within 14 days of moving in. Book the appointment early.';

  @override
  String get stepInsurance => 'Get Health Insurance';

  @override
  String get stepInsuranceNote =>
      'The insurer reports you to the university. Keep your own certificate for the Ausländerbehörde.';

  @override
  String get stepEnroll => 'Enroll at the University';

  @override
  String get stepEnrollNote =>
      'Pay the semester fee first. The semester ticket usually comes with it.';

  @override
  String get stepBank => 'Open a Bank Account';

  @override
  String get stepBankNote =>
      'Some online banks do not ask for the Meldebescheinigung.';

  @override
  String get stepBlockedPayout => 'Start Blocked Account Payouts';

  @override
  String get stepBlockedPayoutNote =>
      'Give your blocked account provider your new IBAN so the monthly payout can start.';

  @override
  String get stepTaxId => 'Receive Your Tax ID';

  @override
  String get stepTaxIdNote =>
      'Arrives by post a few weeks after the Anmeldung. You need it for a job.';

  @override
  String get stepBroadcastFee => 'Register for the Broadcasting Fee';

  @override
  String get stepBroadcastFeeNote =>
      'One fee per flat. If a flatmate already pays, note their contribution number.';

  @override
  String get stepPhoto => 'Get Biometric Photos';

  @override
  String get stepPhotoNote =>
      'Photo booths and photo shops take them. Get a few extra.';

  @override
  String get stepResidencePermit => 'Apply for a Residence Permit';

  @override
  String get stepResidencePermitNote =>
      'At the Ausländerbehörde, before your visa ends. Set the deadline to your visa\'s end date; appointments can take weeks.';

  @override
  String confirmDoneMissing(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count documents are still missing.',
      one: '1 document is still missing.',
    );
    return '$_temp0 Mark as done anyway?';
  }

  @override
  String get stepDone => 'Done';
}
