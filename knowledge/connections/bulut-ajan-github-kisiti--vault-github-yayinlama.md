---
connects: [bulut-ajan-github-kisiti, vault-github-yayinlama]
title: Bulut Ajanı Kısıtı ile Vault Yayınlama
tags: ["bulut-ajan", "github", "vault"]
sources: ["2026-09-03.md"]
created: 2026-09-03
updated: 2026-09-03
---

# Bulut Ajanı Kısıtı ile Vault Yayınlama

## Bağlantı

Bulut ajanının lokal dosyalara erişememesi, vault'u private GitHub deposuna
push etme kararını doğuran tek nedendir. Kısıt olmasaydı vault lokal git olarak
kalabilirdi; kısıt yüzünden `gh` kurulumu, yetkilendirme ve `gh repo create`
adımları yapılacaklar listesine eklendi.

## Ana Fikir

Biri problemi (bulut ajanı lokali göremez), diğeri çözümü (vault'u GitHub'a
taşı) temsil eder; kısıt → çözüm ilişkisidir.
