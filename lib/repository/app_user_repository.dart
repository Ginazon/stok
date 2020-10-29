import 'dart:io';
import 'package:stok/locator.dart';
import 'package:stok/model/konusma.dart';
import 'package:stok/model/mesaj.dart';
import 'package:stok/model/user.dart';
import 'package:stok/services/auth_base.dart';
import 'package:stok/services/fake_auth_services.dart';
import 'package:stok/services/firebase_auth_service.dart';
import 'package:stok/services/firebase_storage_service.dart';
import 'package:stok/services/firestore_db_service.dart';
import 'package:timeago/timeago.dart' as timeago;

enum AppMode {DEBUG,RELEASE}

class AppUserRepository implements AuthBase{

  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthServices _fakeAuthServices = locator<FakeAuthServices>();
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  FirebaseStorageService _firebaseStorageService = locator<FirebaseStorageService>();

  AppMode appMode = AppMode.RELEASE;
  List<AppUser> tumKullaniciListesi=[];

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

 Future<List<AppUser>> getAllUsers() async{

   if (appMode == AppMode.DEBUG) {
     return [];
   } else {
     tumKullaniciListesi=await _firestoreDBService.getAllUsers();

     return tumKullaniciListesi;
   }
 }

  Stream<List<Mesaj>> getMessages(String currentUserID, String sohbetEdilenUserID) {

    if (appMode == AppMode.DEBUG) {
      return Stream.empty();
    } else {
      return _firestoreDBService.getMessages(currentUserID, sohbetEdilenUserID);
    }

  }

  Future<bool> saveMessage(Mesaj kaydedilecekMesaj)async {
    if (appMode == AppMode.DEBUG) {
      return true;
    } else {
      return _firestoreDBService.saveMessage(kaydedilecekMesaj);
    }

  }

  Future<List<Konusma>> getAllConversations(String appUserID)async {

    if (appMode == AppMode.DEBUG) {
      return [];
    } else {
      DateTime _zaman = await _firestoreDBService.saatiGoster(appUserID);
      var konusmaListesi= await _firestoreDBService.getAllConversations(appUserID);
      for (var oankiKonusma in konusmaListesi) {
        var userListesindekiKullanici =
        listedeUserBul(oankiKonusma.kimleKonusuyor);

        if (userListesindekiKullanici != null) {
          print("VERILER LOCAL CACHEDEN OKUNDU");
          oankiKonusma.konusulanUserName = userListesindekiKullanici.userName;
          oankiKonusma.konusulanUserProfilURL =
              userListesindekiKullanici.profilURL;
          oankiKonusma.sonOkunmaZamani=_zaman;

        } else {
          print("VERILER VERITABANINDAN OKUNDU");
          print(
              "aranılan user daha önceden veritabanından getirilmemiş, o yüzden veritabanından bu degeri okumalıyız");
          var _veritabanindanOkunanUser =
          await _firestoreDBService.readUser(oankiKonusma.kimleKonusuyor);
          oankiKonusma.konusulanUserName = _veritabanindanOkunanUser.userName;
          oankiKonusma.konusulanUserProfilURL =
              _veritabanindanOkunanUser.profilURL;
          oankiKonusma.sonOkunmaZamani=_zaman;
        }
      }

      return konusmaListesi;
    }
  }
AppUser listedeUserBul(String appUserID){

  for (int i = 0; i < tumKullaniciListesi.length; i++) {
    if (tumKullaniciListesi[i].appUserID == appUserID) {
      return tumKullaniciListesi[i];
    }
  }

  return null;
}

}