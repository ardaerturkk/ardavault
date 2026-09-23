# Paperpath: Mac'te yapılacaklar

Paperpath, Almanya'ya taşınan öğrencinin resmi işlerini sıraya koyar: her adım hangi
belgeleri istiyor, sana hangi belgeyi veriyor. Adres kaydı (Anmeldung) bitince
Meldebescheinigung dosyana eklenir, onu bekleyen banka hesabı gibi adımlar "Hazır"a geçer.
Tamamen çevrimdışı, hesap yok, veri toplamıyor. İngilizce, Almanca, Türkçe.

Sürüm: 1.0.0 (build 1). Bundle ID: `com.arda.paperpath`.

## 1. Kodu al ve Xcode'da aç

Gerekenler: güncel Xcode, Flutter stable 3.47.5 veya daha yenisi (`flutter --version`).
CocoaPods gerekmiyor, proje Swift Package Manager kullanıyor.

    git clone -b claude/app-studio --single-branch https://github.com/ardaerturkk/ardavault.git app-studio
    cd app-studio/apps/paperpath
    flutter pub get
    flutter build ios --config-only --release
    open ios/Runner.xcworkspace

Zaten klonladıysan: `cd app-studio && git pull`, sonra yukarıdaki son üç komut.

## 2. İstersen önce simülatörde dene (5 dakika)

    open -a Simulator        # iPhone 17 Pro Max (veya 16 Pro Max) seç
    flutter run

Bakılacak akış: Boş ekranda "Add Germany Starter Steps" > bir tarih > Continue.
"Register Your Address (Anmeldung)" aç > "Landlord Confirmation"a dokun > "Mark as Done".
Geri dön: "Open a Bank Account" artık Ready bölümünde olmalı.

## 3. Arşivle ve yükle

1. Xcode'da sol üstte Runner projesi > TARGETS: Runner > Signing & Capabilities.
2. "Automatically manage signing" açık, Team: kendi takımın.
3. Bundle Identifier `com.arda.paperpath` olmalı (öneki değiştirmek istersen bana yaz,
   ben her yerde değiştiririm).
4. Üstteki cihaz seçiminde: Any iOS Device (arm64).
5. Product > Archive. Bitince Organizer açılır: Distribute App > App Store Connect > Upload.

## 4. App Store Connect'te yeni uygulama

My Apps > + > New App:

- Platform: iOS
- Name: `Paperpath: Moving Paperwork` (isim alınmışsa: `Paperpath: Office Steps`)
- Primary Language: English (U.S.)
- Bundle ID: com.arda.paperpath
- SKU: `paperpath-001`
- User Access: Full Access

App Information:
- Category: Primary **Productivity**, Secondary **Reference**
- Content Rights: "does not contain, show, or access third-party content"
- Age Rating: tüm sorulara "None" / "No" (sonuç 4+)
- Localizations: English (U.S.) ana dil; German ve Turkish ekle.

App Privacy:
- Privacy Policy URL: `site/paperpath/privacy.md` dosyasını herkese açık bir yerde yayınla
  (en kolayı: gist.github.com'da public gist, içeriği yapıştır) ve linki gir.
- Data Collection: **"No, we do not collect data from this app"** > sonuç "Data Not Collected".

Pricing and Availability: Free. Availability: tüm ülkeler, **China mainland hariç**.

Sürüm sayfası (1.0), her dil için dosyalar `apps/paperpath/store/<dil>/` içinde:
- `name.txt`, `subtitle.txt`, `promotional_text.txt`, `description.txt`, `keywords.txt`
  (en-US, de-DE, tr)
- Support URL: `site/paperpath/support.md` için de bir gist aç. Yayınlamadan önce en alta
  kendi iletişim e-postanı ekle (bilerek boş bıraktım, e-postanı yayınlamak senin kararın).
- Copyright: `2026 <Adın Soyadın>`
- App Review Information: Sign-in required **kapalı**. Notes kısmına
  `store/en-US/review_notes.txt` içeriğini yapıştır.
- Export compliance: Info.plist'te `ITSAppUsesNonExemptEncryption = false` var, soru
  sorulmayacak.

## 5. Ekran görüntüleri (6.9 inç, 1320x2868)

Bulutta iOS simülatörü yok ve bu oturum GitHub'daki iOS workflow'unu tetikleyemedi (tag
push'u proxy tarafından reddedildi). İki yol var:

A) Mac'te otomatik (önerilen). Simülatörde iPhone 17 Pro Max (veya 16 Pro Max) açıkken,
`apps/paperpath` içinde:

    for l in en de tr; do
      SCREENSHOT_DIR=../../ci-screens/$l flutter drive \
        --driver=test_driver/integration_test.dart \
        --target=integration_test/app_test.dart \
        -d "iPhone 17 Pro Max" --dart-define=SCREENSHOT_LOCALE=$l
    done

Görüntüler `app-studio/ci-screens/<dil>/` içine gelir (1_steps, 2_step_ready,
3_step_done, 4_documents, 5_document). Bu test ayrıca gerçek dosya kaydını da doğrular.

B) GitHub'ın macOS makinesinde (ücretsiz dakikalardan ~15 dk):

    git tag ios-check-paperpath-1 && git push origin ios-check-paperpath-1

Actions sekmesinde "ios-check" çalışır; release build, simülatör testi ve ekran görüntüleri
`ci/screenshots/paperpath` branch'ine gelir. Hata verirse bana haber ver, düzeltirim.

Görüntü yoksa elle: simülatörde demo planı kurup (adım 2'deki akış) şu ekranları Cmd+S ile
çek: Steps listesi, Anmeldung detay, tamamlanmış Anmeldung, Documents listesi.

## Bulutta doğrulanamayanlar

- `flutter build ios` ve Xcode arşivi (Linux'ta mümkün değil). Proje ayarları betikle
  kontrol edildi: iPhone only, sadece dikey, tek deployment target (iOS 15.0),
  PrivacyInfo.xcprivacy Runner kaynaklarında, ikon 1024 alfasız.
- Gerçek San Francisco fontuyla görünüm: testlerde Roboto kullanıldı; düzen 2x yazı
  boyutunda da kontrol edildi.
- VoiceOver ve haptic geri bildirim gerçek cihazda denenmedi.
- "Paperpath" isminin App Store'da boş olup olmadığı.
