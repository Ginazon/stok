import 'package:flutter/material.dart';
import 'package:stok/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stok/locator.dart';
import 'package:stok/services/fake_auth_services.dart';
import 'package:stok/services/firebase_auth_service.dart';


Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();

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
      home: LandingPage(),
    );
  }
}

