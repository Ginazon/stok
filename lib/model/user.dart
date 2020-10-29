import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class AppUser{


  final String appUserID;
  String email;
  String userName;
  String profilURL;
  DateTime createdAt;
  DateTime upDatedAt;
  int seviye;

  AppUser({@required this.appUserID, @required this.email});

  Map<String, dynamic> toMap() {
    return {
      'appUserID': appUserID,
      'email': email,
      'userName': userName ?? email.substring(0,email.indexOf('@'))+randomSayiUret(),
      'profilURL': profilURL ?? 'https://listelist.com/wp-content/uploads/2019/01/Webp.net-resizeimage-1.jpg',
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'upDatedAt': upDatedAt ?? FieldValue.serverTimestamp(),
      'seviye': seviye ?? 1,
    };
  }
  AppUser.fromMap(Map<String,dynamic>map):
      appUserID=map['appUserID'],
        email=map['email'],
        userName=map['userName'],
        profilURL=map['profilURL'],
        createdAt=(map['createdAt'] as Timestamp).toDate(),
        upDatedAt=(map['upDatedAt']as Timestamp).toDate(),
        seviye=map['seviye'];

  AppUser.idveResim({@required this.appUserID, @required this.profilURL});

  @override
  String toString() {
    return 'AppUser{appUserID: $appUserID, email: $email, userName: $userName, profilURL: $profilURL, createdAt: $createdAt, upDatedAt: $upDatedAt, seviye: $seviye}';
  }

  String randomSayiUret() {
    int rastgeleSayi=Random().nextInt(999999);
    return rastgeleSayi.toString();
  }
}