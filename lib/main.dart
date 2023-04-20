/// Goal: provider, goRouter 를 사용하여 날씨앱을 만들자
/// #<a href='https://pngtree.com/so/Weather'>Weather png from pngtree.com/</a>
/// TODO:
/// - 도씨, 화씨 변경(done)
/// - '내 위치' Lon Lat 받아오기
/// - '내 위치'로 날씨 결과값 받아오고, UI 에 표시하기
/// - localization(en, kr)
///  - dark 모드
/// - 즐겨찾기 기능 완성
/// - 검색된 도시의 날씨 결과값 받아오고, UI 에 표시하기
///
/// - etc...

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'config/app_provider_config.dart';
import 'routes/app_router.dart';
import 'service/app_service.dart';
import 'service/theme_service.dart';
import 'utils/color.dart';
import 'utils/scroll_behavior.dart';
import 'utils/theme.dart';

void main() async {
  await initialize();

  return runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppService appService;

  /// 현재 시간
  DateTime currentDateTime = DateTime.now();

  @override
  void initState() {
    appService = AppService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MultiProvider(
          providers: AppProviderConfig.providers(),
          child: Builder(builder: (context) {
            final GoRouter goRouter =
                Provider.of<AppRouter>(context, listen: false).router;
            final ThemeService themeNotifier =
                Provider.of<ThemeService>(context, listen: false);
            return MaterialApp.router(
              // route 정보 전달
              routeInformationProvider: goRouter.routeInformationProvider,
              // URI String을 상태 및 Go Router에서 사용할 수 있는 형태로 변환해주는 함수
              routeInformationParser: goRouter.routeInformationParser,
              // 위에서 변경된 값으로 실제로 어떤 라우트를 보여줄지 정하는 함수
              routerDelegate: goRouter.routerDelegate,
              locale: const Locale('ko', 'KR'),
              localizationsDelegates: const [
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('ko', 'KR'),
              ],
              builder: (context, widget) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                );
              },
              // theme: ThemeData(
              //   appBarTheme: AppBarTheme(
              //     backgroundColor: ColorPath.bgColor,
              //     systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              //       statusBarColor: Colors.white.withOpacity(0.0),
              //     ),
              //   ),
              //   fontFamily: GoogleFonts.openSans().fontFamily,
              //   scaffoldBackgroundColor: ColorPath.bgColor,
              // ),
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeNotifier.themeMode,
              debugShowCheckedModeBanner: false,
              scrollBehavior: AppScrollBehavior(),
              backButtonDispatcher: RootBackButtonDispatcher(),
            );
          }),
        );
      },
    );
  }

  Future<bool> handlePrevBack(BuildContext context) async {
    // 메인 화면에서 뒤로가기 막기
    final DateTime now = DateTime.now();

    if (now.difference(currentDateTime) > const Duration(milliseconds: 1000)) {
      currentDateTime = now;
      Fluttertoast.showToast(
        msg: '한번 더 누르면 앱이 종료됩니다',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black.withOpacity(0.7),
        textColor: Colors.white,
      );
    } else {
      exit(0);
    }

    return false;
  }
}

///initialize before runApp
Future<void> initialize() async {
  /// Widget Binding 초기화
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    SchedulerBinding.instance.scheduleWarmUpFrame();
  });

  /// SystemChrome Color 초기화
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));

  // 가로모드 방지
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //theme 설정
  ThemeService().init();

  // .env 초기화
  await dotenv.load();
}
