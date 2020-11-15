import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok/common_widget/platform_duyarli_alert_dialog.dart';
import 'package:stok/common_widget/social_login_button.dart';
import 'package:stok/model/malzeme_model.dart';
import 'package:stok/viewmodel/app_user_view_model.dart';

class MalzemeDetay extends StatefulWidget {
  final Malzeme currentMalzeme;

  const MalzemeDetay({Key key, this.currentMalzeme}) : super(key: key);

  @override
  _MalzemeDetayState createState() => _MalzemeDetayState();
}

class _MalzemeDetayState extends State<MalzemeDetay> {
  String _type;
  String _kalinlik;
  String _en;
  String _boy;
  String _adet;
  String _yeri;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Malzeme _currentMalzeme = widget.currentMalzeme;
    final _appUserModel = Provider.of<AppUserViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Malzeme Düzenle"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: _currentMalzeme.type,
                          decoration: InputDecoration(
                            labelText: "Malzeme Türü",
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (String yeniType) {
                            _type = yeniType;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(

                          initialValue: _currentMalzeme.kalinlik,
                          decoration: InputDecoration(
                           labelText: "Kalınlık",

                            border: OutlineInputBorder(),
                          ),
                          onSaved: (yeniKalinlik) {
                            _kalinlik = yeniKalinlik;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: _currentMalzeme.en,
                          decoration: InputDecoration(
                            labelText: "En",
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (yeniEn) {
                            _en = yeniEn;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          initialValue: _currentMalzeme.boy,
                          decoration: InputDecoration(
                            labelText: "Boy",
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (yeniBoy) {
                            _boy = yeniBoy;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(children: [
                    Expanded(
                      child: TextFormField(initialValue: _currentMalzeme.adet,
                        decoration: InputDecoration(
                          labelText: "Adet",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (yeniAdet) {
                          _adet = yeniAdet;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue: _currentMalzeme.yeri,
                        decoration: InputDecoration(
                          labelText: "Yeri",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (yeniYeri) {
                          _yeri = yeniYeri;
                        },
                      ),
                    ),
                  ],),

                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SocialLoginButton(
                          onPressed: () async {
                            _formKey.currentState.save();
                            Malzeme _updateMalzeme = Malzeme(
                                malzemeid: _currentMalzeme.malzemeid,
                                kalinlik: _kalinlik,
                                type: _type,
                                en: _en,
                                boy: _boy,
                                adet: _adet,
                                yeri: _yeri);
                            print(_updateMalzeme.kalinlik);
                            Navigator.pop(context);

                            final sonuc=await PlatformDuyarliAlertDialog(
                              baslik:"Malzeme Silinecek" ,
                              icerik: "Silmek istediğinizden Emin misiniz?",
                              anaButonYazisi: "Sil",
                              iptalButonYazisi: "Vazgeç",
                            ).goster(context);
                            if(sonuc){
                              await _appUserModel.deleteMalzeme(_currentMalzeme);
                            }
                          },

                          butonIcon: Icon(
                            Icons.clear,
                            color: Colors.white,
                            size: 32,
                          ),
                          radius: 10,
                          yukseklik: 45,
                          butonText: "Sil",
                          butonColor:Colors.red,
                        textColor: Colors.white,

                      ),
                      SizedBox(width: 30,),
                      SocialLoginButton(
                        onPressed: () async {
                          _formKey.currentState.save();
                          Malzeme _updateMalzeme = Malzeme(
                              malzemeid: _currentMalzeme.malzemeid,

                              kalinlik: _kalinlik,
                              type: _type,
                              en: _en,
                              boy: _boy,
                              adet: _adet,
                              yeri: _yeri);
                          print(_updateMalzeme.kalinlik);
                          Navigator.pop(context);

                          return await _appUserModel.updateMalzeme(_updateMalzeme);
                        },

                        butonIcon: Icon(
                          Icons.save,
                          color: Colors.white,
                          size: 32,
                        ),
                        radius: 10,
                        yukseklik: 45,
                        butonText: "Değiştir",
                        butonColor: Theme
                            .of(context)
                            .primaryColor,
                        textColor: Colors.white,
                      ),


                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
