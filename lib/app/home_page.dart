import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok/app/konusmalarim_page.dart';
import 'package:stok/app/kullanicilar.dart';
import 'package:stok/app/lazer_list.dart';
import 'package:stok/app/my_custom_bottom_navi.dart';
import 'package:stok/app/profil.dart';
import 'package:stok/app/tab_items.dart';
import 'package:stok/common_widget/platform_duyarli_alert_dialog.dart';
import 'package:stok/model/user.dart';
import 'file:///D:/stok/stok/lib/app/plasma_list.dart';
import 'package:stok/viewmodel/all_app_users_view_model.dart';

class HomePage extends StatefulWidget {
  final AppUser user;

  HomePage({Key key, @required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  TabItem _currentTab = TabItem.Konusmalarim;
  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.Kullanicilar: GlobalKey<NavigatorState>(),
    TabItem.Konusmalarim: GlobalKey<NavigatorState>(),
    TabItem.Lazer: GlobalKey<NavigatorState>(),
    TabItem.Plasma: GlobalKey<NavigatorState>(),
    TabItem.Profil: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, Widget> tumSayfalar() {
    return {
      TabItem.Kullanicilar:ChangeNotifierProvider(
        create: (context)=>AllAppUsersViewModel(),
        child: KullanicilarPage(),
      ),


      TabItem.Konusmalarim: KonusmalarimPage(),
      TabItem.Lazer: LazerList(),
      TabItem.Plasma: PlasmaList(),

      TabItem.Profil: ProfilPage(),
    };
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.subscribeToTopic("spor");
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        PlatformDuyarliAlertDialog(
            baslik: message['data']['title'],
            icerik: message['data']['message'],
            anaButonYazisi: "Tamam")
            .goster(context);

      },

      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        PlatformDuyarliAlertDialog(
            baslik: message['data']['title'],
            icerik: message['data']['body'],
            anaButonYazisi: "Tamam")
            .goster(context);

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: MyCustomBottomNavigation(
        navigatorKeys: navigatorKeys,
        sayfaOlusturucu: tumSayfalar(),
        currentTab: _currentTab,
        onSelectedTab: (secilenTab) {
          if (secilenTab == _currentTab) {
            navigatorKeys[secilenTab]
                .currentState
                .popUntil((route) => route.isFirst);
          } else {
            setState(() {
              _currentTab = secilenTab;
            });
          }
          print("Seçilen TabItem" + secilenTab.toString());
        },
      ),
    );
  }
}

