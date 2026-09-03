---
connects: [beyin-kancalari, ozet-sema-dogrulama-kirilganligi]
title: Beyin Kancaları ile Özet Şema Doğrulama Kırılganlığı
tags: ["beyin", "hooks", "flush", "hata"]
sources: ["2026-09-02.md"]
created: 2026-09-03
updated: 2026-09-03
---

# Beyin Kancaları ile Özet Şema Doğrulama Kırılganlığı

## Bağlantı

`summary-schema-invalid` hatası soyut bir bug değil; `SessionEnd` kancasının
otomatik olarak çalıştırdığı flush adımında somutlaşır. Kanca oturum
transkriptini Haiku'ya özetletir, `flush.py` beş başlıklı şablonu doğrular ve
şablon tutmayınca flush başarısız olur. Yani kırılganlığın tetikleyici yüzeyi
tam olarak bu kancadır.

## Ana Fikir

Kanca otomasyonu kırılganlığı görünür kılar: `SessionEnd` her oturumda flush'ı
zorladığı için Haiku'nun format sapmaları düzenli olarak hataya dönüşür.
