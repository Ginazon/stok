import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stok/model/user.dart';
import 'package:stok/services/auth_base.dart';

class FirebaseAuthService implements AuthBase{



  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AppUser> currentUser() async {

    try {
      User user = _firebaseAuth.currentUser;
      return _appUserFromFirebase(user);
    } catch (e) {
      print("FirebaseAuthService/currentUser()........ HATASI "+e.toString());
      return null;
    }
  }

  @override
  Future<bool> signOut() async{

    try {
      final _googleSignIn=GoogleSignIn();
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("FirebaseAuthService/signOut()........ HATASI "+e.toString());
      return false;
    }



  }

  @override
  Future<AppUser> signInAnonymously() async {
    try {
      UserCredential sonuc = await _firebaseAuth.signInAnonymously();
      return _appUserFromFirebase(sonuc.user);
    } catch (e) {
      print(
          "FirebaseAuthService/signInAnonymously()........ HATASI "+e.toString());
      return null;
    }
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();

    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        UserCredential sonuc = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: _googleAuth.idToken,
                accessToken: _googleAuth.accessToken));
        return _appUserFromFirebase(sonuc.user);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  AppUser _appUserFromFirebase(User user) {
    if (user == null) return null;
    return AppUser(appUserID: user.uid,email: user.email);
  }

  @override
  Future<AppUser> createUserWithEmailandPassword(String email, String sifre) async{
    UserCredential sonuc = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: sifre);
      return _appUserFromFirebase(sonuc.user);
  }

  @override
  Future<AppUser> signInWithEmailandPassword(String email, String sifre) async{
    UserCredential sonuc = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: sifre);
      return _appUserFromFirebase(sonuc.user);
  }
}