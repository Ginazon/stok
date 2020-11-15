import 'package:flutter/material.dart';
import 'package:stok/common_widget/social_login_button.dart';
import 'package:stok/model/malzeme_model.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text("Malzeme Düzenle"),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: _currentMalzeme.type,
                    decoration: InputDecoration(

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
                    initialValue: _currentMalzeme.kalinlik,
                    decoration: InputDecoration(

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
                    initialValue: _currentMalzeme.en,
                    decoration: InputDecoration(

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
                    initialValue: _currentMalzeme.boy,
                    decoration: InputDecoration(

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
                child: TextFormField( initialValue: _currentMalzeme.adet,
                  decoration: InputDecoration(

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
                  initialValue: _currentMalzeme.yeri,
                  decoration: InputDecoration(

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

                Malzeme _updateMalzeme = Malzeme(
                    kalinlik: _kalinlik,
                    type: _type,
                    en: _en,
                    boy: _boy,
                    adet: _adet,
                    yeri: _yeri);
                print(_updateMalzeme.type);
                //await _appUserModel.updateMalzeme(_updateMalzeme);
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
    );
  }
}
