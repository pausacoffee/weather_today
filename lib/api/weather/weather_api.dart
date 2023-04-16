import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../../global/global_toast_widget.dart';
import '../../models/weather/current_model.dart';
import '../../models/weather/error_model.dart';
import '../../models/weather/location_model.dart';
import '../base/base_http.dart';
import '../base/base_response_model.dart';

/// 날씨 API
class WeatherApi {
  // Singleton ▼ ==========================================
  static final WeatherApi _singleton = WeatherApi._();
  factory WeatherApi() => _singleton;
  WeatherApi._();

  // Function ▼ ==========================================
  /// Fetch Weather Api Data (type : current)
  Future<BaseResponseModel?> handleFetchCurrent(String location) async {
    try {
      BaseResponseModel response = await BaseHttp.dio(
          method: 'GET',
          url:
              '/current.json?key=${dotenv.env['APP_API_KEY']!}&q=$location&aqi=no');

      switch (response.statusCode) {
        case 200:
          if (kDebugMode) {
            Logger().d(response.toString());
          }

          return response;

          break;
        case 400:
        case 401:
        case 402:
        case 403:
          if (response.body['error'] != null) {
            ErrorModel errorData = ErrorModel.fromJson(response.body['error']);

            throw Exception(errorData.message);
          }
          break;
        default:
        //throw Exception(response.message);
      }
    } catch (e) {
      GlobalToastWidget(message: e.toString().substring(11));
      Logger().d(e.toString());
    }
    return null;
  }
}
