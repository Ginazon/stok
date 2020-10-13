
import 'package:flutter/material.dart';
import 'package:stok/locator.dart';
import 'package:stok/model/app_user_model.dart';
import 'package:stok/repository/app_user_repository.dart';
import 'package:stok/services/auth_base.dart';
enum ViewState {Idle,Busy}

class AppUserViewModel with ChangeNotifier implements AuthBase{
  ViewState _state =ViewState.Idle;
  AppUserRepository _appUserRepository=locator<AppUserRepository>();
  AppUser _user;

  ViewState get state => _state;
  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  @override
  Future<AppUser> currentUser() async {
   try{
     state=ViewState.Busy;
    _user=await _appUserRepository.currentUser();
    return _user;

   }catch(e){
     print("AppUserViewModel/currentUser Metodu..........................HATASI"+e.toString());
     return null;

   }finally{
     state=ViewState.Idle;
   }

  }
  @override
  Future<bool> signOut() async{
    try{
      state=ViewState.Busy;
      return await _appUserRepository.signOut();
    }catch(e){
      print("AppUserViewModel/signOut Metodu..........................HATASI"+e.toString());
      return false;

    }finally{
      state=ViewState.Idle;
    }
  }

  @override
  Future<AppUser> signInAnonymously() async{
    try{
      state=ViewState.Busy;
     _user= await _appUserRepository.signInAnonymously();
      return _user;

    }catch(e){
      print("AppUserViewModel/signInAnonymously Metodu..........................HATASI"+e.toString());
      return null;

    }finally{
      state=ViewState.Idle;
    }
  }



}