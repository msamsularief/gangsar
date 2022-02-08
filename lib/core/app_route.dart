import 'package:klinik/utils/locator.dart';
import 'package:klinik/utils/nav_service.dart';

class AppRoute {
  static const home = "/home";
  static const login = "/login";
  static const register = "/register";
  static const profile = "/profile";
  static const detailProfile = "/detail_profile";
  static const logout = "/logout";
  static const forgotPassword = "/forgot_password";
  static const verifyForgotPassword = "/verify_forgot_password";
  static const homeMenuItemPage = "/home_menu_item_page";
  static const videos = "/videos";
  static const articles = "/articles";
  static const history = "/history";
  static const bodyMassIndex = "/bodyMassIndex";
}

///
///Routing ke halaman yang di tuju.
navigateTo(String routeName, {Object? arguments}) =>
    locator<NavigationService>().navigateTo(
      routeName,
      arguments: arguments,
    );

///Menghapus halaman sebelumnya
///digantikan halaman yang di tuju.
navigateAndRemoveUntil(String routeName) =>
    locator<NavigationService>().navigateAndRemoveUntil(
      routeName,
    );

///Mengganti halam sebelumnya
///dengan halaman yang di tuju (me-replace).
navigateAndReplace(String routeName) => locator<NavigationService>().moveTo(
      routeName,
    );

///Routing ke halaman sebelumnya.
goBack() => locator<NavigationService>().goBack();
