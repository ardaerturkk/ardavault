---
title: ardavault Kurulumu
aliases: ["ardavault", "Arda'nın Obsidian vault'u", "avenoxbeyin kurulumu"]
tags: ["beyin", "kurulum", "obsidian", "vault", "macos"]
sources: ["2026-09-02.md", "2026-09-03.md"]
created: 2026-09-03
updated: 2026-09-03
---

# ardavault Kurulumu

ardavault, Arda'nın macOS üzerinde `avenoxbeyin` şablonuyla kurduğu Obsidian
vault'udur ve beyin hafıza motorunun somut örneğidir. Vault
`/Users/ardaerturk/Desktop/ardavault` yolunda, sürüm 2.1.0 ile ve tam kapsamla
kuruldu. Kurulum bir git deposu olarak başlatıldı ve masaüstünde 🧠 ikonlu bir
kısayol oluşturuldu.

## Önemli Noktalar

- Vault yolu: `/Users/ardaerturk/Desktop/ardavault`; sürüm 2.1.0.
- Tam kapsam: Goals, Vault, Body, Mind, Projects, Knowledge, Arsenal (7 ana
  klasör).
- Git: 50 dosyayla başlatıldı, ilk commit `891dcbf`.
- Masaüstü kısayolu `ardavault.app` (🧠 ikon) oluşturuldu; etkinleşmesi için
  Obsidian'da "Open folder as vault" ile vault bir kez tanıtılmalı.
- Ortağın (asistan kişiliği) adı "Lecko" olarak belirlendi.

## Detaylar

Kurulum adım adım yapıldı; kullanıcı bir noktada ilk adıma dönüp sonra devam
etti. İstikbaldeki Codex uyumluluğu için symlink pariteleri hazırlandı. mem0
API anahtarı `.claude/settings.local.json` içine eklendi ancak entegrasyon
kararı açık bırakıldı (bkz. [[mem0-entegrasyonu]]). Normal kullanım akışı:
`cd ~/Desktop/ardavault && claude` → Lecko ile konuş → `/exit`. Bilgi derlemesi
akşam 18:00 sonrası ilk oturum kapanışında otomatik tetiklenir.

Güncelleme: 2026-09-03 — Vault başlangıçta yalnızca lokal git'ti (GitHub
remote'u yok). Bulut otomasyonu için vault'un private GitHub deposu olarak
yayınlanması planlandı (bkz. [[vault-github-yayinlama]]).

## İlgili Kavramlar

- [[beyin-hafiza-motoru]] — ardavault, bu motorun kurulduğu ve veriyi
  barındıran somut vault'tur.
- [[mem0-entegrasyonu]] — kurulum sırasında mem0 anahtarı bu vault'un
  ayarlarına eklendi ama kullanıma alınmadı.
- [[vault-github-yayinlama]] — bu lokal git vault'a bulut erişimi için private
  GitHub remote'u ekleme adımı.

## Kaynaklar

- 2026-09-02.md
