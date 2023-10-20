import 'package:flutter/material.dart';
import 'package:flutter_mini_social/service/local_service_client.dart';
import 'package:flutter_mini_social/theme/dark_mode.dart';
import 'package:flutter_mini_social/theme/light_mode.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  Future<ThemeData> setUpTheme() async {
    final localTheme = await LocalServiceClient.get('themeData');
    if (localTheme == null) {
      await LocalServiceClient.save(key: 'themeData', value: 'lightMode');
      return lightMode;
    } else {
      if (localTheme == 'lightMode') {
        return lightMode;
      }
      return darkMode;
    }
  }

  void toggleTheme() async{
    if (_themeData == lightMode) {
      themeData = darkMode;
      await LocalServiceClient.save(key: 'themeData', value: 'darkMode');

    } else {
      themeData = lightMode;
      await LocalServiceClient.save(key: 'themeData', value: 'lightMode');
    }
    notifyListeners();
  }
}
