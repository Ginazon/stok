import 'dart:io';

abstract class StorageBase{
  Future<String> uploadFile(String appUserID,String fileType,File yuklenecekDosya);




}