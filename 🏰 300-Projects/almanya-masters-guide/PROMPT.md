---
title: Almanya Master Rehberi — site kurulum prompt'u
created: 2026-09-24
modified: 2026-09-24
type: project
status: active
tags: [almanya, yuksek-lisans, rehber, site, prompt, cau-kiel]
---

# Almanya Master Rehberi: site kurulum prompt'u

> **Nasıl kullanılır:** Boş bir GitHub reposu aç (öneri: `almanya-master-rehberi`), içinde Claude
> Code oturumu başlat, `---8<---` çizgisinden aşağısını olduğu gibi yapıştır. Ajan tek oturumda
> bitiremezse aynı prompt'u yeniden ver; `ROADMAP.md` ve `SOURCES.md` üzerinden kaldığı yerden
> devam edecek şekilde tasarlandı.

---8<---

# GÖREV

Almanya'da yüksek lisans (Master) yapmak isteyen Türkçe konuşan biri için, **hiçbir şey bilmeyen
birini sıfırdan alıp Almanya'da okula kayıtlı, ikamet izni almış, yerleşmiş hale getirene kadar**
adım adım götüren bir rehber/wiki sitesi kur. İlham: [3ds.hacks.guide](https://3ds.hacks.guide).
Oradaki hissi yakala: net sıra, her sayfada "ne lazım / ne yapacaksın / bitti mi →
sonraki adım", hata anında bakılacak Troubleshooting, sade ve güven veren ton.

**Bu rehber kimsenin kişisel tecrübesi değildir.** Tek bir kişinin "ben böyle yaptım" hikâyesini
anlatmaz; her adımda **mevcut tüm yolları ve yöntemleri** anlatır, okurun kendi durumuna göre
seçmesini sağlar ve seçtiği yolu adım adım takip edilebilir bir kontrol listesine çevirir.
Bir adımda birden fazla yöntem varsa (ör. başvuru kanalı, finansman kanıtı, dil belgesi, sigorta
türü, konaklama, vize başvuru kanalı) hepsi yan yana, karşılaştırma tablosuyla, kimin için uygun
olduğu ve artı/eksileriyle yazılır. Site hiçbir yolu "tek doğru" diye dayatmaz; ancak resmi
kurallar bir yolu zorunlu kılıyorsa bunu açıkça söyler.

**Uydurma sıfır.** Sitedeki her bilgi gerçek, güncel ve kaynağı gösterilebilir araştırmaya
dayanır. Bulamadığın veya doğrulayamadığın bilgiyi tahminle doldurma; ya çıkar ya da sayfada açıkça
"doğrulanamadı, şu kuruma sorun" diye işaretle.

Bu bir **doğruluk projesi**. Yanlış bir tarih, tutar veya belge adı birinin vizesini, başvurusunu
veya parasını yakabilir. Hız ikincil; doğruluk ve eksiksizlik birincil.

## 0. Önce oku, sonra yaz

1. `https://3ds.hacks.guide` sitesini gez (Get Started, Site Navigation, bir iki adım sayfası,
   FAQ, Troubleshooting). Bulgularını `docs-internal/ilham-analizi.md` dosyasına yaz: sayfa
   anatomisi, navigasyon mantığı, dallanma (cihaz/firmware'e göre farklı rota), uyarı kutuları,
   "Continue to …" butonları, ton. Kör kopyalama yapma, deseni çıkar.
2. `ROADMAP.md` oluştur: aşağıdaki fazları checkbox listesi olarak yaz, her iş bitince işaretle.
   Oturum kesilirse bir sonraki oturum buradan devam eder.
3. `SOURCES.md` oluştur: kullandığın her kaynak burada (URL, kurum, erişim tarihi, hangi
   sayfalarda kullanıldı).

## 1. Hedef kitle ve kapsam

- **Birincil okur:** Türkiye'de lisansını bitirmiş veya bitirmek üzere olan, T.C. vatandaşı,
  Almanya'da Master yapmak isteyen biri. Süreç hakkında sıfır bilgi varsay: "uni-assist",
  "Sperrkonto", "Anmeldung" kelimelerini ilk kez duyuyor.
- **İkincil okur:** Türkiye dışında lisans yapmış Türk vatandaşları, çift vatandaşlar, Türkiye'de
  yaşayan yabancılar. Bunlar için sapma noktalarında not düş, ayrı rota kurma.
- **Kapsam dışı (ama bir paragrafla yönlendir):** Lisans (Bachelor) başvurusu / Studienkolleg,
  doktora, Ausbildung, AB vatandaşları, Almanca öğretmenliği. Ayrıntıya girme, resmi kaynağa link ver.
- **Dil:** Türkçe. Almanca/İngilizce terimler ilk geçtiği yerde parantez içinde açıklanır ve
  sözlüğe linklenir. Resmi belge/kurum adları orijinal dilinde kalır (ör. "Zulassungsbescheid").

## 2. Araştırma protokolü (bağlayıcı)

### Kaynak hiyerarşisi
1. **Birincil (tek başına yeterli):** Auswärtiges Amt ve Almanya'nın Türkiye misyonları
   (Ankara Büyükelçiliği, İstanbul/İzmir Başkonsoloslukları), Auslandsportal
   (digital.diplo.de), make-it-in-germany.com, BAMF, DAAD (daad.de, daad.org.tr), uni-assist.de,
   anabin (KMK), Hochschulkompass, üniversitelerin kendi program ve Studierendensekretariat
   sayfaları, Studentenwerk/Studierendenwerk sayfaları, gesetze-im-internet.de (AufenthG,
   BeschV, AufenthV), Bundesagentur für Arbeit, Minijob-Zentrale, Bundeszentralamt für Steuern,
   ARD ZDF Deutschlandradio Beitragsservice, T.C. resmi kaynaklar (MSB/ASAL askerlik, e-Devlet,
   GİB, Dışişleri, YÖK), dil sınavı kurumlarının resmi siteleri (TestDaF, Goethe, telc,
   DSH bilgisi için üniversiteler, IELTS, TOEFL/ETS), vize başvuru hizmet sağlayıcısının resmi
   sitesi (Türkiye'de güncel sağlayıcı hangisiyse — iDATA mı, VFS mi, Auslandsportal mı, **kontrol et**).
2. **İkincil (birincille doğrulanmadan yazma):** Sperrkonto/sigorta sağlayıcılarının kendi
   siteleri (Fintiba, Expatrio, Coracle, TK, AOK vb.; ticari çıkarları olduğunu unutma), büyük
   üniversitelerin International Office rehberleri.
3. **Siteye kaynak olamaz:** Reddit (r/germany, r/studyingermany), ekşi sözlük, forumlar,
   Türk öğrenci toplulukları, YouTube, danışmanlık firması blogları, kişisel bloglar. Bunlar
   yalnızca **soru bulmak** için kullanılır: insanlar nerede takılıyor, neyi soruyor, hangi hatayı
   yapıyor. Bulduğun her soru/sorun, cevabı birincil (gerekirse ikincil) kaynaktan doğrulanarak
   siteye girer. Anekdot, "bana böyle oldu" hikâyesi, doğrulanmamış tecrübe siteye yazılmaz.

### Kurallar
- **Her olgusal iddia (tutar, süre, tarih, belge adı, kural) bir kaynağa bağlı.** Sayfa altında
  "Kaynaklar" listesi, iddianın yanında dipnot. Kaynağı olmayan iddia yazılmaz.
- **Değişken bilgilerde "Son doğrulama: GG.AA.YYYY" damgası.** Sperrkonto tutarı, harçlar,
  Minijob sınırı, asgari ücret, vize ücreti, sınav ücretleri, Semesterbeitrag, çalışma günü
  limitleri, yurt dışı çıkış harcı, dövizle askerlik bedeli, pasaport harcı: hepsi değişir.
  Bu değerleri tek bir `data/degerler.yml` (veya `.json`) dosyasında tut, sayfalarda oradan
  çek. Tek yerden güncellenebilsin, her değerin yanında `kaynak` ve `dogrulama_tarihi` alanı olsun.
- **Ezberinden yazma.** Eğitim verin eskimiş olabilir. Aşağıda "doğrulanacak başlangıç
  noktaları" olarak verdiğim her şey dahil, her rakamı canlı kaynaktan tekrar teyit et.
  Kaynaklar çelişirse en yeni tarihli birincil kaynağı esas al, çelişkiyi `docs-internal/celiskiler.md`
  dosyasına yaz ve sayfada "bu konuda kaynaklar farklı; X'i esas alın, emin olmak için Y'ye sorun" de.
- **Kuruma/şehre göre değişen şeyleri genelleme.** Ausländerbehörde uygulamaları, randevu
  sistemleri, Semesterbeitrag, belge onay istekleri şehirden şehre, üniversiteden üniversiteye
  farklıdır. Bunu açıkça söyle ve okuru kendi kurumunun sayfasına yönlendir.
- **Emin olmadığın şeyi emin gibi yazma.** "Genellikle", "çoğu üniversitede" gibi ifadeleri ancak
  birden fazla somut örnekle destekleyebiliyorsan kullan.
- **Hukuki/finansal tavsiye sınırı:** Site bilgi verir, danışmanlık vermez. Her sayfada kısa,
  her yerde aynı bir sorumluluk reddi; vize/ikamet sayfalarında "nihai söz konsolosluk ve
  Ausländerbehörde'nindir" notu.

## 3. Sitenin iskeleti (bilgi mimarisi)

3ds.hacks.guide'daki gibi: **Ana rota** (numaralı, sıralı), **dallanmalar** (durumuna göre farklı
sayfa), **referans** (sözlük, SSS, sorun giderme, araçlar). Aşağıdaki listeyi başlangıç kabul et;
araştırma sırasında eksik adım bulursan ekle, gereksizse birleştir, değişikliği ROADMAP'e not düş.

### Giriş
- **Ana sayfa:** Tek cümlelik vaat, "Başla" butonu, rotanın kuş bakışı haritası (zaman çizelgesi
  diyagramı), toplam süre ve bütçe aralığı özeti.
- **Başlamadan önce (Get Started):** Bu rehber kimin için, nasıl okunur, uyarı kutularının
  anlamı, sıralamayı neden bozmamalı.
- **Uygun muyum? (Öz değerlendirme):** Lisans derecesi, not ortalaması, dil, bütçe, askerlik
  durumu. Sonuca göre rotayı öneren kısa bir karar ağacı.
- **Takvim: Geriye doğru planlama:** Hedef dönem (Wintersemester / Sommersemester) seçilince
  "şu tarihe kadar şunu bitir" listesi üreten bir sayfa (tercihen etkileşimli). Tipik sürelerle:
  dil sınavı sonucu, apostil/tercüme, uni-assist değerlendirmesi (VPD dahil), vize randevusu
  ve işlem süresi.

### Faz 1: Hazırlık (başvurudan 12–18 ay önce)
1. Almanya'da Master sistemi: Universität vs Hochschule/FH, konsekutiv vs nicht-konsekutiv,
   ECTS, NC / zulassungsbeschränkt vs zulassungsfrei, Wintersemester/Sommersemester,
   harç durumu (genelde harçsız; **Baden-Württemberg AB dışı öğrenci harcı** ve diğer istisnaları
   doğrula), Semesterbeitrag, Regelstudienzeit.
2. Program bulma: DAAD International Programmes veritabanı, Hochschulkompass, filtreleme,
   İngilizce vs Almanca programlar, program sayfasını okuma rehberi (Zulassungsvoraussetzungen,
   Bewerbungsfrist, Modulhandbuch, Prüfungsordnung).
3. Uygunluk analizi: Lisansın içerik uyumu (ECTS/modül karşılaştırması), anabin'de üniversite
   (H+) ve derece statüsü, not dönüştürme (Modifizierte Bayerische Formel; uni-assist'in
   hesapladığı not), "fachliche Eignung", ön koşul dersler.
4. Dil: İngilizce programlar (IELTS Academic, TOEFL iBT, Cambridge; hangi skor tipik; "Medium of
   Instruction" belgesi kabul ediliyor mu), Almanca programlar (TestDaF, DSH, Goethe C1/C2,
   telc C1 Hochschule), Türkiye'de sınav merkezleri, ücretler, sonuç süreleri. Almancasız
   gidenler için de minimum A1–A2 önerisi ve gerekçesi (günlük hayat, iş).
5. GRE/GMAT ve diğer testler: Nerede istenir, nerede istenmez.
6. Bütçe planı: Sperrkonto tutarı, vize/sigorta/uçak/depozito/ilk ay masrafları, şehir bazlı
   yaşam maliyeti aralıkları, burs seçenekleri (DAAD, Deutschlandstipendium, vakıflar,
   Stiftungen). Finansman kanıtı alternatifleri: Sperrkonto, Verpflichtungserklärung, burs belgesi.
7. Askerlik (T.C. erkek vatandaşlar): Yükseköğrenim tecili ve yurt dışında öğrenim tecili
   nasıl işler, yaş sınırları, yoklama kaçağı durumuna düşmeme, tecil için gereken belgeler,
   ileride dövizle askerlik seçeneği. **Sadece MSB/ASAL ve mevzuat kaynaklı yaz.**

### Faz 2: Belgeler (başvurudan 6–12 ay önce)
8. Belge listesi (master checklist): Diploma, transkript, diploma eki (Diploma Supplement),
   lise diploması (bazı başvurularda istenir, doğrula), pasaport, dil belgesi, CV, motivasyon
   mektubu, referans mektupları, iş/staj belgeleri, modül açıklamaları.
9. Onay/tasdik/tercüme: Apostil (Türkiye'de hangi kurum; valilik/kaymakamlık/adalet komisyonu,
   doğrula), yeminli tercüme + noter, "amtlich beglaubigte Kopie" ne demek, Türkiye'de nerede
   yapılır (Alman misyonları beglaubigung yapıyor mu, doğrula), uni-assist'in hangi belgeyi
   hangi formatta istediği (dijital yükleme vs posta), İngilizce belgelerde tercüme gerekmez mi.
10. CV (Almanya formatı, Europass tartışması), motivasyon mektubu (yapı, uzunluk, program
    özelinde yazma, yapılmaması gerekenler), referans mektubu (hocadan nasıl istenir, portal
    üzerinden yükleme).

### Faz 3: Başvuru
11. Başvuru kanalını belirleme: Doğrudan üniversite portalı / uni-assist / uni-assist VPD +
    üniversite portalı / Hochschulstart (Master'da nadir, doğrula). Her birinin akışı.
12. uni-assist adım adım: Hesap açma, başvuru ücretleri (ilk başvuru / ek başvuru, doğrula),
    belge yükleme, ödeme, VPD nedir, işlem süreleri, "evaluation" sonucu, sık hata ve eksik belge
    bildirimleri.
13. Üniversite portalı (örnek ekran akışlarıyla ama genel), son tarihler (tipik 15 Temmuz /
    15 Ocak; ancak uluslararası öğrenciler için çok daha erken olabilir, programa göre değişir).
14. Beklemek: Ne zaman sonuç gelir, bekleme listesi, ret sonrası ne yapılır, itiraz.
15. Kabul (Zulassungsbescheid): Kabul şartları (Auflagen), kabulü onaylama/kayıt yenileme süresi,
    birden fazla kabul varsa.

### Faz 4: Vize
16. Vize türü: Öğrenim vizesi (§16b AufenthG), şartlı kabul/dil kursu durumları, başvuru adayı
    vizesi (§17). Türkiye'de başvuru kanalı: **güncel durumda Auslandsportal mı, iDATA mı, başka
    bir hizmet sağlayıcı mı; kesin olarak doğrula ve tarih damgası koy.** Randevu stratejisi.
17. Sperrkonto açma adım adım: Sağlayıcı karşılaştırması (tablo: kurulum ücreti, aylık ücret,
    süre, sigorta paketi), Türkiye'den para transferi (SWIFT, döviz, banka limitleri, masraflar),
    onay belgesi.
18. Sağlık sigortası: Vize için gereken seyahat/incoming sigortası vs kayıt için zorunlu yasal
    sigorta (gesetzliche Krankenversicherung, 30 yaş sınırı ve istisnalar, doğrula), özel sigorta
    ve muafiyet (Befreiung) tuzakları, Türkiye–Almanya sosyal güvenlik anlaşması etkisi (doğrula).
19. Vize belgeleri checklist (konsolosluk listesine birebir dayanarak), form doldurma, ücret,
    biyometrik fotoğraf standardı, mülakat, işlem süresi, ret durumunda remonstrasyon.
20. Vizeyi aldıktan sonra: Vize üzerindeki bilgileri kontrol etme, geçerlilik süresi, giriş.

### Faz 5: Gitmeden önce
21. Konaklama: Studierendenwerk yurtları (erken başvuru), WG-Gesucht, özel yurtlar,
    dolandırıcılık uyarıları (para göndermeden görmeden kiralama), Wohnungsgeberbestätigung'un
    önemi (Anmeldung için şart).
22. Türkiye tarafı işler: Yurt dışı çıkış harcı ve öğrenci muafiyeti (doğrula), vekaletname,
    e-Devlet/banka/telefon, ehliyet (Almanya'da ne kadar geçerli, dönüşüm, doğrula),
    ilaçlar/reçeteler, aşı kartı.
23. Bavul ve ilk hafta çantası checklist'i: Hangi belgelerin aslı yanında olmalı.

### Faz 6: Almanya'da ilk haftalar
24. Varış günü: Ulaşım, SIM kart, Deutschlandticket / Semesterticket.
25. Anmeldung (Bürgeramt, süre sınırı, randevu, gerekli belgeler).
26. Immatrikulation: Kayıt, Semesterbeitrag ödeme, sigorta bildirimi, öğrenci kartı.
27. Banka hesabı (Sperrkonto'dan aylık ödeme akışı), Steuer-ID'nin posta ile gelmesi.
28. Ausländerbehörde: Oturum izni (Aufenthaltserlaubnis) başvurusu, vize bitmeden yapılması,
    eAT kartı, Fiktionsbescheinigung.
29. Rundfunkbeitrag, telefon/internet sözleşmeleri, sigorta (Haftpflicht önerisi).

### Faz 7: Okurken ve sonrasında
30. Çalışma hakları: Yıllık gün limiti (tam/yarım gün), Werkstudent, HiWi, Minijob, zorunlu
    staj istisnası, vergi ve sosyal güvenlik etkileri. **Güncel mevzuata göre yaz (2024
    reformu sonrası rakamları doğrula).**
31. Oturum izni uzatma, program değişikliği, uzama.
32. Mezuniyet sonrası: İş arama izni (süre, doğrula), AB Mavi Kart, §18a/§18b, kalıcı oturuma
    giden yol (genel çerçeve + resmi kaynağa link).

### Dallanma sayfaları (rotadan sapmalar)
- "Almanca programa mı, İngilizce programa mı?"
- "uni-assist mi, doğrudan başvuru mu?"
- "Sperrkonto mu, Verpflichtungserklärung mı, burs mu?"
- "30 yaş üstüyüm / sigorta istisnası"
- "Şartlı kabul (bedingte Zulassung) aldım"
- "Lisansım henüz bitmedi (son sınıf başvurusu)"
- "Vize reddi aldım"
Her dallanma sayfası, ana rotaya nereden geri döneceğini net söyler.

### Referans
- **Sözlük:** Tüm Almanca/teknik terimler (en az 80 madde), her biri kısa tanım + ilgili sayfa.
- **SSS**
- **Sorun giderme (Troubleshooting):** Belirti → sebep → çözüm formatında. Ör: "uni-assist
  belgemi kabul etmedi", "Anmeldung randevusu bulamıyorum", "Ausländerbehörde'den cevap yok,
  vizem bitiyor", "Sperrkonto parası gelmedi", "vize randevusu yok".
- **Belge şablonları / örnekler:** CV iskeleti, motivasyon mektubu iskeleti (içerik değil yapı),
  e-posta şablonları (Almanca/İngilizce: üniversiteye soru, ev sahibine mesaj, Ausländerbehörde'ye
  randevu talebi).
- **Araçlar:** Not dönüştürücü (Bayerische Formel, formülü kaynakla birlikte göster), bütçe
  hesaplayıcı, geriye doğru takvim, indirilebilir/yazdırılabilir master checklist.
- **Kaynaklar ve katkı:** Tüm resmi linkler kategorili; nasıl hata bildirilir; değişiklik günlüğü.

## 4. Sayfa şablonu (her adım sayfası)

```
# Adım N: <Başlık>
[Rota ilerleme çubuğu: Faz X / Adım N]

> ⏱ Tahmini süre: …   💶 Tahmini maliyet: …   📅 Ne zaman: …

::: info Bu adımda ne yapacaksın
2–3 cümle.
:::

## Neye ihtiyacın var
- [ ] … (her madde işaretlenebilir)

## Adımlar
### Bölüm I – …
1. …
2. …

::: warning / ::: danger  (yalnızca gerçek risk olan yerde)

## Kontrol: Bu adım bitti mi?
- [ ] …

## Sık hatalar
…

## Kaynaklar  (Son doğrulama: GG.AA.YYYY)
1. …

[← Önceki adım]            [Sonraki adım: … →]
```

Checkbox'lar etkileşimli olsun ve durum tarayıcıda (localStorage, try/catch ile) kalsın; ayrıca
tüm checklist'lerin birleşik görünümü "Checklist'im" sayfasında bulunsun, yazdırılabilir olsun.

## 5. Teknik

- **VitePress** (Markdown tabanlı, hızlı, yerleşik arama, sidebar, custom container'lar,
  dark mode). 3ds.hacks.guide ile aynı sınıftan bir statik doküman sitesi. Gerekçeli bir sebep
  bulursan (ör. Docusaurus'un versiyonlama/i18n avantajı) değiştirebilirsin, kararı
  `docs-internal/kararlar.md`'ye yaz.
- Deploy: GitHub Pages + GitHub Actions workflow'u. `base` ayarını repo adına göre yap.
- Etkileşimli bileşenler Vue komponenti olarak: Checklist, İlerleme çubuğu, Not dönüştürücü,
  Bütçe hesaplayıcı, Geriye doğru takvim, "Son doğrulama" rozeti (tarih 6 aydan eskiyse sarı).
- Mobil uyumlu, erişilebilir (kontrast, klavye), hızlı. Harici takip/analitik yok.
- `data/degerler.yml` → tüm değişken değerlerin tek kaynağı (bkz. Araştırma protokolü).
- CI'da: build + kırık link kontrolü (ör. `lychee`) + markdown lint.
- Lisans: içerik CC BY-SA 4.0, kod MIT (README'de belirt).

## 6. Çalışma sırası (fazlar)

1. **İlham analizi + iskelet:** VitePress kurulumu, sidebar, boş sayfalar, şablon, bileşen
   taslakları. Build'in geçtiğini gör.
2. **Araştırma turu:** Her sayfa için önce kaynakları topla (`SOURCES.md`), sonra
   `data/degerler.yml` değerlerini doldur. Yazmaya bu bitmeden başlama.
3. **Yazım:** Ana rotayı sırayla yaz (Faz 1 → 7), sonra dallanmalar, sonra referans.
4. **Doğrulama turu (ayrı geçiş, zorunlu):** Her sayfayı baştan sona tekrar oku ve her
   olgusal iddiayı kaynağıyla tek tek eşleştir. Kaynağa açıp bakmadan "doğrulandı" deme. Sonucu
   `docs-internal/dogrulama-raporu.md`'ye tablo olarak yaz: sayfa, iddia, kaynak, durum
   (doğrulandı / düzeltildi / çıkarıldı / belirsiz).
5. **Acemi testi:** Kendini hiçbir şey bilmeyen bir okur olarak konumla ve rotayı başından
   sonuna yürü. Her "bu ne demek?", "şimdi ne yapıyorum?", "bu adımı neden şimdi yapıyorum?"
   anını kaydet ve düzelt. Tanımlanmadan kullanılan terim kalmasın.
6. **Eksiklik taraması:** Aşağıdaki soruları sor ve cevabı sitede yoksa ekle:
   - Gerçek bir öğrenci bu süreçte hangi noktalarda takılıyor? (Forumlardan tipik sorunları çıkar,
     Troubleshooting'e dönüştür, çözümü birincil kaynakla yaz.)
   - Hangi adımın süresi en çok hafife alınıyor? Takvimde yansıyor mu?
   - Geri dönüşü olmayan hatalar hangileri? (Ör. yanlış sigorta muafiyeti, oturum izni süresini
     kaçırmak, askerlik tecil süresi.) Her biri `danger` kutusuyla işaretli mi?
7. **Son kontrol:** Build temiz, link kontrolü temiz, tüm sayfalarda "Son doğrulama" var,
   sorumluluk reddi var, README'de nasıl güncellenir anlatılıyor.

## 7. Mutlaka araştırılacak konular (kontrol listesi)

Aşağıdaki konular sitede eksiksiz yer almalı. Buraya bilerek rakam yazmadım: tüm değerleri
canlı birincil kaynaktan bul, `data/degerler.yml`'e kaynak ve tarihle gir.

- Sperrkonto'nun güncel yıllık/aylık tutarı ve nasıl belirlendiği (Auswärtiges Amt).
- Öğrencilerin yıllık çalışma gün limiti ve Werkstudent/HiWi/zorunlu staj istisnaları (AufenthG §16b, BeschV).
- Güncel asgari ücret ve Minijob sınırı (Minijob-Zentrale, BMAS).
- Anmeldung süresi ve gerekli belgeler (Bundesmeldegesetz + seçilen örnek şehirlerin Bürgeramt sayfaları).
- Mezuniyet sonrası iş arama oturumu süresi ve koşulları (AufenthG §20), Mavi Kart maaş eşikleri.
- APS belgesinin hangi ülke vatandaşlarından istendiği ve Türk vatandaşları için durum.
- Türkiye'de öğrenci (ulusal D) vizesi başvurusunun bugün hangi kanaldan yapıldığı
  (Auslandsportal / hizmet sağlayıcı / misyon), ücret, işlem süresi, belge listesi.
- AB dışı öğrencilerden harç alan eyaletler ve güncel tutarlar.
- Yasal sağlık sigortası öğrenci tarifesi: yaş/dönem sınırları, muafiyetin bağlayıcılığı, güncel katkı payları.
- Sperrkonto ve sigorta sağlayıcılarının güncel ücretleri (karşılaştırma tablosu, tarih damgalı).
- uni-assist ücretleri ve işlem süreleri; VPD'nin nasıl işlediği.
- Dil sınavlarının Türkiye'deki güncel ücretleri, sınav merkezleri, sonuç süreleri.
- T.C. tarafı: yurt dışında öğrenim tecili koşulları ve belgeleri, yurt dışı çıkış harcı ve
  öğrenci muafiyeti, apostil makamları, yeminli tercüme/noter süreci, pasaport harcı.
- Rundfunkbeitrag güncel tutarı ve öğrenci muafiyeti koşulları.

## 9. Teslim kriterleri (bitti sayılması için)

- [ ] Site build oluyor, GitHub Pages'e deploy workflow'u hazır.
- [ ] Ana rotanın tüm adımları yazılı; her sayfa şablona uygun, önceki/sonraki bağlantılı.
- [ ] Tüm dallanma ve referans sayfaları var; sözlük ≥ 80 terim.
- [ ] Tüm değişken değerler `data/degerler.yml`'de, kaynak + doğrulama tarihiyle.
- [ ] `dogrulama-raporu.md`'de "belirsiz" satır kalmadı; kalanlar sayfada açıkça belirsiz diye
      işaretli.
- [ ] Etkileşimli checklist, not dönüştürücü, bütçe hesaplayıcı, geriye doğru takvim çalışıyor.
- [ ] Kırık link yok.
- [ ] README: proje ne, nasıl çalıştırılır, değerler nasıl güncellenir, katkı rehberi.
- [ ] Sitede kaynaksız tek bir olgusal cümle yok; forum/anekdot kaynaklı içerik yok.
- [ ] Birden fazla yöntemi olan her adımda tüm yöntemler karşılaştırmalı olarak anlatılmış.
- [ ] Son mesajında: ne yaptın, neyi doğrulayamadın, hangi konularda insan kontrolü şart.
