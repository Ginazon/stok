import 'package:stok/model/app_user_model.dart';
import 'package:stok/services/auth_base.dart';

class FirebaseAuthService implements AuthBase{
  @override
  Future<AppUser> currentUser() {

    throw UnimplementedError();
  }

  @override
  Future<AppUser> signInAnonymously() {

    throw UnimplementedError();
  }

  @override
  Future<bool> signOut() {

    throw UnimplementedError();
  }
}