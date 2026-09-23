import '../l10n/app_localizations.dart';
import '../model/plan.dart';

/// Display names for documents and steps: the user's text if they set one,
/// otherwise the localized starter text.
String docName(AppLocalizations l, Doc d) =>
    d.name ?? _starterDocName(l, d.templateKey) ?? '';

String stepTitle(AppLocalizations l, PathStep s) =>
    s.title ?? _starterStep(l, s.templateKey)?.$1 ?? '';

String stepNote(AppLocalizations l, PathStep s) =>
    s.note ?? _starterStep(l, s.templateKey)?.$2 ?? '';

String? _starterDocName(AppLocalizations l, String? key) => switch (key) {
  'passport' => l.docPassport,
  'visa' => l.docVisa,
  'admission' => l.docAdmission,
  'blockedAccount' => l.docBlockedAccount,
  'photo' => l.docPhoto,
  'rentalContract' => l.docRentalContract,
  'landlordConfirmation' => l.docLandlordConfirmation,
  'registration' => l.docRegistration,
  'insurance' => l.docInsurance,
  'enrollment' => l.docEnrollment,
  'bankAccount' => l.docBankAccount,
  'taxId' => l.docTaxId,
  'broadcastNumber' => l.docBroadcastNumber,
  'residencePermit' => l.docResidencePermit,
  _ => null,
};

(String, String)? _starterStep(AppLocalizations l, String? key) =>
    switch (key) {
      'signLease' => (l.stepSignLease, l.stepSignLeaseNote),
      'anmeldung' => (l.stepAnmeldung, l.stepAnmeldungNote),
      'insurance' => (l.stepInsurance, l.stepInsuranceNote),
      'enroll' => (l.stepEnroll, l.stepEnrollNote),
      'bank' => (l.stepBank, l.stepBankNote),
      'blockedPayout' => (l.stepBlockedPayout, l.stepBlockedPayoutNote),
      'taxId' => (l.stepTaxId, l.stepTaxIdNote),
      'broadcastFee' => (l.stepBroadcastFee, l.stepBroadcastFeeNote),
      'photo' => (l.stepPhoto, l.stepPhotoNote),
      'residencePermit' => (l.stepResidencePermit, l.stepResidencePermitNote),
      _ => null,
    };
