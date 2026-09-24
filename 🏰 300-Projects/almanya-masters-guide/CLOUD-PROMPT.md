---
title: Almanya Master Rehberi — final prompt (cloud oturumu)
created: 2026-09-24
modified: 2026-09-24
type: project
status: active
tags: [almanya, yuksek-lisans, rehber, site, prompt, cloud]
---

# Final prompt: bu cloud oturumundan (Lecko) çalıştır

> **Neden bu:** Terminal'e geçmek yerine işi buradan yürütüyoruz — Lecko'ya senkron otomatik
> olur, ayrı klonlama hilesi gerekmez. `TERMINAL-PROMPT.md` artık kullanılmıyor, referans olarak
> duruyor.
>
> **Nasıl kullanılır:** Bu chat kapandıktan sonra yeni bir Claude Code (web/cloud) oturumu aç,
> `ardavault` reposunu bağla (zaten primary repo olacak), aşağıdaki `---8<---` çizgisinin altını
> olduğu gibi yapıştır. Oturum kesilirse aynı prompt'u tekrar ver — `ROADMAP.md` kaldığı yerden
> devam ettirir.

---8<---

# GÖREV

`ardaerturkk/almanya-master-rehberi` reposunda, Almanya'da yüksek lisans yapmak isteyen Türkçe
konuşan biri için 3ds.hacks.guide tarzında bir rehber/wiki sitesi tamamlanıyor. Senin işin:
**araştırmak, yazmak, doğrulamak, yayına hazır hale getirmek.**

## 0. Ortam kurulumu (her oturumun başında)

1. `almanya-master-rehberi` reposu bu oturuma ekli değilse `add_repo` ile ekle
   (`owner: ardaerturkk`, `repo: almanya-master-rehberi`, `access: push`), klonla, kaydet.
2. O repodaki `ROADMAP.md`, `SOURCES.md`, `docs/.vitepress/config.mts` dosyalarını oku — nerede
   kalındığını öğren.
3. **Network testi:** Bir WebFetch dene (ör. `https://www.daad.de`). `EGRESS_BLOCKED` dönerse bu
   ortamın network policy'si dış siteleri engelliyor demektir — WebFetch'i bırak, **WebSearch**
   kullan (o çalışıyor, sonuçlarda kaynak URL'si de veriyor). Engel kalkmışsa WebFetch'i tercih
   et, daha güvenilir ham metin verir. Hangi mod olursa olsun kaynak URL'sini her zaman kaydet.
4. **Ölçek uyarısı:** Bu iş büyük (32 adım + 7 dallanma + 6 referans sayfası, hepsi kaynaklı).
   Bağımsız araştırma parçalarını (ör. "Sperrkonto ve sigorta karşılaştırması", "vize belgeleri
   ve kanalı", "askerlik tecili") paralel **Agent** (subagent) çağrılarıyla topla — her biri
   WebSearch yapıp bulduklarını kaynağıyla birlikte raporlasın, sen ana oturumda bu raporları
   `SOURCES.md` / `data/degerler.yml`'e işleyip sayfaları yaz. Agent'ları `general-purpose` tipiyle,
   net bir görev + "her iddiayı kaynağıyla ver" talimatıyla çağır.

Bu bir **doğruluk projesi**. Yanlış bir tarih, tutar veya belge adı birinin vizesini,
başvurusunu veya parasını yakabilir. Hız ikincil; doğruluk ve eksiksizlik birincil.

**Bu rehber kimsenin kişisel tecrübesi değildir.** Tek bir "ben böyle yaptım" hikâyesi anlatmaz;
her adımda **mevcut tüm yolları ve yöntemleri** anlatır, okurun kendi durumuna göre seçmesini
sağlar. Birden fazla yöntem varsa (başvuru kanalı, finansman kanıtı, dil belgesi, sigorta türü,
konaklama, vize başvuru kanalı) hepsi karşılaştırmalı tabloyla, kimin için uygun olduğu ve
artı/eksileriyle yazılır. Resmi kurallar bir yolu zorunlu kılmadıkça site hiçbir yolu "tek doğru"
diye dayatmaz.

**Uydurma sıfır.** Sitedeki her bilgi gerçek, güncel ve kaynağı gösterilebilir araştırmaya
dayanır. Bulamadığın/doğrulayamadığın bilgiyi tahminle doldurma; ya çıkar ya da sayfada açıkça
"doğrulanamadı, şu kuruma sorun" diye işaretle. Ezberinden yazma, her rakamı canlı kaynaktan
doğrula.

## 1. Hedef kitle ve kapsam

- **Birincil okur:** Türkiye'de lisansını bitirmiş/bitirmek üzere olan, T.C. vatandaşı, Almanya'da
  Master yapmak isteyen biri. Süreç hakkında sıfır bilgi varsay.
- **İkincil okur:** Türkiye dışında lisans yapmış Türk vatandaşları, çift vatandaşlar, Türkiye'de
  yaşayan yabancılar. Sapma noktalarında not düş, ayrı rota kurma.
- **Kapsam dışı (bir paragrafla yönlendir):** Bachelor/Studienkolleg, doktora, Ausbildung, AB
  vatandaşları, Almanca öğretmenliği.
- **Dil:** Türkçe. Almanca/İngilizce terimler ilk geçtiği yerde açıklanır, sözlüğe linklenir.
  Resmi belge/kurum adları orijinal dilinde kalır.

## 2. Araştırma protokolü (bağlayıcı)

### Kaynak hiyerarşisi
1. **Birincil (tek başına yeterli):** Auswärtiges Amt, Almanya'nın Türkiye misyonları,
   Auslandsportal, make-it-in-germany.com, BAMF, DAAD, uni-assist.de, anabin (KMK),
   Hochschulkompass, üniversitelerin kendi sayfaları, Studentenwerk, gesetze-im-internet.de
   (AufenthG, BeschV, AufenthV), Bundesagentur für Arbeit, Minijob-Zentrale, Bundeszentralamt
   für Steuern, ARD ZDF Deutschlandradio Beitragsservice, T.C. resmi kaynaklar (MSB/ASAL, e-Devlet,
   GİB, Dışişleri, YÖK), dil sınavı kurumları (TestDaF, Goethe, telc, IELTS, TOEFL/ETS), vize
   başvuru hizmet sağlayıcısının resmi sitesi (**güncel sağlayıcıyı kontrol et**).
2. **İkincil:** Sperrkonto/sigorta sağlayıcılarının kendi siteleri (Fintiba, Expatrio, Coracle,
   TK, AOK vb.; ticari çıkarları olduğunu unutma), büyük üniversitelerin International Office
   rehberleri.
3. **Üçüncül (destekleyici, açıkça etiketlenerek):** Reddit, ekşi sözlük, forumlar, Türk öğrenci
   toplulukları, YouTube, danışmanlık blogları. İki kullanım biçimi:
   - **Soru kaynağı:** nerede takılıyorlar, ne soruyorlar — cevabı birincil kaynaktan doğrulanarak
     siteye girer.
   - **Destekleyici bilgi:** resmi kaynağın söylemediği sahadaki gerçek pratikse, "Topluluk
     tecrübesi (kaynak: r/…, TT.AA.YYYY): …" diye açıkça etiketlenerek girebilir. Tek anekdotla
     genelleme yapma. Resmi kuralla çelişirse resmi kuralın yerine geçmez, en fazla yanına not
     düşülür.

### Kurallar
- Her olgusal iddia (tutar, süre, tarih, belge adı, kural) bir kaynağa bağlı; kaynaksız iddia
  yazılmaz.
- Değişken bilgilerde "Son doğrulama: GG.AA.YYYY" damgası; tüm bu değerler `data/degerler.yml`'de,
  her biri `kaynak` + `dogrulama_tarihi` ile.
- Kaynaklar çelişirse en yeni tarihli birincili esas al, çelişkiyi `docs-internal/celiskiler.md`'ye
  yaz, sayfada belirt.
- Kuruma/şehre göre değişeni genelleme, okuru kendi kurumuna yönlendir.
- Emin olmadığını emin gibi yazma.
- Site bilgi verir, danışmanlık vermez — her sayfada aynı kısa sorumluluk reddi; vize/ikamet
  sayfalarında "nihai söz konsolosluk ve Ausländerbehörde'nindir".

## 3. Mutlaka araştırılacak konular

Her değeri canlı birincil kaynaktan bul, `data/degerler.yml`'e kaynak + tarihle gir: Sperrkonto
tutarı, öğrenci çalışma gün limiti (AufenthG §16b, BeschV), asgari ücret/Minijob sınırı, Anmeldung
süresi, iş arama oturumu süresi (§20 AufenthG) + Mavi Kart eşikleri, APS belgesi (Türkiye için
durum), Türkiye'de öğrenci vizesi başvuru kanalı, AB dışı öğrenci harcı olan eyaletler, yasal
sağlık sigortası öğrenci tarifesi, Sperrkonto/sigorta sağlayıcı karşılaştırması, uni-assist
ücretleri/süreleri, dil sınavı ücretleri (Türkiye), T.C. tarafı (askerlik tecili, çıkış harcı,
apostil, tercüme, pasaport harcı), Rundfunkbeitrag.

## 4. Sitenin iskeleti

`docs/.vitepress/config.mts` sidebar'ı tüm sayfa ağacını tanımlıyor: Giriş (3), Faz 1–7 (32 adım),
7 dallanma, 6 referans, Checklist'im. Eksik adım bulursan ekle, gereksizse birleştir — hem
`docs/` hem `config.mts`'i güncelle, `ROADMAP.md`'ye not düş.

### Sayfa şablonu
```
# Adım N: <Başlık>
> ⏱ Süre: …   💶 Maliyet: …   📅 Ne zaman: …
::: info Bu adımda ne yapacaksın
2–3 cümle.
:::
## Neye ihtiyacın var
- [ ] …
## Adımlar
1. …
::: warning / ::: danger  (yalnızca gerçek risk varsa)
## Kontrol: Bu adım bitti mi?
- [ ] …
## Sık hatalar
…
## Kaynaklar  (Son doğrulama: GG.AA.YYYY)
1. …
```
Checkbox'lar localStorage'da (try/catch ile) kalıcı olsun; `/checklist` sayfasında birleşik ve
yazdırılabilir görünüm olsun.

## 5. Teknik

VitePress zaten kurulu. `.github/workflows/`'a resmi GitHub Pages deploy workflow'unu ekle (yoksa)
— repo Pages ayarı "GitHub Actions" olarak açık. Etkileşimli Vue bileşenleri: Checklist, İlerleme
çubuğu, Not dönüştürücü (Bayerische Formel), Bütçe hesaplayıcı, Geriye doğru takvim. Mobil uyumlu,
erişilebilir, harici analitik yok. CI: build + kırık link kontrolü + markdown lint. Lisans: içerik
CC BY-SA 4.0, kod MIT.

## 6. Çalışma sırası

1. Faz 0 (kısmen hazır) → tamamla.
2. Araştırma turu: önce `SOURCES.md`, sonra `data/degerler.yml`. Yazmaya bitmeden başlama.
3. Yazım: Faz 1 → 7, sonra dallanmalar, sonra referans.
4. **Doğrulama turu (ayrı geçiş, zorunlu):** her iddiayı kaynağıyla eşleştir,
   `docs-internal/dogrulama-raporu.md`'ye tablo (sayfa, iddia, kaynak, durum).
5. Acemi testi: hiçbir şey bilmeyen okur gözüyle baştan sona yürü.
6. Eksiklik taraması: forumlardan tipik takılma noktalarını Troubleshooting'e çevir; süre
   tahminlerini gerçekçi tut; geri dönüşü olmayan hataları `danger` ile işaretle.
7. Son kontrol: build temiz, link kontrolü temiz, README tam.

## 7. Teslim kriterleri

- [ ] Site build oluyor, Pages workflow'u çalışıyor, site yayında.
- [ ] 32 adımın tamamı yazılı, şablona uygun, önceki/sonraki bağlantılı.
- [ ] Tüm dallanma/referans sayfaları dolu; sözlük ≥ 80 terim.
- [ ] Tüm değişken değerler `data/degerler.yml`'de, kaynak + tarihle.
- [ ] `dogrulama-raporu.md`'de "belirsiz" kalmadı; kalanlar sayfada açıkça işaretli.
- [ ] Etkileşimli araçlar çalışıyor, kırık link yok, README tam.
- [ ] Kaynaksız olgusal cümle yok; forum bilgisi hep "Topluluk tecrübesi" etiketli.
- [ ] Birden fazla yöntemi olan her adımda tüm yöntemler karşılaştırmalı anlatılmış.

## 8. Süreklilik ve Lecko senkronu

Bu iş tek oturumda bitmez. Şöyle ilerle:

1. **`almanya-master-rehberi`ye** ilerledikçe commit + push (her faz/doğrulama turu bitince ayrı
   commit) — oturum kesilirse iş kaybolmasın. `ROADMAP.md`'yi her zaman güncel tut.
2. **`ardavault`a** (bu oturumun zaten içinde olduğu repo, `/home/user/ardavault`) her oturum
   kapanışında — context bitmeden önce ya da iş tamamen bitince — şunu yap: `CLAUDE.md` ve
   `🔮 850-Companion/Kurallar.md`'yi oku (protokol oradan), `🔮 850-Companion/Last-Session.md`'ye
   en üste yeni bir `## Session: <tarih>: <başlık>` girdisi ekle (3–6 satır: ne yapıldı, ne kaldı,
   Arda'nın kontrolü gereken yerler), `Threads.md`'deki "Almanya Master rehber sitesi" thread'ini
   güncelle, önemli bir kilometre taşıysa (site yayına girdi, doğrulama turu bitti) `Journal.md`'ye
   kısa bir giriş düş. Commit + şu an bağlı olan branch'e push et. Bu senkron ayrı klonlama
   gerektirmez — dosyalar zaten diskte.
3. Context bitmeye yaklaşırsa: önce adım 2'yi (Lecko senkronu) yap, sonra çık. Devamı gelen
   oturum aynı bu prompt'u alır, `ROADMAP.md`'den kaldığı yeri okur.
4. İş tamamen bitince son mesajında: ne yapıldı, neyi doğrulayamadın, hangi konularda Arda'nın
   kendi kontrolü şart (özellikle vize/askerlik/sigorta gibi geri dönüşü olmayan konular).
