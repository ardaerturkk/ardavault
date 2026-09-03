---
title: Haftalık Sıfırdan Takip Rutini
aliases: ["takip.md", "haftalık bulut rutini", "sifirdan takip otomasyonu"]
tags: ["otomasyon", "bulut-ajan", "sifirdan", "takip", "haftalik"]
sources: ["2026-09-03.md"]
created: 2026-09-03
updated: 2026-09-03
---

# Haftalık Sıfırdan Takip Rutini

Haftada bir çalışacak bir bulut ajanı rutini planlandı: `avenoxai/sifirdan`
deposunu yeni bölüm veya güncelleme için kontrol eder ve vault içindeki
`takip.md` dosyasını buna göre günceller. Rutin, sıfırdan serisini elle takip
etme yükünü ortadan kaldırmayı amaçlıyor. Kurulum, vault'un GitHub'a
yayınlanmasına bağlı.

## Önemli Noktalar

- Tetikleme: haftalık; bulut ajanı ile.
- Girdi: `avenoxai/sifirdan` deposu (klonlanır, yeni bölüm/güncelleme aranır).
- Çıktı: vault içindeki `takip.md` dosyasının güncellenmesi.
- `takip.md` şu an 4 bölüm özeti, açık aksiyonlar ve bir güncelleme protokolü
  içeriyor; içinde tamamlanmamış ödevler var.
- Bulut modeli: `claude-sonnet-5`.
- Ön koşul: vault'un private GitHub deposu olarak yayınlanmış olması.

## Detaylar

Kullanıcı önce git/clone hakkında sordu, ardından sıfırdan serisini takip etme
niyetini netleştirdi ve haftalık otomatik güncelleme talep etti. `takip.md`
oturumda oluşturuldu. Rutinin çalışması için bulut ajanının vault'a erişmesi
gerekir; ajan lokal dosyalara erişemediğinden (bkz. [[bulut-ajan-github-kisiti]])
vault'un GitHub'a taşınması gerekiyor. Her hafta ajan `takip.md`'yi güncelledikçe
kullanıcının bir sonraki lokal push'tan önce değişiklikleri çekmesi gerekecek.

## İlgili Kavramlar

- [[sifirdan-tutorial-serisi]] — rutinin izlediği ve özetlediği kaynak seridir.
- [[bulut-ajan-github-kisiti]] — rutin bu kısıt çözülmeden çalışamaz.
- [[vault-github-yayinlama]] — `takip.md`'nin bulunduğu vault'un erişilebilir
  olması bu adıma bağlıdır.

## Kaynaklar

- 2026-09-03.md
