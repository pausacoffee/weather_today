import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../modules/geo/view/geo_page.dart';
import '../modules/home/view/home_page.dart';
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
        routes: [
          /// sub Page를 설정할수 있다.
          GoRoute(
            path: APP_PAGE.geo.toPath,
            name: APP_PAGE.geo.toName,

            /// page transition을 설정할 수 있다.
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const GeoPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                /// Fade In/Out Slide animation
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                final tween = Tween(begin: begin, end: end);
                final curvedAnimation =
                    CurvedAnimation(parent: animation, curve: curve);

                return SlideTransition(
                  position: tween.animate(curvedAnimation),
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
            ),
          ),
        ],
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
