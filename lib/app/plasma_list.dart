import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok/app/malzeme_detay.dart';
import 'package:stok/app/stok_ekle.dart';
import 'package:stok/common_widget/platform_duyarli_alert_dialog.dart';
import 'package:stok/model/malzeme_model.dart';
import 'package:stok/viewmodel/app_user_view_model.dart';

class PlasmaList extends StatefulWidget {
  @override
  _PlasmaListState createState() => _PlasmaListState();
}

class _PlasmaListState extends State<PlasmaList> {
  @override
  Widget build(BuildContext context) {
    final _appUserModel = Provider.of<AppUserViewModel>(context, listen: false);

    String yeri = "plasma";
    return Scaffold(
        appBar: AppBar(
          title: Text("plasma"),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: FloatingActionButton(
            heroTag: 2,
            child: Icon(
              Icons.add,
              size: 46,
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (context) => StokEkle(),
                ),
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List<Malzeme>>(
              future: _appUserModel.getAllMalzeme(yeri),
              builder: (context, malzemeListesi) {

                var tumMalzemeler = malzemeListesi.data;
                print("......................................................................../n" +
                    malzemeListesi.data.toString() +
                    "...............................................................................");

                if (!malzemeListesi.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (tumMalzemeler.length > 0) {
                    return ListView.builder(
                        itemCount: tumMalzemeler.length,
                        itemBuilder: (context, index) {
                          var oAnKiMalzeme = tumMalzemeler[index];


                          return SingleChildScrollView(
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) => MalzemeDetay(
                                        currentMalzeme: oAnKiMalzeme,
                                      ),
                                    ),
                                  );
                                },
                                child: _listeElemaniOlustur(oAnKiMalzeme)),
                          );
                        });
                  } else {
                    return Center(
                      child: Text("Kayıtlı Malzeme Yok "),
                    );
                  }
                }
              }),
        ));
  }

  _listeElemaniOlustur(Malzeme oAnKiMalzeme) {

    String dismissKey = oAnKiMalzeme.malzemeid;
    return Dismissible(
      key: Key(dismissKey),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _listeElemaniSil(oAnKiMalzeme);

      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: _containerRengi(oAnKiMalzeme.type),
                      //border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(8)),
                  // color: _containerRengi(oAnKiMalzeme.type),
                  child: Column(
                    children: [
                      Container(

                        width: 60,
                        height: 20,
                        child: Center(
                            child: Text(
                              oAnKiMalzeme.kalinlik + " mm",
                              style: TextStyle(
                                fontSize: 14,
                                //fontWeight: FontWeight.bold,
                                color: _yaziRengi(oAnKiMalzeme.type),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(

                        width: 60,
                        height: 20,
                        child: Center(
                            child: Text(
                              oAnKiMalzeme.type,
                              style: TextStyle(
                                fontSize: 14,
                                //fontWeight: FontWeight.bold,
                                color: _yaziRengi(oAnKiMalzeme.type),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Text(
                        oAnKiMalzeme.en + "  X  " + oAnKiMalzeme.boy,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Center(
                      child: Text(
                        oAnKiMalzeme.adet + " adet",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )),
                )
              ],
            ),
          ),
          Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
          )
        ],
      ),
    );
  }

  _containerRengi(String type) {
    Color _containerRengi;

    if (type == "hrp") {
      _containerRengi = Colors.lightBlue;
    }
    if (type == "dkp") {
      _containerRengi = Colors.amberAccent.shade100;
    }
    if (type == "siyah") {
      _containerRengi = Colors.black87;
    }

    return _containerRengi;
  }

  _yaziRengi(String type) {
    Color _yaziRengi;
    if (type == "hrp") {
      _yaziRengi = Colors.black;
    }
    if (type == "dkp") {
      _yaziRengi = Colors.black;
    }
    if (type == "siyah") {
      _yaziRengi = Colors.white;
    }

    return _yaziRengi;
  }

  _listeElemaniSil(Malzeme oAnKiMalzeme) async {
    final _appUserModel = Provider.of<AppUserViewModel>(context, listen: false);
    final sonuc=await PlatformDuyarliAlertDialog(
      baslik:"Malzeme Silinecek" ,
      icerik: "Silmek istediğinizden Emin misiniz?",
      anaButonYazisi: "Sil",
      iptalButonYazisi: "Vazgeç",
    ).goster(context);
    if(sonuc){
      await _appUserModel.deleteMalzeme(oAnKiMalzeme);
      Future.delayed(Duration(seconds: 1));
      setState(() {
      });
    }

  }

/*_malzemeListesiYenile() {
    setState(() {});
  }*/
}
