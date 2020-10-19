import 'package:get_it/get_it.dart';
import 'package:stok/repository/app_user_repository.dart';
import 'package:stok/services/fake_auth_services.dart';
import 'package:stok/services/firebase_auth_service.dart';
import 'package:stok/services/firestore_db_service.dart';
GetIt locator = GetIt.asNewInstance();
void setupLocator(){
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FakeAuthServices());
  locator.registerLazySingleton(() => FirestoreDBService());
  locator.registerLazySingleton(() => AppUserRepository());
}