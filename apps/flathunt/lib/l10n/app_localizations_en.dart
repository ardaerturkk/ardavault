// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flatboard';

  @override
  String get tabFlats => 'Flats';

  @override
  String get tabCompare => 'Compare';

  @override
  String get stageInterested => 'Interested';

  @override
  String get stageMessaged => 'Messaged';

  @override
  String get stageViewing => 'Viewing';

  @override
  String get stageApplied => 'Applied';

  @override
  String get stageAccepted => 'Accepted';

  @override
  String get stageDeclined => 'Declined';

  @override
  String get actionMessaged => 'Mark as Messaged';

  @override
  String get actionViewing => 'Schedule Viewing';

  @override
  String get actionApplied => 'Mark as Applied';

  @override
  String get actionAnswer => 'Record Answer';

  @override
  String get answerQuestion => 'Did you get the flat?';

  @override
  String get answerAccepted => 'Accepted';

  @override
  String get answerDeclined => 'Declined';

  @override
  String get sourceWgGesucht => 'WG-Gesucht';

  @override
  String get sourceKleinanzeigen => 'Kleinanzeigen';

  @override
  String get sourceImmoscout => 'ImmoScout24';

  @override
  String get sourceFacebook => 'Facebook Group';

  @override
  String get sourceStudentenwerk => 'Studentenwerk';

  @override
  String get sourceFriends => 'Friends';

  @override
  String get sourceOther => 'Other';

  @override
  String get emptyFlatsTitle => 'No Flats Yet';

  @override
  String get emptyFlatsBody =>
      'Add each flat you like, from any site or group. Then move it along as you message, view and apply.';

  @override
  String get addFlat => 'Add Flat';

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
    return 'Viewing $date';
  }

  @override
  String viewedOn(String date) {
    return 'Viewed $date';
  }

  @override
  String get noViewingTime => 'No viewing time yet';

  @override
  String addedOn(String date) {
    return 'Added $date';
  }

  @override
  String messagedOn(String date) {
    return 'Messaged $date';
  }

  @override
  String appliedOn(String date) {
    return 'Applied $date';
  }

  @override
  String acceptedOn(String date) {
    return 'Accepted $date';
  }

  @override
  String declinedOn(String date) {
    return 'Declined $date';
  }

  @override
  String get stage => 'Stage';

  @override
  String get viewing => 'Viewing';

  @override
  String get notSet => 'Not Set';

  @override
  String get rent => 'Rent';

  @override
  String get warmRent => 'Warm Rent';

  @override
  String get coldRent => 'Cold Rent';

  @override
  String get size => 'Size';

  @override
  String get perSqm => 'Warm per m²';

  @override
  String get rentFooter =>
      'Warm rent includes heating and running costs (Nebenkosten).';

  @override
  String get listing => 'Listing';

  @override
  String get source => 'Source';

  @override
  String get link => 'Link';

  @override
  String get copyLink => 'Copy Link';

  @override
  String get linkCopied => 'Link copied.';

  @override
  String get district => 'District';

  @override
  String get notes => 'Notes';

  @override
  String get checksHeader => 'Safety Checks';

  @override
  String get checkViewed => 'You have seen the flat in person';

  @override
  String get checkNoPrepay =>
      'No deposit or rent before the viewing and a signed contract';

  @override
  String get checkAccountInName =>
      'Payment only by bank transfer to the landlord, not abroad or through cash transfer services';

  @override
  String get checkIdLater => 'ID copy only once the contract is ready to sign';

  @override
  String get checkPlausible =>
      'The rent fits the area and size, not far below similar flats';

  @override
  String get checksFooter =>
      'Tick each point once you have confirmed it. If one does not hold, stop and ask the Studentenwerk or the local tenants\' association (Mieterverein) before you pay or send documents.';

  @override
  String get semCheckHint => 'Marks this point as confirmed';

  @override
  String get edit => 'Edit';

  @override
  String get newFlat => 'New Flat';

  @override
  String get editFlat => 'Edit Flat';

  @override
  String get title => 'Title';

  @override
  String get titleHint => 'For example: Room Near Campus';

  @override
  String get linkHint => 'Paste the listing link';

  @override
  String get optional => 'Optional';

  @override
  String get districtHint => 'For example: Gaarden';

  @override
  String get notesHint => 'Contact, questions, what to bring';

  @override
  String get deleteFlat => 'Delete Flat';

  @override
  String get deleteFlatConfirm => 'This flat will be removed from your board.';

  @override
  String get invalidAmount =>
      'Enter amounts like 480 or 480,50 and a size like 18 or 18,5.';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get done => 'Done';

  @override
  String get ok => 'OK';

  @override
  String get discardChanges => 'Discard Changes';

  @override
  String get keepEditing => 'Keep Editing';

  @override
  String get viewingTime => 'Viewing Time';

  @override
  String get setTimeLater => 'Set Time Later';

  @override
  String get removeViewing => 'Remove Viewing Time';

  @override
  String get perMonthSeg => 'Per Month';

  @override
  String get perSqmSeg => 'Per m²';

  @override
  String get compareEmptyTitle => 'Nothing to Compare Yet';

  @override
  String get compareEmptyBody =>
      'Add the warm rent to your flats to see them side by side, cheapest first.';

  @override
  String get compareFooter => 'Cheapest first. Declined flats are left out.';

  @override
  String get notCompared => 'Not Compared';

  @override
  String get missingWarm => 'Warm rent missing';

  @override
  String get missingSize => 'Size missing';

  @override
  String get missingBoth => 'Warm rent and size missing';

  @override
  String get cheapest => 'Cheapest';

  @override
  String moreThanCheapest(String amount) {
    return '$amount more';
  }

  @override
  String get chooseStage => 'Move this flat to another stage.';

  @override
  String get loadFailed =>
      'Your saved flats could not be read, so a new board was started. The old file is still on this iPhone.';

  @override
  String get saveFailed =>
      'Your last change could not be saved. Free up some storage and try again.';

  @override
  String get addRent => 'Add Rent and Size';

  @override
  String get sizeSqmLabel => 'Size in m²';
}
