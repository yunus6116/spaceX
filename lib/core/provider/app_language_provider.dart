import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacex/core/constants/app_constants.dart';

class AppLanguageProvider extends ChangeNotifier {
  Locale? appLocale;

  Future<Type> fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      return Null;
    }
    appLocale = Locale(prefs.getString('language_code')!);
    return Null;
  }

  bool get isTR => appLocale == AppConstant.TR_LOCALE;

  Future<void> changeLanguage(type) async {
    var prefs = await SharedPreferences.getInstance();
    if (appLocale == type) {
      return;
    }
    if (type == 'tr') {
      appLocale = Locale('tr');
      await prefs.setString('language_code', 'tr');
      await prefs.setString('countryCode', 'TR');
    } else {
      appLocale = Locale('en');
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }

    notifyListeners();
  }
}
