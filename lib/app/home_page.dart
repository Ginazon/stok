import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok/app/kullanicilar.dart';
import 'package:stok/app/my_custom_bottom_navi.dart';
import 'package:stok/app/profil.dart';
import 'package:stok/app/tab_items.dart';
import 'package:stok/model/app_user_model.dart';
import 'package:stok/viewmodel/app_user_view_model.dart';

class HomePage extends StatefulWidget {
  final AppUser user;

  HomePage({Key key, @required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.Kullanicilar;

  Map<TabItem, Widget> tumSayfalar() {
    return {
      TabItem.Kullanicilar: KullanicilarPage(),
      TabItem.Profil: ProfilPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyCustomBottomNavigation(
        sayfaOlusturucu: tumSayfalar(),
        currentTab: _currentTab,
        onSelectedTab: (secilenTab) {
          setState(() {
            _currentTab = secilenTab;
          });
          print("Seçilen TabItem" + secilenTab.toString());
        },
      ),
    );
  }
}
/*Future<bool> _cikisYap(BuildContext context) async {
    final _appUserModel = Provider.of<AppUserViewModel>(context, listen: false);
    bool sonuc = await _appUserModel.signOut();
    return sonuc;
  }*/
