class Besin {
  final String id;
  final String isim;
  final int kalori;
  final String? porsiyonBirim;
  final double? porsiyonMiktar;
  final String? resim;
  final double? protein;
  final double? karbonhidrat;
  final double? seker;
  final double? yag;
  final String? marka;
  final String? kategori;
  final double? tuz;

  Besin({required this.id, required this.isim, required this.kalori, this.porsiyonBirim, this.porsiyonMiktar, this.resim, this.protein, this.karbonhidrat, this.seker, this.yag, this.marka, this.kategori, this.tuz});
}