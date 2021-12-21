// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klinik/bloc/tab/tab_bloc.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/ui/home.dart';
import 'package:klinik/ui/screen/bumil/home_menu_item_page.dart';
import 'package:klinik/ui/screen/forgot_password/forgot_password.dart';
import 'package:klinik/ui/screen/forgot_password/verify_forgot_password.dart';
import 'package:klinik/ui/screen/login/login_page.dart';
import 'package:klinik/ui/screen/register/register_page.dart';
import 'package:klinik/ui/widget/video_player/video_list_widget.dart';
import 'package:klinik/ui/widget/video_player/video_player.dart';

class RouterGenerator {
  static Route<dynamic>? generateRoute(
    RouteSettings settings,
  ) {
    print('route to ${settings.name} page');
    switch (settings.name) {
      case AppRoute.home:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => TabBloc(),
            child: const Home(),
          ),
        );
      case AppRoute.login:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case AppRoute.register:
        return MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        );
      case AppRoute.forgotPassword:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordPage(),
        );
      case AppRoute.verifyForgotPassword:
        return MaterialPageRoute(
          builder: (context) => const VerifyForgotPasswordPage(),
        );
      case AppRoute.homeMenuItemPage:
        String title = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => HomeMenuItemPage(
            title: title,
          ),
        );
      case "/video_player":
        String videoId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => VideoPlayer(
            videoId: videoId,
          ),
        );

      default:
        return _errorRoute();
    }
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
        automaticallyImplyLeading: true,
      ),
      body: const Center(
        child: Text('ERROR'),
      ),
    );
  });
}
