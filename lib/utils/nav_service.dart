import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigationKey => navigatorKey;

  ///Untuk me-*navigasi* ke halaman selanjutnya dengan menggunakan ***AppRoutes.[routeName]***.
  ///
  ///Apabila Class yang dituju membutuhkan [arguments], cara menggunakannya sama saja,
  ///yaitu dengan menambahkan *argument*-nya.
  ///
  ///Contoh menggunakan [arguments] :
  ///**```locator<NavigationService>.navigateTo(routeName, arguments: [argument]);```**
  ///
  Future<dynamic> navigateTo(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  ///**[navigateAndRemoveUntil]** digunakan hanya ketika [currentState] tidak ingin dibuka kembali,
  ///misal: *dari State Login menuju ke Home*.
  ///
  Future<dynamic> navigateAndRemoveUntil(String routeName,
      {Object? arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  ///**[moveTo]** digunakan ketika [currentState] ingin mengganti State yang lama
  ///dengan State ysng baru.
  ///misal: *ketika *State Logout*.
  ///
  Future<dynamic> moveTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  ///Untuk me-**navigasi** ke halaman sebelumnya.
  ///Penggunaannya sama dengan *Navigator.pop(context)*
  void goBack<T extends Object?>([T? result]) {
    return navigatorKey.currentState!.pop(result);
  }
}
