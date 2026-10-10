import 'kayit.dart';
import 'besin.dart';

final ornekKayitlar = [
  Kayit(id: '1', besinId: 'b1', isim: 'Yulaf Ezmesi', birimKalori: 150, miktar: 1, tarih: DateTime.now(), protein: 5, karbonhidrat: 27, yag: 3),
  Kayit(id: '2', besinId: 'b2', isim: 'Tavuk Göğsü', birimKalori: 165, miktar: 1.5, tarih: DateTime.now(), protein: 31, karbonhidrat: 0, yag: 3.6),
  Kayit(id: '3', besinId: 'b3', isim: 'Muz', birimKalori: 105, miktar: 2, tarih: DateTime.now(), protein: 1.3, karbonhidrat: 27, yag: 0.4),
];

final ornekBesinler = [
  Besin(id: 'b1', isim: 'Yulaf Ezmesi', kalori: 150, porsiyonBirim: 'g', porsiyonMiktar: 40, protein: 5, karbonhidrat: 27, yag: 3, kategori: 'Kahvaltılık'),
  Besin(id: 'b2', isim: 'Tavuk Göğsü', kalori: 165, porsiyonBirim: 'g', porsiyonMiktar: 100, protein: 31, karbonhidrat: 0, yag: 3.6, kategori: 'Et'),
  Besin(id: 'b3', isim: 'Muz', kalori: 105, porsiyonBirim: 'adet', porsiyonMiktar: 1, protein: 1.3, karbonhidrat: 27, yag: 0.4, seker: 14, kategori: 'Meyve'),
  Besin(id: 'b4', isim: 'Yumurta', kalori: 78, porsiyonBirim: 'adet', porsiyonMiktar: 1, protein: 6, karbonhidrat: 0.6, yag: 5, kategori: 'Kahvaltılık'),
  Besin(id: 'b5', isim: 'Pirinç Pilavı', kalori: 206, porsiyonBirim: 'g', porsiyonMiktar: 150, protein: 4.3, karbonhidrat: 45, yag: 0.4, tuz: 0.5, kategori: 'Tahıl'),
];