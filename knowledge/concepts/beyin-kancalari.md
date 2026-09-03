---
title: Beyin Kancaları (Hooks)
aliases: ["beyin hook'ları", "SessionStart hook", "SessionEnd hook", "PreCompact hook"]
tags: ["beyin", "hafıza", "hooks", "claude-cli"]
sources: ["2026-09-02.md"]
created: 2026-09-03
updated: 2026-09-03
---

# Beyin Kancaları (Hooks)

Beyin hafıza motoru, Claude CLI'nin dört yaşam döngüsü kancasını kullanarak
hafıza bağlamını enjekte eder ve kayıt işlemlerini tetikler: `SessionStart`,
`UserPromptSubmit`, `SessionEnd` ve `PreCompact`. Bu kancalar kurulumdan sonra
doğru çalıştığı ve bağlamı beklendiği gibi enjekte ettiği doğrulandı. Kancalar
arka planda `claude` çağrıları yapabildiği için özyineleme koruması içerir.

## Önemli Noktalar

- Dört kanca: `SessionStart`, `UserPromptSubmit`, `SessionEnd`, `PreCompact`.
- `SessionStart` ve `UserPromptSubmit` hafıza bağlamını oturuma enjekte eder.
- `SessionEnd` günlük flush özetini tetikler; hatalı formatlı özet flush'ı
  başarısız kılabilir.
- Özyineleme koruması çalışıyor: arka plan çağrıları sonsuz döngü yaratmıyor.
- Kancalar ayrı API anahtarı gerektirmez; mevcut Claude aboneliği üzerinden işler.

## Detaylar

Kurulum sonrası yapılan gözlemlerde dört kancanın da tetiklendiği ve hafıza
bağlamını doğru enjekte ettiği görüldü. `SessionEnd` kancası oturum
transkriptini özetleyici (Haiku) modele verir; bu özet beş başlıklı şablona
uymazsa flush `summary-schema-invalid` hatası verir. İlk kurulum oturumunun
non-standard transkripti bu hataya yol açtı, ancak normal sohbetlerde bu
sorunun beklenmediği not edildi.

## İlgili Kavramlar

- [[beyin-hafiza-motoru]] — kancalar bu motorun oturum düzeyindeki giriş ve
  kayıt mekanizmasıdır.
- [[ozet-sema-dogrulama-kirilganligi]] — `SessionEnd` kancasının tetiklediği
  flush, bu şema kırılganlığının ortaya çıktığı yerdir.

## Kaynaklar

- 2026-09-02.md
