---
title: Beyin Doktor Skill'i
aliases: ["beyin doktor", "doktor skill", "beyin teşhis akışı"]
tags: ["beyin", "teşhis", "skill", "bakım"]
sources: ["2026-09-02.md"]
created: 2026-09-03
updated: 2026-09-03
---

# Beyin Doktor Skill'i

Beyin doktor, vault içinde çalıştırılan ve hafıza motorunun sağlığını kontrol
eden bir teşhis skill'idir. Başlangıçta her çağrıda otomatik olarak tam teşhis
açıyordu; kullanıcı hızlı evet/hayır yanıtı istediği için davranışı
güncellendi. Yeni kural: önce hızlı cevap, tam teşhis yalnızca açıkça talep
edilince.

## Önemli Noktalar

- Amaç: birkaç realtime oturum sonrası hata varsa motoru teşhis etmek.
- Çağrı: vault içinde `beyin doktor`.
- Eski davranış: otomatik tam teşhis akışı.
- Güncellenen kural: hızlı yanıt öncelikli, teşhis talep üzerine.
- Tipik kullanım tetikleyicisi: flush veya derleme hataları.

## Detaylar

16:34 oturumunda doktor skill'i, kullanıcı sadece kısa bir onay beklerken
kapsamlı teşhis başlattı. Bunun üzerine skill kuralı, gereksiz uzun çıktı
üretmemesi için değiştirildi. Skill hâlâ `summary-schema-invalid` gibi bilinen
kırılganlıkları araştırmak için uygun araçtır.

## İlgili Kavramlar

- [[beyin-hafiza-motoru]] — doktor, bu motorun bakım ve teşhis aracıdır.
- [[ozet-sema-dogrulama-kirilganligi]] — doktor akışı, bu tür flush
  hatalarının kök nedenini araştırmak için kullanılır.

## Kaynaklar

- 2026-09-02.md
