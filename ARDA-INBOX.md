# ARDA-INBOX

## 2026-09-24 sabah: gece yapılanlar
Dediğin gibi ayrı agent'larla çalıştım: bir fikir agent'ı fikir buldu, her uygulamayı
ayrı bir builder yaptı, her birine ayrı bir tasarım+QA agent'ı baktı, ben doğrulayıp
commit ettim. Hepsi Paperpath ile aynı standartta (3 dil, testler, ekran görüntüleri,
ikon, gizlilik sayfası) ve `scripts/dod.sh` geçiyor. Hiçbiri iOS'ta derlenmedi.

Yüklemeye hazır (her birinde `apps/<app>/ARDA-MAC.md` adım adım):
- **Flatboard** (`apps/flathunt`): ev/oda arama takibi, tüm sitelerden tek liste,
  gezme saatleri, sıcak kira karşılaştırması, dolandırıcılık kontrol listesi.
- **Sagbar** (`apps/sagbar`): Bürgeramt, banka, Krankenkasse vb. için kendi
  bilgilerinle dolmuş hazır Almanca cümleler, gişede göstermek için büyük kart.
  Almanca cümleleri anadili Almanca biri okumadı; göz atarsan iyi olur.
- **Halfday** (`apps/halfday`): öğrenci çalışma günü sayacı (140 tam / 280 yarım gün),
  planın sınıra ne zaman takılacağını gösterir. Kuralları kontrol edildi.

Önemli düzeltme: Paperpath'in ekran görüntüleri alfa kanallıydı (App Store reddederdi);
düzeltildi. Hepsini tek seferde değil, önce Paperpath'i yükle; sorun çıkarsa diğerlerine
aynı düzeltmeyi yaparım. Hangilerini yayınlamak istediğini yaz. Gece iki kez abonelik kullanım limitine
takıldık (agent'lar bekledi). Yapımda: **Sheetwise** (Übungsblatt puanları, Klausur-
zulassung için kalan puan) ve **Bayram Rounds** (bayram arama listesi, iki takvim).

Stüdyo şu an seni bekliyor (`.studio/WAITING_ON_ARDA`). Paperpath'i yükleyince ya da
sorulara cevap verince bu dosyayı sil; stüdyo kaldığı yerden devam eder.

## 2026-09-23: Paperpath yüklemeye hazır
İlk uygulama hazır: **Paperpath**. Almanya'daki resmi işleri (Anmeldung, banka, sigorta,
oturum izni...) adım adım gösterir; her adım hangi belgeyi istiyor, sana hangisini veriyor.
Çevrimdışı, hesap yok, veri toplamıyor. EN/DE/TR.

Senden istenen (adım adım): `apps/paperpath/ARDA-MAC.md`
1. Klonla, `flutter pub get`, `flutter build ios --config-only --release`, Xcode'da aç.
2. Team seç, Archive, Upload.
3. App Store Connect değerleri ve metinler dosyada hazır.
4. Ekran görüntüleri hazır (`apps/paperpath/store/screenshots/`, 1320x2868, en/de/tr).
   Bulutta çizildi (Roboto, durum çubuğu yok). Gerçek simülatör görüntüsü istersen
   komut ARDA-MAC.md'de. Bulut iOS testini tetikleyemedi (tag push engelli); istersen
   `git tag ios-check-paperpath-1 && git push origin ios-check-paperpath-1`.
5. Privacy/support sayfalarını public gist olarak yayınla; support'a e-postanı ekle.

Sorular (cevap vermezsen böyle devam ederim):
- Bundle ID öneki `com.arda` kalsın mı? (Varsayılan: evet.)
- Kiel'de hâlâ oda/ev arıyor musun? Evetse sıradaki uygulama bir "ev arama takibi"
  olabilir (`ideas/flathunt.md`). Hayırsa bu fikri park ederim.

## 2026-09-23
Stüdyo kuruldu. Mac'te almak için:

    git clone -b claude/app-studio --single-branch https://github.com/ardaerturkk/ardavault.git app-studio

Durdurmak için bu branch'e `STOP` adında bir dosya koy.
