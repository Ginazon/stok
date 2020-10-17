import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stok/locator.dart';
import 'package:stok/viewmodel/app_user_view_model.dart';

Future<void> main() async {
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
      theme: ThemeData(
        primarySwatch: Colors.teal,

      ),
      home: ChangeNotifierProvider(
          create: (context) => AppUserViewModel(),
          child: LandingPage()),
    );
  }
}

