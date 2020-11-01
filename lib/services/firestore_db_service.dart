import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stok/model/konusma.dart';
import 'package:stok/model/mesaj.dart';
import 'package:stok/model/user.dart';
import 'package:stok/services/database_base.dart';

class FirestoreDBService implements DBBase {
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;


  @override
  Future<bool> saveUser(AppUser user) async {
    await _firebaseDB
        .collection("users")
        .doc(user.appUserID)
        .set(user.toMap());

    DocumentSnapshot _okunanUser =
    await FirebaseFirestore.instance.doc('users/${user.appUserID}').get();
    Map _okunanUserBilgileriMap = _okunanUser.data();
    AppUser _okunanUserBilgileriNesne = AppUser.fromMap(
        _okunanUserBilgileriMap);
    print("Okunan User Bilgileri" + _okunanUserBilgileriNesne.toString());


    return true;
  }


  @override
  Future<AppUser> readUser(String appUserID) async {
    DocumentSnapshot _okunanUser = await _firebaseDB.collection("users").doc(
        appUserID).get();
    Map<String, dynamic> _okunanUserBilgileriMap = _okunanUser.data();

    AppUser _okunanUserNesnesi = AppUser.fromMap(_okunanUserBilgileriMap);
    print("Okunan user nesnesi :" + _okunanUserNesnesi.toString());
    return _okunanUserNesnesi;
  }

  @override
  Future<bool> updateUserName(String appUserID, String yeniAppUserName) async {
    var users = await _firebaseDB.collection("users").where(
        "userName", isEqualTo: yeniAppUserName).get();
    if (users.docs.length >= 1) {
      return false;
    } else {
      await _firebaseDB.collection("users").doc(appUserID).update(
          {'userName': yeniAppUserName});
      return true;
    }
  }

  updateProfilFoto(String appUserID, String profilFotoUrl) async {
    await _firebaseDB.collection("users").doc(appUserID).update(
        {'profilURL': profilFotoUrl});
    return true;
  }

  @override
  Future<List<Konusma>> getAllConversations(String appUserID) async {
    QuerySnapshot querySnapshot = await _firebaseDB
        .collection("konusmalar")
        .where("konusmaSahibi", isEqualTo: appUserID)
        .orderBy("olusturulmaTarihi", descending: true)
        .get();

    List<Konusma> tumKonusmalar = [];
    for (DocumentSnapshot tekKonusma in querySnapshot.docs) {
      Konusma _tekKonusma = Konusma.fromMap(tekKonusma.data());
      tumKonusmalar.add(_tekKonusma);
    }
    return tumKonusmalar;
  }


  @override
  Stream<List<Mesaj>> getMessages(String currentUserID,
      String sohbetEdilenUserID) {
    var snapShot = _firebaseDB
        .collection("konusmalar")
        .doc(currentUserID + "--" + sohbetEdilenUserID)
        .collection("mesajlar")
        .orderBy("date", descending: true)
        .snapshots();
    return snapShot.map((mesajListesi) =>
        mesajListesi.docs.map((mesaj) => Mesaj.fromMap(mesaj.data())).toList());
  }

  Future<bool> saveMessage(Mesaj kaydedilecekMesaj) async {
    var _mesajID = _firebaseDB
        .collection("konusmalar")
        .doc()
        .id;
    var _myDocumentID =
        kaydedilecekMesaj.kimden + "--" + kaydedilecekMesaj.kime;
    var _receiverDocumentID =
        kaydedilecekMesaj.kime + "--" + kaydedilecekMesaj.kimden;

    var _kaydedilecekMesajMapYapisi = kaydedilecekMesaj.toMap();

    await _firebaseDB
        .collection("konusmalar")
        .doc(_myDocumentID)
        .collection("mesajlar")
        .doc(_mesajID)
        .set(_kaydedilecekMesajMapYapisi);
    await _firebaseDB.collection("konusmalar").doc(_myDocumentID).set({
      "konusmaSahibi": kaydedilecekMesaj.kimden,
      "kimleKonusuyor": kaydedilecekMesaj.kime,
      "sonYollananMesaj": kaydedilecekMesaj.mesaj,
      "konusmaGoruldu": false,
      "olusturulmaTarihi": FieldValue.serverTimestamp(),
    });

    _kaydedilecekMesajMapYapisi.update("bendenMi", (deger) => false);

    await _firebaseDB
        .collection("konusmalar")
        .doc(_receiverDocumentID)
        .collection("mesajlar")
        .doc(_mesajID)
        .set(_kaydedilecekMesajMapYapisi);
    await _firebaseDB.collection("konusmalar").doc(_receiverDocumentID).set({
      "konusmaSahibi": kaydedilecekMesaj.kime,
      "kimleKonusuyor": kaydedilecekMesaj.kimden,
      "sonYollananMesaj": kaydedilecekMesaj.mesaj,
      "konusmaGoruldu": false,
      "olusturulmaTarihi": FieldValue.serverTimestamp(),
    });


    return true;
  }

  @override
  Future<DateTime> saatiGoster(String appUserID) async {
    await _firebaseDB.collection("server").doc(appUserID).set(
        {"saat": FieldValue.serverTimestamp()});
    var okunanMap = await _firebaseDB.collection("server").doc(appUserID).get();
    Timestamp okunanTarih = okunanMap.data()["saat"];
    return okunanTarih.toDate();
  }

  @override
  Future<List<AppUser>> getUsersWithPagination(AppUser enSonGetirilenUser,
      int getirilecekElemanSayisi) async {
    QuerySnapshot _querySnapshot;
    List<AppUser>_tumKullanicilar = [];
    if (enSonGetirilenUser == null) {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .orderBy("userName")
          .limit(getirilecekElemanSayisi)
          .get();
    } else {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .orderBy("userName")
          .startAfter([enSonGetirilenUser.userName])
          .limit(getirilecekElemanSayisi)
          .get();
    }
    for (DocumentSnapshot snapshot in _querySnapshot.docs) {
      AppUser _tekUser = AppUser.fromMap(snapshot.data());
      _tumKullanicilar.add(_tekUser);

  }
    return _tumKullanicilar;


  }

}

