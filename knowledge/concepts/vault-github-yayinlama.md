---
title: Vault'u GitHub'a Yayınlama
aliases: ["ardavault private repo", "vault GitHub push", "gh repo create ardavault"]
tags: ["beyin", "vault", "github", "kurulum", "bulut-ajan"]
sources: ["2026-09-03.md"]
created: 2026-09-03
updated: 2026-09-03
---

# Vault'u GitHub'a Yayınlama

Bulut otomasyonunun vault'a erişebilmesi için lokal git deposu olan ardavault'un
private bir GitHub deposu olarak yayınlanması planlandı. Adımlar GitHub CLI
kurulumu, yetkilendirme ve tek komutla repo oluşturup push etmekten oluşuyor.
Bu, ardavault kurulumunu lokal-git aşamasından uzaktan erişilebilir aşamaya
taşıyan adımdır.

## Önemli Noktalar

- `brew install gh` ile GitHub CLI kurulur.
- `gh auth login` ile GitHub yetkilendirmesi yapılır.
- `gh repo create ardavault --private --source=. --push` ile private repo
  oluşturulup mevcut vault push edilir.
- Repo private tutulur; vault'un `.gitignore` yapılandırması sağlam (şifre/anahtar
  içermiyor) olduğu için push güvenli görülüyor.
- Sonraki push'lardan önce vault'un lokal olarak güncel tutulması gerekir; bulut
  ajanı yalnızca GitHub'daki son hâli görür.

## Detaylar

Planlama, kullanıcının sıfırdan serisini haftalık kontrol edip `takip.md`'yi
otomatik güncellemek istemesiyle başladı. Bulut ajanı lokal dosyalara
erişemediğinden (bkz. [[bulut-ajan-github-kisiti]]) vault'un GitHub'a taşınması
zorunlu oldu. Repo oluşturulduktan sonra URL'nin paylaşılması ve haftalık bulut
rutininin bu repo üzerine kurulması bekleniyor. Bu adımlar günlük kaydı
alındığında henüz yapılacaklar listesindeydi.

## İlgili Kavramlar

- [[ardavault-kurulumu]] — bu yayınlama, o kurulumda lokal git olarak başlatılan
  vault'a bir GitHub remote'u ekler.
- [[bulut-ajan-github-kisiti]] — yayınlama kararının nedeni bu kısıttır.
- [[haftalik-sifirdan-takip-rutini]] — haftalık otomasyon ancak vault
  yayınlandıktan sonra kurulabilir.

## Kaynaklar

- 2026-09-03.md
