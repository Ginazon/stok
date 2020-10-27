import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok/viewmodel/app_user_view_model.dart';
class KullanicilarPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final _appUserModel = Provider.of<AppUserViewModel>(context, listen: false);
    _appUserModel.getAllUsers();

    return Scaffold(
      appBar: AppBar(title: Text("Kullanıcılar"),),
      body: Center(child: Text("Kullanıcılar Sayfası"),),
    );
  }
}

