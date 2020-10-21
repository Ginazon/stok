import 'package:stok/model/user.dart';

abstract class AuthBase{
  Future<AppUser> currentUser();
  Future<AppUser> signInAnonymously();
  Future<bool> signOut();
  Future<AppUser> signInWithGoogle();
  Future<AppUser> signInWithEmailandPassword(String email,String sifre);
  Future<AppUser> createUserWithEmailandPassword(String email,String sifre);




}