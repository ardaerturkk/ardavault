// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Flatboard';

  @override
  String get tabFlats => 'Evler';

  @override
  String get tabCompare => 'Karşılaştır';

  @override
  String get stageInterested => 'İlgileniyorum';

  @override
  String get stageMessaged => 'Mesaj Atıldı';

  @override
  String get stageViewing => 'Ev Gezme';

  @override
  String get stageApplied => 'Başvuruldu';

  @override
  String get stageAccepted => 'Kabul Edildi';

  @override
  String get stageDeclined => 'Reddedildi';

  @override
  String get actionMessaged => 'Mesaj Attım';

  @override
  String get actionViewing => 'Ev Gezme Randevusu Ekle';

  @override
  String get actionApplied => 'Başvurdum';

  @override
  String get actionAnswer => 'Cevabı Kaydet';

  @override
  String get answerQuestion => 'Evi aldın mı?';

  @override
  String get answerAccepted => 'Kabul Edildi';

  @override
  String get answerDeclined => 'Reddedildi';

  @override
  String get sourceWgGesucht => 'WG-Gesucht';

  @override
  String get sourceKleinanzeigen => 'Kleinanzeigen';

  @override
  String get sourceImmoscout => 'ImmoScout24';

  @override
  String get sourceFacebook => 'Facebook Grubu';

  @override
  String get sourceStudentenwerk => 'Studentenwerk';

  @override
  String get sourceFriends => 'Arkadaşlar';

  @override
  String get sourceOther => 'Diğer';

  @override
  String get emptyFlatsTitle => 'Henüz Ev Yok';

  @override
  String get emptyFlatsBody =>
      'Beğendiğin her evi ekle, hangi siteden ya da gruptan olursa olsun. Sonra yazdıkça, gezdikçe ve başvurdukça ilerlet.';

  @override
  String get addFlat => 'Ev Ekle';

  @override
  String warmShort(String amount) {
    return '$amount sıcak';
  }

  @override
  String sizeShort(String size) {
    return '$size m²';
  }

  @override
  String viewingOn(String date) {
    return 'Ev gezme $date';
  }

  @override
  String viewedOn(String date) {
    return 'Gezildi $date';
  }

  @override
  String get noViewingTime => 'Henüz randevu yok';

  @override
  String addedOn(String date) {
    return 'Eklendi $date';
  }

  @override
  String messagedOn(String date) {
    return 'Mesaj atıldı $date';
  }

  @override
  String appliedOn(String date) {
    return 'Başvuruldu $date';
  }

  @override
  String acceptedOn(String date) {
    return 'Kabul edildi $date';
  }

  @override
  String declinedOn(String date) {
    return 'Reddedildi $date';
  }

  @override
  String get stage => 'Aşama';

  @override
  String get viewing => 'Ev Gezme';

  @override
  String get notSet => 'Belirlenmedi';

  @override
  String get rent => 'Kira';

  @override
  String get warmRent => 'Sıcak Kira';

  @override
  String get coldRent => 'Soğuk Kira';

  @override
  String get size => 'Büyüklük';

  @override
  String get perSqm => 'm² Başına Sıcak';

  @override
  String get rentFooter =>
      'Sıcak kira (Warmmiete) ısınma ve yan giderleri (Nebenkosten) içerir.';

  @override
  String get listing => 'İlan';

  @override
  String get source => 'Kaynak';

  @override
  String get link => 'Bağlantı';

  @override
  String get copyLink => 'Bağlantıyı Kopyala';

  @override
  String get linkCopied => 'Bağlantı kopyalandı.';

  @override
  String get district => 'Semt';

  @override
  String get notes => 'Notlar';

  @override
  String get checksHeader => 'Güvenlik Kontrolü';

  @override
  String get checkViewed => 'Evi kendin yerinde gördün';

  @override
  String get checkNoPrepay =>
      'Ev gezmeden ve imzalı sözleşme olmadan depozito ya da kira ödenmez';

  @override
  String get checkAccountInName =>
      'Ödeme yalnızca ev sahibine banka havalesiyle, yurt dışına ya da nakit para transfer servisleriyle değil';

  @override
  String get checkIdLater =>
      'Kimlik fotokopisi ancak sözleşme imzaya hazır olunca';

  @override
  String get checkPlausible =>
      'Kira, semte ve büyüklüğe uygun, benzer evlerin çok altında değil';

  @override
  String get checksFooter =>
      'Her maddeyi doğruladıktan sonra işaretle. Biri tutmuyorsa bu sık görülen bir uyarı işaretidir: Para ödemeden ya da belge göndermeden önce Studentenwerk\'e veya yerel kiracılar derneğine (Mieterverein) danış.';

  @override
  String get semCheckHint => 'Bu maddeyi doğrulandı olarak işaretler';

  @override
  String get edit => 'Düzenle';

  @override
  String get newFlat => 'Yeni Ev';

  @override
  String get editFlat => 'Evi Düzenle';

  @override
  String get title => 'Başlık';

  @override
  String get titleHint => 'Örneğin: Kampüse Yakın Oda';

  @override
  String get linkHint => 'İlan bağlantısını yapıştır';

  @override
  String get optional => 'İsteğe bağlı';

  @override
  String get districtHint => 'Örneğin: Gaarden';

  @override
  String get notesHint => 'İletişim, sorular, yanına alacakların';

  @override
  String get deleteFlat => 'Evi Sil';

  @override
  String get deleteFlatConfirm => 'Bu ev listenden kaldırılacak.';

  @override
  String get invalidAmount =>
      'Tutarları 480 ya da 480,50 gibi, büyüklüğü 18 ya da 18,5 gibi gir.';

  @override
  String get save => 'Kaydet';

  @override
  String get cancel => 'Vazgeç';

  @override
  String get done => 'Bitti';

  @override
  String get ok => 'Tamam';

  @override
  String get discardChanges => 'Değişiklikleri At';

  @override
  String get keepEditing => 'Düzenlemeye Devam Et';

  @override
  String get viewingTime => 'Ev Gezme Zamanı';

  @override
  String get setTimeLater => 'Zamanı Sonra Gir';

  @override
  String get removeViewing => 'Randevuyu Kaldır';

  @override
  String get perMonthSeg => 'Aylık';

  @override
  String get perSqmSeg => 'm² Başına';

  @override
  String get compareEmptyTitle => 'Henüz Karşılaştıracak Bir Şey Yok';

  @override
  String get compareEmptyBody =>
      'Evlerine sıcak kirayı ekle, en ucuzundan başlayarak yan yana gör.';

  @override
  String get compareFooter => 'En ucuz en üstte. Reddedilen evler dahil değil.';

  @override
  String get notCompared => 'Karşılaştırılmayanlar';

  @override
  String get missingWarm => 'Sıcak kira eksik';

  @override
  String get missingSize => 'Büyüklük eksik';

  @override
  String get missingBoth => 'Sıcak kira ve büyüklük eksik';

  @override
  String get cheapest => 'En ucuz';

  @override
  String moreThanCheapest(String amount) {
    return '$amount fazla';
  }

  @override
  String get chooseStage => 'Bu evi başka bir aşamaya taşı.';

  @override
  String get loadFailed =>
      'Kayıtlı evlerin okunamadı, bu yüzden yeni bir liste başlatıldı. Eski dosya hâlâ bu iPhone\'da.';

  @override
  String get saveFailed =>
      'Son değişikliğin kaydedilemedi. Biraz yer aç ve tekrar dene.';

  @override
  String get addRent => 'Kira ve Büyüklük Ekle';

  @override
  String get sizeSqmLabel => 'Büyüklük (m²)';
}
