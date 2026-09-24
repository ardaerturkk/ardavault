// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Sagbar';

  @override
  String get tabSituations => 'Durumlar';

  @override
  String get tabMe => 'Bilgilerim';

  @override
  String get startTitle => 'Bilgilerini Bir Kez Gir';

  @override
  String get startBody =>
      'Adın, adresin ve numaraların her Almanca cümleye kendiliğinden yerleşir.';

  @override
  String get startButton => 'Bilgilerimi Gir';

  @override
  String get situationsFooter =>
      'Gişe ve telefon için gündelik cümleler. Hukuki tavsiye değildir.';

  @override
  String appointmentOn(String date) {
    return 'Randevu $date';
  }

  @override
  String get fillMissing => 'Eksik Bilgileri Tamamla';

  @override
  String missingList(String names) {
    return 'Eksik: $names';
  }

  @override
  String get visitHeader => 'Bu Randevu';

  @override
  String get appointment => 'Randevu';

  @override
  String get removeAppointment => 'Randevuyu Kaldır';

  @override
  String get refFooter => 'Mektubundaki veya randevu onayındaki numara.';

  @override
  String get notSet => 'Belirtilmedi';

  @override
  String get linesHeader => 'Cümleler';

  @override
  String get linesFooter =>
      'Bir cümleye dokun, büyük yazıyla göster. Kopyalamak veya gizlemek için basılı tut.';

  @override
  String get noLines =>
      'Burada cümle yok. Kendi cümleni ekle veya gizlenenleri göster.';

  @override
  String get addLine => 'Kendi Cümleni Ekle';

  @override
  String showHidden(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Gizli Cümleyi Göster',
      one: '1 Gizli Cümleyi Göster',
    );
    return '$_temp0';
  }

  @override
  String get showCards => 'Kart Olarak Göster';

  @override
  String get yourLine => 'Senin cümlen';

  @override
  String get copy => 'Kopyala';

  @override
  String get copied => 'Kopyalandı';

  @override
  String get hideLine => 'Cümleyi Gizle';

  @override
  String get editLine => 'Cümleyi Düzenle';

  @override
  String get deleteLine => 'Cümleyi Sil';

  @override
  String get deleteLineConfirm => 'Bu cümle silinecek.';

  @override
  String get newLine => 'Yeni Cümle';

  @override
  String get germanLabel => 'Almanca';

  @override
  String get germanHint => 'Söylemek istediğin, Almanca';

  @override
  String get meaningLabel => 'Anlamı';

  @override
  String get meaningHint => 'Ne anlama geldiği (isteğe bağlı)';

  @override
  String get lineEditorFooter =>
      'Cümleni söylemek istediğin gibi yaz. Kendi cümlelerine bilgilerin otomatik eklenmez.';

  @override
  String cardOf(int index, int total) {
    return '$index / $total';
  }

  @override
  String get previousLine => 'Önceki Cümle';

  @override
  String get nextLine => 'Sonraki Cümle';

  @override
  String get aboutYou => 'Kişisel';

  @override
  String get contact => 'İletişim';

  @override
  String get numbers => 'Numaralar';

  @override
  String get meFooter =>
      'Yalnızca bu iPhone’da saklanır. Sagbar bunları Almanca cümlelerine yerleştirir.';

  @override
  String get fieldName => 'Ad Soyad';

  @override
  String get fieldBirthDate => 'Doğum Tarihi';

  @override
  String get fieldAddress => 'Adres';

  @override
  String get fieldPhone => 'Telefon';

  @override
  String get fieldEmail => 'E-posta';

  @override
  String get fieldInsurer => 'Sağlık Sigortası';

  @override
  String get fieldInsuranceNumber => 'Sigorta Numarası';

  @override
  String get fieldStudentId => 'Öğrenci Numarası';

  @override
  String get fieldTime => 'Randevu Saati';

  @override
  String get fieldDate => 'Randevu Tarihi';

  @override
  String get hintName => 'Pasaportundaki gibi';

  @override
  String get hintAddress => 'Sokak ve numara, posta kodu ve şehir';

  @override
  String get hintPhone => 'Cep telefonu numaran';

  @override
  String get hintEmail => 'ad@ornek.com';

  @override
  String get hintInsurer => 'Örneğin TK veya AOK';

  @override
  String get hintInsuranceNumber => 'Sağlık kartının üzerinde';

  @override
  String get hintStudentId => 'Öğrenci kimlik kartının üzerinde';

  @override
  String get footerName =>
      '“Mein Name ist …” gibi cümlelerde ve harf harf söylerken kullanılır.';

  @override
  String get footerAddress =>
      'Almanya’daki gibi yaz: Holtenauer Straße 12, 24105 Kiel.';

  @override
  String get removeBirthDate => 'Doğum Tarihini Kaldır';

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
  String listAnd(String first, String last) {
    return '$first ve $last';
  }

  @override
  String get loadFailed =>
      'Kayıtlı bilgilerin okunamadı. Bir kopyası saklandı ve Sagbar boş başladı.';

  @override
  String get saveFailed =>
      'Son değişiklik kaydedilemedi. Sagbar bir sonraki değişiklikte yeniden deneyecek.';

  @override
  String get semLineHint => 'Cümleyi büyük yazıyla gösterir';

  @override
  String semMissing(String name) {
    return 'eksik: $name';
  }
}
