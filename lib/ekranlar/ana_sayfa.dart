import 'package:flutter/material.dart';
import '../modeller/ornek_veri.dart';
import '../modeller/kayit.dart';

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    final kayitlar = ornekKayitlar;
    return Scaffold(
      appBar: AppBar(title: const Text('Bugün')),
      body: ListView(children: [
        ozetKart(context, kayitlar),
        for (final kayit in kayitlar)
          ListTile(
            leading: Container(width: 50, height: 50, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.restaurant, color: Colors.grey)),
            title: Text(kayit.isim, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${kayit.miktar.toStringAsFixed(1)} birim'),
            trailing: Text('${kayit.toplamKalori} kcal', style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
      ]),
    );
  }
  Widget ozetKart(BuildContext context, List<Kayit> kayitlar) {
    int toplamKalori = 0;
    double toplamProtein = 0;
    double toplamKarbonhidrat = 0;
    double toplamYag = 0;
    for (final kayit in kayitlar) {
      toplamKalori += kayit.toplamKalori;
      toplamProtein += kayit.toplamProtein;
      toplamKarbonhidrat += kayit.toplamKarbonhidrat;
      toplamYag += kayit.toplamYag;
    }

    const hedefKalori = 2000;
    final kalan = hedefKalori - toplamKalori;
    double oran = toplamKalori / hedefKalori;
    if (oran > 1) {
      oran = 1;
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(16)),
      child: Column(children: [
        Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Alınan', style: TextStyle(fontSize: 12, color: Colors.grey)),
            Text('$toplamKalori / $hedefKalori kcal', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ]),
          const Spacer(),
          Text(kalan >= 0 ? '$kalan kcal kaldı' : '${-kalan} kcal aştın', style: TextStyle(color: kalan >= 0 ? Colors.green : Colors.red)),
        ]),
        const SizedBox(height: 12),
        LinearProgressIndicator(value: oran, minHeight: 8, color: kalan >= 0 ? Colors.green : Colors.red, borderRadius: BorderRadius.circular(4)),
        const SizedBox(height: 8),
        makroBar('Protein', toplamProtein, 150, Colors.blue),
        makroBar('Karbonhidrat', toplamKarbonhidrat, 225, Colors.orange),
        makroBar('Yağ', toplamYag, 56, Colors.purple),
      ]),
    );
  }

  Widget makroBar(String ad, double mevcut, double hedef, Color renk) {
    final asildi = mevcut > hedef;
    double oran = mevcut / hedef;
    if (oran > 1) {
      oran = 1;
    }
    Color cubukRengi = renk;
    if (asildi) {
      cubukRengi = Colors.red;
    }

    return Padding(padding: const EdgeInsets.only(top: 8), child: Column(children: [
      Row(children: [
        Text(ad, style: const TextStyle(fontSize: 12)),
        const Spacer(),
        Text('${mevcut.round()} / ${hedef.round()} g', style: TextStyle(fontSize: 12, color: asildi ? Colors.red : Colors.grey)),
      ]),
      const SizedBox(height: 4),
      LinearProgressIndicator(value: oran, color: cubukRengi, borderRadius: BorderRadius.circular(4)),
    ]));
  }
}