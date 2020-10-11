import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stok/home_page.dart';
import 'package:stok/sign_in_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}


class _LandingPageState extends State<LandingPage> {

  User _user;
  @override
   void initState()  {



    super.initState();

    _checkUser();




  }
  @override

  Widget build(BuildContext context) {
    if(_user==null){
      return SignInPage(onSignIn: (user){
        _updateUser(user);

      },);
    }else{
      return HomePage(user: _user,
      onSignOut: (){
        _updateUser(null);
      },);
    }
  }

  Future <void>_checkUser()  async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    _user= FirebaseAuth.instance.currentUser;
  }
  void _updateUser(User user){
    setState(() {
      _user=user;
    });
  }
}
