import 'package:flutter/material.dart';
import 'package:stok/locator.dart';
import 'package:stok/model/user.dart';
import 'package:stok/repository/app_user_repository.dart';

enum AllAppUsersViewState { Idle, Loaded, Busy }

class AllAppUsersViewModel with ChangeNotifier {
  AllAppUsersViewState _state = AllAppUsersViewState.Idle;

  List<AppUser> _tumKullanicilar;
  AppUser _enSonGetirilenUser;
  static final sayfaBasinaGonderiSayisi = 10;
  bool _hasMore = true;
  bool get hasMoreLoading => _hasMore;
  AppUserRepository _appUserRepository = locator<AppUserRepository>();

  List<AppUser> get kullanicilarListesi => _tumKullanicilar;

  AllAppUsersViewState get state => _state;

  set state(AllAppUsersViewState value) {
    _state = value;
    notifyListeners();
  }

  AllAppUsersViewModel() {
    _tumKullanicilar = [];
    _enSonGetirilenUser = null;
    getUserWithPagination(_enSonGetirilenUser, false);
  }

  getUserWithPagination(
      AppUser enSonGetirilenUser, bool yeniElemanlarGetiriliyor) async {
    if (_tumKullanicilar.length > 0) {
      _enSonGetirilenUser = _tumKullanicilar.last;
      print("en son getirilen username:" + _enSonGetirilenUser.userName);
    }
    if (yeniElemanlarGetiriliyor) {
    } else {
      state = AllAppUsersViewState.Busy;
    }

    var yeniListe = await _appUserRepository.getUsersWithPagination(
        _enSonGetirilenUser, sayfaBasinaGonderiSayisi);
    if (yeniListe.length < sayfaBasinaGonderiSayisi) {
      _hasMore = false;
    }
    yeniListe.forEach((usr) => print("Getirilen username:" + usr.userName));

    _tumKullanicilar.addAll(yeniListe);
    state = AllAppUsersViewState.Loaded;
  }

  Future<void> dahaFazlaKullaniciGetir() async {
    print("Daha fazla user getir tetiklendi - viewmodeldeyiz -");
    if (_hasMore)
      getUserWithPagination(_enSonGetirilenUser, true);
    else
      print("Daha fazla eleman yok o yüzden çagrılmayacak");
    await Future.delayed(Duration(seconds: 2));
  }
}
