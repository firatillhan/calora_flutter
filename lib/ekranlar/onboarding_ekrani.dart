import 'package:flutter/material.dart';
import '../hesap/profil_hesap.dart';
import 'ana_iskelet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingEkrani extends StatefulWidget {
  const OnboardingEkrani({super.key});

  @override
  State<OnboardingEkrani> createState() => _OnboardingEkraniState();
}

class _OnboardingEkraniState extends State<OnboardingEkrani> {
  final boyController = TextEditingController();
  final kiloController = TextEditingController();
  final yasController = TextEditingController();
  String cinsiyet = 'erkek';

  int adim = 1;
  String aktivite = 'hareketsiz';
  String hedef = 'koru';

  final aktiviteler = [
    (anahtar: 'hareketsiz', baslik: 'Hareketsiz', aciklama: 'Masa başı iş, egzersiz yok', katsayi: 1.2),
    (anahtar: 'az', baslik: 'Az Hareketli', aciklama: 'Haftada 1-3 gün hafif egzersiz', katsayi: 1.375),
    (anahtar: 'orta', baslik: 'Orta Hareketli', aciklama: 'Haftada 3-5 gün egzersiz', katsayi: 1.55),
    (anahtar: 'aktif', baslik: 'Hareketli', aciklama: 'Haftada 6-7 gün egzersiz', katsayi: 1.725),
    (anahtar: 'cok', baslik: 'Çok Hareketli', aciklama: 'Fiziksel iş + yoğun egzersiz', katsayi: 1.9),
  ];

  @override
  void dispose() {
    boyController.dispose();
    kiloController.dispose();
    yasController.dispose();
    super.dispose();
  }
  void mesajGoster(String mesaj) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mesaj)));
  }

  @override
  Widget build(BuildContext context) {
    Widget icerik = adim1();
    if (adim == 2) {
      icerik = adim2();
    }
    if (adim == 3) {
      icerik = adim3();
    }
    return Scaffold(
      appBar: AppBar(title: Text('Adım $adim / 3'), leading: adim > 1 ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {
        setState(() {
          adim = adim - 1;
        });
      }) : null),
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(24), child: icerik)),
    );
  }

  Widget adim1() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      TextField(controller: boyController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Boy', suffixText: 'cm', border: OutlineInputBorder())),
      const SizedBox(height: 16),
      TextField(controller: kiloController, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Kilo', suffixText: 'kg', border: OutlineInputBorder())),
      const SizedBox(height: 16),
      TextField(controller: yasController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Yaş', border: OutlineInputBorder())),
      const SizedBox(height: 24),
      SegmentedButton<String>(segments: const [ButtonSegment(value: 'erkek', label: Text('Erkek')), ButtonSegment(value: 'kadin', label: Text('Kadın'))], selected: {cinsiyet}, onSelectionChanged: (secim) {
        setState(() {
          cinsiyet = secim.first;
        });
      }),
      const Spacer(),
      SizedBox(height: 50, child: FilledButton(onPressed: () {
        if (boyController.text.isEmpty || kiloController.text.isEmpty || yasController.text.isEmpty) {
          mesajGoster('Lütfen tüm alanları doldurun');
          return;
        }
        setState(() {
          adim = 2;
        });
      }, child: const Text('İleri'))),
    ]);
  }

  Widget adim2() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Text('Ne kadar hareketlisin?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      for (final secenek in aktiviteler)
        Card(child: ListTile(title: Text(secenek.baslik), subtitle: Text(secenek.aciklama), selected: aktivite == secenek.anahtar, trailing: aktivite == secenek.anahtar ? const Icon(Icons.check_circle) : null, onTap: () {
          setState(() {
            aktivite = secenek.anahtar;
          });
        })),
      const Spacer(),
      SizedBox(height: 50, child: FilledButton(onPressed: () {
        setState(() {
          adim = 3;
        });
      }, child: const Text('İleri'))),
    ]);
  }
  Widget adim3() {
    final sonuc = hesapla(hedef);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Text('Hedefin ne?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      SegmentedButton<String>(segments: const [ButtonSegment(value: 'ver', label: Text('Kilo Ver')), ButtonSegment(value: 'koru', label: Text('Koru')), ButtonSegment(value: 'al', label: Text('Kilo Al'))], selected: {hedef}, onSelectionChanged: (secim) {
        setState(() {
          hedef = secim.first;
        });
      }),
      const SizedBox(height: 24),
      Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
        const Text('Günlük Hedefin'),
        Text('${sonuc.kalori} kcal', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        const Divider(height: 32),
        sonucSatiri('Protein', '${sonuc.protein} g'),
        sonucSatiri('Karbonhidrat', '${sonuc.karbonhidrat} g'),
        sonucSatiri('Yağ', '${sonuc.yag} g'),
        const Divider(height: 32),
        sonucSatiri('BMR', '${sonuc.bmr} kcal'),
        sonucSatiri('TDEE', '${sonuc.tdee} kcal'),
        sonucSatiri('İdeal kilo', '${sonuc.idealAlt}-${sonuc.idealUst} kg'),
      ]))),
      const Spacer(),
      SizedBox(height: 50, child: FilledButton(onPressed: () async {
        final boy = double.tryParse(boyController.text.replaceAll(',', '.')) ?? 0;
        final kilo = double.tryParse(kiloController.text.replaceAll(',', '.')) ?? 0;
        final yas = int.tryParse(yasController.text) ?? 0;
        double katsayi = 1.2;
        for (final secenek in aktiviteler) {
          if (secenek.anahtar == aktivite) {
            katsayi = secenek.katsayi;
          }
        }

        final ayarlar = await SharedPreferences.getInstance();
        await ayarlar.setDouble('boy', boy);
        await ayarlar.setDouble('kilo', kilo);
        await ayarlar.setInt('yas', yas);
        await ayarlar.setString('cinsiyet', cinsiyet);
        await ayarlar.setString('aktivite', aktivite);
        await ayarlar.setDouble('aktiviteKatsayi', katsayi);
        await ayarlar.setString('hedef', hedef);
        await ayarlar.setBool('girisYapildi', true);
        if (!context.mounted) return;
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AnaIskelet()), (route) => false);
      }, child: const Text('Başla'))),
    ]);
  }

  Widget sonucSatiri(String baslik, String deger) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(children: [
      Text(baslik),
      const Spacer(),
      Text(deger, style: const TextStyle(fontWeight: FontWeight.bold)),
    ]));
  }
  ProfilSonuc hesapla(String hedef) {
    final boy = double.tryParse(boyController.text.replaceAll(',', '.')) ?? 0;
    final kilo = double.tryParse(kiloController.text.replaceAll(',', '.')) ?? 0;
    final yas = int.tryParse(yasController.text) ?? 0;

    double katsayi = 1.2;
    for (final secenek in aktiviteler) {
      if (secenek.anahtar == aktivite) {
        katsayi = secenek.katsayi;
      }
    }

    final sonuc = profilHesapla(boy: boy, kilo: kilo, yas: yas, cinsiyet: cinsiyet, aktiviteKatsayi: katsayi, hedef: hedef);
    return sonuc;
  }
}