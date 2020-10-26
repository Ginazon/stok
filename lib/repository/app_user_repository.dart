import 'dart:io';

import 'package:stok/locator.dart';
import 'package:stok/model/user.dart';
import 'package:stok/services/auth_base.dart';
import 'package:stok/services/fake_auth_services.dart';
import 'package:stok/services/firebase_auth_service.dart';
import 'package:stok/services/firebase_storage_service.dart';
import 'package:stok/services/firestore_db_service.dart';

enum AppMode {DEBUG,RELEASE}

class AppUserRepository implements AuthBase{

  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthServices _fakeAuthServices = locator<FakeAuthServices>();
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  FirebaseStorageService _firebaseStorageService = locator<FirebaseStorageService>();

  AppMode appMode = AppMode.RELEASE;

  @override
  Future<AppUser> currentUser() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthServices.currentUser();
    } else {
      AppUser user= await _firebaseAuthService.currentUser();
      return await _firestoreDBService.readUser(user.appUserID);
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
        return await _firestoreDBService.readUser(user.appUserID);
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


        return await _firestoreDBService.readUser(user.appUserID);
      }else return null;
    }

  }

  @override
  Future<AppUser> signInWithEmailandPassword(String email, String sifre) async{
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthServices.signInWithEmailandPassword(email, sifre);
    } else {
      AppUser _user= await _firebaseAuthService.signInWithEmailandPassword(email, sifre);
      return await _firestoreDBService.readUser(_user.appUserID);
    }

  }

  Future<bool> updateUserName(String appUserID, String yeniAppUserName) async{
    if (appMode == AppMode.DEBUG) {
      return false;
    } else {

      return await _firestoreDBService.updateUserName(appUserID, yeniAppUserName);
    }
  }

  Future<String>uploadFile(String appUserID, String fileType, File profilFoto) async {
    if (appMode == AppMode.DEBUG) {
      return "dosya_indirme_linki";
    } else {
      var profilFotoUrl=await _firebaseStorageService.uploadFile(appUserID, fileType, profilFoto);
      await _firestoreDBService.updateProfilFoto(appUserID,profilFotoUrl);

      return profilFotoUrl;
    }

  }


}