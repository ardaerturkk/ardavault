// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Paperpath';

  @override
  String get tabSteps => 'Adımlar';

  @override
  String get tabDocuments => 'Belgeler';

  @override
  String get sectionReady => 'Hazır';

  @override
  String get sectionWaiting => 'Bekliyor';

  @override
  String get sectionDone => 'Tamamlandı';

  @override
  String get readyFooter => 'Bu adımlar için gereken her şey elinde.';

  @override
  String needsOne(String doc) {
    return 'Gerekli: $doc';
  }

  @override
  String needsMany(String doc, int count) {
    return 'Gerekli: $doc ve $count belge daha';
  }

  @override
  String get dueToday => 'Bugün son gün';

  @override
  String get dueTomorrow => 'Yarın son gün';

  @override
  String dueInDays(int count) {
    return '$count gün kaldı';
  }

  @override
  String dueOn(String date) {
    return 'Son gün $date';
  }

  @override
  String overdue(int count) {
    return '$count gün gecikti';
  }

  @override
  String appointmentOn(String date) {
    return 'Randevu $date';
  }

  @override
  String get movedIn => 'Taşınma Tarihi';

  @override
  String get notSet => 'Belirlenmedi';

  @override
  String get starterFooter =>
      'Anmeldung gibi süreler bu günden itibaren sayılır. Kurallar şehre göre değişir, ilgili dairenin web sitesine bak.';

  @override
  String get emptyStepsTitle => 'Henüz Adım Yok';

  @override
  String get emptyStepsBody =>
      'Almanya\'ya taşınırken gereken olağan evrak işleriyle başla. Her adımı değiştirebilirsin.';

  @override
  String get addStarter => 'Almanya Başlangıç Adımlarını Ekle';

  @override
  String get addOwnStep => 'Kendi Adımını Ekle';

  @override
  String get moveInQuestion => 'Ne Zaman Taşınıyorsun?';

  @override
  String get moveInHelp => 'Anmeldung gibi süreler bu günden itibaren sayılır.';

  @override
  String get continueLabel => 'Devam';

  @override
  String get cancel => 'Vazgeç';

  @override
  String get done => 'Bitti';

  @override
  String get save => 'Kaydet';

  @override
  String get edit => 'Düzenle';

  @override
  String get addStep => 'Adım Ekle';

  @override
  String get addDocument => 'Belge Ekle';

  @override
  String get bring => 'Yanına Al';

  @override
  String get bringFooter =>
      'Elindeki belgeye dokun. Asıllarını ve bir kopyasını götür.';

  @override
  String get nothingToBring => 'Götürülecek bir şey yok';

  @override
  String get youGet => 'Alacağın';

  @override
  String get dates => 'Tarihler';

  @override
  String get deadline => 'Son Tarih';

  @override
  String get appointment => 'Randevu';

  @override
  String get none => 'Yok';

  @override
  String get notes => 'Notlar';

  @override
  String get markDone => 'Tamamlandı Olarak İşaretle';

  @override
  String get markNotDone => 'Tamamlanmadı Olarak İşaretle';

  @override
  String get removeDeadline => 'Son Tarihi Kaldır';

  @override
  String get removeAppointment => 'Randevuyu Kaldır';

  @override
  String get inHand => 'Elimde';

  @override
  String get missing => 'Eksik';

  @override
  String neededForCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count açık adımda gerekli',
      zero: 'Açık adımlarda gerekmiyor',
    );
    return '$_temp0';
  }

  @override
  String comesFrom(String step) {
    return 'Nereden: $step';
  }

  @override
  String get neededFor => 'Gerekli Olduğu Adımlar';

  @override
  String get comesFromHeader => 'Nereden Alınır';

  @override
  String get emptyDocsTitle => 'Henüz Belge Yok';

  @override
  String get emptyDocsBody =>
      'Pasaportun gibi zaten elinde olan belgeleri ekle.';

  @override
  String get newStep => 'Yeni Adım';

  @override
  String get editStep => 'Adımı Düzenle';

  @override
  String get newDocument => 'Yeni Belge';

  @override
  String get editDocument => 'Belgeyi Düzenle';

  @override
  String get title => 'Başlık';

  @override
  String get stepTitleHint => 'Örneğin: Adresini Kaydet';

  @override
  String get name => 'Ad';

  @override
  String get docNameHint => 'Örneğin: Pasaport';

  @override
  String get notesHint => 'Nereye gidilecek, ne sorulacak';

  @override
  String get needs => 'Yanına Al';

  @override
  String get givesYou => 'Alacağın';

  @override
  String get noneChosen => 'Yok';

  @override
  String get deleteStep => 'Adımı Sil';

  @override
  String get deleteDocument => 'Belgeyi Sil';

  @override
  String get deleteStepConfirm => 'Bu adım planından kaldırılacak.';

  @override
  String get deleteDocConfirm => 'Bu belge tüm adımlardan da kaldırılacak.';

  @override
  String get saveFailed =>
      'Son değişikliğin kaydedilemedi. Biraz yer aç ve tekrar dene.';

  @override
  String get loadFailed =>
      'Kayıtlı planın okunamadı, bu yüzden yeni bir plan başlatıldı. Eski dosya hâlâ bu iPhone\'da.';

  @override
  String get ok => 'Tamam';

  @override
  String received(String docs) {
    return 'Artık elinde: $docs.';
  }

  @override
  String get semToggleHint => 'Belgeyi elimde ya da eksik olarak işaretler';

  @override
  String get docPassport => 'Pasaport';

  @override
  String get docVisa => 'Vize (Ulusal D Vizesi)';

  @override
  String get docAdmission => 'Kabul Mektubu (Zulassungsbescheid)';

  @override
  String get docBlockedAccount => 'Bloke Hesap Belgesi (Sperrkonto)';

  @override
  String get docPhoto => 'Biyometrik Fotoğraf';

  @override
  String get docRentalContract => 'Kira Sözleşmesi (Mietvertrag)';

  @override
  String get docLandlordConfirmation =>
      'Ev Sahibi Onayı (Wohnungsgeberbestätigung)';

  @override
  String get docRegistration => 'Adres Kayıt Belgesi (Meldebescheinigung)';

  @override
  String get docInsurance => 'Sağlık Sigortası Belgesi';

  @override
  String get docEnrollment => 'Öğrenci Belgesi (Immatrikulationsbescheinigung)';

  @override
  String get docBankAccount => 'Alman Banka Hesabı (IBAN)';

  @override
  String get docTaxId => 'Vergi Numarası Mektubu (Steuer-ID)';

  @override
  String get docBroadcastNumber => 'Yayın Ücreti Numarası (Rundfunkbeitrag)';

  @override
  String get docResidencePermit => 'Oturum İzni Kartı (eAT)';

  @override
  String get stepSignLease => 'Kira Sözleşmesini İmzala';

  @override
  String get stepSignLeaseNote =>
      'Ev sahibinden Wohnungsgeberbestätigung da iste. Anmeldung için gerekli.';

  @override
  String get stepAnmeldung => 'Adresini Kaydet (Anmeldung)';

  @override
  String get stepAnmeldungNote =>
      'Bürgeramt\'ta, genelde taşındıktan sonraki 14 gün içinde. Randevuyu erken al.';

  @override
  String get stepInsurance => 'Sağlık Sigortası Yaptır';

  @override
  String get stepInsuranceNote =>
      'Sigorta seni üniversiteye bildirir. Ausländerbehörde için kendi belgeni sakla.';

  @override
  String get stepEnroll => 'Üniversiteye Kaydol';

  @override
  String get stepEnrollNote =>
      'Önce dönem ücretini öde. Dönem bileti genelde buna dahildir.';

  @override
  String get stepBank => 'Banka Hesabı Aç';

  @override
  String get stepBankNote => 'Bazı online bankalar Meldebescheinigung istemez.';

  @override
  String get stepBlockedPayout => 'Bloke Hesap Ödemelerini Başlat';

  @override
  String get stepBlockedPayoutNote =>
      'Aylık ödemenin başlaması için bloke hesap sağlayıcına yeni IBAN\'ını ver.';

  @override
  String get stepTaxId => 'Vergi Numaranı Al';

  @override
  String get stepTaxIdNote =>
      'Anmeldung\'dan birkaç hafta sonra postayla gelir. İş için gerekir.';

  @override
  String get stepBroadcastFee => 'Yayın Ücretine Kaydol';

  @override
  String get stepBroadcastFeeNote =>
      'Her ev için tek ücret. Ev arkadaşın zaten ödüyorsa onun numarasını not et.';

  @override
  String get stepPhoto => 'Biyometrik Fotoğraf Çektir';

  @override
  String get stepPhotoNote =>
      'Fotoğraf kabinlerinde ve fotoğrafçılarda çekilir. Birkaç fazla al.';

  @override
  String get stepResidencePermit => 'Oturum İzni Başvurusu Yap';

  @override
  String get stepResidencePermitNote =>
      'Ausländerbehörde\'ye, vizen bitmeden. Son tarihi vizenin bitiş tarihi yap; randevular haftalar sürebilir.';

  @override
  String confirmDoneMissing(int count) {
    return '$count belge hâlâ eksik. Yine de tamamlandı olarak işaretlensin mi?';
  }

  @override
  String get stepDone => 'Tamamlandı';
}
