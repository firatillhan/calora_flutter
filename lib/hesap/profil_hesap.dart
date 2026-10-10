class ProfilSonuc {
  final int bmr;
  final int tdee;
  final int kalori;
  final int protein;
  final int karbonhidrat;
  final int yag;
  final int idealAlt;
  final int idealUst;

  const ProfilSonuc({required this.bmr, required this.tdee, required this.kalori, required this.protein, required this.karbonhidrat, required this.yag, required this.idealAlt, required this.idealUst});
}

ProfilSonuc profilHesapla({required double boy, required double kilo, required int yas, required String cinsiyet, required double aktiviteKatsayi, required String hedef}) {
  double bmr = 10 * kilo + 6.25 * boy - 5 * yas;
  if (cinsiyet == 'erkek') {
    bmr += 5;
  } else {
    bmr -= 161;
  }

  final tdee = bmr * aktiviteKatsayi;

  double kalori = tdee;
  if (hedef == 'ver') {
    kalori = tdee - 500;
  } else if (hedef == 'al') {
    kalori = tdee + 500;
  }
  if (kalori < 1200) {
    kalori = 1200;
  }

  final protein = kalori * 0.30 / 4;
  final karbonhidrat = kalori * 0.45 / 4;
  final yag = kalori * 0.25 / 9;

  final boyMetre = boy / 100;
  final idealAlt = 22 * boyMetre * boyMetre;
  final idealUst = 24.9 * boyMetre * boyMetre;

  final sonuc = ProfilSonuc(bmr: bmr.round(), tdee: tdee.round(), kalori: kalori.round(), protein: protein.round(), karbonhidrat: karbonhidrat.round(), yag: yag.round(), idealAlt: idealAlt.round(), idealUst: idealUst.round());
  return sonuc;
}