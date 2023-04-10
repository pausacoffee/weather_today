/// Goal: provider, goRouter 를 사용하여 날씨앱을 만들자
/// #<a href='https://pngtree.com/so/Weather'>Weather png from pngtree.com/</a>

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_today/service/app_service.dart';

import 'routes/app_router.dart';
import 'utils/color.dart';

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
          providers: [
            ChangeNotifierProvider<AppService>(create: (_) => appService),
            Provider<AppRouter>(create: (_) => AppRouter(appService)),
          ],
          child: Builder(builder: (context) {
            final GoRouter goRouter =
                Provider.of<AppRouter>(context, listen: false).router;
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
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                  backgroundColor: ColorPath.bgColor,
                  systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
                    statusBarColor: Colors.white.withOpacity(0.0),
                  ),
                ),
                fontFamily: "Pretendard",
                scaffoldBackgroundColor: ColorPath.bgColor,
              ),
              debugShowCheckedModeBanner: false,
            );
          }),
        );
      },
    );
  }
}

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

  // .env 초기화
  await dotenv.load();
}