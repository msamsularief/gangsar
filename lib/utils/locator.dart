import 'package:get_it/get_it.dart';
import 'package:klinik/utils/nav_service.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
}
