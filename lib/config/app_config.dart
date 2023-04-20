import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  // Singleton ▼ ========================================
  static final AppConfig _singleton = AppConfig._();

  ///앱의 설정 값 : Scale(°F, °C), 언어, 다크모드 etc
  factory AppConfig() {
    return _singleton;
  }

  AppConfig._();
  // Variable ▼ ========================================

  ///온도 표기
  ///true : 화씨 (°F)
  ///false : 섭씨 (°C)
  ///기본 섭씨
  bool get temperatureScale => _temperatureScale;
  bool _temperatureScale = false;
  set temperatureScale(bool value) {
    _temperatureScale = value;

    saveScale(value);
  }

  void init() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _temperatureScale = prefs.getBool('temperature_scale') ?? false;
    } catch (e) {
      Logger().d(e);
    }
  }

  Future<void> saveScale(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('temperature_scale', value);

    return;
  }
}
