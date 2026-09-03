---
title: Özet Şema Doğrulama Kırılganlığı
aliases: ["summary-schema-invalid", "flush format hatası", "validate_summary kırılganlığı"]
tags: ["beyin", "hafıza", "flush", "hata", "haiku"]
sources: ["2026-09-02.md"]
created: 2026-09-03
updated: 2026-09-03
---

# Özet Şema Doğrulama Kırılganlığı

`flush.py` oturum sonu özetini beş başlıklı sabit bir şablona göre doğrular
(`validate_summary`). Özeti üreten Haiku modeli ufak metin farklılıklarıyla bu
sözleşmeyi tutturamayınca flush `summary-schema-invalid` hatasıyla başarısız
olur. Bu bilinen ve tekrar eden bir kırılganlıktır; özellikle non-standard
transkriptlerde (ör. kurulum oturumları) tetiklenir.

## Önemli Noktalar

- Hata kodu: `summary-schema-invalid`; kaynağı `flush.py` içindeki
  `validate_summary` kontrolü.
- Kök neden: Haiku modelinin beş başlıklı şablonu birebir üretememesi.
- İlk `flush.py` çalışması bu hataya düştü; sebep kurulum oturumunun
  non-standard transkripti olarak bağlandı.
- Normal sohbetlerde sorunun beklenmediği, çoğu zaman kendi kendine düzeldiği
  değerlendirildi.
- Kalıcılaşırsa çözüm: `validate_summary` kuralını gevşetmek.

## Detaylar

İki ardışık oturumda da (16:33 ve 16:34) aynı gözlem tekrarlandı: önceki
oturum-sonu özeti beş başlıklı formatı kaçırdığı için flush başarısız oldu.
Beklenen davranış, bir sonraki oturum-sonu özeti düzgün formatlanırsa sorunun
kendiliğinden çözülmesidir. Aksi halde doğrulama şeması gevşetilerek küçük
biçim sapmalarına tolerans tanınacaktır.

## İlgili Kavramlar

- [[beyin-kancalari]] — hata, `SessionEnd` kancasının tetiklediği flush
  adımında ortaya çıkar.
- [[beyin-hafiza-motoru]] — bu kırılganlık motorun günlük kayıt hattındaki
  zayıf noktadır ve derlemeyi besleyen veriyi bozabilir.

## Kaynaklar

- 2026-09-02.md
