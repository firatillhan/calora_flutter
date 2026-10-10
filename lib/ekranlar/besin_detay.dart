import 'package:flutter/material.dart';
import '../modeller/besin.dart';
import '../modeller/kayit.dart';
import '../modeller/ornek_veri.dart';

class BesinDetay extends StatefulWidget {
  final Besin besin;
  const BesinDetay({super.key, required this.besin});

  @override
  State<BesinDetay> createState() => _BesinDetayState();
}

class _BesinDetayState extends State<BesinDetay> {
  final miktarController = TextEditingController(text: '1');

  @override
  void dispose() {
    miktarController.dispose();
    super.dispose();
  }

  double miktar() {
    final sonuc = double.tryParse(miktarController.text.replaceAll(',', '.')) ?? 0;
    return sonuc;
  }

  void yedim() {
    final girilen = miktar();
    if (girilen <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lütfen geçerli bir miktar girin')));
      return;
    }

    final besin = widget.besin;
    final kayit = Kayit(id: DateTime.now().millisecondsSinceEpoch.toString(), besinId: besin.id, isim: besin.isim, birimKalori: besin.kalori, miktar: girilen, tarih: DateTime.now(), protein: besin.protein, karbonhidrat: besin.karbonhidrat, yag: besin.yag, seker: besin.seker, tuz: besin.tuz, resim: besin.resim);
    ornekKayitlar.add(kayit);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${besin.isim} eklendi')));
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    final besin = widget.besin;
    final toplamKalori = (besin.kalori * miktar()).round();

    String porsiyonYazisi = '';
    if (besin.porsiyonMiktar != null && besin.porsiyonBirim != null) {
      porsiyonYazisi = '1 porsiyon = ${besin.porsiyonMiktar!.round()} ${besin.porsiyonBirim}';
    }

    return Scaffold(
      appBar: AppBar(title: Text(besin.isim)),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Container(height: 200, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.restaurant, size: 64, color: Colors.grey)),
        const SizedBox(height: 16),
        Text(besin.isim, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text('${besin.kalori} kcal / porsiyon', style: const TextStyle(color: Colors.grey)),
        if (porsiyonYazisi.isNotEmpty) Text(porsiyonYazisi, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 16),
        TextField(controller: miktarController, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Miktar', suffixText: 'porsiyon', border: OutlineInputBorder()), onChanged: (yazi) {
          setState(() {});
        }),
        const SizedBox(height: 8),
        Text('Toplam: $toplamKalori kcal', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
          besinSatiri('Protein', besin.protein),
          besinSatiri('Karbonhidrat', besin.karbonhidrat),
          besinSatiri('Yağ', besin.yag),
          besinSatiri('Şeker', besin.seker),
          besinSatiri('Tuz', besin.tuz),
        ]))),
      ]),
      bottomNavigationBar: SafeArea(child: Padding(padding: const EdgeInsets.all(16), child: SizedBox(height: 50, child: FilledButton(onPressed: () {
        yedim();
      }, child: const Text('Yedim'))))),
    );
  }

  Widget besinSatiri(String ad, double? deger) {
    String yazi = '—';
    if (deger != null) {
      yazi = '${(deger * miktar()).toStringAsFixed(1)} g';
    }
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(children: [
      Text(ad),
      const Spacer(),
      Text(yazi, style: const TextStyle(fontWeight: FontWeight.bold)),
    ]));
  }

}