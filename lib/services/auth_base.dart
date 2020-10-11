import 'package:stok/model/app_user_model.dart';

abstract class AuthBase{
  Future<AppUser> currentUser();
  Future<AppUser> signInAnonymously();
  Future<bool> signOut();
}