import 'package:stok/model/app_user_model.dart';
import 'package:stok/services/auth_base.dart';

class FakeAuthServices implements AuthBase{
  String fakeUserID="Fake AppUser UID:1 2 3 4 5 6 7 8 9 0";
  @override
  Future<AppUser> currentUser()async {
    return AppUser(appUserID: fakeUserID);


  }
  @override
  Future<bool> signOut() {

    return Future.value(true);
  }

  @override
  Future<AppUser> signInAnonymously() {

    return  Future.delayed(Duration(seconds: 1),()=> AppUser(appUserID: fakeUserID));
  }


}