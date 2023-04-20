import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';
import 'condition_service.dart';

class AppService with ChangeNotifier {
  // Singleton ▼ ========================================
  static final AppService _singleton = AppService._();

  ///router redirect listener : permission, auth, Data 초기화, 앱 설정 등..
  factory AppService() {
    return _singleton;
  }

  AppService._();

  // Variable ▼ ========================================
  ///앱에 대한 init 여부
  bool _initialized = false;
  bool get initialized => _initialized;

  ///허용 여부(permission_service)
  bool _permissionState = false;
  bool get permitted => _permissionState;
  set permitted(bool value) {
    _permissionState = value;
    notifyListeners();
  }

  //Fucntion  ▼ ========================================
  ///onAppStart가 완료되면 route redirect됨.
  Future<void> onAppStart() async {
    await initialize();

    await Future.delayed(const Duration(seconds: 2));

    _initialized = true;

    notifyListeners();
  }

  /// 앱을 시작하기 위해 필요한 데이터와 세팅 로딩(오래 걸리는 것)
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 2));

    // 최초 permission 체크 한번
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _permissionState = prefs.getBool('initialize_permission') ?? false;

    //load condition data from json
    ConditionService().init();

    // Config 초기화
    AppConfig().init();

    // 파이어베이스 초기화
    //await Firebase.initializeApp();

    // 카카오
    // KakaoSdk.init(
    //   nativeAppKey: dotenv.env['APP_KAKAO_NATIVE_APP_KEY'],
    //   javaScriptAppKey: dotenv.env['APP_KAKAO_JAVASCRIPT_APP_KEY'],
    // );

    // 스크롤 서비스 초기화
    // Get.put(FCMService(), permanent: true);

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
