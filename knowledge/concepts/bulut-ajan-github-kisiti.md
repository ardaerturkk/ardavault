---
title: Bulut Ajanı GitHub Kısıtı
aliases: ["bulut ajanı kısıtı", "cloud agent GitHub gereksinimi", "bulut ajan lokal erişim yok"]
tags: ["bulut-ajan", "github", "otomasyon", "kisit"]
sources: ["2026-09-03.md"]
created: 2026-09-03
updated: 2026-09-03
---

# Bulut Ajanı GitHub Kısıtı

Bulut ajanları geliştiricinin lokal dosya sistemine erişemez; yalnızca GitHub
üzerindeki depoları klonlayarak çalışabilir. Bu nedenle bir bulut rutini
oluşturmak için ilgili verinin bir GitHub deposunda bulunması zorunludur.
Arda'nın vault'u lokal bir git deposu olduğundan (GitHub remote'u yok) planlanan
haftalık otomasyon önce bu kısıta takıldı.

## Önemli Noktalar

- Bulut ajanı lokal diske erişemez; girdi olarak yalnızca klonlanabilir GitHub
  deposu alır.
- Lokal git deposu olması yeterli değildir; erişilebilir bir remote gerekir.
- Çözüm: veriyi (burada vault) private bir GitHub deposuna push etmek.
- GitHub yetkilendirmesi GitHub CLI (`gh auth login`) ile yapılır.
- Bulut model seçimi bu senaryoda `claude-sonnet-5`.

## Detaylar

Kullanıcı sıfırdan serisini haftalık kontrol edip `takip.md`'yi otomatik
güncellemek isteyince bulut ajanı önerildi. Planlama sırasında vault'un yalnızca
lokal git olduğu, GitHub remote'u bulunmadığı keşfedildi. Bulut ajanı vault'a
ancak GitHub üzerinden ulaşabileceği için vault'un private repo olarak
yüklenmesi gerektiği sonucuna varıldı. Sıfırdan deposu zaten herkese açık
olduğundan onun kontrolü ek bir kısıt yaratmıyor; kısıt esas olarak güncellenen
hedef dosyanın (`takip.md`) bulunduğu vault için geçerli.

## İlgili Kavramlar

- [[vault-github-yayinlama]] — bu kısıt, vault'un private GitHub deposuna
  push edilmesi kararının doğrudan gerekçesidir.
- [[haftalik-sifirdan-takip-rutini]] — kurulacak haftalık otomasyon bu kısıt
  çözülmeden çalışamaz.

## Kaynaklar

- 2026-09-03.md
