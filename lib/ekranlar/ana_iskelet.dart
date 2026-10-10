import 'package:flutter/material.dart';
import 'ana_sayfa.dart';
import 'besin_liste.dart';
import 'profil_ekrani.dart';

class AnaIskelet extends StatefulWidget {
  const AnaIskelet({super.key});

  @override
  State<AnaIskelet> createState() => _AnaIskeletState();
}

class _AnaIskeletState extends State<AnaIskelet> {
  int seciliSekme = 0;

  final sayfalar = const [
    AnaSayfa(),
    BesinListe(),
    Center(child: Text('Takvim')),
    ProfilEkrani(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sayfalar[seciliSekme],
      bottomNavigationBar: NavigationBar(selectedIndex: seciliSekme, onDestinationSelected: (index) {
        setState(() {
          seciliSekme = index;
        });
      }, destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Ana Sayfa'),
        NavigationDestination(icon: Icon(Icons.restaurant_outlined), selectedIcon: Icon(Icons.restaurant), label: 'Besinler'),
        NavigationDestination(icon: Icon(Icons.calendar_month_outlined), selectedIcon: Icon(Icons.calendar_month), label: 'Takvim'),
        NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profil'),
      ]),
    );
  }
}
