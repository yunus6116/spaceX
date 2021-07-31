import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacex/core/theme/light_theme.dart';
import 'package:spacex/views/screens/home/home_view.dart';

import 'core/constants/app_constants.dart';
import 'core/provider/app_language_provider.dart';
import 'core/provider/theme_provider.dart';
import 'core/theme/dark_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  var appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await SharedPreferences.getInstance().then((prefs) {
    var darkModeOn = prefs.getBool('darkMode') ?? false;
    if (darkModeOn) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            systemNavigationBarColor: Color(
                darkModeOn ? 0xff121212 : 0xffffff), // navigation bar color
            statusBarColor:
                Color(darkModeOn ? 0xff121212 : 0xffffff), // status bar color
            systemNavigationBarIconBrightness:
                darkModeOn ? Brightness.light : Brightness.dark),
      );
    }
    runApp(
      EasyLocalization(
        supportedLocales: AppConstant.SUPPORTED_LOCALE,
        path: AppConstant.LANG_PATH,
        child: ChangeNotifierProvider<ThemeProvider>(
          create: (_) =>
              ThemeProvider(darkModeOn ? getDarkTheme() : getLightTheme()),
          child: MyApp(),
        ),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return MaterialApp(
      themeMode: themeProvider.themeMode,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      title: 'SpaceX',
      theme: getLightTheme(),
      darkTheme: getDarkTheme(),
      home: HomeView(),
    );
  }
}
