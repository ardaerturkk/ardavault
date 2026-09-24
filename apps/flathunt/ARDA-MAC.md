# Flatboard: Mac'te yapılacaklar

Flatboard, ev/oda aramasını tek listede toplar: WG-Gesucht, Kleinanzeigen, ImmoScout24,
Facebook grupları, Studentenwerk, arkadaşlar, hangi kaynaktan olursa olsun. Her ev
İlgileniyorum > Yazıldı > Ev Gezme > Başvuruldu > Kabul/Ret aşamalarından geçer; ev gezme
saatleri, aylık ve m² başına sıcak kira karşılaştırması ve her ev için kısa bir
dolandırıcılık kontrol listesi var. Tamamen çevrimdışı, hesap yok, veri toplamıyor.
Bağlantılar yalnızca metin olarak saklanır (kopyalanabilir, uygulama açmaz). İngilizce,
Almanca, Türkçe.

Sürüm: 1.0.0 (build 1). Bundle ID: `com.arda.flathunt`. Ekranda görünen ad: Flatboard.

## 1. Kodu al ve Xcode'da aç

Gerekenler: güncel Xcode, Flutter stable 3.47.5 veya daha yenisi (`flutter --version`).
CocoaPods gerekmiyor, proje Swift Package Manager kullanıyor. Flutter'ında bu kapalıysa
(Xcode "FlutterGeneratedPluginSwiftPackage bulunamadı" derse) bir kez şunu çalıştır:
`flutter config --enable-swift-package-manager`, sonra aşağıdaki komutları tekrarla.

    git clone -b claude/app-studio --single-branch https://github.com/ardaerturkk/ardavault.git app-studio
    cd app-studio/apps/flathunt
    flutter pub get
    flutter build ios --config-only --release
    open ios/Runner.xcworkspace

Zaten klonladıysan: `cd app-studio && git pull`, sonra `cd apps/flathunt` ve yukarıdaki
son üç komut.

## 2. İstersen önce simülatörde dene (5 dakika)

    open -a Simulator        # iPhone 17 Pro Max (veya 16 Pro Max) seç
    flutter run

Bakılacak akış: Boş ekranda "Add Flat" > başlık, Warm Rent 450, Size 18 > Save.
Evi aç > "Mark as Messaged" > "Schedule Viewing" > bir saat seç > Done. Liste "Viewing"
bölümünde yeşil tarihi göstermeli. Compare sekmesinde "Per m²" seç. Evin sayfasında
"Safety Checks" maddelerine dokun, "Copy Link" ile bağlantıyı kopyala.

## 3. Arşivle ve yükle

1. Xcode'da sol üstte Runner projesi > TARGETS: Runner > Signing & Capabilities.
2. "Automatically manage signing" açık, Team: kendi takımın.
3. Bundle Identifier `com.arda.flathunt` olmalı (öneki değiştirmek istersen bana yaz,
   ben her yerde değiştiririm).
4. Üstteki cihaz seçiminde: Any iOS Device (arm64).
5. Product > Archive. Bitince Organizer açılır: Distribute App > App Store Connect > Upload.

## 4. App Store Connect'te yeni uygulama

My Apps > + > New App:

- Platform: iOS
- Name: `Flatboard: Flat Hunt Tracker` (isim alınmışsa: `Flatboard: Room Hunt Tracker`)
- Primary Language: English (U.S.)
- Bundle ID: com.arda.flathunt
- SKU: `flathunt-001`
- User Access: Full Access

App Information:
- Category: Primary **Productivity**, Secondary **Lifestyle**
- Content Rights: "does not contain, show, or access third-party content"
- Age Rating: tüm sorulara "None" / "No" (sonuç 4+)
- Localizations: English (U.S.) ana dil; German ve Turkish ekle.

App Privacy:
- Privacy Policy URL: `site/flathunt/privacy.md` dosyasını herkese açık bir yerde yayınla
  (en kolayı: gist.github.com'da public gist, içeriği yapıştır) ve linki gir.
- Data Collection: **"No, we do not collect data from this app"** > sonuç "Data Not Collected".

Pricing and Availability: Free. Availability: tüm ülkeler, **China mainland hariç**.

Sürüm sayfası (1.0), her dil için dosyalar `apps/flathunt/store/<dil>/` içinde:
- `name.txt`, `subtitle.txt`, `promotional_text.txt`, `description.txt`, `keywords.txt`
  (en-US, de-DE, tr)
- Support URL: `site/flathunt/support.md` için de bir gist aç. Yayınlamadan önce en alta
  kendi iletişim e-postanı ekle (bilerek boş bıraktım, e-postanı yayınlamak senin kararın).
- Copyright: `2026 <Adın Soyadın>`
- App Review Information: Sign-in required **kapalı**. Notes kısmına
  `store/en-US/review_notes.txt` içeriğini yapıştır.
- Export compliance: Info.plist'te `ITSAppUsesNonExemptEncryption = false` var, soru
  sorulmayacak.

Not: Mağaza metinlerinde portal markalarını (WG-Gesucht, ImmoScout24, Facebook...)
bilerek kullanmadım (App Review marka kullanımına takılabilir). Uygulamanın içinde
yalnızca "kaynak" seçeneği olarak geçiyorlar.

## 5. Ekran görüntüleri (6.9 inç, 1320x2868)

Hazır olanlar: `apps/flathunt/store/screenshots/<dil>/` (en-US, de-DE, tr), her dilde 5
görüntü (liste, ev sayfası, güvenlik kontrolü, aylık ve m² karşılaştırma), tam 1320x2868,
alfasız. Uygulamanın gerçek ekranları ama bulutta render edildi: yazı tipi San Francisco
yerine Roboto, üstte durum çubuğu yok. Yüklemek için yeterli; daha iyisini istersen:

A) Mac'te gerçek simülatör görüntüleri (önerilen, 5 dk). iPhone 17 Pro Max (veya 16 Pro
Max) simülatörü açıkken `apps/flathunt` içinde:

    for l in en de tr; do
      SCREENSHOT_DIR=../../ci-screens/flathunt/$l flutter drive \
        --driver=test_driver/integration_test.dart \
        --target=integration_test/app_test.dart \
        -d "iPhone 17 Pro Max" --dart-define=SCREENSHOT_LOCALE=$l
    done

Görüntüler `app-studio/ci-screens/flathunt/<dil>/` içine gelir. Bu test ayrıca gerçek
dosya kaydını doğrular. Bu test bulutta hiç koşmadı (cihaz/simülatör yok); hata verirse
bana yaz.

B) GitHub'ın macOS makinesinde (ücretsiz dakikalardan ~15 dk):

    git tag ios-check-flathunt-1 && git push origin ios-check-flathunt-1

Actions > ios-check: release build, simülatör testi, ekran görüntüleri
`ci/screenshots/flathunt` branch'ine gelir.

## Bulutta doğrulanamayanlar

- `flutter build ios` ve Xcode arşivi (Linux'ta mümkün değil). Proje ayarları betikle
  kontrol edildi: iPhone only, sadece dikey, tek deployment target (iOS 15.0),
  PrivacyInfo.xcprivacy Runner kaynaklarında, ikon 1024 alfasız.
- Entegrasyon testi (`integration_test/app_test.dart`) hiç çalıştırılmadı.
- Gerçek San Francisco fontuyla görünüm: testlerde Roboto kullanıldı; düzen 2x yazı
  boyutunda da kontrol edildi.
- "Copy Link" sonrası panonun gerçek cihazda dolduğu (testte sahte kanal ile doğrulandı).
- Sayı klavyesinde ondalık ayıracı: Almanca/Türkçe klavye virgül verir, uygulama hem
  virgülü hem noktayı kabul eder (testli), ama gerçek klavyede denenmedi.
- VoiceOver ve haptic geri bildirim gerçek cihazda denenmedi.
- "Flatboard" isminin App Store'da boş olup olmadığı (web aramasında aynı isimli
  uygulama çıkmadı).
