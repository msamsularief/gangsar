import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klinik/bloc/klinik/klinik_bloc.dart';
import 'package:klinik/bloc/login/login_bloc.dart';
import 'package:klinik/bloc/register/register.dart';
import 'package:klinik/bloc/tab/tab_bloc.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/model/article.dart';
import 'package:klinik/model/image_component.dart';
import 'package:klinik/model/video.dart';
import 'package:klinik/ui/home.dart';
import 'package:klinik/ui/screen/article/article_detail_page.dart';
import 'package:klinik/ui/screen/article/article_page.dart';
import 'package:klinik/ui/screen/bmi/bmi_history_page.dart';
import 'package:klinik/ui/screen/bmi/bmi_page.dart';
import 'package:klinik/ui/screen/history/history_page.dart';
import 'package:klinik/ui/screen/home/home_menu_item_page.dart';
import 'package:klinik/ui/screen/forgot_password/forgot_password.dart';
import 'package:klinik/ui/screen/forgot_password/verify_forgot_password.dart';
import 'package:klinik/ui/screen/login/login_page.dart';
import 'package:klinik/ui/screen/profile/detail_profile_page.dart';
import 'package:klinik/ui/screen/profile/profile_page.dart';
import 'package:klinik/ui/screen/register/register_page.dart';
import 'package:klinik/ui/screen/video/video_page.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';
import 'package:klinik/ui/widget/video_player/video_player.dart';
import 'package:klinik/ui/widget/video_player/video_player_second.dart';
import 'package:klinik/utils/route_arguments.dart';

class RouterGenerator {
  static Route<dynamic>? generateRoute(
    RouteSettings settings,
    KlinikBloc klinikBloc,
  ) {
    print('route to ${settings.name} page');
    switch (settings.name) {
      case AppRoute.home:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => TabBloc(),
            child: Home(klinikBloc: klinikBloc),
          ),
        );
      case AppRoute.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginBloc(klinikBloc: klinikBloc),
            child: const LoginPage(),
          ),
        );
      case AppRoute.register:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(),
            child: const RegisterPage(),
          ),
        );
      case AppRoute.forgotPassword:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordPage(),
        );
      case AppRoute.verifyForgotPassword:
        return MaterialPageRoute(
          builder: (context) => const VerifyForgotPasswordPage(),
        );
      case AppRoute.profile:
        return MaterialPageRoute(
          builder: (context) => ProfilePage(klinikBloc: klinikBloc),
        );
      case AppRoute.detailProfile:
        return MaterialPageRoute(
          builder: (context) => const DetailProfilePage(),
        );
      case AppRoute.homeMenuItemPage:
        String title = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => HomeMenuItemPage(
            title: title,
          ),
        );
      case AppRoute.videos:
        return MaterialPageRoute(
          builder: (context) => const VideoPage(),
        );
      case AppRoute.history:
        return MaterialPageRoute(
          builder: (context) => const HistoryPage(),
        );
      case AppRoute.bodyMassIndex:
        return MaterialPageRoute(
          builder: (context) => const BmiPage(),
        );
      case AppRoute.articles:
        RouteArgument argument = settings.arguments as RouteArgument;
        print("""${argument.imageInitial}\n
        ${argument.imageUrls}
        """);
        return MaterialPageRoute(
          builder: (context) => ArticlePage(
            imageUrls: argument.imageUrls!,
            imageInitial: argument.imageInitial!,
          ),
        );
      case "/video_player":
        List data = settings.arguments as List;
        String videoId = data.first;
        Video videoData = data.last;

        return MaterialPageRoute(
          builder: (context) => VideoPlayer(
            videoId: videoId,
            videoData: videoData,
          ),
        );
      case "/bmi_history":
        return MaterialPageRoute(
          builder: (context) => BmiHistoryPage(),
        );
      case "/view_article":
        Article article = settings.arguments as Article;
        print(article);
        return MaterialPageRoute(
          builder: (context) => ArticleDetailPage(
            article: article,
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
      appBar: KlinikAppBar(
        title: "Error",
        automaticallyImplyLeading: true,
      ),
      body: const Center(
        child: Text('ERROR'),
      ),
    );
  });
}

Widget _testingRoutePage() {
  return Scaffold(
    appBar: KlinikAppBar(
      title: "Error",
      automaticallyImplyLeading: true,
    ),
    body: const Center(
      child: Text('ERROR'),
    ),
  );
}
