import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  AppLanguage();

  late Locale appLocale;

  Future<Type> fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      return Null;
    }
    appLocale = Locale(prefs.getString('language_code')!);
    return Null;
  }

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
