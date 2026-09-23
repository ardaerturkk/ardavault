# Kuromi Pixel Doldurma

Basit bir "renk numarasıyla boyama" (paint-by-numbers) tarzı pixel-art oyunu. Kuromi
esintili kukuletalı bir figürü, doğru rengi seçip doğru kareleri tıklayarak ortaya
çıkarıyorsun.

## Çalıştırma

Statik bir sitedir, build adımı yok. Yerelde denemek için:

```bash
python3 -m http.server 8000
# tarayıcıda http://localhost:8000
```

## Vercel'e deploy

Bu klasörü olduğu gibi bir Vercel projesi olarak bağlamak yeterli (framework: "Other",
build command yok, output directory: `.`).

```bash
npx vercel --cwd kuromi-pixel-game
```

## Dosyalar

- `index.html` — sayfa iskeleti
- `style.css` — tema ve düzen
- `script.js` — grid verisi + oyun mantığı (renk seçimi, doldurma, ilerleme, kazanma)
