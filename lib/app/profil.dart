import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok/common_widget/platform_duyarli_alert_dialog.dart';
import 'package:stok/viewmodel/app_user_view_model.dart';

class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        actions: [
          FlatButton(
              onPressed: () => _cikisIcinOnayIste(context),
              child: Text(
                "Çıkış Yap",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ))
        ],
      ),
      body: Center(
        child: Text("Profil Sayfası"),
      ),
    );
  }

  Future<bool> _cikisYap(BuildContext context) async {
    final _appUserModel = Provider.of<AppUserViewModel>(context, listen: false);
    bool sonuc = await _appUserModel.signOut();
    return sonuc;
  }

  Future _cikisIcinOnayIste(BuildContext context) async {
    final sonuc=await PlatformDuyarliAlertDialog(
      baslik: "Çıkış Yapılıyor",
      icerik: "Çıkış işlemi yapılsın mı?",
      anaButonYazisi: "Evet",
      iptalButonYazisi: "Hayır",
    ).goster(context);
    if(sonuc==true){_cikisYap(context);}
  }
}
