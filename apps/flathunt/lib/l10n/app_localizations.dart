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
  /// **'Flatboard'**
  String get appTitle;

  /// No description provided for @tabFlats.
  ///
  /// In en, this message translates to:
  /// **'Flats'**
  String get tabFlats;

  /// No description provided for @tabCompare.
  ///
  /// In en, this message translates to:
  /// **'Compare'**
  String get tabCompare;

  /// No description provided for @stageInterested.
  ///
  /// In en, this message translates to:
  /// **'Interested'**
  String get stageInterested;

  /// No description provided for @stageMessaged.
  ///
  /// In en, this message translates to:
  /// **'Messaged'**
  String get stageMessaged;

  /// No description provided for @stageViewing.
  ///
  /// In en, this message translates to:
  /// **'Viewing'**
  String get stageViewing;

  /// No description provided for @stageApplied.
  ///
  /// In en, this message translates to:
  /// **'Applied'**
  String get stageApplied;

  /// No description provided for @stageAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get stageAccepted;

  /// No description provided for @stageDeclined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get stageDeclined;

  /// No description provided for @actionMessaged.
  ///
  /// In en, this message translates to:
  /// **'Mark as Messaged'**
  String get actionMessaged;

  /// No description provided for @actionViewing.
  ///
  /// In en, this message translates to:
  /// **'Schedule Viewing'**
  String get actionViewing;

  /// No description provided for @actionApplied.
  ///
  /// In en, this message translates to:
  /// **'Mark as Applied'**
  String get actionApplied;

  /// No description provided for @actionAnswer.
  ///
  /// In en, this message translates to:
  /// **'Record Answer'**
  String get actionAnswer;

  /// No description provided for @answerQuestion.
  ///
  /// In en, this message translates to:
  /// **'Did you get the flat?'**
  String get answerQuestion;

  /// No description provided for @answerAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get answerAccepted;

  /// No description provided for @answerDeclined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get answerDeclined;

  /// No description provided for @sourceWgGesucht.
  ///
  /// In en, this message translates to:
  /// **'WG-Gesucht'**
  String get sourceWgGesucht;

  /// No description provided for @sourceKleinanzeigen.
  ///
  /// In en, this message translates to:
  /// **'Kleinanzeigen'**
  String get sourceKleinanzeigen;

  /// No description provided for @sourceImmoscout.
  ///
  /// In en, this message translates to:
  /// **'ImmoScout24'**
  String get sourceImmoscout;

  /// No description provided for @sourceFacebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook Group'**
  String get sourceFacebook;

  /// No description provided for @sourceStudentenwerk.
  ///
  /// In en, this message translates to:
  /// **'Studentenwerk'**
  String get sourceStudentenwerk;

  /// No description provided for @sourceFriends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get sourceFriends;

  /// No description provided for @sourceOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get sourceOther;

  /// No description provided for @emptyFlatsTitle.
  ///
  /// In en, this message translates to:
  /// **'No Flats Yet'**
  String get emptyFlatsTitle;

  /// No description provided for @emptyFlatsBody.
  ///
  /// In en, this message translates to:
  /// **'Add each flat you like, from any site or group. Then move it along as you message, view and apply.'**
  String get emptyFlatsBody;

  /// No description provided for @addFlat.
  ///
  /// In en, this message translates to:
  /// **'Add Flat'**
  String get addFlat;

  /// No description provided for @warmShort.
  ///
  /// In en, this message translates to:
  /// **'{amount} warm'**
  String warmShort(String amount);

  /// No description provided for @sizeShort.
  ///
  /// In en, this message translates to:
  /// **'{size} m²'**
  String sizeShort(String size);

  /// No description provided for @viewingOn.
  ///
  /// In en, this message translates to:
  /// **'Viewing {date}'**
  String viewingOn(String date);

  /// No description provided for @viewedOn.
  ///
  /// In en, this message translates to:
  /// **'Viewed {date}'**
  String viewedOn(String date);

  /// No description provided for @noViewingTime.
  ///
  /// In en, this message translates to:
  /// **'No viewing time yet'**
  String get noViewingTime;

  /// No description provided for @addedOn.
  ///
  /// In en, this message translates to:
  /// **'Added {date}'**
  String addedOn(String date);

  /// No description provided for @messagedOn.
  ///
  /// In en, this message translates to:
  /// **'Messaged {date}'**
  String messagedOn(String date);

  /// No description provided for @appliedOn.
  ///
  /// In en, this message translates to:
  /// **'Applied {date}'**
  String appliedOn(String date);

  /// No description provided for @acceptedOn.
  ///
  /// In en, this message translates to:
  /// **'Accepted {date}'**
  String acceptedOn(String date);

  /// No description provided for @declinedOn.
  ///
  /// In en, this message translates to:
  /// **'Declined {date}'**
  String declinedOn(String date);

  /// No description provided for @stage.
  ///
  /// In en, this message translates to:
  /// **'Stage'**
  String get stage;

  /// No description provided for @viewing.
  ///
  /// In en, this message translates to:
  /// **'Viewing'**
  String get viewing;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not Set'**
  String get notSet;

  /// No description provided for @rent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get rent;

  /// No description provided for @warmRent.
  ///
  /// In en, this message translates to:
  /// **'Warm Rent'**
  String get warmRent;

  /// No description provided for @coldRent.
  ///
  /// In en, this message translates to:
  /// **'Cold Rent'**
  String get coldRent;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @perSqm.
  ///
  /// In en, this message translates to:
  /// **'Warm per m²'**
  String get perSqm;

  /// No description provided for @rentFooter.
  ///
  /// In en, this message translates to:
  /// **'Warm rent includes heating and running costs (Nebenkosten).'**
  String get rentFooter;

  /// No description provided for @listing.
  ///
  /// In en, this message translates to:
  /// **'Listing'**
  String get listing;

  /// No description provided for @source.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get source;

  /// No description provided for @link.
  ///
  /// In en, this message translates to:
  /// **'Link'**
  String get link;

  /// No description provided for @copyLink.
  ///
  /// In en, this message translates to:
  /// **'Copy Link'**
  String get copyLink;

  /// No description provided for @linkCopied.
  ///
  /// In en, this message translates to:
  /// **'Link copied.'**
  String get linkCopied;

  /// No description provided for @district.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get district;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @checksHeader.
  ///
  /// In en, this message translates to:
  /// **'Safety Checks'**
  String get checksHeader;

  /// No description provided for @checkViewed.
  ///
  /// In en, this message translates to:
  /// **'You have seen the flat in person'**
  String get checkViewed;

  /// No description provided for @checkNoPrepay.
  ///
  /// In en, this message translates to:
  /// **'No deposit or rent before the viewing and a signed contract'**
  String get checkNoPrepay;

  /// No description provided for @checkAccountInName.
  ///
  /// In en, this message translates to:
  /// **'Payment only by bank transfer to the landlord, not abroad or through cash transfer services'**
  String get checkAccountInName;

  /// No description provided for @checkIdLater.
  ///
  /// In en, this message translates to:
  /// **'ID copy only once the contract is ready to sign'**
  String get checkIdLater;

  /// No description provided for @checkPlausible.
  ///
  /// In en, this message translates to:
  /// **'The rent fits the area and size, not far below similar flats'**
  String get checkPlausible;

  /// No description provided for @checksFooter.
  ///
  /// In en, this message translates to:
  /// **'Tick each point once you have confirmed it. If one does not hold, stop and ask the Studentenwerk or the local tenants\' association (Mieterverein) before you pay or send documents.'**
  String get checksFooter;

  /// No description provided for @checksCount.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} confirmed'**
  String checksCount(int done, int total);

  /// No description provided for @semCheckHint.
  ///
  /// In en, this message translates to:
  /// **'Marks this point as confirmed'**
  String get semCheckHint;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @newFlat.
  ///
  /// In en, this message translates to:
  /// **'New Flat'**
  String get newFlat;

  /// No description provided for @editFlat.
  ///
  /// In en, this message translates to:
  /// **'Edit Flat'**
  String get editFlat;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @titleHint.
  ///
  /// In en, this message translates to:
  /// **'For example: Room Near Campus'**
  String get titleHint;

  /// No description provided for @linkHint.
  ///
  /// In en, this message translates to:
  /// **'Paste the listing link'**
  String get linkHint;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @districtHint.
  ///
  /// In en, this message translates to:
  /// **'For example: Gaarden'**
  String get districtHint;

  /// No description provided for @notesHint.
  ///
  /// In en, this message translates to:
  /// **'Contact, questions, what to bring'**
  String get notesHint;

  /// No description provided for @deleteFlat.
  ///
  /// In en, this message translates to:
  /// **'Delete Flat'**
  String get deleteFlat;

  /// No description provided for @deleteFlatConfirm.
  ///
  /// In en, this message translates to:
  /// **'This flat will be removed from your board.'**
  String get deleteFlatConfirm;

  /// No description provided for @invalidAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter amounts like 480 or 480,50 and a size like 18 or 18,5.'**
  String get invalidAmount;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

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

  /// No description provided for @viewingTime.
  ///
  /// In en, this message translates to:
  /// **'Viewing Time'**
  String get viewingTime;

  /// No description provided for @setTimeLater.
  ///
  /// In en, this message translates to:
  /// **'Set Time Later'**
  String get setTimeLater;

  /// No description provided for @removeViewing.
  ///
  /// In en, this message translates to:
  /// **'Remove Viewing Time'**
  String get removeViewing;

  /// No description provided for @compareBy.
  ///
  /// In en, this message translates to:
  /// **'Compare by'**
  String get compareBy;

  /// No description provided for @perMonthSeg.
  ///
  /// In en, this message translates to:
  /// **'Per Month'**
  String get perMonthSeg;

  /// No description provided for @perSqmSeg.
  ///
  /// In en, this message translates to:
  /// **'Per m²'**
  String get perSqmSeg;

  /// No description provided for @compareEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing to Compare Yet'**
  String get compareEmptyTitle;

  /// No description provided for @compareEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add the warm rent to your flats to see them side by side, cheapest first.'**
  String get compareEmptyBody;

  /// No description provided for @compareFooter.
  ///
  /// In en, this message translates to:
  /// **'Cheapest first. Declined flats are left out.'**
  String get compareFooter;

  /// No description provided for @notCompared.
  ///
  /// In en, this message translates to:
  /// **'Not Compared'**
  String get notCompared;

  /// No description provided for @missingWarm.
  ///
  /// In en, this message translates to:
  /// **'Warm rent missing'**
  String get missingWarm;

  /// No description provided for @missingSize.
  ///
  /// In en, this message translates to:
  /// **'Size missing'**
  String get missingSize;

  /// No description provided for @missingBoth.
  ///
  /// In en, this message translates to:
  /// **'Warm rent and size missing'**
  String get missingBoth;

  /// No description provided for @cheapest.
  ///
  /// In en, this message translates to:
  /// **'Cheapest'**
  String get cheapest;

  /// No description provided for @moreThanCheapest.
  ///
  /// In en, this message translates to:
  /// **'{amount} more'**
  String moreThanCheapest(String amount);

  /// No description provided for @chooseStage.
  ///
  /// In en, this message translates to:
  /// **'Move this flat to another stage.'**
  String get chooseStage;

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Your saved flats could not be read, so a new board was started. The old file is still on this iPhone.'**
  String get loadFailed;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Your last change could not be saved. Free up some storage and try again.'**
  String get saveFailed;

  /// No description provided for @addRent.
  ///
  /// In en, this message translates to:
  /// **'Add Rent and Size'**
  String get addRent;

  /// No description provided for @sizeSqmLabel.
  ///
  /// In en, this message translates to:
  /// **'Size in m²'**
  String get sizeSqmLabel;
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
