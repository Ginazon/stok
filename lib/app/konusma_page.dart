
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stok/model/mesaj.dart';
import 'package:stok/model/user.dart';
import 'package:stok/viewmodel/app_user_view_model.dart';

class KonusmaPage extends StatefulWidget {
  final AppUser currentUser;
  final AppUser sohbetEdilenUser;

  KonusmaPage({this.currentUser, this.sohbetEdilenUser});

  @override
  _KonusmaPageState createState() => _KonusmaPageState();
}

class _KonusmaPageState extends State<KonusmaPage> {
  var _mesajController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    AppUser _currentUser = widget.currentUser;
    AppUser _sohbetEdilenUser = widget.sohbetEdilenUser;
    final _appUserModel = Provider.of<AppUserViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Konusma"),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Mesaj>>(
                stream: _appUserModel.getMessages(
                    _currentUser.appUserID, _sohbetEdilenUser.appUserID),
                builder: (context, streamMesajlarListesi) {
                  if (!streamMesajlarListesi.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<Mesaj> tumMesajlar = streamMesajlarListesi.data;
                  return ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return _konusmaBalonuOlustur(tumMesajlar[index]);
                    },
                    itemCount: tumMesajlar.length,
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 8, left: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _mesajController,
                      cursorColor: Colors.blueGrey,
                      style: new TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Mesajınızı Yazın",
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.navigation,
                        size: 35,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        if (_mesajController.text.trim().length > 0) {
                          Mesaj _kaydedilecekMesaj = Mesaj(
                              kimden: _currentUser.appUserID,
                              kime: _sohbetEdilenUser.appUserID,
                              bendenMi: true,
                              mesaj: _mesajController.text);
                          var sonuc = await _appUserModel
                              .saveMessage(_kaydedilecekMesaj);
                          if (sonuc) {
                            _mesajController.clear();
                            _scrollController.animateTo(
                              0,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 10),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _konusmaBalonuOlustur(Mesaj oAnkiMesaj) {
    Color _gelenMesajRenk = Colors.blue;
    Color _gidenMesajRenk = Theme.of(context).primaryColor;
   var _saatDakikaDegeri= _saatDakikaGoster(oAnkiMesaj.date ?? Timestamp(1,1));


    var _benimMesajimMi = oAnkiMesaj.bendenMi;
    if (_benimMesajimMi) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 90,),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: _gidenMesajRenk,
                    ),
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(4),
                    child: Text(
                      oAnkiMesaj.mesaj,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Text(_saatDakikaDegeri),

              ],
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(widget.sohbetEdilenUser.profilURL),
                ),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: _gelenMesajRenk,
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(4),
                    child: Text(
                      oAnkiMesaj.mesaj,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Text(_saatDakikaDegeri),
                SizedBox(width: 90,)
              ],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      );
    }
  }

  String _saatDakikaGoster(Timestamp date) {
    var _formater=DateFormat.Hm();
    var _formatlanmisTarih=_formater.format(date.toDate());
    return _formatlanmisTarih ;
  }
}
