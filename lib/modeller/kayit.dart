class Kayit {
  final String id;
  final String besinId;
  final String isim;
  final int birimKalori;
  final double miktar;
  final DateTime tarih;
  final double? protein;
  final double? karbonhidrat;
  final double? yag;
  final double? seker;
  final double? tuz;
  final String? resim;

  Kayit({required this.id, required this.besinId, required this.isim, required this.birimKalori, required this.miktar, required this.tarih, this.protein, this.karbonhidrat, this.yag, this.seker, this.tuz, this.resim});

  int get toplamKalori {
    final sonuc = (birimKalori * miktar).round();
    return sonuc;
  }

  double get toplamProtein {
    final sonuc = (protein ?? 0) * miktar;
    return sonuc;
  }

  double get toplamKarbonhidrat {
    final sonuc = (karbonhidrat ?? 0) * miktar;
    return sonuc;
  }

  double get toplamYag {
    final sonuc = (yag ?? 0) * miktar;
    return sonuc;
  }

  double get toplamSeker {
    final sonuc = (seker ?? 0) * miktar;
    return sonuc;
  }

  double get toplamTuz {
    final sonuc = (tuz ?? 0) * miktar;
    return sonuc;
  }
}