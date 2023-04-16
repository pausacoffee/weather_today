import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
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
  Future<void> fetchViewModel() async {
    try {
      BaseResponseModel? response = await WeatherApi().handleFetchCurrent();

      if (response == null) return;

      if (response.body['current'] != null) {
        currentData = CurrentModel.fromJson(response.body['current']);
      }
      if (response.body['location'] != null) {
        locationData = LocationModel.fromJson(response.body['location']);
      }
      setIsLoding(false);
    } catch (e) {
      Logger().d(e);
    } finally {}
  }
}
