import 'package:flutter/material.dart';
import '../modeller/ornek_veri.dart';
import 'besin_detay.dart';

class BesinListe extends StatelessWidget {
  const BesinListe({super.key});

  @override
  Widget build(BuildContext context) {
    final besinler = ornekBesinler;
    return Scaffold(
      appBar: AppBar(title: const Text('Besinler'), actions: [
        TextButton(onPressed: () {
          print('Yeni besin ekle');
        }, child: const Text('Yeni Besin Ekle')),
      ]),
      body: ListView(children: [
        for (final besin in besinler)
          ListTile(
            leading: Container(width: 50, height: 50, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.restaurant, color: Colors.grey)),
            title: Text(besin.isim),
            trailing: Text('${besin.kalori} kcal', style: const TextStyle(color: Colors.grey)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => BesinDetay(besin: besin)));
              print('Seçilen: ${besin.isim}');
            },
          ),
      ]),
    );
  }
}