
import 'package:flutter/material.dart';
import 'package:stok/home_page.dart';
import 'package:stok/model/app_user_model.dart';
import 'package:stok/services/auth_base.dart';
import 'package:stok/sign_in_page.dart';

class LandingPage extends StatefulWidget {
  final AuthBase authService;

  const LandingPage({Key key, @required this.authService}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  AppUser _user;





  @override
  void initState() {
    super.initState();

    _checkUser();




  }





  @override

  Widget build(BuildContext context) {
    if(_user==null){
      return SignInPage(authService: widget.authService, onSignIn: (user) {
        _updateUser(user);
      },);
    }else{
      return HomePage(authService: widget.authService,
        user: _user,
        onSignOut: () {
          _updateUser(null);
        },);
    }
  }






  Future <void> _checkUser() async {


    _user = await widget.authService.currentUser();
  }





  void _updateUser(AppUser user) {
    setState(() {
      _user = user;
    });
  }
}
