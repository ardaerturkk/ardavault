// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Bayramlaşma';

  @override
  String get tabCalls => 'Aramalar';

  @override
  String get tabPeople => 'Kişiler';

  @override
  String get kindRamazan => 'Ramazan Bayramı';

  @override
  String get kindKurban => 'Kurban Bayramı';

  @override
  String get kindNewYear => 'Yılbaşı';

  @override
  String get kindMothersDay => 'Anneler Günü';

  @override
  String get kindFathersDayTr => 'Babalar Günü';

  @override
  String get kindVatertag => 'Almanya Babalar Günü';

  @override
  String get kindBirthday => 'Doğum günü';

  @override
  String birthdayOf(String name) {
    return 'Doğum günü: $name';
  }

  @override
  String occasionYear(String occasion, String year) {
    return '$occasion $year';
  }

  @override
  String get kindMothersDayNote =>
      'Mayıs ayının ikinci pazarı, Türkiye ve Almanya';

  @override
  String get kindFathersDayTrNote => 'Haziran ayının üçüncü pazarı';

  @override
  String get kindVatertagNote => 'Hristiyanların Göğe Yükseliş günü';

  @override
  String get circleElders => 'Büyükler';

  @override
  String get circleFamily => 'Aile';

  @override
  String get circleFriends => 'Arkadaşlar';

  @override
  String hijriShawwal(int day, int year) {
    return '$day Şevval $year';
  }

  @override
  String hijriDhuAlHijjah(int day, int year) {
    return '$day Zilhicce $year';
  }

  @override
  String get startsTomorrow => 'Yarın';

  @override
  String get arefeToday => 'Bugün arefe, bayram yarın';

  @override
  String dayOf(int day, int total) {
    return 'Bayramın $day. günü';
  }

  @override
  String get today => 'Bugün';

  @override
  String get endedYesterday => 'Dün bitti';

  @override
  String inDays(int count) {
    return '$count gün sonra';
  }

  @override
  String reachedOf(int done, int total) {
    return '$total kişiden $done kişiye ulaşıldı';
  }

  @override
  String peopleCount(int count) {
    return '$count kişi';
  }

  @override
  String leftCount(int count) {
    return '$count kişi kaldı';
  }

  @override
  String get sectionNow => 'Şimdi';

  @override
  String get sectionUpcoming => 'Yaklaşanlar';

  @override
  String get sectionEarlier => 'Geçmiş';

  @override
  String datesFooter(String year) {
    return 'Bayram tarihleri Diyanet takvimine göredir, $year yılı sonuna kadar uygulamada var.';
  }

  @override
  String get noUpcoming => 'Önümüzdeki on iki ayda başka gün yok.';

  @override
  String get emptyCallsTitle => 'İlk Kimi Ararsın?';

  @override
  String emptyCallsBody(String occasion, String date) {
    return 'Bayramda aradığın kişileri ekle, önce büyükleri. Sıradaki: $occasion, $date.';
  }

  @override
  String get addPerson => 'Kişi Ekle';

  @override
  String get sectionReached => 'Ulaşılanlar';

  @override
  String get allReached => 'Herkese ulaşıldı.';

  @override
  String opensOn(String date) {
    return '$date tarihinden itibaren işaretleyebilirsin.';
  }

  @override
  String get nobodyInRound => 'Bu listede artık kimse yok.';

  @override
  String timeIn(String time, String city) {
    return '$city saatiyle $time';
  }

  @override
  String get nightThere => 'Orada gece';

  @override
  String get pickCalled => 'Aradım';

  @override
  String get pickMessaged => 'Mesaj Attım';

  @override
  String get pickVisited => 'Ziyaret Ettim';

  @override
  String statusCalled(String when) {
    return 'Arandı, $when';
  }

  @override
  String statusMessaged(String when) {
    return 'Mesaj atıldı, $when';
  }

  @override
  String statusVisited(String when) {
    return 'Ziyaret edildi, $when';
  }

  @override
  String get markNotReached => 'Ulaşılmadı Olarak İşaretle';

  @override
  String get addNote => 'Not Ekle';

  @override
  String get editNote => 'Notu Düzenle';

  @override
  String get noteHint => 'Sınavları sordu';

  @override
  String get showNumber => 'Numarayı Göster';

  @override
  String get copyNumber => 'Numarayı Kopyala';

  @override
  String get copied => 'Kopyalandı';

  @override
  String get numberHelp =>
      'Telefon uygulamasından ya da mesajlaşma uygulamandan ara.';

  @override
  String markCalledFor(String name) {
    return '$name arandı olarak işaretle';
  }

  @override
  String unmarkFor(String name) {
    return '$name ulaşılmadı olarak işaretle';
  }

  @override
  String get reorder => 'Sırala';

  @override
  String get reorderTitle => 'Sıralama';

  @override
  String get reorderFooter =>
      'Kimin önce geleceğini sürükleyerek seç. Her liste bu sırayı izler.';

  @override
  String dragToReorder(String name) {
    return '$name kişisini taşı';
  }

  @override
  String get eldersFooter => 'Büyükler her listede en üstte.';

  @override
  String get emptyPeopleTitle => 'Henüz Kimse Yok';

  @override
  String get emptyPeopleBody => 'Bayram sabahı ilk aradığın büyüklerle başla.';

  @override
  String get newPerson => 'Yeni Kişi';

  @override
  String get editPerson => 'Kişiyi Düzenle';

  @override
  String get edit => 'Düzenle';

  @override
  String get name => 'İsim';

  @override
  String get nameHint => 'İsim, örneğin Hasan Amca';

  @override
  String get relation => 'Yakınlık';

  @override
  String get relationHint => 'Yakınlık, örneğin amca (isteğe bağlı)';

  @override
  String get phone => 'Telefon';

  @override
  String get phoneHint => 'Telefon numarası (isteğe bağlı)';

  @override
  String get circle => 'Grup';

  @override
  String get city => 'Şehir';

  @override
  String get birthday => 'Doğum Günü';

  @override
  String get noneSet => 'Yok';

  @override
  String get removeBirthday => 'Doğum Gününü Kaldır';

  @override
  String get callOn => 'Aranacak Günler';

  @override
  String get callOnFooter => 'Doğum günü girersen o gün de eklenir.';

  @override
  String get deletePerson => 'Kişiyi Sil';

  @override
  String deletePersonMessage(String name) {
    return '$name silinsin mi? Geçmiş listelerdeki işaretleri de silinir.';
  }

  @override
  String get delete => 'Sil';

  @override
  String get searchCities => 'Ara';

  @override
  String get regionTurkey => 'Türkiye';

  @override
  String get regionGermany => 'Almanya';

  @override
  String get regionElsewhere => 'Diğer Yerler';

  @override
  String get anyTown => 'Başka bir şehir';

  @override
  String get cityFooter =>
      'Türkiye ve Almanya tek saat diliminde, ülkeyi seçmek yeter.';

  @override
  String get noCityFound =>
      'Şehir bulunamadı. Ülkeyi ya da aynı saatteki yakın bir şehri seç.';

  @override
  String get cancel => 'Vazgeç';

  @override
  String get save => 'Kaydet';

  @override
  String get done => 'Bitti';

  @override
  String get ok => 'Tamam';

  @override
  String get discardChanges => 'Değişiklikleri At';

  @override
  String get keepEditing => 'Düzenlemeye Devam Et';

  @override
  String get saveFailed =>
      'Son değişikliğin kaydedilemedi. Biraz yer aç ve tekrar dene.';

  @override
  String get loadFailed =>
      'Kayıtlı listen okunamadı, bu yüzden yeni bir liste başlatıldı. Eski dosya hâlâ bu iPhone\'da.';

  @override
  String dateRange(String from, String to) {
    return '$from - $to';
  }

  @override
  String arefeOn(String date) {
    return 'Arefe $date';
  }

  @override
  String turnsAge(int age) {
    return '$age yaşına giriyor';
  }
}
