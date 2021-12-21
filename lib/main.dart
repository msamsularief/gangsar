import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:klinik/helper/color_helper.dart';
import 'package:klinik/ui/screen/login/login_page.dart';
import 'package:klinik/utils/locator.dart';
import 'package:klinik/utils/nav_service.dart';
import 'package:klinik/utils/router_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KlinikSystemChrome.preferredOrientations;
  KlinikSystemChrome.uiOverlayStyle;
  await initializeDateFormatting('id_ID', null).then((_) => true);

  await Future.delayed(const Duration(milliseconds: 0), () {
    DefaultCacheManager().emptyCache();
  });

  setupLocator();

  runApp(const KlinikApp());
}

///Root of Klinik App
class KlinikApp extends StatelessWidget {
  const KlinikApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Klinik Kesehatan Digital',
      theme: KlinikTheme.theme,
      home: const LoginPage(),
      navigatorKey: locator<NavigationService>().navigationKey,
      onGenerateRoute: (settings) => RouterGenerator.generateRoute(settings),
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
    );

    return ThemeData.light().copyWith(
      platform: TargetPlatform.android,
      primaryColor: ColorHelper.fromHex("#FFE65100"),
      primaryColorLight: Colors.orange,
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(
              color: Colors.orangeAccent.shade400,
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
        backgroundColor: Colors.orange,
      ).copyWith(secondary: Colors.orange),
    );
  }
}
