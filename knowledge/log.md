# Derleme Günlüğü

Derleyici her çalıştığında bu dosyanın sonuna bir blok ekler: hangi günlük log işlendi, hangi
makaleler oluştu veya güncellendi, kısa bir not.

## [2026-09-03T12:16:27+02:00] compile | 2026-09-02.md

Oluşturulan makaleler: beyin-hafiza-motoru, beyin-kancalari,
ozet-sema-dogrulama-kirilganligi, mem0-entegrasyonu, ardavault-kurulumu,
beyin-doktor-skill.
Oluşturulan bağlantılar: beyin-hafiza-motoru--beyin-kancalari,
beyin-hafiza-motoru--mem0-entegrasyonu,
beyin-kancalari--ozet-sema-dogrulama-kirilganligi,
ardavault-kurulumu--beyin-hafiza-motoru.
Güncellenen makaleler: yok (bilgi tabanı boştu).

Bu ilk derleme, Arda'nın avenoxbeyin kurulum oturumundan beyin hafıza
motorunun mimarisini, dört kancasını ve bilinen flush şema kırılganlığını
kalıcı kavramlara ayırdı. İki oturum arasındaki mem0 çelişkisi (16:33 "aktif"
vs 16:34 "entegrasyon yok") düzeltilmiş durumla, yani entegrasyon yok ve karar
açık şeklinde kaydedildi. index.md tablosu altı satırla dolduruldu.

## [2026-09-03T18:22:16+02:00] compile | 2026-09-03.md

Oluşturulan makaleler: sifirdan-tutorial-serisi, bulut-ajan-github-kisiti,
vault-github-yayinlama, haftalik-sifirdan-takip-rutini.
Oluşturulan bağlantılar: bulut-ajan-github-kisiti--vault-github-yayinlama,
ardavault-kurulumu--vault-github-yayinlama,
haftalik-sifirdan-takip-rutini--sifirdan-tutorial-serisi.
Güncellenen makaleler: ardavault-kurulumu (vault'un başlangıçta yalnızca lokal
git olduğu ve GitHub'a yayınlanacağı notu eklendi).

12:16 oturumu, Arda'nın sıfırdan serisini haftalık izleyip `takip.md`'yi
otomatik güncelleme isteği etrafında dönüyordu. Ana içgörü, bulut ajanlarının
lokal dosyalara erişememesi ve bu yüzden lokal-git vault'un private GitHub
deposu olarak yayınlanmasının gerekmesiydi. Kavramlar seri, kısıt, yayınlama
adımı ve haftalık rutin olarak ayrıldı; index tablosuna dört yeni satır eklendi.
