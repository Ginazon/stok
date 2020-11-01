import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok/app/konusma_page.dart';
import 'package:stok/model/konusma.dart';
import 'package:stok/model/user.dart';
import 'package:stok/viewmodel/app_user_view_model.dart';

class KonusmalarimPage extends StatefulWidget {
  @override
  _KonusmalarimPageState createState() => _KonusmalarimPageState();
}

class _KonusmalarimPageState extends State<KonusmalarimPage> {
  @override
  Widget build(BuildContext context) {
    final _appUserModel = Provider.of<AppUserViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Konuşmalarım"),
      ),
      body: FutureBuilder<List<Konusma>>(
          future:
              _appUserModel.getAllConversations(_appUserModel.user.appUserID),
          builder: (context, konusmaListesi) {
            if (!konusmaListesi.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              var tumKonusmalar = konusmaListesi.data;
              print("......................................................................../n" +
                  konusmaListesi.data.toString() +
                  "...............................................................................");

              return RefreshIndicator(
                onRefresh: _konusmalarimListesiniYenile,
                child: ListView.builder(
                    itemCount: tumKonusmalar.length,
                    itemBuilder: (context, index) {
                      var oAnKiKonusma = tumKonusmalar[index];
                      if (tumKonusmalar.length > 0) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                    builder: (context) => KonusmaPage(
                                      currentUser: _appUserModel.user,
                                      sohbetEdilenUser: AppUser.idveResim(
                                          appUserID:
                                              oAnKiKonusma.kimleKonusuyor,
                                          profilURL: oAnKiKonusma
                                              .konusulanUserProfilURL),
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                trailing: Text(oAnKiKonusma.aradakiFark
                                  //_saatDakikaGoster(oAnKiKonusma.olusturulmaTarihi),
                                     ),
                                title: Text(oAnKiKonusma.konusulanUserName),
                                subtitle: Text(oAnKiKonusma.sonYollananMesaj),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      oAnKiKonusma.konusulanUserProfilURL),
                                  radius: 40,
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
                        return Center(
                          child: RefreshIndicator(
                            onRefresh: _konusmalarimListesiniYenile,
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Container(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.chat,
                                        color: Theme.of(context).primaryColor,
                                        size: 80,
                                      ),
                                      Text(
                                        "Henüz Kimseyle Komuşmadın",
                                        style: TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                                height:
                                    MediaQuery.of(context).size.height - 150,
                              ),
                            ),
                          ),
                        );
                      }
                    }),
              );
            }
          }),
    );
  }



  Future<Null> _konusmalarimListesiniYenile() async {
    setState(() {});
    await Future.delayed(Duration(seconds: 1));
    return null;
  }
}
