import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stok/app/tab_items.dart';

class MyCustomBottomNavigation extends StatelessWidget {
  const MyCustomBottomNavigation(
      {Key key,
      @required this.currentTab,
      @required this.onSelectedTab,
      @required this.sayfaOlusturucu,
      @required this.navigatorKeys})
      : super(key: key);
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem, Widget> sayfaOlusturucu;
  final Map<TabItem, GlobalKey> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _navItemOlustur(TabItem.Kullanicilar),
          _navItemOlustur(TabItem.Konusmalarim),
          _navItemOlustur(TabItem.Lazer),
          _navItemOlustur(TabItem.Plasma),

          _navItemOlustur(TabItem.Profil),
        ],
        onTap: (index) => onSelectedTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final gosterilecekItem=TabItem.values[index];
        return CupertinoTabView(
            navigatorKey: navigatorKeys[gosterilecekItem],
            builder: (context) {
              return sayfaOlusturucu[gosterilecekItem];
            }

        );
      },
    );
  }

  BottomNavigationBarItem _navItemOlustur(TabItem tabitem) {
    final olusturulacakTab = TabItemData.tumTablar[tabitem];
    return BottomNavigationBarItem(
      icon: Icon(olusturulacakTab.icon),
      label: olusturulacakTab.label,
    );
  }
}
