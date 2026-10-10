import 'package:flutter/material.dart';
import 'onboarding_ekrani.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KayitEkrani extends StatefulWidget {
  const KayitEkrani({super.key});

  @override
  State<KayitEkrani> createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  final adController = TextEditingController();
  final epostaController = TextEditingController();
  final sifreController = TextEditingController();
  final sifreTekrarController = TextEditingController();

  @override
  void dispose() {
    adController.dispose();
    epostaController.dispose();
    sifreController.dispose();
    sifreTekrarController.dispose();
    super.dispose();
  }

  void mesajGoster(String mesaj) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mesaj)));
  }


  void kayitOl() async {
    final ad = adController.text.trim();
    final eposta = epostaController.text.trim();
    final sifre = sifreController.text;
    final sifreTekrar = sifreTekrarController.text;

    if (ad.isEmpty || eposta.isEmpty || sifre.isEmpty) {
      mesajGoster('Lütfen tüm alanları doldurun');
      return;
    }
    if (sifre.length < 6) {
      mesajGoster('Şifre en az 6 karakter olmalı');
      return;
    }
    if (sifre != sifreTekrar) {
      mesajGoster('Şifreler eşleşmiyor');
      return;
    }
    print('Kayıt: $ad, $eposta');
    final ayarlar = await SharedPreferences.getInstance();
    await ayarlar.setString('ad', ad);
    await ayarlar.setString('eposta', eposta);
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const OnboardingEkrani()), (route) => false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kayıt Ol')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              TextField(controller: adController, decoration: const InputDecoration(labelText: 'Ad Soyad', border: OutlineInputBorder())),
              const SizedBox(height: 16),
              TextField(controller: epostaController, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'E-posta', border: OutlineInputBorder())),
              const SizedBox(height: 16),
              TextField(controller: sifreController, obscureText: true, decoration: const InputDecoration(labelText: 'Şifre', border: OutlineInputBorder())),
              const SizedBox(height: 16),
              TextField(controller: sifreTekrarController, obscureText: true, decoration: const InputDecoration(labelText: 'Şifre Tekrar', border: OutlineInputBorder())),
              const SizedBox(height: 24),
              SizedBox(width: double.infinity, height: 50, child: FilledButton(onPressed: () {
                kayitOl();
              }, child: const Text('Kayıt Ol'))),
            ],
          ),
        ),
      ),
    );
  }
}