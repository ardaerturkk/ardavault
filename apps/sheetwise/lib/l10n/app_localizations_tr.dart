// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Sheetwise';

  @override
  String get courses => 'Dersler';

  @override
  String get addCourse => 'Ders Ekle';

  @override
  String get emptyTitle => 'Henüz Ders Yok';

  @override
  String get emptyBody =>
      'Bir dersi, ders sayfasındaki sınav hakkı kuralıyla ekle. Her notlanan ödevden sonra daha ne kadar puan gerektiğini görürsün.';

  @override
  String get listFooter =>
      'En acil olan en üstte. Girdiğin kurallara göre hesaplanır; son söz ders sayfasınındır.';

  @override
  String get loadFailed =>
      'Kayıtlı derslerin okunamadı. Bir kopyası saklandı, hiçbir şeyin üzerine yazılmadı.';

  @override
  String get saveFailed =>
      'Son değişikliğin kaydedilemedi. Sheetwise bir sonraki değişiklikte tekrar dener.';

  @override
  String get ok => 'Tamam';

  @override
  String get cancel => 'Vazgeç';

  @override
  String get save => 'Kaydet';

  @override
  String get edit => 'Düzenle';

  @override
  String get all => 'Tümü';

  @override
  String get increase => 'Artır';

  @override
  String get decrease => 'Azalt';

  @override
  String get discardChanges => 'Değişiklikleri Sil';

  @override
  String get keepEditing => 'Düzenlemeye Devam Et';

  @override
  String get statusAdmitted => 'Sınav hakkı kazanıldı';

  @override
  String get statusOutOfReach => 'Artık yetişmiyor';

  @override
  String get statusNoSheets => 'Henüz ödev yok';

  @override
  String statusNeedPoints(String points, String max) {
    return 'Ödev başına $max üzerinden $points gerekli';
  }

  @override
  String statusNeedShare(String percent) {
    return 'Ödev başına $percent gerekli';
  }

  @override
  String statusPresentations(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sunum kaldı',
      one: '1 sunum kaldı',
    );
    return '$_temp0';
  }

  @override
  String sheetsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ödev kaldı',
      one: '1 ödev kaldı',
      zero: 'Ödev kalmadı',
    );
    return '$_temp0';
  }

  @override
  String sheetName(int number) {
    return 'Ödev $number';
  }

  @override
  String extraSheetName(int number) {
    return 'Ek Ödev $number';
  }

  @override
  String heroPerSheetOf(int count, String max) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'puan ($max üzerinden), kalan $count ödevin her birinde',
      one: 'puan ($max üzerinden), kalan son ödevde',
    );
    return '$_temp0';
  }

  @override
  String heroPerSheetShare(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'puan, kalan $count ödevin her birinde',
      one: 'puan, kalan son ödevde',
    );
    return '$_temp0';
  }

  @override
  String get heroAdmitted => 'Sınav Hakkı Kazanıldı';

  @override
  String get heroAdmittedBody => 'Girdiğin kuralın bütün koşulları sağlandı.';

  @override
  String get heroOutOfReach => 'Artık Yetişmiyor';

  @override
  String outOfReachPoints(String points) {
    return 'Kalan her ödevden tam puan alsan bile $points puan eksik kalıyor.';
  }

  @override
  String outOfReachSheets(int possible, String percent, int required) {
    return 'Yalnızca $possible ödev hâlâ $percent barajını geçebilir, gereken $required.';
  }

  @override
  String heroPresentationsBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'sunum daha gerekli. Puanların yeterli.',
      one: 'sunum daha gerekli. Puanların yeterli.',
    );
    return '$_temp0';
  }

  @override
  String get heroNoSheets => 'Henüz Ödev Yok';

  @override
  String get heroNoSheetsBody =>
      'Nerede olduğunu görmek için bu dersin ödevlerini ekle.';

  @override
  String pointsSoFar(String counted, String total) {
    return '$counted / $total puan';
  }

  @override
  String pointsNeeded(String needed) {
    return '$needed gerekli';
  }

  @override
  String sheetsPassedSoFar(int passed, int required, String percent) {
    return '$required ödevden $passed tanesi en az $percent';
  }

  @override
  String skipNeedPoints(String sheet, String points, String max) {
    return '$sheet atlanırsa: diğer her ödevde $max üzerinden $points.';
  }

  @override
  String skipNeedShare(String sheet, String percent) {
    return '$sheet atlanırsa: diğer her ödevde $percent.';
  }

  @override
  String skipOutOfReach(String sheet) {
    return '$sheet atlanırsa sınav hakkı artık yetişmez.';
  }

  @override
  String skipNoCost(String sheet) {
    return '$sheet atlanırsa hiçbir şey kaybetmezsin.';
  }

  @override
  String enterSheet(String sheet) {
    return '$sheet Notunu Gir';
  }

  @override
  String get ruleHeader => 'Sınav Hakkı Kuralı';

  @override
  String rulePercentAll(String percent) {
    return 'Tüm puanların $percent kadarı';
  }

  @override
  String rulePercentBest(String percent, int count) {
    return 'En iyi $count ödevin $percent kadarı';
  }

  @override
  String rulePoints(String points) {
    return '$points puan';
  }

  @override
  String rulePointsBest(String points, int count) {
    return 'En iyi $count ödevden $points puan';
  }

  @override
  String ruleMinAll(String percent) {
    return 'Her ödevde $percent';
  }

  @override
  String ruleMinCount(String percent, int count) {
    return 'En az $count ödevde $percent';
  }

  @override
  String get presentations => 'Sunumlar';

  @override
  String valueOf(String value, String total) {
    return '$value / $total';
  }

  @override
  String get ruleFooter =>
      'Girdiğin kurala göre hesaplanır. Son söz ders sayfasınındır.';

  @override
  String get met => 'Sağlandı';

  @override
  String get notMetYet => 'Henüz sağlanmadı';

  @override
  String bonusFrom(String percent) {
    return '$percent ve üstüne bonus';
  }

  @override
  String get bonusReached => 'Ulaşıldı';

  @override
  String get addPresentation => 'Sunum Ekle';

  @override
  String get removePresentation => 'Sunumu Kaldır';

  @override
  String get sheetsHeader => 'Ödevler';

  @override
  String get sheetOpen => 'Henüz notlanmadı';

  @override
  String get sheetMissed => 'Teslim edilmedi';

  @override
  String get sheetExcused => 'Mazeretli';

  @override
  String get addSheet => 'Ödev Ekle';

  @override
  String get addExtraSheet => 'Ek Ödev Ekle';

  @override
  String get addSheetMessage =>
      'Ek ödevdeki puanlar sayılır ama tam puanı toplama eklenmez.';

  @override
  String get noteHeader => 'Not';

  @override
  String get points => 'Puan';

  @override
  String ofMax(String max) {
    return '/ $max';
  }

  @override
  String get resultHeader => 'Sonuç';

  @override
  String get stateGraded => 'Notlandı';

  @override
  String get stateOpen => 'Henüz Notlanmadı';

  @override
  String get stateMissed => 'Teslim Edilmedi';

  @override
  String get stateExcused => 'Mazeretli';

  @override
  String get resultFooter =>
      'Teslim edilmeyen ödev sıfır sayılır. Mazeretli ödev toplamdan çıkar.';

  @override
  String get maxPoints => 'Tam Puan';

  @override
  String get extraSheet => 'Ek Ödev';

  @override
  String get extraFooter =>
      'Ek ödevdeki puanlar sayılır ama tam puanı toplama eklenmez.';

  @override
  String get whatIfHeader => 'Ya Şöyle Olursa';

  @override
  String get whatIfSkip => 'Bu Ödevi Atlarsan';

  @override
  String whatIfNeedPoints(String points, String max) {
    return 'Kalan diğer her ödevde $max üzerinden $points gerekirdi.';
  }

  @override
  String whatIfNeedShare(String percent) {
    return 'Kalan diğer her ödevde $percent gerekirdi.';
  }

  @override
  String get whatIfOut => 'Sınav hakkı artık yetişmezdi.';

  @override
  String get whatIfAdmitted => 'Sınav hakkın yine de olurdu.';

  @override
  String get whatIfEnough => 'Puanların yine de yeterdi.';

  @override
  String get whatIfFooter =>
      'Hiçbir şey kaydedilmez; burada yalnızca sayıları görürsün.';

  @override
  String get deleteSheet => 'Ödevi Sil';

  @override
  String get deleteSheetConfirm => 'Bu ödev ve sonucu silinsin mi?';

  @override
  String get pointsInvalid => 'Puanı gir, örneğin 7,5.';

  @override
  String get newCourse => 'Yeni Ders';

  @override
  String get editCourse => 'Dersi Düzenle';

  @override
  String get courseName => 'Ders Adı';

  @override
  String get courseNameHint => 'Örneğin Lineer Cebir';

  @override
  String get sheetCount => 'Ödev Sayısı';

  @override
  String get pointsPerSheet => 'Ödev Başına Puan';

  @override
  String get sheetsFooterNew =>
      'Henüz emin değil misin? Tahmini bir sayı gir. Ödevleri sonra ekleyip çıkarabilirsin.';

  @override
  String get sheetsFooterEdit =>
      'Sonucu olan ödevler burada asla çıkarılmaz; onları tek tek sil.';

  @override
  String get presetsHeader => 'Yaygın Kurallar';

  @override
  String presetHalf(String percent) {
    return 'Tüm Puanların $percent Kadarı';
  }

  @override
  String presetHalfAndMinimum(String percent, String minimum) {
    return 'Tüm Puanların $percent Kadarı, Ödev Başına $minimum';
  }

  @override
  String presetHalfOfBest(String percent) {
    return 'En İyi Ödevlerin $percent Kadarı, 2 Ödev Düşer';
  }

  @override
  String presetMostSheets(String percent) {
    return '2 Ödev Hariç Hepsinde $percent';
  }

  @override
  String get presetsFooter => 'En yakın olanı seç, ayrıntıları aşağıda düzelt.';

  @override
  String get neededKind => 'Toplam';

  @override
  String get kindPercent => 'Oran';

  @override
  String get kindPoints => 'Puan';

  @override
  String get kindNone => 'Yok';

  @override
  String get shareOfPoints => 'Puan Oranı';

  @override
  String get pointsNeededField => 'Gereken Puan';

  @override
  String get bestOnly => 'Yalnızca En İyi Ödevler Sayılır';

  @override
  String get bestCount => 'Sayılan Ödev';

  @override
  String get minEach => 'Ödev Başına Asgari';

  @override
  String get minPercent => 'Ödev Başına Oran';

  @override
  String get minCount => 'Barajı Geçmesi Gereken Ödev';

  @override
  String get presentationsSwitch => 'Sunumlar';

  @override
  String get presentationsNeeded => 'Gereken Sunum';

  @override
  String get ruleEditorFooter =>
      'Kuralı ders sayfasından aktar. Teslim edilmeyen ödev sıfır sayılır; mazeretli ödev toplamdan çıkar.';

  @override
  String get noConditionFooter => 'En az bir koşul seç.';

  @override
  String get invalidFooter =>
      'Bazı sayılar geçersiz. Oranlar en fazla 100 olabilir.';

  @override
  String get bonusHeader => 'Sınav Bonusu';

  @override
  String get addBonusTier => 'Bonus Kademesi Ekle';

  @override
  String get bonusFooter =>
      'İyi ödev sonuçları sınavda bonus getiriyorsa her kademeyi ekle.';

  @override
  String get bonusTierTitle => 'Bonus Kademesi';

  @override
  String get bonusFromField => 'Başlangıç';

  @override
  String get bonusLabelField => 'Bonus';

  @override
  String get bonusLabelHint => 'Örneğin 0,3 not adımı';

  @override
  String get bonusTierFooter =>
      'Bu bonus için gereken, sayılan puanların oranı.';

  @override
  String get deleteBonusTier => 'Bonus Kademesini Sil';

  @override
  String get noteHint => 'Asistan, grup, puanların yayımlandığı yer';

  @override
  String get deleteCourse => 'Dersi Sil';

  @override
  String get deleteCourseConfirm => 'Bu ders ve bütün ödevleri silinsin mi?';
}
