import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../modules/home/home_page.dart';
import '../modules/splash/splash_page.dart';
import '../service/app_service.dart';
import '../utils/errorPage.dart';
import 'app_page.dart';

class AppRouter {
  late final AppService appService;
  GoRouter get router => _goRouter;

  AppRouter(this.appService);

  late final GoRouter _goRouter = GoRouter(
    refreshListenable: appService,
    initialLocation: APP_PAGE.home.toPath,
    debugLogDiagnostics: true, //router 정보 콘솔에 출력
    errorBuilder: (BuildContext context, GoRouterState state) =>
        const ErrorPage(), //state.error.toString()으로 에러메세지 출력가능
    routes: <GoRoute>[
      GoRoute(
        path: APP_PAGE.home.toPath,
        name: APP_PAGE.home.toName,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
        //routes:  //GetX처럼 서브 루트가능
      ),
      GoRoute(
        path: APP_PAGE.splash.toPath,
        name: APP_PAGE.splash.toName,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final homeLocation = APP_PAGE.home.toPath;
      final splashLocation = APP_PAGE.splash.toPath;

      final isInitialized = appService.initialized;

      final isGoingToInit = state.subloc == splashLocation;

      /// 앱 시작전 권한, 로그인 여부, 세팅 등을 체크하고 route 한다.
      if (!isInitialized && !isGoingToInit) {
        return splashLocation;
      } else if ((isInitialized && isGoingToInit)) {
        return homeLocation;
      } else {
        // Else Don't do anything
        return null;
      }
    },
  );
}
