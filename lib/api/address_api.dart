import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

import '../global/global_toast_widget.dart';
import 'base/base_http.dart';
import 'base/base_response_model.dart';

/// 주소 검색 API
class AddressApi {
  // Singleton ▼ ==========================================
  static final AddressApi _singleton = AddressApi._();
  factory AddressApi() => _singleton;
  AddressApi._();

  // Function ▼ ==========================================
  Future<BaseResponseModel?> fetch(
      String keyword, int curPage, cntPerPage) async {
    try {
      BaseResponseModel response = await BaseHttp.dio(
          method: 'GET',
          url:
              '${dotenv.env["APP_ADDRESS_API_URL"]}&confmKey=${dotenv.env['APP_ADDRESS_API_KEY']!}&keyword=$keyword&countPerPage=$cntPerPage&currentPage=$curPage');

      switch (response.statusCode) {
        case 200:
          if (kDebugMode) {
            Logger().d(response.toString());
          }

          return response;

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
