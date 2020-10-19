import 'package:stok/model/app_user_model.dart';

abstract class DBBase{
  Future<bool> saveUser(AppUser user);
}