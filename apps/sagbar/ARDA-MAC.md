# Sagbar: Mac'te yapılacaklar

Sagbar, Almanya'daki resmi dairelerde ve telefonda söyleyeceklerini önceden hazırlar.
Bilgilerini (ad, doğum tarihi, adres, sigorta numarası, Matrikelnummer...) bir kez
girersin; 8 durumda (Allgemein, Bürgeramt, Ausländerbehörde, Bank, Krankenkasse,
Arztpraxis, Vermieter, Hochschule) kibar Almanca cümleler bu bilgilerle dolu gelir, altında
İngilizce veya Türkçe anlamı yazar. Bir cümleye dokununca ekranı büyük yazıyla kaplar,
gişede gösterebilirsin. Tamamen çevrimdışı, hesap yok, veri toplamıyor. İngilizce,
Almanca, Türkçe.

Sürüm: 1.0.0 (build 1). Bundle ID: `com.arda.sagbar`.

## 1. Kodu al ve Xcode'da aç

Gerekenler: güncel Xcode, Flutter stable 3.47.5 veya daha yenisi (`flutter --version`).
CocoaPods gerekmiyor, proje Swift Package Manager kullanıyor. Flutter'ında bu kapalıysa
(Xcode "FlutterGeneratedPluginSwiftPackage bulunamadı" derse) bir kez şunu çalıştır:
`flutter config --enable-swift-package-manager`, sonra aşağıdaki komutları tekrarla.

    git clone -b claude/app-studio --single-branch https://github.com/ardaerturkk/ardavault.git app-studio
    cd app-studio/apps/sagbar
    flutter pub get
    flutter build ios --config-only --release
    open ios/Runner.xcworkspace

Zaten klonladıysan: `cd app-studio && git pull`, sonra yukarıdaki son üç komut
(`cd apps/sagbar` içinden).

## 2. İstersen önce simülatörde dene (5 dakika)

    open -a Simulator        # iPhone 17 Pro Max (veya 16 Pro Max) seç
    flutter run

Bakılacak akış: Situations sekmesinde "Add My Details" > Full Name > adını yaz > Save.
Situations'a dön, "Bürgeramt"ı aç: eksik bilgiler üstte listelenir. Appointment ve
Vorgangsnummer gir, cümlelerde turuncu olarak görünmeli. "Show Cards" > oklarla
cümleler arasında gez > "Copy". Bir cümleye basılı tut: Copy / Hide Line.

Özellikle kontrol etmeni istediğim şey: **Almanca cümleler.** Kiel'de bir Almanla veya
gişede kulağa doğal gelip gelmediklerine bak; tuhaf olan varsa bana cümleyi yaz, düzeltirim.
Cümlelerin hepsi `lib/model/content.dart` içinde.

## 3. Arşivle ve yükle

1. Xcode'da sol üstte Runner projesi > TARGETS: Runner > Signing & Capabilities.
2. "Automatically manage signing" açık, Team: kendi takımın.
3. Bundle Identifier `com.arda.sagbar` olmalı (öneki değiştirmek istersen bana yaz,
   ben her yerde değiştiririm).
4. Üstteki cihaz seçiminde: Any iOS Device (arm64).
5. Product > Archive. Bitince Organizer açılır: Distribute App > App Store Connect > Upload.

## 4. App Store Connect'te yeni uygulama

My Apps > + > New App:

- Platform: iOS
- Name: `Sagbar: German for Offices` (isim alınmışsa: `Sagbar: Office German Lines`)
- Primary Language: English (U.S.)
- Bundle ID: com.arda.sagbar
- SKU: `sagbar-001`
- User Access: Full Access

App Information:
- Category: Primary **Reference**, Secondary **Education**
- Content Rights: "does not contain, show, or access third-party content"
- Age Rating: tüm sorulara "None" / "No" (sonuç 4+)
- Localizations: English (U.S.) ana dil; German ve Turkish ekle.

App Privacy:
- Privacy Policy URL: `site/sagbar/privacy.md` dosyasını herkese açık bir yerde yayınla
  (en kolayı: gist.github.com'da public gist, içeriği yapıştır) ve linki gir.
- Data Collection: **"No, we do not collect data from this app"** > sonuç "Data Not Collected".
  (Kişisel bilgiler sadece cihazda kalıyor, hiçbir yere gönderilmiyor; Apple'ın tanımında
  bu "toplama" sayılmaz.)

Pricing and Availability: Free. Availability: tüm ülkeler, **China mainland hariç**.

Sürüm sayfası (1.0), her dil için dosyalar `apps/sagbar/store/<dil>/` içinde:
- `name.txt`, `subtitle.txt`, `promotional_text.txt`, `description.txt`, `keywords.txt`
  (en-US, de-DE, tr)
- Support URL: `site/sagbar/support.md` için de bir gist aç. Yayınlamadan önce en alta
  kendi iletişim e-postanı ekle (bilerek boş bıraktım, e-postanı yayınlamak senin kararın).
- Copyright: `2026 <Adın Soyadın>`
- App Review Information: Sign-in required **kapalı**. Notes kısmına
  `store/en-US/review_notes.txt` içeriğini yapıştır.
- Export compliance: Info.plist'te `ITSAppUsesNonExemptEncryption = false` var, soru
  sorulmayacak.

## 5. Ekran görüntüleri (6.9 inç, 1320x2868)

Hazır olanlar: `apps/sagbar/store/screenshots/<dil>/` (en-US, de-DE, tr), her dilde 5
görüntü (Bürgeramt cümleleri, büyük kart, durum listesi, Krankenkasse, bilgilerim), tam
1320x2868, alfasız. Uygulamanın gerçek ekranları ama bulutta render edildi: yazı tipi San
Francisco yerine Roboto, üstte durum çubuğu yok. Yüklemek için yeterli; daha iyisini
istersen:

A) Mac'te gerçek simülatör görüntüleri (önerilen, 5 dk). iPhone 17 Pro Max (veya 16 Pro
Max) simülatörü açıkken `apps/sagbar` içinde:

    for l in en de tr; do
      SCREENSHOT_DIR=../../ci-screens/$l flutter drive \
        --driver=test_driver/integration_test.dart \
        --target=integration_test/app_test.dart \
        -d "iPhone 17 Pro Max" --dart-define=SCREENSHOT_LOCALE=$l
    done

Görüntüler `app-studio/ci-screens/<dil>/` içine gelir. Bu test ayrıca gerçek dosya
kaydını doğrular. Bu entegrasyon testi henüz hiç iOS'ta koşmadı (bulutta simülatör yok);
hata verirse bana yaz.

B) GitHub'ın macOS makinesinde (ücretsiz dakikalardan ~15 dk):

    git tag ios-check-sagbar-1 && git push origin ios-check-sagbar-1

Actions > ios-check: release build, simülatör testi, ekran görüntüleri
`ci/screenshots/sagbar` branch'ine gelir.

## Bulutta doğrulanamayanlar

- `flutter build ios` ve Xcode arşivi (Linux'ta mümkün değil). Proje ayarları betikle
  kontrol edildi: iPhone only, sadece dikey, tek deployment target (iOS 15.0),
  PrivacyInfo.xcprivacy Runner kaynaklarında, ikon 1024 alfasız.
- Entegrasyon testi (gerçek dosya kaydı + ana akış) iOS'ta hiç koşmadı.
- Almanca cümlelerin doğallığı: dikkatle yazıldı ve kendim gözden geçirdim, ama anadili
  Almanca olan biri tarafından kontrol edilmedi.
- Gerçek San Francisco fontuyla görünüm: testlerde Roboto kullanıldı; düzen 2x yazı
  boyutunda da kontrol edildi.
- VoiceOver, haptic geri bildirim ve panoya kopyalama gerçek cihazda denenmedi.
- Kart ekranı açıkken ekranın kararmaması (ekstra eklenti gerektirdiği için yok):
  kartı uzun süre gösterirken ekran kilitlenebilir.
- "Sagbar" isminin App Store'da boş olup olmadığı (2026-09-23 aramasında bulunmadı).
