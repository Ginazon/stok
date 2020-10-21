import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok/common_widget/social_login_button.dart';
import 'package:stok/model/user.dart';
import 'package:stok/viewmodel/app_user_view_model.dart';
enum FormType{Register,Login}

class EmailVeSifreLoginPage extends StatefulWidget {
  @override
  _EmailVeSifreLoginPageState createState() => _EmailVeSifreLoginPageState();
}

class _EmailVeSifreLoginPageState extends State<EmailVeSifreLoginPage> {
  String _email, _sifre;
  String _buttonText,_linkText;
  String _intValEmail="onur@onur.com";
  String _intValPass="123456";

  var _formType=FormType.Login;

  final _formKey=GlobalKey<FormState>();



  Future<void> _formSubmit() async {
    _formKey.currentState.save();
    print("Email :"+_email +"     sifre :"+_sifre.toString());
    final _userModel=Provider.of<AppUserViewModel>(context,listen: false);
   if(_formType==FormType.Login){

    AppUser _girisYapanUser= await _userModel.signInWithEmailandPassword(_email, _sifre);
    if(_girisYapanUser!=null)print("Oturum Açan Kullanıcı :"+_girisYapanUser.appUserID.toString());

   }else{
     AppUser _kayitOlanUser= await _userModel.createUserWithEmailandPassword(_email, _sifre);
     if(_kayitOlanUser!=null)print("Oturum Açan Kullanıcı :"+_kayitOlanUser.appUserID.toString());

   }
  }




  void _degistir() {
  setState(() {
    _formType==FormType.Login ? _formType=FormType.Register : _formType=FormType.Login;
  });

  }
  @override

  Widget build(BuildContext context) {

    _buttonText=_formType==FormType.Login ? "Giriş Yap": "Kayıt Ol";
    _linkText  =_formType==FormType.Login ? "Kayıt Ol": "Giriş Yap";

    final _appUserModel = Provider.of<AppUserViewModel>(context,listen: true);


if(_appUserModel.user!=null){
  Future.delayed(Duration(milliseconds: 3),(){ Navigator.of(context).pop();});

}

    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş / Kayıt"),
      ),
      body: _appUserModel.state== ViewState.Idle? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key:_formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: _intValEmail,
                 keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    errorText: _appUserModel.emailHataMesaji !=null ? _appUserModel.emailHataMesaji:null,
                    prefixIcon: Icon(Icons.mail),
                    hintText: 'Email',
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (String girilenEmail){
                    _email = girilenEmail;
                  },
                ),
                SizedBox(height: 16,),
                TextFormField(
                  initialValue: _intValPass,
                  obscureText: true,
                  decoration: InputDecoration(
                    errorText: _appUserModel.sifreHataMesaji !=null ? _appUserModel.sifreHataMesaji:null,
                    prefixIcon: Icon(Icons.mail),
                    hintText: 'Şifre',
                    labelText: 'Şifre',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (String girilenSifre){
                    _sifre = girilenSifre;
                  },
                ),
                SizedBox(height: 16,),
                SocialLoginButton(
                  onPressed:()=> _formSubmit(),
                  butonIcon: Icon(
                    Icons.login,
                    color: Colors.white,
                    size: 32,
                  ),
                  radius: 10,
                  yukseklik: 45,
                  butonText:_buttonText,
                  butonColor: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
                SizedBox(height: 18,),
                FlatButton(onPressed: ()=>_degistir(), child: Text(_linkText,style: TextStyle(color: Colors.blue),)),
              ],
            ),

          ),
        ),
      ):Center(
        child: CircularProgressIndicator(),
      ),
    );
  }




}
