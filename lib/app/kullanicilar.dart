import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<AppUser> _tumKullanicilar = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _getirilecekElemanSayisi = 10;
  AppUser _enSonGetirilenUser;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser(_enSonGetirilenUser);
    _scrollController.addListener(() {

      if(_scrollController.position.atEdge){
        if(_scrollController.position==0){

        }else{
          getUser(_enSonGetirilenUser);
        }
      }

    });


  }

  @override
  Widget build(BuildContext context) {
    final _appUserModel = Provider.of<AppUserViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcılar"),
        actions: [
          FlatButton(
              onPressed: () async {
                await getUser(_enSonGetirilenUser);
              },
              child: Text("Next Users"))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: _tumKullanicilar.length > 0
                  ? _kullaniciListesiOlustur()
                  : Center(
                      child: Text("Kullanıcı Yok"),
                    )),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(),
        ],
      ),
    );
  }

  getUser(AppUser enSonGetirilenUser) async {
    if(!_hasMore){
      print("Kullanıcı Yok");
      return;

    }
    if(_isLoading){
      print("isloading true");
      return;
    }
    setState(() {
      _isLoading = true;
    });
    QuerySnapshot _querySnapshot;
    if (enSonGetirilenUser == null) {
      print("İlk defa kullanıcılar getiriliyor");
      _querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .orderBy("userName")
          .limit(_getirilecekElemanSayisi)
          .get();
    } else {
      print("Sonraki kullanıcılar getiriliyor");
      _querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .orderBy("userName")
          .startAfter([enSonGetirilenUser.userName])
          .limit(_getirilecekElemanSayisi)
          .get();


    }
    if(_querySnapshot.docs.length < _getirilecekElemanSayisi){
      _hasMore=false;
    }
    for (DocumentSnapshot snapshot in _querySnapshot.docs) {
      AppUser _tekUser = AppUser.fromMap(snapshot.data());
      _tumKullanicilar.add(_tekUser);
      print("Getirilen user name:" + _tekUser.userName);
    }
    _enSonGetirilenUser = _tumKullanicilar.last;
    print("en son getirilen user name:" + _enSonGetirilenUser.userName);
    setState(() {

    });
    _isLoading = false;
  }

  _kullaniciListesiOlustur() {
    return ListView.builder(
      controller: _scrollController,
      itemBuilder: (context, index) {
        return ListTile(title: Text(_tumKullanicilar[index].userName),);
      },
      itemCount:  _tumKullanicilar.length,
    );
  }
}
