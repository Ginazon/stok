import 'package:stok/model/konusma.dart';
import 'package:stok/model/mesaj.dart';
import 'package:stok/model/user.dart';

abstract class DBBase{
  Future<bool> saveUser(AppUser user);
  Future<AppUser> readUser(String appUserID);
  Future<bool> updateUserName(String appUserID,String yeniAppUserName);
  Future<bool>updateProfilFoto(String appUserID, String profilFotoUrl);
  Future<List<AppUser>>getUsersWithPagination(AppUser enSonGetirilenUser, int getirilecekElemanSayisi);
  Future<List<Konusma>>getAllConversations(String appUserID);
  Stream <List<Mesaj>>getMessages(String currentUserID,String sohbetEdilenUserID);
  Future<bool> saveMessage(Mesaj kaydedilecekMesaj);
  Future <DateTime>saatiGoster(String appUserID);
}