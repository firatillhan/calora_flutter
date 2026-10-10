import 'package:flutter/material.dart';
import 'ekranlar/giris_ekrani.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ekranlar/ana_iskelet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ayarlar = await SharedPreferences.getInstance();
  final girisYapildi = ayarlar.getBool('girisYapildi') ?? false;
  runApp(CaloraApp(girisYapildi: girisYapildi));
}

class CaloraApp extends StatelessWidget {
  final bool girisYapildi;
  const CaloraApp({super.key, required this.girisYapildi});

  @override
  Widget build(BuildContext context) {
    Widget ilkEkran = const GirisEkrani();
    if (girisYapildi) {
      ilkEkran = const AnaIskelet();
    }
    return MaterialApp(
      title: 'Calora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.green, useMaterial3: true),
      home: ilkEkran,
    );
  }
}