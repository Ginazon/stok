import 'package:stok/model/app_user_model.dart';
import 'package:stok/services/auth_base.dart';

class FakeAuthServices implements AuthBase{
  String fakeUserID="Fake AppUser UID:1 2 3 4 5 6 7 8 9 0";
  String fakeUserEmail="Fake AppUser Email:fake@fake.com";
  @override
  Future<AppUser> currentUser()async {
    return Future.delayed(
        Duration(milliseconds: 1), () => AppUser(appUserID: fakeUserID,email: fakeUserEmail));
  }
  @override
  Future<bool> signOut() {

    return Future.value(true);
  }

  @override
  Future<AppUser> signInAnonymously() {
    return Future.delayed(
        Duration(seconds: 1), () => AppUser(appUserID: fakeUserID,email: fakeUserEmail));
  }

  @override
  Future<AppUser> signInWithGoogle() {
    return Future.delayed(Duration(milliseconds: 3), () =>
        AppUser(appUserID: "Google Fake User" + fakeUserID,email: "Google Fake User" + fakeUserEmail ));
  }

  @override
  Future<AppUser> createUserWithEmailandPassword(String email, String sifre) {
    return Future.delayed(Duration(milliseconds: 3), () =>
        AppUser(appUserID: "Google Fake User created" + fakeUserID,email: "Google Fake User" + fakeUserEmail ));
  }

  @override
  Future<AppUser> signInWithEmailandPassword(String email, String sifre) {
    return Future.delayed(Duration(milliseconds: 3), () =>
        AppUser(appUserID: "Google Fake User signed" + fakeUserID,email: "Google Fake User" + fakeUserEmail ));
  }


}