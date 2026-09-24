# Halfday: Mac'te yapılacaklar

Halfday, AB dışından gelen öğrencinin Almanya'daki çalışma günü hakkını sayar. Her
vardiya tam gün (4 saatten fazla) ya da yarım gün (4 saate kadar) olur, aynı gündeki
vardiyalar toplanır, üniversite işleri (HiWi, tutor) sayım dışı bırakılabilir. Büyük sayı
bu yıl kalan günü gösterir (140 tam / 280 yarım gün). Planla sekmesi "8 hafta, haftada 5
gün, günde 8 saat" gibi bir planın sınırı hangi tarihte aşacağını söyler. Bütün sınırlar
Ayarlar'dan değiştirilebilir. Tamamen çevrimdışı, hesap yok, veri toplamıyor. İngilizce,
Almanca, Türkçe. Hukuki tavsiye değil; metinler bunu sakin bir dille söylüyor.

Sürüm: 1.0.0 (build 1). Bundle ID: `com.arda.halfday`. Ana ekrandaki ad: Halfday.

## 1. Kodu al ve Xcode'da aç

Gerekenler: güncel Xcode, Flutter stable 3.47.5 veya daha yenisi (`flutter --version`).
CocoaPods gerekmiyor, proje Swift Package Manager kullanıyor. Flutter'ında bu kapalıysa
(Xcode "FlutterGeneratedPluginSwiftPackage bulunamadı" derse) bir kez şunu çalıştır:
`flutter config --enable-swift-package-manager`, sonra aşağıdaki komutları tekrarla.

    git clone -b claude/app-studio --single-branch https://github.com/ardaerturkk/ardavault.git app-studio
    cd app-studio/apps/halfday
    flutter pub get
    flutter build ios --config-only --release
    open ios/Runner.xcworkspace

Zaten klonladıysan: `cd app-studio && git pull`, sonra `cd apps/halfday` ve yukarıdaki
son üç komut.

## 2. İstersen önce simülatörde dene (5 dakika)

    open -a Simulator        # iPhone 17 Pro Max (veya 16 Pro Max) seç
    flutter run

Bakılacak akış:
1. Özet (Overview) ekranında 140 yazmalı. Log Shift > Add a Job > bir ad yaz > Save.
2. Saat çarkı 4 saatte: "Counts as a half day" yazmalı. Save. Sayı 139.5 olur.
3. Bir vardiya daha ekle, aynı gün, 2 saat: "Together with 1 other shift that day: 6 h"
   ve "Counts as a full day" görünmeli. Save: sayı 139 olur.
4. Plan sekmesi: sonuç en üstte, "Fits Within the Limit" yazmalı. Weeks'i 20 yap: plan
   2027'ye taşar, altta "Left in 2027" satırı da görünür.
5. Ayarlar > Full Days per Year: 50 yap. Özet'teki sayı hemen güncellenmeli ve Plan
   sekmesindeki sonuç kırmızıya dönmeli ("Over the Limit from ..."). Restore Typical
   Values ile geri al.
6. Telefonun dilini Almanca veya Türkçe yap, metinlere göz at.

## 3. Arşivle ve yükle

1. Xcode'da sol üstte Runner projesi > TARGETS: Runner > Signing & Capabilities.
2. "Automatically manage signing" açık, Team: kendi takımın.
3. Bundle Identifier `com.arda.halfday` olmalı (öneki değiştirmek istersen bana yaz,
   ben her yerde değiştiririm).
4. Üstteki cihaz seçiminde: Any iOS Device (arm64).
5. Product > Archive. Bitince Organizer açılır: Distribute App > App Store Connect > Upload.

## 4. App Store Connect'te yeni uygulama

My Apps > + > New App:

- Platform: iOS
- Name: `Halfday: Student Work Days` (alınmışsa: `Halfday: Work Day Counter`)
- Primary Language: English (U.S.)
- Bundle ID: com.arda.halfday
- SKU: `halfday-001`
- User Access: Full Access

İsim notu: App Store'da "Halfday" adında bir uygulama bulamadım (24.09.2026). Benzer
adlar var: "Little Halfday" (kedili odak uygulaması), "Halfway", "HALF-TIME". Tam ad
"Halfday: Student Work Days" olduğu için karışmaz, ama yüklemeden önce bir kez ara.

App Information:
- Category: Primary **Productivity**, Secondary **Education**
- Content Rights: "does not contain, show, or access third-party content"
- Age Rating: tüm sorulara "None" / "No" (sonuç 4+)
- Localizations: English (U.S.) ana dil; German ve Turkish ekle.

App Privacy:
- Privacy Policy URL: `site/halfday/privacy.md` dosyasını herkese açık bir yerde yayınla
  (en kolayı: gist.github.com'da public gist, içeriği yapıştır) ve linki gir.
- Data Collection: **"No, we do not collect data from this app"** > sonuç "Data Not Collected".

Pricing and Availability: Free. Availability: tüm ülkeler, **China mainland hariç**.

Sürüm sayfası (1.0), her dil için dosyalar `apps/halfday/store/<dil>/` içinde:
- `name.txt`, `subtitle.txt`, `promotional_text.txt`, `description.txt`, `keywords.txt`
  (en-US, de-DE, tr)
- Support URL: `site/halfday/support.md` için de bir gist aç. Yayınlamadan önce en alta
  kendi iletişim e-postanı ekle (bilerek boş bıraktım, e-postanı yayınlamak senin kararın).
- Copyright: `2026 <Adın Soyadın>`
- App Review Information: Sign-in required **kapalı**. Notes kısmına
  `store/en-US/review_notes.txt` içeriğini yapıştır.
- Export compliance: Info.plist'te `ITSAppUsesNonExemptEncryption = false` var, soru
  sorulmayacak.

## 5. Ekran görüntüleri (6.9 inç, 1320x2868)

Hazır olanlar: `apps/halfday/store/screenshots/<dil>/` (en-US, de-DE, tr), her dilde 5
görüntü (Özet, vardiya düzenleme, vardiya listesi, sınırı aşan plan, Ayarlar), tam
1320x2868, alfasız. Uygulamanın gerçek ekranları, ama bulutta render edildi: yazı tipi
San Francisco yerine Roboto, üstte durum çubuğu yok. Yüklemek için yeterli; daha iyisini
istersen:

A) Mac'te gerçek simülatör görüntüleri (önerilen, 5 dk). iPhone 17 Pro Max (veya 16 Pro
Max) simülatörü açıkken `apps/halfday` içinde:

    for l in en de tr; do
      SCREENSHOT_DIR=../../ci-screens/$l flutter drive \
        --driver=test_driver/integration_test.dart \
        --target=integration_test/app_test.dart \
        -d "iPhone 17 Pro Max" --dart-define=SCREENSHOT_LOCALE=$l
    done

Görüntüler `app-studio/ci-screens/<dil>/` içine gelir. Bu test ayrıca gerçek dosya
kaydını doğrular. Bu test henüz hiç iOS'ta koşmadı; hata verirse bana yaz.

B) GitHub'ın macOS makinesinde (ücretsiz dakikalardan ~15 dk):

    git tag ios-check-halfday-1 && git push origin ios-check-halfday-1

Actions > ios-check: release build, simülatör testi, ekran görüntüleri
`ci/screenshots/halfday` branch'ine gelir.

## Bulutta doğrulanamayanlar

- `flutter build ios` ve Xcode arşivi (Linux'ta mümkün değil). Proje ayarları betikle
  kontrol edildi: iPhone only, sadece dikey, tek deployment target (iOS 15.0),
  PrivacyInfo.xcprivacy Runner kaynaklarında, ikon 1024 alfasız.
- Integration test (gerçek dosya kaydı + ekran görüntüleri) iOS'ta hiç koşmadı.
- Gerçek San Francisco fontuyla görünüm: testlerde Roboto kullanıldı; düzen 2x yazı
  boyutunda da kontrol edildi.
- Saat çarkı (CupertinoTimerPicker) ve tarih çarkı gerçek cihazda kaydırılarak denenmedi.
- VoiceOver ve haptic geri bildirim gerçek cihazda denenmedi.
- Kurallar (140/280 gün, 4 saat, Minijob 603/633 EUR) 2026 itibarıyla genel bilgiye
  göre girildi; hepsi Ayarlar'dan değiştirilebilir. Kiel Ausländerbehörde'sinin kendi
  uygulaması (ör. haftada 2,5 gün yöntemi) farklı olabilir; uygulama bunu "How Halfday
  Counts" sayfasında açıkça söylüyor ama hesaplamıyor.
