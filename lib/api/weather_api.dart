import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

import '../global/global_toast_widget.dart';
import '../models/weather/error_model.dart';
import 'base/base_http.dart';
import 'base/base_response_model.dart';

/// 날씨 API
class WeatherApi {
  // Singleton ▼ ==========================================
  static final WeatherApi _singleton = WeatherApi._();
  factory WeatherApi() => _singleton;
  WeatherApi._();

  // Function ▼ ==========================================
  /// Fetch Weather Api Data (type : current)
  /// q (in url) : Pass US Zipcode, UK Postcode, Canada Postalcode, IP address, Latitude/Longitude (decimal degree) or city name.
  Future<BaseResponseModel?> handleFetchCurrent(String location) async {
    try {
      BaseResponseModel response = await BaseHttp.dio(
          method: 'GET',
          url:
              '${dotenv.env["APP_API_URL"]}&key=${dotenv.env['APP_API_KEY']!}&q=$location');

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
