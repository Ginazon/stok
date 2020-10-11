import 'package:firebase_auth/firebase_auth.dart';
import 'package:stok/model/app_user_model.dart';
import 'package:stok/services/auth_base.dart';

class FirebaseAuthService implements AuthBase{



  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AppUser> currentUser() async {

    try {
      User user = _firebaseAuth.currentUser;
      return _appUserFromFirebase(user);
    } catch (e) {
      print("FirebaseAuthService/currentUser()........ HATASI ".toString());
      return null;
    }
  }

  AppUser _appUserFromFirebase(User user) {

    if (user == null) return null;
    return AppUser(appUserID: user.uid);
  }

  @override
  Future<bool> signOut() async{

    try {
      _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("FirebaseAuthService/signOut()........ HATASI ".toString());
      return false;
    }



  }

  @override
  Future<AppUser> signInAnonymously() async{
    try{

      UserCredential sonuc= await  _firebaseAuth.signInAnonymously();
      return _appUserFromFirebase(sonuc.user);
    }catch(e){ print("FirebaseAuthService/signInAnonymously()........ HATASI ".toString());
    return null;}

  }


}