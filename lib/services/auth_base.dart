import 'package:stok/model/app_user_model.dart';

abstract class AuthBase{
  Future<AppUser> currentUser();
  Future<AppUser> signInAnonymously();
  Future<bool> signOut();
  Future<AppUser> signInWithGoogle();
  Future<AppUser> signInWithEmailandPassword(String email,String sifre);
  Future<AppUser> createUserWithEmailandPassword(String email,String sifre);




}