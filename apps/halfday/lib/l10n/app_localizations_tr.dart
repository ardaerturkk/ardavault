// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Halfday';

  @override
  String get tabOverview => 'Özet';

  @override
  String get tabShifts => 'Vardiyalar';

  @override
  String get tabPlan => 'Planla';

  @override
  String get tabSettings => 'Ayarlar';

  @override
  String get cancel => 'Vazgeç';

  @override
  String get done => 'Bitti';

  @override
  String get save => 'Kaydet';

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
      'Kayıtlı vardiyaların okunamadı, bu yüzden Halfday boş başladı. Eski dosya hâlâ bu iPhone\'da.';

  @override
  String daysLeftIn(String year) {
    return '$year için kalan gün';
  }

  @override
  String daysOverIn(String year) {
    return '$year içinde sınırın üstünde gün';
  }

  @override
  String usedOfLimit(String used, String limit) {
    return '$limit günün $used günü kullanıldı';
  }

  @override
  String fullAndHalf(int full, int half) {
    return '$full tam gün, $half yarım gün';
  }

  @override
  String upcomingIncluded(int count) {
    return 'Planlanmış $count gün dahil';
  }

  @override
  String get logShift => 'Vardiya Ekle';

  @override
  String overviewFirstHint(String hours) {
    return 'Her vardiya tam gün ($hours üstü) ya da yarım gün sayılır. Üniversitedeki işler sayım dışı bırakılabilir.';
  }

  @override
  String heroFooter(String full, String half) {
    return 'Genel kural: yılda $full tam ya da $half yarım gün. Belirleyici olan oturma iznin ve Yabancılar Dairesi\'dir (Ausländerbehörde).';
  }

  @override
  String customLimitFooter(String full, String half) {
    return 'Senin sınırın: yılda $full tam ya da $half yarım gün, Ayarlar\'da belirlendi. Belirleyici olan oturma iznin ve Yabancılar Dairesi\'dir.';
  }

  @override
  String get sectionThisWeek => 'Bu Hafta';

  @override
  String get hoursThisWeek => 'Bu Haftaki Saat';

  @override
  String ofValue(String used, String limit) {
    return '$used / $limit';
  }

  @override
  String minijobPayIn(String month) {
    return '$month Minijob Kazancı';
  }

  @override
  String get weekFooter =>
      'Tüm işlerdeki saatler, pazartesiden pazara. Haftalık sınır ders döneminde önemlidir.';

  @override
  String get overWeekLimit => 'Haftalık sınırın üstünde';

  @override
  String get overMinijobLimit => 'Minijob sınırının üstünde';

  @override
  String hoursValue(String hours) {
    return '$hours sa';
  }

  @override
  String get oneDay => '1 gün';

  @override
  String daysValue(String days) {
    return '$days gün';
  }

  @override
  String get noShiftsTitle => 'Henüz Vardiya Yok';

  @override
  String get noShiftsBody =>
      'Bir vardiya ekle; burada ay ay, tam ya da yarım gün olarak görünür.';

  @override
  String get statusFull => 'Tam Gün';

  @override
  String get statusHalf => 'Yarım Gün';

  @override
  String get statusNotCounted => 'Sayılmaz';

  @override
  String dayTotal(String hours) {
    return 'o gün toplam $hours';
  }

  @override
  String get upcoming => 'Planlanmış';

  @override
  String get newShift => 'Yeni Vardiya';

  @override
  String get editShift => 'Vardiyayı Düzenle';

  @override
  String get date => 'Tarih';

  @override
  String get job => 'İş';

  @override
  String get hours => 'Saat';

  @override
  String get addAJob => 'İş Ekle';

  @override
  String get countsFull => 'Tam gün sayılır';

  @override
  String get countsHalf => 'Yarım gün sayılır';

  @override
  String get countsNotUniversity => 'Sayılmaz: üniversite işi';

  @override
  String get countsZero => 'Çalışılan saati seç';

  @override
  String withOtherShifts(int count, String hours) {
    return 'O günkü diğer $count vardiyayla birlikte: $hours';
  }

  @override
  String halfDayRule(String hours) {
    return '$hours üstü tam gün sayılır.';
  }

  @override
  String get note => 'Not';

  @override
  String get noteHint => 'Not (isteğe bağlı)';

  @override
  String get deleteShift => 'Vardiyayı Sil';

  @override
  String get deleteShiftConfirm => 'Bu vardiya sayımından çıkarılacak.';

  @override
  String get jobs => 'İşler';

  @override
  String get newJob => 'Yeni İş';

  @override
  String get editJob => 'İşi Düzenle';

  @override
  String get jobNameHint => 'İşin adı';

  @override
  String get jobType => 'Tür';

  @override
  String get kindRegular => 'Normal İş';

  @override
  String get kindRegularInfo => 'Gün sınırına sayılır.';

  @override
  String get kindMinijob => 'Minijob';

  @override
  String get kindMinijobInfo =>
      'Gün sınırına sayılır. Kazanç aylık Minijob sınırıyla karşılaştırılır.';

  @override
  String get kindUniversity => 'Üniversite İşi';

  @override
  String get kindUniversityInfo =>
      'Üniversitede öğrenci asistanı ya da tutor. Genelde sayılmaz.';

  @override
  String get hourlyPay => 'Saatlik Ücret';

  @override
  String get hourlyPayHint => 'Tutar';

  @override
  String get hourlyPayFooter =>
      'Yalnızca aylık Minijob sınırını kontrol etmek için kullanılır.';

  @override
  String get deleteJob => 'İşi Sil';

  @override
  String get deleteJobConfirm => 'Bu iş silinecek.';

  @override
  String deleteJobWithShifts(int count) {
    return 'Bu iş ve ona ait $count vardiya silinecek.';
  }

  @override
  String get addJob => 'İş Ekle';

  @override
  String get planSchedule => 'Program';

  @override
  String get planStart => 'Başlangıç';

  @override
  String get planWeeks => 'Hafta';

  @override
  String get planDaysPerWeek => 'Haftada Gün';

  @override
  String get planHoursPerDay => 'Günde Saat';

  @override
  String weekdaySpan(String count, String first, String last) {
    return '$count ($first–$last)';
  }

  @override
  String planOverTitle(String date) {
    return '$date itibarıyla sınırın üstünde';
  }

  @override
  String planOverBody(String date, String days, String year) {
    return 'Sınır içindeki son planlı günün $date. Plan $year içinde $days fazla.';
  }

  @override
  String planOverBodyNoLast(String year, String days) {
    return '$year sınırı zaten dolmuş. Plan $days fazla.';
  }

  @override
  String planUsedUpTitle(String year) {
    return '$year İçin Gün Kalmadı';
  }

  @override
  String daysOver(String days) {
    return '$days fazla';
  }

  @override
  String get planReachedTitle => 'Kalan Tüm Günleri Kullanır';

  @override
  String planReachedBody(String year, String date) {
    return '$year sınırına $date tarihinde ulaşılır. Sonrasında gün kalmaz.';
  }

  @override
  String get planFitsTitle => 'Sınırın İçinde Kalır';

  @override
  String planFitsBody(String days, String year) {
    return 'Bu plandan sonra $year için $days kalır.';
  }

  @override
  String get planNotCountedTitle => 'Sayılmaz';

  @override
  String get planNotCountedBody => 'Üniversite işleri gün sınırına sayılmaz.';

  @override
  String get planWorkDays => 'Çalışma Günü';

  @override
  String get planAdds => 'Eklenen';

  @override
  String get planLastDay => 'Son Gün';

  @override
  String leftAfterIn(String year) {
    return '$year için kalan';
  }

  @override
  String get addAsShifts => 'Vardiya Olarak Ekle';

  @override
  String addShiftsConfirm(int count, String job) {
    return '$job için $count vardiya kaydına eklenecek.';
  }

  @override
  String addShiftsAction(int count) {
    return '$count Vardiya Ekle';
  }

  @override
  String get planFooter =>
      'Bir varsayım planı. Vardiya olarak ekleyene kadar hiçbir şey kaydedilmez. Planlanan saatler aynı günkü vardiyalara eklenir.';

  @override
  String get planNeedsJob =>
      'Planı vardiya olarak kaydetmek için Ayarlar\'dan bir iş ekle.';

  @override
  String shiftsAdded(int count) {
    return '$count vardiya eklendi';
  }

  @override
  String get limits => 'Sınırlar';

  @override
  String get fullDaysPerYear => 'Yılda Tam Gün';

  @override
  String get halfDayUpTo => 'Yarım Gün Sınırı';

  @override
  String get hoursPerWeek => 'Haftada Saat';

  @override
  String minijobLimitIn(String year) {
    return '$year Minijob Sınırı';
  }

  @override
  String get limitsFooter =>
      'AB dışından gelen öğrenciler için 2026 itibarıyla genel değerler. Kurallar 2024\'te değişti, yine değişebilir. Belirleyici olan oturma iznin ve Yabancılar Dairesi\'dir.';

  @override
  String get restoreTypical => 'Genel Değerlere Dön';

  @override
  String get restoreTypicalConfirm =>
      'Tüm sınırlar 2026 genel değerlerine döner. Vardiyaların olduğu gibi kalır.';

  @override
  String get howItCounts => 'Halfday Nasıl Sayar';

  @override
  String get fullDaysHelp => 'Yarım gün hakkı bunun iki katıdır.';

  @override
  String get halfDayHelp =>
      'Bundan fazla saat çalışılan gün tam gün sayılır. Aynı gündeki vardiyalar toplanır.';

  @override
  String get weeklyHelp =>
      'Özette gösterilir. Ders döneminde daha fazla saat öğrenci statünü etkileyebilir.';

  @override
  String minijobHelp(String year) {
    return '$year için aylık Minijob kazanç sınırı. Sonraki yıllar, sen değiştirene kadar bu değeri kullanır.';
  }

  @override
  String get valueInvalid => 'Sıfırdan büyük bir sayı gir.';

  @override
  String get howFullHalfTitle => 'Tam ve Yarım Gün';

  @override
  String howFullHalfBody(String hours) {
    return 'Halfday her tarihteki sayılan işlerin saatlerini toplar. $hours üstü tam gün, $hours ve altı yarım gündür. Sayım takvim yılına göre yapılır ve 1 Ocak\'ta yeniden başlar. Kalan günler tam gün olarak gösterilir: 118,5, 118 tam gün ve bir yarım gün demektir.';
  }

  @override
  String get howNotCountedTitle => 'Sayılmayanlar';

  @override
  String get howNotCountedBody =>
      'Üniversite İşi olarak işaretlenen işler sayılmaz, çünkü üniversitedeki öğrenci asistanlığı ve tutorluk genelde sayılmaz. İzin ve hastalık günleri de sayılmaz: onları hiç girme.';

  @override
  String get howWeekTitle => 'Haftalık Saat';

  @override
  String howWeekBody(String hours) {
    return 'Ders döneminde haftada $hours üstü çalışmak, örneğin sağlık sigortasında, öğrenci statünü etkileyebilir. Halfday saatleri gösterir, yorumlamaz.';
  }

  @override
  String get howOtherTitle => 'Başka Bir Yöntem';

  @override
  String get howOtherBody =>
      'Bazı Yabancılar Daireleri düzenli yarı zamanlı işi haftada 2,5 gün olarak da sayabiliyor. Halfday bunu hesaplamaz; senin için geçerli olup olmadığını dairene sor.';

  @override
  String get howLegalTitle => 'Hukuki Tavsiye Değildir';

  @override
  String get howLegalBody =>
      'Halfday girdiklerini genel kurallarla sayar. Senin için neyin geçerli olduğuna oturma iznin, ek sayfası ve Yabancılar Dairesi karar verir.';
}
