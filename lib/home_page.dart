
import 'package:flutter/material.dart';
import 'package:stok/locator.dart';
import 'package:stok/model/app_user_model.dart';
import 'package:stok/services/auth_base.dart';
import 'package:stok/services/firebase_auth_service.dart';

class HomePage extends StatelessWidget {


  final VoidCallback onSignOut;
  final AppUser user;
  AuthBase authService=locator<FirebaseAuthService>();

  HomePage({Key key,@required this.onSignOut,@required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [FlatButton(onPressed: _cikisYap, child: Text("Çıkış Yap",style: TextStyle(color: Colors.white),))],
        title: Text("Ana Sayfa"),
      ),
      body: Center(
        child: Text("Hoş Geldiniz ${user.appUserID}"),
      ),
    );
  }

  Future<bool> _cikisYap() async {
  bool sonuc=await authService.signOut();
    onSignOut();
    return sonuc;

  }
}
