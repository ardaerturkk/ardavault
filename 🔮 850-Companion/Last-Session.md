# Last Session

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
