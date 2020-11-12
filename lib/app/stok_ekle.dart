import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok/common_widget/social_login_button.dart';
import 'package:stok/model/malzeme_model.dart';
import 'package:stok/viewmodel/app_user_view_model.dart';

class StokEkle extends StatefulWidget {
  @override
  _StokEkleState createState() => _StokEkleState();
}

class _StokEkleState extends State<StokEkle> {
  String _type;
  String _kalinlik;
  String _en;
  String _boy;
  String _adet;
  String _yeri;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _appUserModel = Provider.of<AppUserViewModel>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text(" Stok Ekle"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Malzeme Türü',
                              labelText: 'Malzeme Türü',
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (String type) {
                              _type = type;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Malzeme Kalınlığı',
                              labelText: 'Malzeme Kalınlığı',
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (kalinlik) {
                              _kalinlik = kalinlik;
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
                            decoration: InputDecoration(
                              hintText: 'Malzeme Eni',
                              labelText: 'Malzeme Eni',
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (en) {
                              _en = en;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Malzeme Boyu',
                              labelText: 'Malzeme Boyu',
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (boy) {
                              _boy = boy;
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
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Malzeme Adedi',
                            labelText: 'Malzeme Adedi',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (adet) {
                            _adet = adet;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Malzeme Yeri',
                            labelText: 'Malzeme Yeri',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (yeri) {
                            _yeri = yeri;
                          },
                        ),
                      ),
                    ],),
                   
                    SizedBox(
                      height: 16,
                    ),
                    SocialLoginButton(
                      onPressed: () async {
                        _formKey.currentState.save();

                        Malzeme _kaydedilecekMalzeme = Malzeme(
                            kalinlik: _kalinlik,
                            type: _type,
                            en: _en,
                            boy: _boy,
                            adet: _adet,
                            yeri: _yeri);
                        print(_kaydedilecekMalzeme.type);
                        await _appUserModel.saveMalzeme(_kaydedilecekMalzeme);
                      },
                      butonIcon: Icon(
                        Icons.save,
                        color: Colors.white,
                        size: 32,
                      ),
                      radius: 10,
                      yukseklik: 45,
                      butonText: "Kaydet",
                      butonColor: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
