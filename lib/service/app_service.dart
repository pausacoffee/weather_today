import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class AppService with ChangeNotifier {
  AppService();

  bool _initialized = false;
  bool get initialized => _initialized;

  set initialized(bool value) {
    _initialized = value;
    notifyListeners();
  }

  ///앱 시작전 필요한 init 을 시행한다.
  Future<void> onAppStart() async {
    await initialize();

    await Future.delayed(const Duration(seconds: 2));

    _initialized = true;
    notifyListeners();
  }

  /// home이 시작되기전 허용, 세팅, 로그인 등을 init함.
  /// 시간 오래 소요되는것 여기!
  Future<void> initialize() async {
    // Http 초기화 (디버그 모드일 경우)
    // if (kDebugMode) {
    //   HttpOverrides.global = MyHttpOverrides();
    // }

    // 파이어베이스 초기화
    //await Firebase.initializeApp();

    // 카카오
    // KakaoSdk.init(
    //   nativeAppKey: dotenv.env['APP_KAKAO_NATIVE_APP_KEY'],
    //   javaScriptAppKey: dotenv.env['APP_KAKAO_JAVASCRIPT_APP_KEY'],
    // );

    // Config 초기화
    //Get.put(ConfigService());

    // 스크롤 서비스 초기화
    // Get.put(FCMService(), permanent: true);

    /// 서버 설정 가져오기
    //await ConfigService.to.handleInitialization();

    /// 카카오 맵 키
    // AuthRepository.initialize(
    //     appKey: dotenv.env['APP_KAKAO_JAVASCRIPT_APP_KEY']!);

    // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
    WidgetsFlutterBinding.ensureInitialized();

    // 다이나믹 링크 서비스
    // Get.put(DynamicLinkService(), permanent: true);
    // DynamicLinkService.to.setup();
  }
}
