import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  // Singleton ▼ ========================================
  static final AppConfig _singleton = AppConfig._();

  ///앱의 설정 값 : Scale(°F, °C), 언어 etc
  factory AppConfig() {
    return _singleton;
  }

  AppConfig._();
  // Variable ▼ ========================================

  bool _temperatureScale = false;

  ///온도 표기
  ///true : 화씨 (°F)
  ///false : 섭씨 (°C)
  ///기본 섭씨
  bool get temperatureScale => _temperatureScale;

  set temperatureScale(bool value) {
    _temperatureScale = value;

    saveTemperatureScale(value);
  }

  ///속도 표기
  ///true : miles
  ///false : kilometer
  ///기본 kilometer
  bool get speedScale => _speedScale;
  bool _speedScale = false;
  set speedScale(bool value) {
    _speedScale = value;

    saveSpeedScale(value);
  }

  // Fucntion ▼ ========================================
  void init() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _temperatureScale = prefs.getBool('temperature_scale') ?? false;
      _speedScale = prefs.getBool('speed_scale') ?? false;
      //_themeScale = prefs.getBool('theme_scale') ?? false;
    } catch (e) {
      Logger().d(e);
    }
  }

  Future<void> saveTemperatureScale(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('temperature_scale', value);

    return;
  }

  Future<void> saveSpeedScale(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('speed_scale', value);

    return;
  }
}
