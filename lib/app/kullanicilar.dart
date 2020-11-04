import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok/app/konusma_page.dart';
import 'package:stok/viewmodel/all_app_users_view_model.dart';
import 'package:stok/viewmodel/app_user_view_model.dart';

class KullanicilarPage extends StatefulWidget {
  @override
  _KullanicilarPageState createState() => _KullanicilarPageState();
}

class _KullanicilarPageState extends State<KullanicilarPage> {

  bool _isLoading = false;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_listeScrollListener);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcılar"),

      ),
      body: Consumer<AllAppUsersViewModel>(builder:(context,model,child){
        if(model.state==AllAppUsersViewState.Busy){
          return Center(child: CircularProgressIndicator(),);
        }else if(model.state==AllAppUsersViewState.Loaded){
          return  RefreshIndicator(
            onRefresh: model.refresh,
            child: ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) {
                if(model.kullanicilarListesi.length==1){
                  return _kullaniciYok();
                }else

                if(model.hasMoreLoading && index==model.kullanicilarListesi.length){
                  return _yeniElemanlarYukleniyorIndicater();
                }else{
                  return _appUserListeElemaniOlustur(index);
                }



              },
              itemCount:model.hasMoreLoading ? model.kullanicilarListesi.length+1:model.kullanicilarListesi.length,
            ),
          );
        }else{return Container();

        }
      } ,)
    );
  }

  Widget _kullaniciYok(){
    final _allAppUsersViewModel = Provider.of<AllAppUsersViewModel>(context, listen: false);

    return Center(
      child: RefreshIndicator(
        onRefresh: _allAppUsersViewModel.refresh,
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

  Widget _appUserListeElemaniOlustur(int index) {
    final _appUserModel = Provider.of<AppUserViewModel>(context, listen: false);
    final _allAppUsersViewModel = Provider.of<AllAppUsersViewModel>(context, listen: false);

    var _oankiUser = _allAppUsersViewModel.kullanicilarListesi[index];
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
      child: Center(child:CircularProgressIndicator()));
  }


  Future<void> dahaFazlaKullaniciGetir() async {
    if(_isLoading==false){
      _isLoading=true;
      final _allAppUsersViewModel = Provider.of<AllAppUsersViewModel>(context, listen: false);
    await _allAppUsersViewModel.dahaFazlaKullaniciGetir();
    _isLoading=false;
    }


  }

  void _listeScrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange){
      dahaFazlaKullaniciGetir();
    }


  }
}

