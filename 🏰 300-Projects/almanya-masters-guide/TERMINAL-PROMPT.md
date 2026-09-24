---
title: Almanya Master Rehberi — terminal tek-seferlik prompt
created: 2026-09-24
modified: 2026-09-24
type: project
status: active
tags: [almanya, yuksek-lisans, rehber, site, prompt, terminal]
---

# Terminalde çalıştırılacak prompt

Bilgisayarında (internet erişimi kısıtlanmamış terminalde) şunu çalıştır:

```
git clone https://github.com/ardaerturkk/almanya-master-rehberi
cd almanya-master-rehberi
claude
```

Sonra Claude Code içine aşağıdaki `---8<---` çizgisinden itibaren her şeyi olduğu gibi yapıştır.

---8<---

# GÖREV

Bu repo (`almanya-master-rehberi`) Almanya'da yüksek lisans yapmak isteyen Türkçe konuşan biri
için 3ds.hacks.guide tarzında bir rehber/wiki sitesi. İskelet zaten kuruldu (VitePress, sidebar,
58 boş sayfa, `ROADMAP.md`, `SOURCES.md`). Senin işin: **araştırmak, yazmak, doğrulamak** —
iskeleti tamamlayıp yayına hazır hale getirmek. Önce `ROADMAP.md`, `SOURCES.md` ve
`docs/.vitepress/config.mts` dosyalarını oku, mevcut yapıyı öğren, sonra devam et.

Bu bir **doğruluk projesi**. Yanlış bir tarih, tutar veya belge adı birinin vizesini,
başvurusunu veya parasını yakabilir. Hız ikincil; doğruluk ve eksiksizlik birincil.

**Bu rehber kimsenin kişisel tecrübesi değildir.** Tek bir "ben böyle yaptım" hikâyesi anlatmaz;
her adımda **mevcut tüm yolları ve yöntemleri** anlatır, okurun kendi durumuna göre seçmesini
sağlar. Bir adımda birden fazla yöntem varsa (başvuru kanalı, finansman kanıtı, dil belgesi,
sigorta türü, konaklama, vize başvuru kanalı) hepsi karşılaştırmalı tabloyla, kimin için uygun
olduğu ve artı/eksileriyle yazılır. Resmi kurallar bir yolu zorunlu kılmadıkça site hiçbir yolu
"tek doğru" diye dayatmaz.

**Uydurma sıfır.** Sitedeki her bilgi gerçek, güncel ve kaynağı gösterilebilir araştırmaya
dayanır. Bulamadığın/doğrulayamadığın bilgiyi tahminle doldurma; ya çıkar ya da sayfada açıkça
"doğrulanamadı, şu kuruma sorun" diye işaretle. Ezberinden yazma — eğitim verin eskimiş olabilir,
her rakamı canlı kaynaktan doğrula.

## 0. Önce oku, sonra yaz

1. `https://3ds.hacks.guide` sitesini gez (Get Started, Site Navigation, bir iki adım sayfası,
   FAQ, Troubleshooting). Bulgularını `docs-internal/ilham-analizi.md` dosyasına yaz: sayfa
   anatomisi, navigasyon mantığı, dallanma sistemi, uyarı kutuları, "Continue to …" butonları,
   ton. Kör kopyalama yapma, deseni çıkar.
2. `ROADMAP.md`'yi güncelle: fazları checkbox olarak takip et, her iş bitince işaretle. Oturum
   kesilirse bir sonraki oturum (`claude -c` veya aynı prompt'u tekrar vererek) buradan devam eder.
3. `SOURCES.md`'yi her kaynağı kullandıkça güncelle: URL, kurum, erişim tarihi, hangi sayfada
   kullanıldığı.

## 1. Hedef kitle ve kapsam

- **Birincil okur:** Türkiye'de lisansını bitirmiş/bitirmek üzere olan, T.C. vatandaşı, Almanya'da
  Master yapmak isteyen biri. Süreç hakkında sıfır bilgi varsay: "uni-assist", "Sperrkonto",
  "Anmeldung" kelimelerini ilk kez duyuyor.
- **İkincil okur:** Türkiye dışında lisans yapmış Türk vatandaşları, çift vatandaşlar, Türkiye'de
  yaşayan yabancılar. Sapma noktalarında not düş, ayrı rota kurma.
- **Kapsam dışı (bir paragrafla yönlendir):** Lisans (Bachelor) başvurusu / Studienkolleg,
  doktora, Ausbildung, AB vatandaşları, Almanca öğretmenliği.
- **Dil:** Türkçe. Almanca/İngilizce terimler ilk geçtiği yerde parantez içinde açıklanır ve
  sözlüğe linklenir. Resmi belge/kurum adları orijinal dilinde kalır (ör. "Zulassungsbescheid").

## 2. Araştırma protokolü (bağlayıcı)

### Kaynak hiyerarşisi
1. **Birincil (tek başına yeterli):** Auswärtiges Amt ve Almanya'nın Türkiye misyonları (Ankara
   Büyükelçiliği, İstanbul/İzmir Başkonsoloslukları), Auslandsportal (digital.diplo.de),
   make-it-in-germany.com, BAMF, DAAD (daad.de, daad.org.tr), uni-assist.de, anabin (KMK),
   Hochschulkompass, üniversitelerin kendi program ve Studierendensekretariat sayfaları,
   Studentenwerk/Studierendenwerk sayfaları, gesetze-im-internet.de (AufenthG, BeschV, AufenthV),
   Bundesagentur für Arbeit, Minijob-Zentrale, Bundeszentralamt für Steuern, ARD ZDF
   Deutschlandradio Beitragsservice, T.C. resmi kaynaklar (MSB/ASAL askerlik, e-Devlet, GİB,
   Dışişleri, YÖK), dil sınavı kurumlarının resmi siteleri (TestDaF, Goethe, telc, IELTS,
   TOEFL/ETS), vize başvuru hizmet sağlayıcısının resmi sitesi (Türkiye'de güncel sağlayıcı
   hangisiyse — **kontrol et**).
2. **İkincil (birincille doğrulanmadan yazma):** Sperrkonto/sigorta sağlayıcılarının kendi
   siteleri (Fintiba, Expatrio, Coracle, TK, AOK vb.; ticari çıkarları olduğunu unutma), büyük
   üniversitelerin International Office rehberleri.
3. **Üçüncül (destekleyici, açıkça etiketlenerek):** Reddit (r/germany, r/studyingermany), ekşi
   sözlük, forumlar, Türk öğrenci toplulukları, YouTube, danışmanlık firması blogları, kişisel
   bloglar. İki kullanım biçimi var:
   - **Soru kaynağı olarak:** İnsanlar nerede takılıyor, neyi soruyor — buradan çıkan her
     soru/sorun, cevabı birincil (gerekirse ikincil) kaynaktan doğrulanarak siteye girer.
   - **Destekleyici bilgi olarak:** Resmi kaynağın söylemediği ama sahada gerçekten yaşanan bir
     pratikse (tipik bekleme süresi, bir sağlayıcıyla yaşanan somut deneyim), siteye
     **girebilir** — ama açıkça etiketlenerek: "Topluluk tecrübesi (kaynak: r/…, TT.AA.YYYY): …".
     Tek anekdotla genelleme yapma; birden fazla bağımsız kaynak aynı şeyi söylüyorsa yaz, tek
     kişinin hikâyesiyse ya atla ya da "tek bir kullanıcının tecrübesi" diye belirt.
   Resmi kuralla çelişen forum bilgisi asla resmi kuralın yerine yazılmaz; en fazla yanına not
   düşülür.

### Kurallar
- **Her olgusal iddia (tutar, süre, tarih, belge adı, kural) bir kaynağa bağlı.** Sayfa altında
  "Kaynaklar" listesi, iddianın yanında dipnot. Kaynağı olmayan iddia yazılmaz.
- **Değişken bilgilerde "Son doğrulama: GG.AA.YYYY" damgası.** Sperrkonto tutarı, harçlar,
  Minijob sınırı, asgari ücret, vize ücreti, sınav ücretleri, Semesterbeitrag, çalışma günü
  limitleri, yurt dışı çıkış harcı, dövizle askerlik bedeli, pasaport harcı: hepsi değişir. Bu
  değerleri `data/degerler.yml` dosyasında tut, sayfalarda oradan çek. Her değerin yanında
  `kaynak` ve `dogrulama_tarihi` alanı olsun.
- Kaynaklar çelişirse en yeni tarihli birincil kaynağı esas al, çelişkiyi
  `docs-internal/celiskiler.md`'ye yaz ve sayfada "kaynaklar farklı; X'i esas alın, emin olmak
  için Y'ye sorun" de.
- **Kuruma/şehre göre değişen şeyleri genelleme.** Ausländerbehörde uygulamaları, randevu
  sistemleri, Semesterbeitrag, belge onay istekleri şehirden şehre, üniversiteden üniversiteye
  farklıdır. Açıkça söyle, okuru kendi kurumunun sayfasına yönlendir.
- **Emin olmadığın şeyi emin gibi yazma.** "Genellikle", "çoğu üniversitede" gibi ifadeleri ancak
  birden fazla somut örnekle destekleyebiliyorsan kullan.
- **Hukuki/finansal tavsiye sınırı:** Site bilgi verir, danışmanlık vermez. Her sayfada kısa, aynı
  sorumluluk reddi; vize/ikamet sayfalarında "nihai söz konsolosluk ve Ausländerbehörde'nindir".

## 3. Mutlaka araştırılacak konular (kontrol listesi)

Aşağıdaki her değeri canlı birincil kaynaktan bul, `data/degerler.yml`'e kaynak ve tarihle gir:

- Sperrkonto'nun güncel yıllık/aylık tutarı ve nasıl belirlendiği (Auswärtiges Amt).
- Öğrencilerin yıllık çalışma gün limiti ve Werkstudent/HiWi/zorunlu staj istisnaları (AufenthG
  §16b, BeschV).
- Güncel asgari ücret ve Minijob sınırı (Minijob-Zentrale, BMAS).
- Anmeldung süresi ve gerekli belgeler (Bundesmeldegesetz + seçilen örnek şehirlerin Bürgeramt
  sayfaları).
- Mezuniyet sonrası iş arama oturumu süresi ve koşulları (AufenthG §20), Mavi Kart maaş eşikleri.
- APS belgesinin hangi ülke vatandaşlarından istendiği ve Türk vatandaşları için durum.
- Türkiye'de öğrenci (ulusal D) vizesi başvurusunun bugün hangi kanaldan yapıldığı (Auslandsportal
  / hizmet sağlayıcı / misyon), ücret, işlem süresi, belge listesi.
- AB dışı öğrencilerden harç alan eyaletler ve güncel tutarlar.
- Yasal sağlık sigortası öğrenci tarifesi: yaş/dönem sınırları, muafiyetin bağlayıcılığı, güncel
  katkı payları.
- Sperrkonto ve sigorta sağlayıcılarının güncel ücretleri (karşılaştırma tablosu, tarih damgalı).
- uni-assist ücretleri ve işlem süreleri; VPD'nin nasıl işlediği.
- Dil sınavlarının Türkiye'deki güncel ücretleri, sınav merkezleri, sonuç süreleri.
- T.C. tarafı: yurt dışında öğrenim tecili koşulları/belgeleri, yurt dışı çıkış harcı ve öğrenci
  muafiyeti, apostil makamları, yeminli tercüme/noter süreci, pasaport harcı.
- Rundfunkbeitrag güncel tutarı ve öğrenci muafiyeti koşulları.

## 4. Sitenin iskeleti

`docs/.vitepress/config.mts` içindeki sidebar zaten tüm sayfa ağacını tanımlıyor: Giriş (3
sayfa), Faz 1–7 (32 adım), 7 dallanma sayfası, 6 referans sayfası, Checklist'im. Araştırma
sırasında eksik adım bulursan ekle, gereksizse birleştir — hem `docs/` hem `config.mts`'i
güncellemeyi unutma, değişikliği `ROADMAP.md`'ye not düş.

### Sayfa şablonu (her adım sayfası)

```
# Adım N: <Başlık>

> ⏱ Tahmini süre: …   💶 Tahmini maliyet: …   📅 Ne zaman: …

::: info Bu adımda ne yapacaksın
2–3 cümle.
:::

## Neye ihtiyacın var
- [ ] … (her madde işaretlenebilir)

## Adımlar
### Bölüm I – …
1. …

::: warning / ::: danger  (yalnızca gerçek risk olan yerde)

## Kontrol: Bu adım bitti mi?
- [ ] …

## Sık hatalar
…

## Kaynaklar  (Son doğrulama: GG.AA.YYYY)
1. …
```

Checkbox'lar etkileşimli olsun, durumu tarayıcıda (localStorage, try/catch ile) saklansın; tüm
checklist'lerin birleşik görünümü `/checklist` sayfasında olsun, yazdırılabilir olsun.

## 5. Teknik

- VitePress zaten kurulu (`package.json`, `docs/.vitepress/config.mts`). `npm install` çalıştır,
  `npm run docs:dev` ile lokal kontrol et.
- Etkileşimli bileşenler Vue komponenti olarak: Checklist, İlerleme çubuğu, Not dönüştürücü
  (Bayerische Formel), Bütçe hesaplayıcı, Geriye doğru takvim, "Son doğrulama" rozeti (tarih 6
  aydan eskiyse sarı).
- `.github/workflows/` altına VitePress'in resmi GitHub Pages deploy workflow'unu ekle (yoksa).
  Repo Pages ayarı zaten "GitHub Actions" olarak açık.
- Mobil uyumlu, erişilebilir, hızlı. Harici takip/analitik yok.
- CI'da: build + kırık link kontrolü (ör. `lychee`) + markdown lint.
- Lisans: içerik CC BY-SA 4.0, kod MIT (README'de belirt).

## 6. Çalışma sırası

1. İlham analizi + iskelet tamamlama (Faz 0, kısmen hazır).
2. Araştırma turu: önce `SOURCES.md`'ye kaynak topla, sonra `data/degerler.yml`'i doldur. Yazmaya
   bu bitmeden başlama.
3. Yazım: Ana rotayı sırayla yaz (Faz 1 → 7), sonra dallanmalar, sonra referans.
4. **Doğrulama turu (ayrı geçiş, zorunlu):** Her sayfayı baştan sona tekrar oku, her olgusal
   iddiayı kaynağıyla eşleştir. Kaynağa bakmadan "doğrulandı" deme. Sonucu
   `docs-internal/dogrulama-raporu.md`'ye tablo olarak yaz: sayfa, iddia, kaynak, durum
   (doğrulandı / düzeltildi / çıkarıldı / belirsiz).
5. Acemi testi: Hiçbir şey bilmeyen bir okur gibi rotayı baştan sona yürü, tanımlanmadan
   kullanılan terim bırakma.
6. Eksiklik taraması: Gerçek öğrencilerin nerede takıldığını (forum taraması) Troubleshooting'e
   dönüştür; en çok hafife alınan süreleri takvime yansıt; geri dönüşü olmayan hataları `danger`
   kutusuyla işaretle.
7. Son kontrol: Build temiz, link kontrolü temiz, her sayfada "Son doğrulama" var, sorumluluk
   reddi var, README güncel.

## 7. Teslim kriterleri (bitti sayılması için)

- [ ] Site build oluyor, GitHub Pages workflow'u çalışıyor, site yayında.
- [ ] Ana rotanın tüm 32 adımı yazılı; her sayfa şablona uygun, önceki/sonraki bağlantılı.
- [ ] Tüm dallanma ve referans sayfaları dolu; sözlük ≥ 80 terim.
- [ ] Tüm değişken değerler `data/degerler.yml`'de, kaynak + doğrulama tarihiyle.
- [ ] `dogrulama-raporu.md`'de "belirsiz" satır kalmadı; kalanlar sayfada açıkça belirsiz diye
      işaretli.
- [ ] Etkileşimli checklist, not dönüştürücü, bütçe hesaplayıcı, geriye doğru takvim çalışıyor.
- [ ] Kırık link yok.
- [ ] README: proje ne, nasıl çalıştırılır, değerler nasıl güncellenir, katkı rehberi.
- [ ] Sitede kaynaksız tek bir olgusal cümle yok; her forum/topluluk kaynaklı bilgi "Topluluk
      tecrübesi" olarak açıkça etiketli ve kaynaklı, resmi kural yerine geçmiyor.
- [ ] Birden fazla yöntemi olan her adımda tüm yöntemler karşılaştırmalı olarak anlatılmış.

## 8. Nasıl çalışacaksın

Bu iş tek oturumda bitmez — 32 adım, 7 dallanma, 6 referans sayfası, hepsi kaynaklı. Şöyle ilerle:

1. Sen (Claude) `git commit` + `git push` yaparak ilerlemeyi anında kaydet, her mantıklı kilometre
   taşında (bir faz bitince, bir doğrulama turu bitince) ayrı commit at — oturum kesilirse iş
   kaybolmasın.
2. Context bitmeye yaklaşırsa veya iş kesilirse: `ROADMAP.md`'yi güncel bırak, çık.
3. Devam etmek için terminalde tekrar `cd almanya-master-rehberi && git pull && claude -c` ile
   dön, ya da yeni bir `claude` oturumunda "ROADMAP.md'yi oku ve kaldığın yerden devam et" de.
4. Sonunda son mesajında: ne yaptın, neyi doğrulayamadın, hangi konularda insan kontrolü şart
   (özellikle vize/askerlik/sigorta gibi geri dönüşü olmayan konular).

## 9. Lecko'ya senkron (ardavault hafızası) — ZORUNLU

Bu iş Arda'nın "Lecko" adlı ikinci beynine (`ardaerturkk/ardavault` reposu) bağlı ama sen ayrı bir
repoda çalışıyorsun, o vault'un hook'ları burada yok. Bu yüzden hafıza senkronunu **sen elle
yapacaksın**, otomatik olmuyor. Her oturumun sonunda (context bitmeden önce, veya iş tamamen
bitince) şunu yap:

1. `ardaerturkk/ardavault` reposunu ayrı, geçici bir klasöre klonla (bu repoyla karıştırma):
   `git clone https://github.com/ardaerturkk/ardavault /tmp/ardavault-sync`
2. O klasördeki `CLAUDE.md` ve `🔮 850-Companion/Kurallar.md`'yi oku — hafıza protokolü ve ton
   oradan geliyor, uydurmadan birebir uygula.
3. `🔮 850-Companion/Last-Session.md`'yi aç, en üste (mevcut en üstteki oturumun üzerine, onu
   silmeden — "## Previous Sessions" başlığının üstüne) yeni bir madde ekle:
   `## Session: <bugünün tarihi>: <kısa başlık>` + 3-6 satırlık özet: bu oturumda ne yapıldı,
   hangi fazlar bitti, ne kaldı, hangi konularda Arda'nın kontrolü şart.
4. `🔮 850-Companion/Threads.md`'de "Almanya Master rehber sitesi" thread'ini bul, durumunu
   güncelle (kaç adım yazıldı, doğrulama turu yapıldı mı, sıradaki ne).
5. Gerçekten önemli bir şey olduysa (site yayına girdi, doğrulama turu tamamlandı gibi)
   `🔮 850-Companion/Journal.md`'ye kısa bir giriş ekle. Küçük ilerlemeler için Journal'a yazma.
6. Commit mesajı Türkçe ve net olsun (ör. "Lecko senkron: Almanya rehberi Faz 3 tamamlandı").
   `git push origin main` (veya reponun varsayılan branch'i neyse). Push reddedilirse önce
   `git pull --rebase` yap, tekrar dene.
7. Geçici klasörü (`/tmp/ardavault-sync`) silebilirsin, `almanya-master-rehberi` reposundaki
   çalışmana geri dön.

Bunu atlama — Arda bu senkronu özellikle istedi. Küçük, sık commit'lerde her seferinde Lecko'yu
güncellemene gerek yok; ama her oturum kapanışında (context bitmeden önce) en az bir senkron
commit'i olmalı.
