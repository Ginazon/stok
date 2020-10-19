import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stok/model/app_user_model.dart';
import 'package:stok/services/database_base.dart';

class FirestoreDBService implements DBBase {
  final FirebaseFirestore _firebaseAuth = FirebaseFirestore.instance;

  @override
  Future<bool> saveUser(AppUser user) async {


    await _firebaseAuth
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
}
