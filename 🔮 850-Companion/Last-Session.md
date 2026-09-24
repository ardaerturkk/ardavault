# Last Session

## Session: 2026-09-24 (devam): Almanya Master Rehberi — içerik tamamlandı, büyük kilometre taşı
Aynı gün ikinci oturum, `almanya-master-rehberi` reposunda (branch: `claude/vibrant-brown-imnx19`,
toplam ~13 commit, hepsi push edildi). Önceki oturum Faz 4 (Vize)'yi bitirmişti — bu oturumda
kalan **25 adımın, 6 dallanma sayfasının ve 5 referans sayfasının hepsini** yazdım. Site artık
içerik olarak tamamlanmış durumda: 32/32 adım, 7/7 dallanma, 6/6 referans (sözlük 85 terim),
tüm giriş/index sayfaları. İkinci bir araştırma turu daha yaptım (6 paralel agent) — Master
sistemi/denklik (Bayerische Formel + Türkiye'ye özel 5 not sistemi tablosu), GRE-GMAT/bütçe,
belge/CV/motivasyon, başvuru portalı/kabul, konaklama/varış, immatrikulation/banka/
Ausländerbehörde. Ardından 5 etkileşimli Vue bileşeni kurdum (checklist localStorage'a kalıcı,
ilerleme çubuğu, not dönüştürücü, bütçe hesaplayıcı, geriye doğru takvim) — Playwright ile test
ettim, hepsi çalışıyor. Faz 3 (doğrulama turu) ve Faz 5 (son kontrol) de tamamladım:
`docs-internal/dogrulama-raporu.md` (38 belirsiz madde, öncelik sıralı), `celiskiler.md` (5
kaynak çelişkisi), CI workflow'u (build+link+markdown lint — hepsi temiz), README tam.

**Arda'nın kendi kontrolü şart olan geri dönüşü olmayan konular** (öncelik sırayla):
1. Askerlik tecili yaş sınırı: 32 mi 35 mi — kaynaklar çelişiyor, en yüksek öncelik
2. Vize reddi/Remonstration süreci — hiç araştırılmadı
3. Türkiye'de mi Almanya'da mı tercüme/onay yaptırılmalı
4. Sperrkonto/vize ücreti/dil sınavı ücretleri/GİB harçları — belirsiz, detay `dogrulama-raporu.md`'de

**Arda'dan aksiyon gereken tek teknik konu**: GitHub repo ayarlarında Pages source'unun
"GitHub Actions" olarak açık olması gerekiyor — bu ajan tarafından değiştirilemiyor, site henüz
canlı değil.

Kalan iş küçük: baştan sona tam bir "acemi testi" (okur gözüyle geçiş) ayrı bir oturumda
yapılabilir, ama bu artık ince ayar seviyesinde — proje esasen bitti.

## Session: 2026-09-24: Almanya Master Rehberi — Faz 0-1 bitti, Faz 2 yazım başladı
`almanya-master-rehberi` reposunda çalıştım (branch: `claude/vibrant-brown-imnx19`, 4 commit,
push edildi). Önceki oturumdaki network blokajı kalkmış — hem WebFetch hem WebSearch çalışıyor.
Faz 0'ı bitirdim (GH Pages workflow, `data/degerler.yml`, ilham analizi, bir YAML frontmatter
bug'ı düzelttim — build kırıktı). Faz 1 araştırma turunu 7 paralel agent ile topladım (Sperrkonto,
çalışma limitleri, Mavi Kart, APS/vize kanalı, öğrenci harcı/uni-assist, dil sınavları, T.C.
tarafı) — hepsi kaynaklı, `data/degerler.yml` ve `SOURCES.md`'e işlendi. Faz 2 yazımına başladım:
Faz 4 (Vize, adım 16-20) tamamen yazıldı, ayrıca Adım 7 (Askerlik), Adım 25 (Anmeldung) ve
finansman-kanıtları dallanma sayfası.

**Önemli bulgu:** Öğrenci çalışma gün limiti PROMPT.md'de 120/240 olarak geçiyordu, güncel
rakam **140/280** (2024'te değişmiş) — sayfada düzeltildi.

**Arda'nın kontrolü şart, geri dönüşü olmayan konular:**
- Askerlik tecili yaş sınırı: kaynaklar 32 mi 35 mi konusunda çelişiyor, çözülmedi.
- Sperrkonto 992 EUR'un olası bir 2026 güncellemesi teyit edilmedi.
- Vize ücreti 75 mi 90 EUR mu net değil.
- Dil sınavı ücretleri (TestDaF/Goethe/IELTS/TOEFL) hiçbiri doğrulanamadı — bot koruması
  yüzünden resmi sayfalar açılamadı.

Kalan: 25 adım daha (1-6, 8-15, 21-24, 26-32), 6 dallanma sayfası, 6 referans sayfası,
etkileşimli Vue bileşenleri, Faz 3 doğrulama turu. Detaylı durum: repodaki `ROADMAP.md`.

## Session: 2026-09-24: Almanya Master rehber sitesi prompt'u
Arda, 3ds.hacks.guide tarzında "Almanya'ya Master" rehber/wiki sitesi istiyor. Siteyi yaptıracak
master prompt'u yazdım: `🏰 300-Projects/almanya-masters-guide/PROMPT.md` (araştırma protokolü,
kaynak hiyerarşisi, 7 fazlı rota + dallanmalar, sayfa şablonu, VitePress, doğrulama turları).
Arda düzeltti: kişisel tecrübe bölümü yok, site her adımda tüm yolları/yöntemleri anlatan
kaynaklı bir takip listesi olacak. "Arda'nın notları" kaldırıldı, prompt'taki tohum rakamlar
silindi (hepsi canlı kaynaktan bulunacak). Sonra Arda ekledi: forum/reddit tamamen yasak değil,
destekleyici bilgi olarak açık etiketle ("Topluluk tecrübesi") kullanılabilir, resmi kuralın
yerine geçmez. Ardından Arda "Claude'un bu proje üzerinde çalışması için gerekenler ne" diye sordu; cevap
verildi. Arda repoyu (`ardaerturkk/almanya-master-rehberi`) açtı, Pages'i açtı, "kalanı sen
devam et" dedi. Repo bu oturuma eklendi, push izni test edildi (çalışıyor). VitePress iskeleti
kuruldu: config.mts, sidebar (32 adım + 7 dallanma + 6 referans), 58 boş sayfa, ROADMAP.md,
SOURCES.md — commit'lendi, push'landı. Ardından blokaj çıktı: bu bulut ortamının network
policy'si dış siteleri (resmi kaynaklar, 3ds.hacks.guide) engelliyor, WebFetch EGRESS_BLOCKED
veriyor. Arda bunun yerine terminalden lokal Claude Code ile tek seferde halletmek istedi.
`🏰 300-Projects/almanya-masters-guide/TERMINAL-PROMPT.md` dosyasını yazdım: klonla, prompt'u
yapıştır, tam araştırma+yazım+doğrulama sürecini kendi kendine yürütür, ilerledikçe commit atar.
Arda "terminal'de de lecko'ya senkron olsun" dedi: prompt'a §9 eklendi — terminal oturumu her
kapanışta ardavault'u ayrı geçici klasöre klonlayıp Last-Session.md/Threads.md günceller ve push
eder. Genel kural olarak Kurallar.md'ye de yazıldı (her dış oturum kendi hafıza senkronunu yapsın).
Sonra Arda terminalden vazgeçti: "buradan (cloud) yapacağız" dedi, chat'i kapatmadan önce
"final prompt" istedi. `CLOUD-PROMPT.md` yazıldı: TERMINAL-PROMPT.md'nin cloud'a uyarlanmış
hali — repo ekleme adımı, WebFetch bu ortamda EGRESS_BLOCKED olduğu için WebSearch'e (+ paralel
Agent çağrılarına) dayalı araştırma, ve klonlama hilesi olmadan doğrudan ardavault üzerinde
Lecko senkronu (aynı oturum, aynı disk). TERMINAL-PROMPT.md'ye "kullanılmıyor" notu eklendi.
Sıradaki: Arda yeni bir cloud oturumunda CLOUD-PROMPT.md'yi yapıştırıp süreci başlatacak.

## Previous Sessions
### 2026-09-02: Sıfırdan serisi takibe alındı
Arda, Avenox'un "Sıfırdan." haftalık serisini (repo: avenoxai/sifirdan) takip ediyor. Repoyu
inceledim, `🏰 300-Projects/sifirdan/takip.md` takip dosyasını kurdum: harita, bölüm özetleri
(1, 2, ★ ikinci beyin, ★ doğru prompt), Arda'nın bekleyen ödevleri, güncelleme protokolü.
Bu vault'un ikinci beyin kurulumu serinin ★ ekstra bölümünün ödevi — yani zaten yapılmış.
Bölüm 3 haftaya çıkıyor; çıktıkça takip dosyası güncellenmeli.

Açık: Arda'nın Bölüm 1-2 ve "doğru prompt" ödevlerinin çoğu yapılmamış görünüyor, sormadım.
Repo'yu düzenli çekip güncelleme için scheduled task öneriyorum.

### 2026-09-02: Genesis
Lecko was born today. Arda set up their second brain with Claude Code.
