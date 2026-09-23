---
title: Flutter bulut stüdyosu — kurulum
created: 2026-09-23
modified: 2026-09-23
type: project
status: active
tags: [flutter, ios, claude-code, otonom-ajan]
---

# Flutter bulut stüdyosu

> **Durum (2026-09-23):** Canlı. Lecko kurdu: stüdyo `ardavault` reposunun
> `claude/app-studio` branch'inde (vault'tan ayrı geçmiş; yeni repo açma yetkisi yoktu).
> Bulut oturumu `session_01Y9VaCzfWjGkDBBKYXkUCot`, rutin her 2 saatte bir.
> Mac'te: `git clone -b claude/app-studio --single-branch https://github.com/ardaerturkk/ardavault.git app-studio`
> Aşağıdaki kurulum adımları artık gerekmiyor; referans için duruyor.

Mac'e bağlı olmayan versiyon. Ajan Claude Code bulut oturumlarında, Flutter'la, sen
uyurken çalışıyor. Uygulamaları App Store'a yüklemeye hazır hale getiriyor. Mac'te
çalıştırma, archive ve yükleme sende. Mac'li SwiftUI versiyonu `../README.md`'de.

| Dosya | Ne |
| --- | --- |
| `KICKOFF.md` | Yapıştıracağın başlatma prompt'u + rutin prompt'u |
| `session-start.sh` | Her oturumda Flutter'ı kurar, çalışma süresini başlatır |
| `keep-going.sh` | Oturumu ~100 dk durmadan çalıştırır, sonra devri bir sonraki çalışmaya bırakır |
| `settings.json` | Hook kayıtları |

## Nasıl durmadan çalışıyor

Bulut konteynerleri geçici, tek oturum sonsuza kadar açık kalamıyor. Bu yüzden iki katman var:

1. **Rutin:** her 2 saatte bir yeni bir bulut oturumu açılıyor, repoyu çekiyor,
   `STATE.md`'den kaldığı yeri okuyup devam ediyor.
2. **Stop hook:** her oturum yaklaşık 100 dakika boyunca durmadan adım adım çalışıyor,
   sonra her şeyi push'layıp bitiyor. `STUDIO.LOCK` iki oturumun çakışmasını engelliyor.

Durdurmak için repoya `STOP` adında bir dosya koy ya da rutini kapat.

## Ajan cihaz olmadan nasıl test ediyor (bu konteynerde doğrulandı)

- Bu ortamda KVM yok, yani Android emülatörü çalışmıyor. Android SDK'nın indirildiği
  sunucu da ağ politikasında kapalı. Zaten hedef iOS olduğu için Android'e girmiyor.
- Flutter kuruluyor, `flutter test` ve `flutter build web` çalışıyor.
- **Gözleri golden testler:** her ekranı açık/koyu, normal/büyük yazı, küçük/büyük telefonda
  PNG olarak render edip kendisi bakıyor ve düzeltiyor. Etkileşimli akışları web build +
  Chromium ile tıklayarak deniyor.
- **Gerçek iOS kontrolü:** GitHub Actions'ın macOS makinesinde `flutter build ios` +
  iPhone simulator'da test + 6.9" ekran görüntüleri. Private repoda GitHub Free ayda
  ~200 macOS dakikası veriyor (bedava, kart yoksa aşınca sadece durur). Ajan bunu sadece
  kilometre taşlarında çalıştırıyor.

## Kurulum (senin yapacakların, ~10 dakika)

1. GitHub'da boş, **private** bir repo aç: `app-studio`. Claude GitHub App'in bu repoya
   erişimi olsun (claude.ai/code'da repo seçerken listede görünmüyorsa GitHub App ayarından ekle).
2. claude.ai/code → yeni oturum → repo olarak `app-studio`'yu seç → ortam **Default**
   (Trusted ağ yeterli) → `KICKOFF.md`'deki büyük bloğu yapıştır.
   - Ajan hook dosyalarını `ardavault` reposundan çekmeye çalışacak. Erişemezse kendisi yazar.
3. İlk oturum kurulumu bitirip çalışmaya başlayınca **rutin**i kur: claude.ai/code/routines
   → New routine → repo `app-studio`, ortam Default, tetikleyici **her 2 saat**
   (formda "hourly" seçip sonra `/schedule update` ile `0 */2 * * *` yap ya da saatlik
   bırak), prompt: `KICKOFF.md`'nin altındaki kısa rutin prompt'u.
4. claude.ai/settings/usage'da **usage credits kapalı** olsun. Limit dolunca para
   yazmaz, çalışma bir sonraki pencereye kalır. Rutinlerin ayrıca günlük çalışma sınırı var;
   aşılırsa o günlük durur, ücret çıkmaz.

## Yarın Mac'te

- `git clone` / `git pull`, sonra `ARDA-INBOX.md`'yi oku.
- Her hazır uygulama için `apps/<app>/ARDA-MAC.md`: komutlar, Xcode tıkları, App Store
  Connect'e yapıştırılacak değerler (isim, bundle ID, SKU, kategori, yaş derecesi, gizlilik
  "Data Not Collected", fiyat, ülkeler), metadata ve ekran görüntülerinin yeri.
- Gerekenler: Flutter SDK, Xcode, Developer hesabı, (CocoaPods kullanıyorsa) `pod`.

## Bilinen sınırlar

- iOS'a özgü hisler (Liquid Glass, sistem animasyonları) Flutter'da taklit; Cupertino
  widget'larıyla olabildiğince yakın tutuluyor. Widget, Control Center, Live Activity gibi
  Swift gerektiren özellikler bu versiyonda yok.
- Bulut iOS'u sadece GitHub Actions üzerinden doğrulayabiliyor. Dakika biterse son iOS
  kontrolü yarın senin Mac'inde olur, `ARDA-MAC.md` bunu açıkça yazar.
- Gizlilik/destek sayfaları `site/` altında hazırlanıyor. Private repoda GitHub Pages
  ücretli; yayın için ayrı bir public repo ya da başka bedava hosting seçimi sende.
