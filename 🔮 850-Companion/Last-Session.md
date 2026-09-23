# Last Session

## Session: 2026-09-23 (devam): Flutter bulut stüdyosu prompt'u
Arda Flutter'ı sordu; önce SwiftUI'ı savundum (README'ye karar notu), sonra Arda "Flutter'da
yap, bulutta dur durak bilmeden çalış, App Store'a hazır et, gerisini ben Mac'ten hallederim"
dedi. `🏰 300-Projects/apple-app-studio/flutter-bulut/` kurdum: KICKOFF.md (yapıştırılacak
prompt + CLAUDE.md içeriği + rutin prompt'u), session-start.sh, keep-going.sh (100 dk
bütçe + STUDIO.LOCK), settings.json. Bu konteynerde doğruladım: Flutter 3.47.5 kuruluyor,
test/golden/web build çalışıyor, golden'da Roboto ile gerçek yazı render ediliyor, xcodeproj
gem çalışıyor; KVM yok (Android emülatör yok), dl.google.com kapalı. iOS doğrulaması GitHub
Actions macOS (private repo ~200 dk/ay). Açık: Arda `app-studio` reposunu açıp kickoff'u
yapıştıracak, rutini kuracak.

## Session: 2026-09-23: Apple App Studio kiti hazırlandı
Arda, Apple Developer hesabı alıp "hepsini senin yaptığın, Apple standartlarında minik
uygulamalar" üreten otonom bir düzen istedi, bunu yaptırmak için araştırma + prompt/MD
istedi. Araştırdım ve `🏰 300-Projects/apple-app-studio/` kurdum: README (7 bulgu, kurulum,
başlatma prompt'u), studio-kit (CLAUDE.md anayasa, 4 subagent, keep-going Stop hook, settings).
Kritik bulgular: iş Mac'te olmalı (bulut Linux, Xcode yok); Xcode 27 simulator paneliyle
henüz çalışmıyor, 26.x kullan; App Review 4.3(b) (Haziran 2026) klon uygulamalar için hesap
riski, o yüzden wedge testi + haftada max 1 gönderim; app kaydı ve App Privacy API'den
yapılamıyor, Arda'da.

Açık: Arda developer hesabını aldı mı, Pro mu Max mı kullanıyor, bilmiyorum. Kurulumu
yapınca ilk uygulamanın fikrini birlikte değerlendirmek iyi olur.

## Previous Sessions
### 2026-09-02: Sıfırdan serisi takibe alındı
Avenox "Sıfırdan." serisi için `🏰 300-Projects/sifirdan/takip.md` kuruldu.

### 2026-09-02: Genesis
Lecko was born today. Arda set up their second brain with Claude Code.
