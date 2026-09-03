---
title: Sıfırdan serisi — takip
created: 2026-09-02
modified: 2026-09-02
type: project
status: active
tags: [tutorial, avenox, yapay-zeka, ogrenme, ikinci-beyin]
---

# Sıfırdan. — takip dosyası

**Ne:** Avenox'un "yapay zekaya sıfırdan başlayanlar için haftalık serisi". Tutorial değil,
sözleşme: her hafta bir harita + kendi gerçek işinde ödev. Amaç vibe coding değil, agentic
engineering — yapay zekayı bir organ gibi kullanıp kendi alanında iş seviyesini yükseltmek.

**Kaynak repo:** https://github.com/avenoxai/sifirdan
**Kanal:** https://www.youtube.com/@Avenoxai
**İkinci beyin tek-prompt kurulumu:** https://avenox.lol/beyin.md · repo https://github.com/avenoxai/avenoxbeyin

Arda bu seriyi takip ediyor. Bu dosya bölümler yayınlandıkça güncellenir (repo'dan çekilir).

## Bu vault ile bağlantı

Bu vault'un ikinci beyin sistemi (Lecko + hafıza motoru) serinin **★ İkinci beyin (gelişmiş)**
ekstra bölümünün kurduğu sistemin ta kendisi. Yani Arda o bölümün ödevini yapmış durumda:
vault kurulu, ilk oturum notu düşülmüş. Serinin geri kalanı "kurulmuş bir sınıf" varsayarak
ilerliyor — bu koşul sağlanıyor.

## Harita (repo'daki güncel durum — 2026-09-02)

| Durak | Konu | Durum | Notlar |
| --- | --- | --- | --- |
| 1 | Harita ve sözleşme | ✅ yayında | `bolumler/01-harita-ve-sozlesme/notlar.md` |
| ★ | İkinci beyin (gelişmiş) | ✅ yayında | `bolumler/ekstra-ikinci-beyin/notlar.md` — bu vault'un kurulumu |
| ★ | Doğru prompt | ✅ yayında | `bolumler/ekstra-dogru-prompt/notlar.md` — video "yakında" |
| 2 | Kurulum + agentik arayüzler | ✅ yayında | `bolumler/02-kurulum-ve-agentik-arayuzler/notlar.md` |
| 3 | 🔒 | haftaya | — |
| 4-8 | 🔒 | sırası gelince | — |

## Bölüm özetleri ve Arda'nın durumu

### Bölüm 1 — Harita ve sözleşme
Halüsinasyon kader değil mekanik; "sihirli prompt" yok; aynı modelden farklı sonuç context
farkından. Bütçe: API kredisine bulaşma, abonelik ~40-70 kat ucuz. 3 ödev: (1) ikinci beyni
kur, (2) derin sohbet deneyi, (3) repo keşfi — PR yok.
**Arda:** ikinci beyin ✅ kurulu. Diğer iki ödev: _durum belirsiz, sor._

### ★ İkinci beyin (gelişmiş)
Hafızasını kendi yazan, her akşam kendini derleyen sistem. Tek prompt ile kurulur, ajan kurar
sen okursun. v1→v2 farkı: compaction artık kayıp değil, geçmiş import edilebiliyor, hafızayı
akşam derleyicisi yazıyor, kaynak gösterme zorunlu.
**Arda:** ✅ yapıldı — bu vault.

### ★ Doğru prompt
~1.900 gerçek prompt taranmış. Üç mit: rol atama çalışmıyor, uzun ≠ iyi, "her şey promptta"
değil (prompt context'in binde 2'si). Ana tez: **sınır çiz, yol çizme.** GPT asker / Claude
yorumcu. Beş parçalı brief: görev, sınırlar, protokol, rapor, kontrol.
**Arda ödevi:** gerçek bir işte "hedefim/elimdekiler/sınırlarım/kalanı sende" formatını dene,
eski hali + şablonlu hali yan yana vault'a koy. _Durum: yapılmadı._

### Bölüm 2 — Kurulum + agentik arayüzler
**Tez:** ajanı nerede/nasıl çalıştırdığın işin kalitesini belirler.
- **Beyin ayrı oda, atölye ayrı oda.** Projeler ikinci beynin İÇİNDE açılmaz. Kod beyne
  girmez, projenin notu girer. Hayat kaç parçaysa da **tek vault**.
- Uygulama/terminal/IDE aynı motor, performans farkı yok.
- `CLAUDE.md` Claude'a, `AGENTS.md` diğer ajanlara. İlk kural: biri güncellenirse diğeri de.
  Abartma — her satır her oturumda context'te.
- Merdiven: prompt < kural < protokol (protokol olmadan geçilemez, ör. test geçmeden commit yok).
- "Bitti"nin tanımını sen koyarsın. Boş test tuzağı. Diff'e bakmaya başla. GitHub zorunlu:
  repo, commit, branch, diff, worktree.
- Sıfırdan reçete: klasör aç → AGENTS.md+CLAUDE.md + senkron kuralı → notes.md dump →
  reports/ → Backlog.md → sabitler dosyası → skill/rol notları → GitHub repo.
**Arda bu hafta (ödev değil, davranış):** (1) beyin/atölye ayrımını kur, projeyi kendi
klasörüne taşı, (2) AGENTS.md + CLAUDE.md yaz, (3) kendi projeni reçeteyle başlat, yoruma
`PROJE:` ile bırak. _Durum: yapılmadı._

## Açık aksiyonlar (Arda'ya)

- [ ] Bölüm 1 ödev 2 (derin sohbet deneyi) yapıldı mı?
- [ ] Bölüm 1 ödev 3 (repo keşfi, 5 cümle not) yapıldı mı?
- [ ] "Doğru prompt" ödevi: bir promptu beş parçalı şablona dök
- [ ] Bölüm 2: kendi projeni sıfırdan reçeteyle başlat
- [ ] Bölüm 3 yayınlanınca bu dosyayı güncelle

## Güncelleme protokolü

Repo `avenoxai/sifirdan` düzenli olarak yeni bölüm/güncelleme alıyor. Kontrol yolu:

```bash
cd /tmp && rm -rf sifirdan-check && git clone --depth 1 https://github.com/avenoxai/sifirdan.git sifirdan-check
```

Sonra `README.md` haritası + `bolumler/` klasörü + `sozluk.md` bu dosyayla karşılaştırılır,
yeni bölüm varsa özeti buraya eklenir, harita tablosu güncellenir, `daily/` loguna düşülür.
Son senkron: **2026-09-02**, repo son commit: `ec727f4 bolum 2: video linki eklendi`.

**Otomasyon planı (Arda seçti 2026-09-02):** vault private GitHub repoya push edilecek, sonra
haftalık bir bulut ajanı (Claude Code routine) repoyu çekip bu dosyayı güncelleyip commit
atacak. Durum: _vault henüz GitHub'a push edilmedi; push edilince routine kurulacak._
