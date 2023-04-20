import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService with ChangeNotifier {
  // Singleton ▼ ========================================
  static final ThemeService _singleton = ThemeService._();

  /// Theme Mode 관리 및 notify
  factory ThemeService() {
    return _singleton;
  }

  ThemeService._();

  // Variable ▼ ========================================
  ThemeMode _themeMode = ThemeMode.light;

  ///다크모드
  ///true : 다크
  ///false: 라이트
  ///기본 : 라이트
  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode value) {
    _themeMode = value;

    notifyListeners();

    saveThemeScale(value);
  }

  // Fucntion ▼ ========================================

  ///theme mode 설정값 로드
  void init() async {
    try {
      bool result = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      result = prefs.getBool('theme_mode') ?? false;

      if (result) {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light;
      }
    } catch (e) {
      Logger().d(e);
    }
  }

  ///theme mode 설정값 저장
  Future<void> saveThemeScale(ThemeMode value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (value) {
      case ThemeMode.dark:
        prefs.setBool('theme_mode', true);
        break;
      case ThemeMode.light:
        prefs.setBool('theme_mode', false);
        break;
      default:
        prefs.setBool('theme_mode', false);
        break;
    }

    return;
  }
}
