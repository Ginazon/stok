import 'package:cloud_firestore/cloud_firestore.dart';

class Konusma {
  final String konusmaSahibi;
  final String kimleKonusuyor;
  final bool goruldu;
  final Timestamp olusturulmaTarihi;
  final String sonYollananMesaj;
  final Timestamp gorulmeTarihi;
  String konusulanUserName;
  String konusulanUserProfilURL;
  DateTime sonOkunmaZamani;
  String aradakiFark;

  Konusma(
      {this.konusmaSahibi,
      this.kimleKonusuyor,
      this.goruldu,
      this.olusturulmaTarihi,
      this.sonYollananMesaj,
      this.gorulmeTarihi});

  Map<String, dynamic> toMap() {
    return {
      'konusmaSahibi': konusmaSahibi,
      'kimleKonusuyor': kimleKonusuyor,
      'goruldu': goruldu,
      'olusturulmaTarihi': olusturulmaTarihi ?? FieldValue.serverTimestamp(),
      'sonYollananMesaj': sonYollananMesaj ?? FieldValue.serverTimestamp(),
      'gorulmeTarihi': gorulmeTarihi,
    };
  }

  Konusma.fromMap(Map<String, dynamic> map)
      : konusmaSahibi = map['konusmaSahibi'],
        kimleKonusuyor = map['kimleKonusuyor'],
        goruldu = map['goruldu'],
        olusturulmaTarihi = map['olusturulmaTarihi'],
        sonYollananMesaj = map['sonYollananMesaj'],
        gorulmeTarihi = map['gorulmeTarihi'];

  @override
  String toString() {
    return 'Konusma{konusmaSahibi: $konusmaSahibi,kimleKonusuyor: $kimleKonusuyor, goruldu: $goruldu, olusturulmaTarihi: $olusturulmaTarihi, sonYollananMesaj: $sonYollananMesaj, gorulmeTarihi: $gorulmeTarihi}';
  }
}
