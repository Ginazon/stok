
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok/app/sign_in/sign_in_page.dart';
import 'file:///D:/stok/stok/lib/app/home_page.dart';
import 'package:stok/viewmodel/app_user_view_model.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _appUserModel = Provider.of<AppUserViewModel>(context,listen: true);

    if(_appUserModel.state==ViewState.Idle){
      if(_appUserModel.user==null){
        return SignInPage();
      }else{
        return HomePage(user: _appUserModel.user);
      }
    }else{
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

  }
}
