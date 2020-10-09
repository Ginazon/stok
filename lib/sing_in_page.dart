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
            SocialoginButton(
              butonText: "Gmail ile Giriş Yap",
              textColor: Colors.black87,
              butonColor: Colors.white,
              radius: 10,
              onPressed: () {},)
          ],
        ),
      ),
    );
  }
}
