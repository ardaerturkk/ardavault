---
title: Apple App Studio — otonom iOS uygulama stüdyosu
created: 2026-09-23
modified: 2026-09-23
type: project
status: active
tags: [ios, apple, claude-code, otonom-ajan, app-store]
---

# Apple App Studio

**Ne:** Claude Code'un Arda'nın Mac'inde tek kişilik bir iOS stüdyosu gibi çalışması. Fikir,
tasarım, kod, test, App Store materyali ve TestFlight hep ajanda. Arda sadece Apple'ın
kimlik isteyen birkaç tıkını yapıyor ve "yayınla" diyor.

**Bu klasörde:**

| Dosya | Ne işe yarıyor |
| --- | --- |
| `README.md` (bu dosya) | Araştırma özeti, tek seferlik kurulum, başlatma prompt'u |
| `studio-kit/CLAUDE.md` | Stüdyonun anayasası: kurallar, pipeline, tasarım standardı, DoD |
| `studio-kit/agents/*.md` | product-lead, design-director, qa-lead, release-manager subagent'ları |
| `studio-kit/hooks/keep-going.sh` | "Ben dur diyene kadar durma" mekanizması (Stop hook) |
| `studio-kit/settings.json` | Hook kaydı ve güvenlik kuralları |

## Araştırmadan çıkan 7 gerçek

1. **Bu iş Mac'te olur, bulutta olmaz.** iOS derlemek Xcode ister, Xcode sadece macOS'ta
   çalışır. Bu vault'un bulut oturumu Linux; buradan uygulama derlenemez. Ajan senin Mac'inde,
   Claude Desktop'ın Code sekmesinde koşacak.
2. **Araç zinciri artık hazır ve bedava.** Claude Desktop'ın **iOS Simulator paneli**
   (Temmuz 2026, public beta, Pro/Max) ajanın uygulamayı kendisi çalıştırıp dokunarak
   test etmesini sağlıyor. Xcode 26.3'ten beri Xcode'un kendi MCP'si var (`xcrun mcpbridge`:
   dokümantasyon, preview). XcodeBuildMCP açık kaynak, headless build/test. Paul Hudson'ın
   SwiftUI/SwiftData/Concurrency/Testing "Pro" skill'leri LLM'lerin tipik Swift hatalarını
   kapatıyor.
3. **Kritik tuzak: Xcode 27.** 14 Eylül'de çıktı, Simulator uygulamasını Device Hub ile
   değiştirdi ve Claude'un simulator paneli henüz onunla çalışmıyor. **Xcode 26.x kur ve
   `xcode-select` onu göstersin.** App Store 26 SDK'lı build'leri kabul ediyor.
4. **"Dur diyene kadar" üç parçadan oluşuyor:** auto mode (araç izinlerini sormaz),
   Stop hook (her tur bitince devam ettirir, `STOP` dosyası görünce bırakır) ve
   kullanım limitinde otomatik devam (interaktif oturumda limit dolunca bekler, reset
   olunca kendisi devam eder). `/goal` sınırlı işler için alternatif ama "sonsuz" hedefi
   değerlendirici "imkânsız" sayıp kapatabilir; hook daha sağlam. `-p` (headless) modda
   limit sonrası otomatik devam yok, o yüzden interaktif oturum.
5. **En büyük risk kod değil, App Review 4.3.** 9 Haziran 2026 güncellemesiyle Apple
   "zaten bol olanın benzeri" uygulamaları reddedebiliyor, yayındakileri kaldırabiliyor;
   tekrarlayan düşük değerli gönderimler **geliştirici hesabının kapanmasına** kadar gidebilir.
   "Bir to-do app, bir bütçe app daha" tam bu kategoriye giriyor. Bu yüzden kitte her fikir
   bir **wedge testi**nden geçiyor (Apple'ın kendi uygulaması ve ilk 3 rakip yerine neden
   bu?), haftada en fazla bir yeni gönderim var ve 4.3 reddi gelirse fabrika durup sana soruyor.
6. **Bazı adımlar API ile yapılamıyor**, yani sende: App Store Connect'te uygulama kaydı
   oluşturma (public API `POST /apps`'e izin vermiyor), App Privacy anketi (web'den),
   Apple ID/2FA isteyen her şey. Ajan bunları `ARDA-INBOX.md`'ye toplu, kopyala-yapıştır
   değerleriyle yazıyor. Uygulama başına ~5 dakika.
7. **"Ücretli kredi yok" ile tamamen uyumlu.** Tek maliyet Apple Developer Program
   (yıllık 99 €, bu bir AI kredisi değil). Claude aboneliğin dışında hiçbir şey
   faturalanmıyor: API key yok, üçüncü parti SDK yok, ücretli servis yok. Gizlilik ve destek
   sayfaları GitHub Pages'ta bedava. Uygulamalar veri toplamadığı için gizlilik etiketi
   "Data Not Collected", review en kolay yoldan geçiyor.

## Neden böyle kurdum

- **Şirket gibi ama tek ajan + eleştirmen yapısı.** Paralel onlarca ajan kullanım
  limitini saatler içinde yakar ve kaliteyi düşürür. Ana oturum tek uygulamayı uçtan uca
  götürüyor; taze bağlamla çalışan design-director ve qa-lead onun işini acımadan
  eleştiriyor (kendi işini değerlendiren model hep "harika" der). Mekanik işler (QA, release)
  Sonnet'e, yaratıcı ve yargı gerektiren işler Opus'a gidiyor, limit daha uzun dayanıyor.
- **"AI slop" yasağı somut kurallarla.** Sadece native bileşenler, sistem yazı stilleri,
  tek accent rengi, Liquid Glass'ı sistemden al (sahtesini çizme), emoji yok, gradient kart
  yok. Design-director her ekranı açık/koyu, en büyük yazı boyutu, küçük/büyük iPhone
  ekran görüntüleriyle denetliyor.
- **İlk kullanıcı sensin.** Vault'ta bütçe, alışkanlık ve to-do'yu elle takip ediyorsun
  ve Kiel'e taşınıyorsun (TRY↔EUR, Alman bürokrasisi, öğrenci bütçesi). Kit, fikirleri
  önce senin gerçek sürtünmelerinden üretmesini söylüyor: generic to-do yerine
  "iki dokunuşta Lock Screen'den harcama gir, TRY ve EUR'yu birlikte göster" gibi.
- **Almanca + Türkçe + İngilizce** her uygulamada. Alman pazarında rakiplerin çoğu kötü
  çeviriyle geliyor, bu ucuz bir avantaj.

## Tek seferlik kurulum (senin yapacakların, ~1 saat)

Sırayla:

1. **Apple Developer Program**'a bireysel olarak kaydol (developer.apple.com/programs,
   99 €/yıl, kimlik doğrulama Apple Developer uygulamasından). Onay birkaç gün sürebilir;
   bu sırada ajan fikir ve ilk uygulamanın geliştirmesine başlayabilir, hesap sadece
   TestFlight ve yayın için lazım.
2. **App Store Connect'te:**
   - EU Digital Services Act **trader status**: ücretsiz ve gelir amaçsız yayınlıyorsan
     "non-trader" seç (adresin App Store'da görünmez). İleride ücretli/uygulama içi satın
     alma eklersen trader'a geçmen gerekir, o zaman adres/telefon görünür.
   - Users and Access → Integrations → **App Store Connect API** → Team Key oluştur, rol
     **App Manager**. `.p8` dosyası bir kere iner: `~/.appstoreconnect/private_keys/`
     altına koy. Key ID ve Issuer ID'yi not et.
3. **Mac'te:**
   - Xcode **26.x**'i kur (developer.apple.com/download/all, bedava). Xcode 27 kuruluysa
     kalabilir ama `sudo xcode-select -s /Applications/Xcode-26.x.app` ile 26'yı seç.
     Bir kere aç, iOS platformunu indir, Settings → Accounts'ta Apple ID ile giriş yap.
   - Homebrew yoksa kur. `gh auth login` ile GitHub'a giriş yap (gizlilik sayfaları için).
   - Claude Desktop'ı güncelle (v1.24012.0+).
   - Önerilen: stüdyo için ayrı bir macOS kullanıcı hesabı aç. Ajan auto mode'da geniş
     yetkiyle çalışacak; ayrı kullanıcı kişisel dosyalarını ondan korur.
   - System Settings → Energy/Battery: şarjdayken ekran kapansa da uyumasın.
4. **claude.ai → Settings → Usage:** "extra usage" kapalı olsun. Böylece limit dolunca
   para yazmaz, sadece bekler. Terminalde `ANTHROPIC_API_KEY` tanımlı olmadığından emin ol
   (tanımlıysa Claude Code aboneliği değil API'yi kullanır ve faturalar).
5. **Stüdyo klasörü:** `mkdir -p ~/Developer/studio`

Abonelik notu: Pro ile de çalışır ama limitlere sık takılır ve stüdyo yavaş ilerler (her
reset'te kaldığı yerden devam eder). Max'te günde çok daha fazla iş çıkar. İkisi de ek
ücret getirmez.

## Başlatma

Claude Desktop → **Code** sekmesi → proje klasörü `~/Developer/studio` → mod **Auto** →
aşağıdaki prompt'u yapıştır. `<VAULT>` yerine Mac'teki vault yolunu yaz (Obsidian'da vault
klasörüne sağ tık → Reveal in Finder).

```text
Sen bu klasörde tek kişilik bir iOS uygulama stüdyosu kuracaksın ve ben dur diyene kadar
çalıştıracaksın.

1. Kit'i kur: "<VAULT>/🏰 300-Projects/apple-app-studio/studio-kit/" içinden
   CLAUDE.md'yi bu klasörün köküne, agents/ klasörünü .claude/agents/ olarak,
   hooks/ klasörünü .claude/hooks/ olarak, settings.json'ı .claude/settings.json olarak
   kopyala. Hook'u çalıştırılabilir yap. git init yap. .gitignore'a .env.local, build
   çıktıları, DerivedData, .studio/ ekle.
2. CLAUDE.md'yi baştan sona oku; bundan sonra bağlayıcı olan o.
3. Ortamı doğrula ve eksikleri kendin kur (sudo gerekmeyenleri): xcode-select Xcode 26.x'i
   gösteriyor mu, iOS simulator'lar var mı, Homebrew, xcodegen, asc, gh, jq, ripgrep.
   Paul Hudson'ın swiftui-pro, swiftdata-pro, swift-concurrency-pro, swift-testing-pro
   skill'lerini kur. XcodeBuildMCP'yi ve Xcode MCP'yi (xcrun mcpbridge) Claude Code'a ekle.
   Boş bir SwiftUI uygulamasını XcodeGen ile üretip simulator panelinde çalıştırarak zinciri
   uçtan uca kanıtla, sonra sil.
4. API anahtarı için .env.local şablonu oluştur (ASC_KEY_ID, ASC_ISSUER_ID,
   ASC_KEY_PATH). Ben doldurmadıysam ya da Developer hesabım henüz onaylanmadıysa
   bunu ARDA-INBOX.md'ye yaz ve hesap gerektirmeyen işlerle devam et.
5. STATE.md, PORTFOLIO.md, ARDA-INBOX.md, scripts/dod.sh ve shared/DesignKit iskeletini
   oluştur. İlk commit.
6. Pipeline'ı başlat: Discover aşamasından en az 5 fikir üret, product-lead ile wedge
   testinden geçir, en güçlüsüyle devam et.

Bana sadece ARDA-INBOX.md üzerinden, Türkçe ve kısa konuş. Bir STOP dosyası görene kadar
durma. Kaliteyi hıza asla feda etme.
```

İlk seferde simulator paneli cihaz kontrolü için bir kerelik izin ister, onu ver.

## Günlük kullanım

- **Bakman gereken tek dosya:** `~/Developer/studio/ARDA-INBOX.md`. Orada bir şey yazıyorsa
  5 dakikalık iş demektir, değerler hazır.
- **Yayın onayı:** oturuma `yayınla <UygulamaAdı>` yaz. Onsuz App Review'a hiçbir şey gitmez;
  TestFlight'a gider. İstersen TestFlight'tan telefonuna yükleyip bir gün kullan.
- **Durdurmak:** `touch ~/Developer/studio/STOP` ya da oturumda Esc. Devam için dosyayı sil,
  oturuma "devam" yaz.
- **Telefondan takip:** Remote Control ile oturumu telefondan izleyip mesaj atabilirsin.
- Mac kapanırsa/yeniden başlarsa: Code sekmesinde oturumu aç, "devam" yaz; ajan STATE.md'den
  kaldığı yeri okur.

## Beklenti ayarı

- İlk uygulama: kurulum + fikir + geliştirme + review ile gerçekçi olarak 1-3 hafta.
  Sonra haftada en fazla bir yeni uygulama; aradaki zaman mevcutları iyileştirmeye gider.
- Apple review'ları çoğunlukla 1-2 gün. Red gelirse ajan düzeltip tekrar gönderir;
  4.3 (spam) reddinde durur ve sana sorar.
- Stüdyo senin adınla yayınlıyor (bireysel hesapta satıcı adı gerçek adın). O yüzden onay
  kapısı kaldırılmamalı.

## Açık kararlar

- Monetizasyon şimdilik yok (her şey bedava, non-trader). İleride "tip jar" ya da tek
  seferlik Pro düşünülürse: Paid Apps sözleşmesi, vergi/banka, trader status (adres
  görünür) gerekir. Karar Arda'nın.
- Stüdyo adı ve bundle ID öneki (`com.<isim>.<app>`): ajan önerecek, Arda onaylayacak.

## Kaynaklar

- [App Review Guidelines (4.2, 4.3, 5.1.1)](https://developer.apple.com/app-store/review/guidelines/)
- [Claude Code: iOS Simulator paneli](https://code.claude.com/docs/en/desktop-ios-simulator)
- [Claude Code: /goal](https://code.claude.com/docs/en/goal) · [Hooks (Stop, block cap)](https://code.claude.com/docs/en/hooks) · [Permission modes / auto](https://code.claude.com/docs/en/permission-modes)
- [Xcode 26.3 agentic coding + mcpbridge](https://swiftjectivec.com/Agentic-Coding-Codex-Claude-Code-in-Xcode/) · [Xcode MCP + Claude Code](https://danielsaidi.com/blog/2026/04/30/using-xcode-mcp-with-claude-code)
- [XcodeBuildMCP (getsentry)](https://mcp.directory/blog/xcodebuildmcp-complete-guide-2026)
- [Swift Agent Skills listesi](https://github.com/twostraws/swift-agent-skills) · [SwiftUI Pro skill](https://github.com/twostraws/swiftui-agent-skill)
- [App Store Connect CLI (asc)](https://github.com/rorkai/App-Store-Connect-CLI)
- [API ile app kaydı oluşturulamıyor](https://github.com/andrewralon/app-template/issues/2)
- [EU DSA trader status](https://developer.apple.com/help/app-store-connect/manage-compliance-information/manage-european-union-digital-services-act-trader-requirements/)
- [Liquid Glass ikonları: Icon Composer + actool](https://www.hendrik-erz.de/post/supporting-liquid-glass-icons-in-apps-without-xcode)
