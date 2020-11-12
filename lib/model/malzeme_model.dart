import 'package:flutter/cupertino.dart';

class Malzeme {

  final String kalinlik;
  final String type;
  final String en;
  final String boy;
  final String adet;
  final String yeri;


  Malzeme(
      {
      @required this.kalinlik,
      @required this.type,
      @required this.en,
      @required this.boy,
      @required this.adet,
      @required this.yeri});

  Map<String, dynamic> toMap() {
    return {

      'kalinlik': kalinlik,
      'type': type,
      'en': en,
      'boy': boy,
      'adet': adet,
      'yeri': yeri,
    };
  }

  Malzeme.fromMap(Map<String, dynamic> map)
      :
        kalinlik = map['kalinlik'],
        type = map['type'],
        en = map['en'],
        boy = map['boy'],
        adet = map['adet'],
        yeri = map['yeri'];

  @override
  String toString() {
    return 'Malzeme{ kalinlik: $kalinlik, type: $type, en: $en, boy: $boy, adet: $adet, yeri: $yeri}';
  }
}
