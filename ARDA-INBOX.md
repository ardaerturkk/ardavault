# ARDA-INBOX

## 2026-09-23: Paperpath yüklemeye hazır
İlk uygulama hazır: **Paperpath**. Almanya'daki resmi işleri (Anmeldung, banka, sigorta,
oturum izni...) adım adım gösterir; her adım hangi belgeyi istiyor, sana hangisini veriyor.
Çevrimdışı, hesap yok, veri toplamıyor. EN/DE/TR.

Senden istenen (adım adım): `apps/paperpath/ARDA-MAC.md`
1. Klonla, `flutter pub get`, `flutter build ios --config-only --release`, Xcode'da aç.
2. Team seç, Archive, Upload.
3. App Store Connect değerleri ve metinler dosyada hazır.
4. Ekran görüntüleri: bulut iOS testini tetikleyemedi (tag push engelli). Mac'te
   `flutter drive` komutu dosyada, ya da `git tag ios-check-paperpath-1 && git push origin ios-check-paperpath-1`.
5. Privacy/support sayfalarını public gist olarak yayınla; support'a e-postanı ekle.

Soru (cevap vermezsen böyle devam ederim): Bundle ID öneki `com.arda` kalsın mı?

## 2026-09-23
Stüdyo kuruldu. Mac'te almak için:

    git clone -b claude/app-studio --single-branch https://github.com/ardaerturkk/ardavault.git app-studio

Durdurmak için bu branch'e `STOP` adında bir dosya koy.
