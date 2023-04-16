import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_today/api/weather/weather_api.dart';

import '../../api/base/base_response_model.dart';
import '../../models/weather/current_model.dart';
import '../../models/weather/location_model.dart';

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

  // Getter/Settter ▼ ==========================================
  /// 데이터 로딩
  bool get isLoding => _isLoading;

  void setIsLoding(bool data) {
    _isLoading = data;

    notifyListeners();
  }

  // Fucntion ▼ ==========================================

  /// load data : user location list, current weather...
  Future<void> initialize() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userLocationList =
          prefs.getStringList('user_loacation_list') ?? userLocationList;

      userLocation = userLocationList[0];

      await fetchCurrentData();

      setIsLoding(false);
    } catch (e) {
      Logger().d(e);
    }
  }

  ///fetch multiple data for home view
  Future<void> fetchViewModel() async {
    try {
      await fetchCurrentData();

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
}
