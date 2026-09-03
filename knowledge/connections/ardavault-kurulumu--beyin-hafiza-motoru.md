---
connects: [ardavault-kurulumu, beyin-hafiza-motoru]
title: ardavault Kurulumu ile Beyin Hafıza Motoru
tags: ["beyin", "kurulum", "vault"]
sources: ["2026-09-02.md"]
created: 2026-09-03
updated: 2026-09-03
---

# ardavault Kurulumu ile Beyin Hafıza Motoru

## Bağlantı

ardavault, beyin hafıza motorunun soyut mimarisinin fiilen kurulduğu tekil
örnektir. Motorun git deposu, 7 ana klasörü, hook'ları ve `compile.py`/
`flush.py` scriptleri bu vault içinde `avenoxbeyin` 2.1.0 şablonundan üretildi.
Motorun davranışına dair ilk gözlemler (hook tetiklemesi, ilk flush hatası)
doğrudan bu kurulumdan geldi.

## Ana Fikir

Motor "nasıl çalışır"ı, ardavault ise "burada çalışıyor"u temsil eder; genel
tasarım ile somut örnek arasındaki ilişkidir.
