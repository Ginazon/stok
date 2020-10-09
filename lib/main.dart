import 'package:flutter/material.dart';
import 'package:stok/sing_in_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stok',
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        primarySwatch: Colors.teal,

      ),
      home: SingInPage(),
    );
  }
}

