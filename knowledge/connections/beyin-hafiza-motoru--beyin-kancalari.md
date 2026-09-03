---
connects: [beyin-hafiza-motoru, beyin-kancalari]
title: Beyin Hafıza Motoru ile Beyin Kancaları
tags: ["beyin", "hafıza", "hooks"]
sources: ["2026-09-02.md"]
created: 2026-09-03
updated: 2026-09-03
---

# Beyin Hafıza Motoru ile Beyin Kancaları

## Bağlantı

Dört kanca (`SessionStart`, `UserPromptSubmit`, `SessionEnd`, `PreCompact`)
hafıza motorunun oturum düzeyindeki giriş ve çıkış noktalarıdır. Motorun
"markdown + git + derleme" hattı, ancak bu kancalar bağlamı okuyup enjekte
ettiği ve oturum sonunda flush'ı tetiklediği için canlı hale gelir. Kancalar
olmadan motor sadece durağan bir dosya deposu olur.

## Ana Fikir

Kancalar, kendine yeten hafıza motorunu her Claude oturumuna bağlayan
tetikleme katmanıdır; motorun otomasyonu bu dört olaya dayanır.
