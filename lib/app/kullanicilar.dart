import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:stok/app/konusma_page.dart';
import 'package:stok/model/user.dart';
import 'package:stok/viewmodel/app_user_view_model.dart';

class KullanicilarPage extends StatefulWidget {
  @override
  _KullanicilarPageState createState() => _KullanicilarPageState();
}

class _KullanicilarPageState extends State<KullanicilarPage> {
  List<AppUser> _tumKullanicilar;
  bool _isLoading = false;
  bool _hasMore = true;
  int _getirilecekElemanSayisi = 10;
  AppUser _enSonGetirilenUser;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      getUser();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position == 0) {
        } else {
          getUser();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcılar"),

      ),
      body: _tumKullanicilar == null ? Center(
        child: CircularProgressIndicator(),) : _kullaniciListesiOlustur(),
    );
  }

  getUser() async {
    final _appUserModel = Provider.of<AppUserViewModel>(context, listen: false);

    if (!_hasMore) {
      return;
    }
    if (_isLoading) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    List<AppUser> _appusers = await _appUserModel.getUsersWithPagination(
        _enSonGetirilenUser, _getirilecekElemanSayisi);
    if (_enSonGetirilenUser== null) {
      _tumKullanicilar = [];
      _tumKullanicilar.addAll(_appusers);
    } else {
      _tumKullanicilar.addAll(_appusers);
    }

    if (_appusers.length < _getirilecekElemanSayisi) {
      _hasMore = false;
    }

    _enSonGetirilenUser = _tumKullanicilar.last;

    setState(() {

    });
    _isLoading = false;
  }

  _kullaniciListesiOlustur() {
    if(_tumKullanicilar.length>1){
      return RefreshIndicator(
        onRefresh:_kullanicilarListesiniYenile,
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder: (context, index) {
            if (index == _tumKullanicilar.length) {
              return _yeniElemanlarYukleniyorIndicater();
            }

            return _appUserListeElemaniOlustur(index);
          },
          itemCount: _tumKullanicilar.length + 1,
        ),
      );



    }else{

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

  }

  Widget _appUserListeElemaniOlustur(int index) {
    final _appUserModel = Provider.of<AppUserViewModel>(context, listen: false);

    var _oankiUser = _tumKullanicilar[index];
    if(_oankiUser.appUserID==_appUserModel.user.appUserID){
      return Container();
    }
    return GestureDetector(
      onTap: (){
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (context) => KonusmaPage(
              currentUser: _appUserModel.user,
              sohbetEdilenUser: _oankiUser,
            ),
          ),
        );
      },
      child: Column(
        children: [
          ListTile(title: Text(_oankiUser.userName),
            subtitle: Text(_oankiUser.email),
            leading: CircleAvatar(
              radius: 40,
              backgroundColor: Theme.of(context).primaryColor,
              backgroundImage:
              NetworkImage(_oankiUser.profilURL),
            ),),
          Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
          )
        ],
      ),
    );
  }

  _yeniElemanlarYukleniyorIndicater() {
    return Padding(padding: EdgeInsets.all(8),
      child: Center(child: Opacity(
        opacity: _isLoading ? 1 : 0,
        child: _isLoading ? CircularProgressIndicator() : null,),),);
  }

  Future<Null> _kullanicilarListesiniYenile() async {
    _hasMore = true;
    _enSonGetirilenUser = null;
    getUser();
  }
  }

