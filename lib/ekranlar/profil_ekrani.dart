import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../hesap/profil_hesap.dart';
import 'giris_ekrani.dart';

class ProfilEkrani extends StatefulWidget {
  const ProfilEkrani({super.key});

  @override
  State<ProfilEkrani> createState() => _ProfilEkraniState();
}

class _ProfilEkraniState extends State<ProfilEkrani> {
  bool yuklendi = false;
  String ad = '';
  String eposta = '';
  double boy = 0;
  double kilo = 0;
  int yas = 0;
  String cinsiyet = 'erkek';
  double aktiviteKatsayi = 1.2;
  String hedef = 'koru';

  @override
  void initState() {
    super.initState();
    bilgileriYukle();
  }

  void bilgileriYukle() async {
    final ayarlar = await SharedPreferences.getInstance();
    setState(() {
      ad = ayarlar.getString('ad') ?? '';
      eposta = ayarlar.getString('eposta') ?? '';
      boy = ayarlar.getDouble('boy') ?? 0;
      kilo = ayarlar.getDouble('kilo') ?? 0;
      yas = ayarlar.getInt('yas') ?? 0;
      cinsiyet = ayarlar.getString('cinsiyet') ?? 'erkek';
      aktiviteKatsayi = ayarlar.getDouble('aktiviteKatsayi') ?? 1.2;
      hedef = ayarlar.getString('hedef') ?? 'koru';
      yuklendi = true;
    });
  }

  void cikisYap() async {
    final ayarlar = await SharedPreferences.getInstance();
    await ayarlar.clear();
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const GirisEkrani()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    if (!yuklendi) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final sonuc = profilHesapla(boy: boy, kilo: kilo, yas: yas, cinsiyet: cinsiyet, aktiviteKatsayi: aktiviteKatsayi, hedef: hedef);

    String cinsiyetYazisi = 'Erkek';
    if (cinsiyet == 'kadin') {
      cinsiyetYazisi = 'Kadın';
    }
    String hedefYazisi = 'Kilo Koru';
    if (hedef == 'ver') {
      hedefYazisi = 'Kilo Ver';
    } else if (hedef == 'al') {
      hedefYazisi = 'Kilo Al';
    }
    String ilkHarf = '?';
    if (ad.isNotEmpty) {
      ilkHarf = ad[0].toUpperCase();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Center(child: CircleAvatar(radius: 40, child: Text(ilkHarf, style: const TextStyle(fontSize: 32)))),
        const SizedBox(height: 8),
        Text(ad, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(eposta, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 24),
        Card(child: Column(children: [
          ListTile(title: const Text('Boy'), trailing: Text('${boy.round()} cm')),
          ListTile(title: const Text('Kilo'), trailing: Text('${kilo.toStringAsFixed(1)} kg')),
          ListTile(title: const Text('Yaş'), trailing: Text('$yas')),
          ListTile(title: const Text('Cinsiyet'), trailing: Text(cinsiyetYazisi)),
          ListTile(title: const Text('Hedef'), trailing: Text(hedefYazisi)),
          ListTile(title: const Text('Günlük Kalori'), trailing: Text('${sonuc.kalori} kcal', style: const TextStyle(fontWeight: FontWeight.bold))),
        ])),
        const SizedBox(height: 24),
        OutlinedButton.icon(style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), minimumSize: const Size.fromHeight(50)), icon: const Icon(Icons.logout), label: const Text('Çıkış Yap'), onPressed: () {
          cikisYap();
        }),
      ]),
    );
  }
}