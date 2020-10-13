
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok/model/app_user_model.dart';
import 'package:stok/viewmodel/app_user_view_model.dart';

class HomePage extends StatelessWidget {
  final AppUser user;

  HomePage({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
              onPressed: () => _cikisYap(context),
              child: Text(
                "Çıkış Yap",
                style: TextStyle(color: Colors.white),
              ))
        ],
        title: Text("Ana Sayfa"),
      ),
      body: Center(
        child: Text("Hoş Geldiniz ${user.appUserID}"),
      ),
    );
  }

  Future<bool> _cikisYap(BuildContext context) async {
    final _appUserModel = Provider.of<AppUserViewModel>(context, listen: false);
    bool sonuc = await _appUserModel.signOut();
    return sonuc;
  }
}
