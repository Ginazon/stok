
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stok/locator.dart';
import 'package:stok/model/konusma.dart';
import 'package:stok/model/mesaj.dart';
import 'package:stok/model/user.dart';
import 'package:stok/repository/app_user_repository.dart';
import 'package:stok/services/auth_base.dart';
enum ViewState {Idle,Busy}

class AppUserViewModel with ChangeNotifier implements AuthBase{
  ViewState _state = ViewState.Idle;
  AppUserRepository _appUserRepository = locator<AppUserRepository>();
  AppUser _user;
  String emailHataMesaji, sifreHataMesaji;

  AppUser get user => _user;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  AppUserViewModel() {
    currentUser();
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
      bool sonuc=await _appUserRepository.signOut();
      _user=null;
      return sonuc;
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
    } catch (e) {
      print(
          "AppUserViewModel/signInAnonymously Metodu..........................HATASI" +
              e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    try {
      state = ViewState.Busy;
      _user = await _appUserRepository.signInWithGoogle();
      return _user;
    } catch (e) {
      print(
          "AppUserViewModel/signInWithGoogle Metodu..........................HATASI" +
              e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<AppUser> createUserWithEmailandPassword(String email,
      String sifre) async {
    try {
      if (_emailSifreKontrol(email, sifre)) {
        state = ViewState.Busy;
        _user =
        await _appUserRepository.createUserWithEmailandPassword(email, sifre);
        return _user;
      } else
        return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<AppUser> signInWithEmailandPassword(String email, String sifre) async {
    try {
      if (_emailSifreKontrol(email, sifre)) {
        state = ViewState.Busy;
        _user =
        await _appUserRepository.signInWithEmailandPassword(email, sifre);
        return _user;
      } else
        return null;
    }finally {
      state = ViewState.Idle;
    }
  }

  bool _emailSifreKontrol(String email, String sifre) {
    var sonuc = true;
    if (sifre.length < 6) {
      sifreHataMesaji = "Şifre en az 6 karakterden oluşmalı";
      sonuc = false;
    } else
      sifreHataMesaji = null;
    if (!email.contains('@')) {
      emailHataMesaji = "Doğru bir email adresi yazınız";
      sonuc = false;
    } else
      emailHataMesaji = null;
    return sonuc;
  }

  Future<bool> updateUserName(String appUserID , String yeniAppUserName) async {


    var sonuc=await _appUserRepository.updateUserName(appUserID,yeniAppUserName);
    if(sonuc){
      _user.userName=yeniAppUserName;
    }


    return sonuc;


  }

  Future<String>uploadFile(String appUserID, String fileType, File profilFoto) async {
    var indirmeLinki=await _appUserRepository.uploadFile(appUserID,fileType,profilFoto);
    return indirmeLinki;


  }

  Stream <List<Mesaj>>getMessages(String currentUserID, String sohbetEdilenUserID) {

    return _appUserRepository.getMessages(currentUserID,sohbetEdilenUserID);

  }

  Future<bool> saveMessage(Mesaj kaydedilecekMesaj) async {
    return await _appUserRepository.saveMessage(kaydedilecekMesaj);
  }

  Future<List<Konusma>> getAllConversations(String appUserID) async {
    return await _appUserRepository.getAllConversations(appUserID);
  }

  Future<List<AppUser>> getUsersWithPagination(AppUser enSonGetirilenUser,
      int getirilecekElemanSayisi) async {
    return await _appUserRepository.getUsersWithPagination(
        enSonGetirilenUser, getirilecekElemanSayisi);
  }

}