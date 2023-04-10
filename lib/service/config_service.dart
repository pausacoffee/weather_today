import 'dart:io';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:vibration/vibration.dart';

class ConfigService {
  // /// 개인정보 취급 방침
  // Rx<String> privacy_policy = "".obs;

  // /// 이용약관
  // Rx<String> service = "".obs;

  // Future<void> handleInitialization() async {
  //   try {
  //     AuthBaseResponseModel response =
  //         await Provider.dio(method: 'GET', url: '/config');

  //     switch (response.statusCode) {
  //       case 200:
  //         Logger().d("설정서비스 : 설정 정보 업로드");
  //         privacy_policy.value = response.data['privacy_policy'];
  //         service.value = response.data['service'];
  //         break;
  //       default:
  //     }
  //   } catch (e) {
  //     //TODO 원래 에러시 앱 종료 유도
  //   }
  // }

  /// 진동효과
  void handleOnHapticFeedback() {
    if (Platform.isAndroid) {
      Vibration.vibrate(duration: 35, amplitude: 16);
    } else if (Platform.isIOS) {
      HapticFeedback.heavyImpact();
    }
  }
}
