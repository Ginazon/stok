import 'package:stok/locator.dart';
import 'package:stok/model/app_user_model.dart';
import 'package:stok/services/auth_base.dart';
import 'package:stok/services/fake_auth_services.dart';
import 'package:stok/services/firebase_auth_service.dart';
import 'package:stok/services/firestore_db_service.dart';

enum AppMode {DEBUG,RELEASE}

class AppUserRepository implements AuthBase{

  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthServices _fakeAuthServices = locator<FakeAuthServices>();
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

  AppMode appMode = AppMode.RELEASE;

  @override
  Future<AppUser> currentUser() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthServices.currentUser();
    } else {
      return await _firebaseAuthService.currentUser();
    }
  }

  @override
  Future<bool> signOut() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthServices.signOut();
    } else {
      return await _firebaseAuthService.signOut();
    }
  }

  @override
  Future<AppUser> signInAnonymously() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthServices.signInAnonymously();
    } else {
      return await _firebaseAuthService.signInAnonymously();
    }
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthServices.signInWithGoogle();
    } else {
      AppUser user= await _firebaseAuthService.signInWithGoogle();
      bool _sonuc=await _firestoreDBService.saveUser(user);
      if(_sonuc){
        return user;
      }else return null;
    }
  }

  @override
  Future<AppUser> createUserWithEmailandPassword(String email, String sifre) async{
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthServices.createUserWithEmailandPassword(email, sifre);
    } else {
      AppUser user= await _firebaseAuthService.createUserWithEmailandPassword(email, sifre);
      bool _sonuc=await _firestoreDBService.saveUser(user);
      if(_sonuc){
        return user;
      }else return null;
    }

  }

  @override
  Future<AppUser> signInWithEmailandPassword(String email, String sifre) async{
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthServices.signInWithEmailandPassword(email, sifre);
    } else {
      return await _firebaseAuthService.signInWithEmailandPassword(email, sifre);
    }

  }


}