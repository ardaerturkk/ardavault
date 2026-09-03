---
connects: [ardavault-kurulumu, vault-github-yayinlama]
title: ardavault Kurulumu ile GitHub'a Yayınlama
tags: ["beyin", "vault", "github", "kurulum"]
sources: ["2026-09-03.md"]
created: 2026-09-03
updated: 2026-09-03
---

# ardavault Kurulumu ile GitHub'a Yayınlama

## Bağlantı

ardavault kurulumu vault'u lokal bir git deposu olarak başlatmıştı (ilk commit
`891dcbf`, GitHub remote'u yok). GitHub'a yayınlama, aynı depoya bir private
remote ekleyip mevcut geçmişi push ederek bu kurulumu bir sonraki aşamaya
taşır. Kurulumdaki sağlam `.gitignore` yapılandırması, push'un şifre/anahtar
sızdırmadan güvenli yapılabilmesinin ön koşuludur.

## Ana Fikir

Yayınlama, ardavault kurulumunun devamıdır: lokal-only vault'tan bulut
ajanlarının erişebildiği uzak depoya geçiş.
