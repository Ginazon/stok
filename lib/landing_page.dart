
import 'package:flutter/material.dart';
import 'package:stok/home_page.dart';
import 'package:stok/locator.dart';
import 'package:stok/model/app_user_model.dart';
import 'package:stok/services/auth_base.dart';
import 'package:stok/services/firebase_auth_service.dart';
import 'package:stok/sign_in_page.dart';

class LandingPage extends StatefulWidget {


  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
AuthBase authService=locator<FirebaseAuthService>();
  AppUser _user;

  @override
  void initState() {
    super.initState();

    _checkUser();
  }
  @override
  Widget build(BuildContext context) {
    if(_user==null){
      return SignInPage( onSignIn: (user) {
        _updateUser(user);
      },);
    }else{
      return HomePage(
        user: _user,
        onSignOut: () {
          _updateUser(null);
        },);
    }
  }
  Future <void> _checkUser() async {
    _user = await authService.currentUser();
  }
  void _updateUser(AppUser user) {
    setState(() {
      _user = user;
    });
  }
}
