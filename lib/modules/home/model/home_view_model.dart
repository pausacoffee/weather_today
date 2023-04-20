import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_today/models/weather/hour_model.dart';

import '../../../api/base/base_response_model.dart';
import '../../../api/weather_api.dart';
import '../../../config/app_config.dart';
import '../../../models/weather/current_model.dart';
import '../../../models/weather/forecast_day_model.dart';
import '../../../models/weather/location_model.dart';

///HomePage에서 필요한 데이터들은 불러오고, notify 함.
class HomeViewModel extends ChangeNotifier {
  HomeViewModel();
  // Variable ▼ ==========================================
  /// 데이터 로딩
  bool _isLoading = true;

  /// 현재 선택된 위치
  String userLocation = 'London';

  /// 즐겨찾기 location 리스트
  List<String> userLocationList = ['London', '+'];

  /// Current Weather Data
  late CurrentModel currentData;

  /// Current Weather's Location Data
  late LocationModel locationData;

  /// forecastday Weather's Location Data
  List<ForecastdayModel> forcastList = [];

  /// forecast list를 hourlist로 expand함.
  List<HourModel> hourList = [];

  // Getter/Settter ▼ ==========================================
  /// 데이터 로딩
  bool get isLoading => _isLoading;

  void setIsLoding(bool data) {
    _isLoading = data;

    notifyListeners();
  }

  // Fucntion ▼ ==========================================

  /// Home 화면에 보여줄 데이터를 load 한다.
  Future<void> initialize() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userLocationList =
          prefs.getStringList('user_loacation_list') ?? userLocationList;

      userLocation = userLocationList[0];

      await fetchViewModel();

      setIsLoding(false);
    } catch (e) {
      Logger().d(e);
    }
  }

  ///fetch multiple data for home page
  Future<void> fetchViewModel() async {
    try {
      await fetchForcasttData();

      setIsLoding(false);
    } catch (e) {
      Logger().d(e);
    }
  }

  ///fetch current weather data
  Future<void> fetchCurrentData() async {
    try {
      BaseResponseModel? response =
          await WeatherApi().handleFetchCurrent(userLocation);

      if (response == null) return;

      if (response.body['current'] != null) {
        currentData = CurrentModel.fromJson(response.body['current']);
      }
      if (response.body['location'] != null) {
        locationData = LocationModel.fromJson(response.body['location']);
      }
    } catch (e) {
      Logger().d(e);
    }
  }

  ///fetch forecast
  ///: current data를 포함한다! current대신 사용할 것!
  Future<void> fetchForcasttData() async {
    try {
      BaseResponseModel? response =
          await WeatherApi().handleFetchForcast(userLocation);

      if (response == null) return;

      if (response.body['current'] != null) {
        currentData = CurrentModel.fromJson(response.body['current']);
      }
      if (response.body['location'] != null) {
        locationData = LocationModel.fromJson(response.body['location']);
      }
      if (response.body['forecast'] != null) {
        Map<String, dynamic> forecast = response.body['forecast'];

        if (forecast['forecastday'] != null) {
          forcastList.clear();
          forcastList.addAll(List<ForecastdayModel>.from(
              (forecast['forecastday']
                  .map((e) => ForecastdayModel.fromJson(e)))));

          if (forcastList.isNotEmpty) {
            hourList.clear();
            hourList = forcastList.expand((element) => element.hour).toList();
          }
        }
      }
    } catch (e) {
      Logger().d(e);
    }
  }

  ///기온 scale
  ///true : 화씨 (°F)
  ///false : 섭씨 (°C)
  Future<void> setScale(bool value) async {
    try {
      AppConfig().temperatureScale = value;

      notifyListeners();
    } finally {}

    return;
  }

  /// 사용자 Scale에 맞게 현재 기온과 Scale을 보여줌.
  String currenTempScale() {
    String reulst = '';
    try {
      if (AppConfig().temperatureScale) {
        reulst = '${currentData.tempF} ℉';
      } else {
        reulst = '${currentData.tempC} ℃';
      }
    } catch (e) {
      Logger().d(e);
    }

    return reulst;
  }

  /// 사용자 Scale에 맞게 현재 기온을 보여줌.
  String currenTemp() {
    String reulst = '';

    try {
      if (AppConfig().temperatureScale) {
        reulst = '${currentData.tempF}';
      } else {
        reulst = '${currentData.tempC}';
      }
    } catch (e) {
      Logger().d(e);
    }

    return reulst;
  }

  /// 사용자 기온 Scale에 맞게 Scale을 보여줌.
  String getTempScale() {
    String reulst = '';
    try {
      if (AppConfig().temperatureScale) {
        reulst = '℉';
      } else {
        reulst = '℃';
      }
    } catch (e) {
      Logger().d(e);
    }

    return reulst;
  }
}
