---
title: Beyin Hafıza Motoru
aliases: ["avenoxbeyin", "beyin sistemi", "markdown+git hafıza motoru"]
tags: ["beyin", "hafıza", "mimari", "claude-cli"]
sources: ["2026-09-02.md"]
created: 2026-09-03
updated: 2026-09-03
---

# Beyin Hafıza Motoru

Beyin, Claude asistanı için kalıcı hafızayı yöneten markdown ve git tabanlı bir
motordur. Çalışması hook'lar, günlük "flush" özetleri ve akşam derlemesi
(`compile.py`) üzerine kuruludur ve tüm veri bir Obsidian vault'u içinde düz
metin olarak tutulur. Motor tamamen kendi kendine yeterlidir: harici hafıza
servisi, embedding veya vektör veritabanı gerektirmez ve yalnızca `claude` CLI
üzerinden çalışır.

## Önemli Noktalar

- Veri katmanı: bir git deposu olarak başlatılan Obsidian vault (kurulumda 50
  dosya, ilk commit `891dcbf`).
- Üç ana mekanizma: oturum hook'ları, oturum sonu günlük flush'ı ve akşam
  bilgi derlemesi.
- Python scriptleri (`flush.py`, `compile.py`) ayrı API anahtarı istemez;
  mevcut Claude aboneliğine bağlı çalışır.
- Bilgi derlemesi akşam 18:00 sonrası ilk oturum kapanışında otomatik tetiklenir.
- Sorun yaşanırsa vault içinde `beyin doktor` teşhis akışı çalıştırılır.

## Detaylar

Kurulum şablonu Avenox'un açık kaynak `avenoxbeyin` deposundan gelir; bu
oturumda sürüm 2.1.0 tam kapsamla (Goals, Vault, Body, Mind, Projects,
Knowledge, Arsenal klasörleri) kuruldu. Kurulum sırasında "cosmetic vs.
mechanical" tercihleri sunulur; kullanıcı tam kapsamı seçti. İstikbaldeki
Codex uyumluluğu için symlink'lerle pariteler hazırlandı.

İki oturum arasında motorun harici bağımlılığı konusunda çelişkili ifadeler
oluştu. Güncelleme: 16:33 oturumunda mem0 "aktif" sayılmışken, 16:34
oturumunda vault'ta hiç geçmiş olmadığı ve motorun hiçbir harici hafıza
servisi entegrasyonu içermediği netleşti. Geçerli durum: motor kendi kendine
yeterli, mem0 kararı açık (bkz. [[mem0-entegrasyonu]]).

## İlgili Kavramlar

- [[beyin-kancalari]] — motorun bağlam enjeksiyonunu ve flush tetiklemesini
  yapan dört hook, bu motorun giriş mekanizmasıdır.
- [[ozet-sema-dogrulama-kirilganligi]] — motorun flush aşamasındaki bilinen
  bir kırılganlıktır ve derlemeyi bozabilir.
- [[mem0-entegrasyonu]] — bu kendine yeten motora alternatif veya ek olarak
  değerlendirilen harici hafıza seçeneğidir.
- [[ardavault-kurulumu]] — motorun bu oturumda kurulduğu somut vault örneğidir.

## Kaynaklar

- 2026-09-02.md
