import 'package:flutter/material.dart';
import 'kayit_ekrani.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({super.key});

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  final epostaController = TextEditingController();
  final sifreController = TextEditingController();

  @override
  void dispose() {
    epostaController.dispose();
    sifreController.dispose();
    super.dispose();
  }

  void girisYap() {
    final eposta = epostaController.text;
    final sifre = sifreController.text;
    print('E-posta: $eposta, Şifre: $sifre');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Calora', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              TextField(controller: epostaController, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'E-posta', border: OutlineInputBorder())),
              const SizedBox(height: 16),
              TextField(controller: sifreController, obscureText: true, decoration: const InputDecoration(labelText: 'Şifre', border: OutlineInputBorder())),
              const SizedBox(height: 24),
              SizedBox(width: double.infinity, height: 50, child: FilledButton(onPressed: () {
                girisYap();
              }, child: const Text('Giriş Yap'))),
              const SizedBox(height: 8),
              TextButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const KayitEkrani()));
                print('Kayıt ol tıklandı');
              }, child: const Text('Hesabın yok mu? Kayıt ol')),
            ],

          ),
        ),
      ),
    );
  }
}