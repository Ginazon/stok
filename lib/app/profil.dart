import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:stok/common_widget/platform_duyarli_alert_dialog.dart';
import 'package:stok/common_widget/social_login_button.dart';
import 'package:stok/viewmodel/app_user_view_model.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  TextEditingController _controller;
  File _profilFoto;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  Future<void> _kameradanFotoCek() async {
   final _picketFoto=await picker.getImage(source: ImageSource.camera);

   setState(() {
     _profilFoto=File(_picketFoto.path);
     Navigator.of(context).pop();
   });
  }


  Future<void> _galeridenFotoSec() async {
    final _picketFoto=await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _profilFoto=File(_picketFoto.path);
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    AppUserViewModel _appUserModel = Provider.of<AppUserViewModel>(context);
    _controller.text = _appUserModel.user.userName;
    print("Profil Sayfasındaki User Değerleri...................:" +
        _appUserModel.user.toString());
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){showModalBottomSheet(context: context, builder: (context){
                    return Container(
                      height: 170,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.camera_alt_outlined),
                            title: Text("Fotoğraf Çek"),
                            onTap: (){_kameradanFotoCek();},
                          ),
                          ListTile(
                            leading: Icon(Icons.photo_library_outlined),
                            title: Text("Galeriden Seç"),
                            onTap: (){_galeridenFotoSec();},
                          ),
                        ],
                      ),
                    );

                  });},
                  child: CircleAvatar(
                    backgroundImage:_profilFoto==null ?NetworkImage(_appUserModel.user.profilURL):FileImage(_profilFoto),
                    radius: 50,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _appUserModel.user.email,
                  readOnly: true,
                  decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Email",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                      labelText: "Kullanıcı Adı",
                      hintText: "Kullanıcı Adı",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SocialLoginButton(
                  butonText: "Kaydet",
                  onPressed: () {
                    _userNameGuncelle(context);
                    _profilFotoGuncelle(context);
                  },
                  butonColor: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _cikisYap(BuildContext context) async {
    final _appUserModel = Provider.of<AppUserViewModel>(context, listen: false);
    bool sonuc = await _appUserModel.signOut();
    return sonuc;
  }

  Future _cikisIcinOnayIste(BuildContext context) async {
    final sonuc = await PlatformDuyarliAlertDialog(
      baslik: "Çıkış Yapılıyor",
      icerik: "Çıkış işlemi yapılsın mı?",
      anaButonYazisi: "Evet",
      iptalButonYazisi: "Hayır",
    ).goster(context);
    if (sonuc == true) {
      _cikisYap(context);
    }
  }

  Future<void> _userNameGuncelle(BuildContext context) async {
    final _appUserModel = Provider.of<AppUserViewModel>(context, listen: false);
    if (_appUserModel.user.userName != _controller.text) {
      var updateResult = await _appUserModel.updateUserName(
          _appUserModel.user.appUserID, _controller.text);
      if(updateResult == true){

        PlatformDuyarliAlertDialog(
          baslik: "Başarılı",
          icerik: "Kullanıcı Adı Değiştirildi",
          anaButonYazisi: "Tamam",
        ).goster(context);
      }else{

        PlatformDuyarliAlertDialog(
          baslik: "Kullanıcı Adı Zaten Var",
          icerik: "Farklı Bir Kullanıcı Adı Seçiniz",
          anaButonYazisi: "Tamam",
        ).goster(context);
        _controller.text=_appUserModel.user.userName;
      }
    }
  }

  Future<void> _profilFotoGuncelle(BuildContext context) async {
    final _appUserModel = Provider.of<AppUserViewModel>(context, listen: false);
    if(_profilFoto!=null){


      var url = await _appUserModel.uploadFile(_appUserModel.user.appUserID,"profil_foto",_profilFoto);
      print ("gelen Url........:"+url);
      if(url!=null){
        PlatformDuyarliAlertDialog(
          baslik: "Başarılı",
          icerik: "Profil Foto Değiştirildi",
          anaButonYazisi: "Tamam",
        ).goster(context);

      }

    }
  }


}
