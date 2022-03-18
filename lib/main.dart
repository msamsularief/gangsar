import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:klinik/api/auth.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/helper/color_helper.dart';
import 'package:klinik/models/app_info.dart';
import 'package:klinik/ui/screen/splash/splash.dart';
import 'package:klinik/utils/locator.dart';
import 'package:klinik/utils/nav_service.dart';
import 'package:klinik/utils/router_generator.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'bloc/klinik/klinik.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KlinikSystemChrome.preferredOrientations;
  KlinikSystemChrome.uiOverlayStyle;
  await initializeDateFormatting('id_ID', null).then((_) => true);
  dotenv.load(fileName: ".env"); //LOAD ENV FILE
  firebaseApp = await Firebase.initializeApp();

  appInfo = await PackageInfo.fromPlatform().then(
    (value) => AppInfo(
      version: value.version,
    ),
  );

  await Future.delayed(const Duration(milliseconds: 0), () {
    DefaultCacheManager().emptyCache();
  });

  setupLocator();

  runApp(BlocProvider<KlinikBloc>(
    create: (context) => KlinikBloc()..add(StartupEvent()),
    child: KlinikApp(),
  ));
}

///Root of Klinik App
class KlinikApp extends StatelessWidget {
  const KlinikApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final klinikBloc = BlocProvider.of<KlinikBloc>(context);
    return MaterialApp(
      title: 'Gangsar O',
      theme: KlinikTheme.theme,
      home: BlocListener<KlinikBloc, KlinikState>(
        listener: (context, state) {
          print('main state : $state');
          if (state is AuthenticationAuthenticated) {
            navigateAndReplace(AppRoute.home);
          }
          if (state is AuthenticationUnauthenticated) {
            navigateAndReplace(AppRoute.selectRole);
          }
        },
        child: Splash(),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      onGenerateRoute: (settings) => RouterGenerator.generateRoute(
        settings,
        klinikBloc,
      ),
    );
  }
}

extension KlinikSystemChrome on SystemChrome {
  static get preferredOrientations => SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
      );
  static get uiOverlayStyle => SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemStatusBarContrastEnforced: true,
        ),
      );
}

class KlinikTheme {
  static get theme {
    final originalTextTheme = ThemeData.light().textTheme;
    final originalBody1 = originalTextTheme.bodyText1!.copyWith(
      decorationColor: Colors.transparent,
      fontSize: 16,
      letterSpacing: 0.4,
      wordSpacing: 0.0,
      color: ColorHelper.fromHex("#240B1D"),
    );

    return ThemeData.light().copyWith(
      platform: TargetPlatform.android,
      primaryColor: ColorHelper.fromHex("#D6009A"),
      primaryColorLight: ColorHelper.fromHex("#FF9CEE"),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(
              color: ColorHelper.fromHex("#D6009A"),
              backgroundColor: Colors.transparent,
              fontSize: 18.0,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ),
      dividerColor: Colors.grey[350],
      backgroundColor: Colors.white,
      toggleableActiveColor: Colors.cyan[300],
      textTheme: originalTextTheme.copyWith(
        bodyText1: originalBody1,
        bodyText2: originalBody1,
      ),
      colorScheme: ColorScheme.fromSwatch(
        backgroundColor: Colors.white,
      ).copyWith(secondary: ColorHelper.fromHex("#D6009A")),
    );
  }
}
