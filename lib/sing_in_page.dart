import 'package:flutter/material.dart';
import 'package:stok/common_widget/social_login_button.dart';

class SingInPage extends StatelessWidget {
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
              butonIcon: Image.asset("images/google-logo.png"),
              radius: 10,
              onPressed: () {},),
            SocialLoginButton(
              butonText: "Facebook ile Giriş Yap",
              butonIcon: Image.asset("images/facebook-logo.png"),
              onPressed: () {},
              butonColor: Color(0xFF334D92),
              radius: 10,
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
              butonText: "Email ve Şifre ile Giriş yap",
              butonColor: Colors.blueAccent,
              textColor: Colors.white,
            ),
            SocialLoginButton(
              onPressed: (){},
              butonColor: Colors.teal,
              butonIcon: Icon(Icons.supervised_user_circle,color: Colors.white,),
              butonText: "Misafir Girişi",
              radius: 10,
              textColor: Colors.white,
            ),

          ],
        ),
      ),
    );
  }
}
