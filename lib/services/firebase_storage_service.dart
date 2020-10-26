import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:stok/services/stoge_base.dart';

class FirebaseStorageService implements StorageBase{
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  StorageReference _storageReference ;
  @override
  Future<String> uploadFile(String appUserID, String fileType, File yuklenecekDosya) async {

 _storageReference=_firebaseStorage.ref().child(appUserID).child(fileType).child("profil_foto.png");
 var uploadTask=_storageReference.putFile(yuklenecekDosya);
 var url =await(await uploadTask.onComplete).ref.getDownloadURL();
 return url;

  }
}