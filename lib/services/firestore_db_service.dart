import 'package:cloud_firestore/cloud_firestore.dart';
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
    Map _okunanUserBilgileriMap=_okunanUser.data();
    AppUser _okunanUserBilgileriNesne=AppUser.fromMap(_okunanUserBilgileriMap);
    print("Okunan User Bilgileri"+_okunanUserBilgileriNesne.toString());


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
    if(users.docs.length>=1){
      return false;
    }else{
      await _firebaseDB.collection("users").doc(appUserID).update({'userName':yeniAppUserName});
      return true;

    }

  }

  updateProfilFoto(String appUserID, String profilFotoUrl) async {
    await _firebaseDB.collection("users").doc(appUserID).update({'profilURL':profilFotoUrl});
    return true;
  }

  @override
  Future<List<AppUser>> getAllUsers() async {
    QuerySnapshot querySnapshot= await _firebaseDB.collection("users").get();
    List<AppUser> tumKullanicilar=[];
    for(DocumentSnapshot tekUser in querySnapshot.docs){
     AppUser _tekUser=AppUser.fromMap(tekUser.data());
     tumKullanicilar.add(_tekUser);
    }

    //MAP METOTU ILE
    //tumKullanicilar = querySnapshot.docs.map((tekSatir)=>AppUser.fromMap(tekSatir.data())).toList();

    return tumKullanicilar;

  }


}
