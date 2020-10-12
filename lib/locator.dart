import 'package:get_it/get_it.dart';
import 'package:stok/services/fake_auth_services.dart';
import 'package:stok/services/firebase_auth_service.dart';
GetIt locator = GetIt.asNewInstance();
void setupLocator(){
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FakeAuthServices());
}