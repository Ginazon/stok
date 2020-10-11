
import 'package:flutter/material.dart';
import 'package:stok/common_widget/social_login_button.dart';
import 'package:stok/model/app_user_model.dart';
import 'package:stok/services/auth_base.dart';

class SignInPage extends StatelessWidget {

  final Function(AppUser) onSignIn;
  final AuthBase authService;

  const SignInPage({Key key, @required this.onSignIn,@required this.authService}) : super(key: key);

  Future<void> _misafirGirisi() async {
   AppUser _user = await authService.signInAnonymously();

    onSignIn(_user);
    print("Oturum Açan User ID="+_user.appUserID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Stok Uygulaması'),
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade300,
      body:Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget> [
            Text('Oturum Açınız',textAlign:TextAlign.center,style: TextStyle(fontSize: 18),),SizedBox(height: 16,),
            SocialLoginButton(
              butonText: "Gmail ile Giriş Yap",
              textColor: Colors.black87,
              butonColor: Colors.white,
              yukseklik: 45,
              butonIcon: Image.asset("images/google-logo.png"),
              radius: 10,
              onPressed: () {},),

            SocialLoginButton(
              butonText: "Facebook ile Giriş Yap",
              butonIcon: Image.asset("images/facebook-logo.png"),
              onPressed: () {},
              butonColor: Color(0xFF334D92),
              radius: 10,
              yukseklik: 45,
              textColor: Colors.white,
            ),
            SocialLoginButton(
              onPressed: () {},
              butonIcon: Icon(
                Icons.email,
                color: Colors.white,
                size: 32,
              ),
              radius: 10,
              yukseklik: 45,
              butonText: "Email ve Şifre ile Giriş yap",
              butonColor: Colors.blueAccent,
              textColor: Colors.white,
            ),
            SocialLoginButton(
              onPressed: _misafirGirisi,
              butonColor: Colors.teal,
              butonIcon: Icon(Icons.supervised_user_circle,color: Colors.white,size: 35,),
              butonText: "Misafir Girişi",
              radius: 10, yukseklik: 45,
              textColor: Colors.white,
            ),


          ],
        ),
      ),
    );
  }


}
