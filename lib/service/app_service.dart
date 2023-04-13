import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppService with ChangeNotifier {
  static final AppService _singleton = AppService._internal();

  factory AppService() {
    return _singleton;
  }

  AppService._internal();

  // Getter Setter ▼ ========================================
  //앱에 대한 init 여부
  bool _initialized = false;
  bool get initialized => _initialized;

  set initialized(bool value) {
    _initialized = value;
    notifyListeners();
  }

  //허용 여부
  bool _permissionState = false;
  bool get permitted => _permissionState;

  set permitted(bool value) {
    _permissionState = value;
    notifyListeners();
  }

  //Fucntion  ▼ ========================================
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _permissionState = prefs.getBool('initialize_permission') ?? false;

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
