import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok/app/konusma_page.dart';
import 'package:stok/model/user.dart';
import 'package:stok/viewmodel/app_user_view_model.dart';

class KullanicilarPage extends StatefulWidget {
  @override
  _KullanicilarPageState createState() => _KullanicilarPageState();
}

class _KullanicilarPageState extends State<KullanicilarPage> {
  @override
  Widget build(BuildContext context) {
    final _appUserModel = Provider.of<AppUserViewModel>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text("Kullanıcılar"),
        ),
        body: FutureBuilder<List<AppUser>>(
          future: _appUserModel.getAllUsers(),
          builder: (context, sonuc) {
            if (sonuc.hasData) {
              var tumKullanicilar = sonuc.data;
              if (tumKullanicilar.length - 1 > 0) {
                return RefreshIndicator(
                  onRefresh: _kullanicilarListesiniYenile,
                  child: ListView.builder(
                    itemCount: tumKullanicilar.length,
                    itemBuilder: (context, index) {
                      var oAnKiUser = sonuc.data[index];
                      if (oAnKiUser.appUserID != _appUserModel.user.appUserID) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                    builder: (context) => KonusmaPage(
                                      currentUser: _appUserModel.user,
                                      sohbetEdilenUser: oAnKiUser,
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(oAnKiUser.userName),
                                subtitle: Text(oAnKiUser.email),
                                leading: CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      NetworkImage(oAnKiUser.profilURL),
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              indent: 20,
                              endIndent: 20,
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                );
              } else {
                return Center(
                  child: RefreshIndicator(
                    onRefresh: _kullanicilarListesiniYenile,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.supervised_user_circle,
                                color: Theme.of(context).primaryColor,
                                size: 100,
                              ),
                              Text(
                                "Burada Yalnızsınız",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                        height: MediaQuery.of(context).size.height - 150,
                      ),
                    ),
                  ),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  Future<Null> _kullanicilarListesiniYenile() async {
    setState(() {});
    await Future.delayed(Duration(seconds: 1));
    return null;
  }
}
