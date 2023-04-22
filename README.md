# weather_today

'https://www.weatherapi.com/' 에서 제공하는 날씨 API를 사용하여 '오늘의 날씨'를 확인하게 도와주는 모바일 서비스입니다.

## 제작 기간 & 참여 인원
- 2023년 4월 11일
- 개인프로젝트

## 사용한 기술
- language : dart
- framework : flutter
> provider, goRouter, dio, http

## 핵심 기능 
- 관심지역의 날씨를 알 수 있습니다.
- 사용자는 관심지역을 설정할 수 있습니다.
- 날씨 정보에는 다음을 포함.
  > 기온, 체감온도, 바람, 강수확률, 자외선 지수 
- dark mode, light mode를 설정할 수 있다.
- 사용자는 scale을 지정할 수 있다.(바람 속도 단위, 기온 단위)

## 자랑하고 싶은 코드
<details><summary><b>앱 initialize 후 HomePage로 리다이렉트</b></summary>
<div markdown="1">
~~~dart
  import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_today/modules/setting/view/setting_page.dart';

import '../modules/address/view/address_page.dart';
import '../modules/home/view/home_page.dart';
import '../modules/permission/view/permission_page.dart';
import '../modules/splash/splash_page.dart';
import '../modules/error/view/error_page.dart';
import '../service/app_service.dart';
import 'app_page.dart';

/// goRouter 을 사용하여 navigation 과 조건에 따라 redirect를 수행
class AppRouter {
  GoRouter get router => _goRouter;

  AppRouter();

  late final GoRouter _goRouter = GoRouter(
    refreshListenable: AppService(),
    initialLocation: APP_PAGE.splash.toPath,
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
            path: APP_PAGE.address.toPath,
            name: APP_PAGE.address.toName,

            /// page transition을 설정할 수 있다.
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const AddressPage(),
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
          GoRoute(
            path: APP_PAGE.setting.toPath,
            name: APP_PAGE.setting.toName,
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const SettingPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
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
      GoRoute(
        path: APP_PAGE.permission.toPath,
        name: APP_PAGE.permission.toName,
        builder: (BuildContext context, GoRouterState state) {
          return PermissionPage();
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final homeLocation = APP_PAGE.home.toPath;
      final splashLocation = APP_PAGE.splash.toPath;
      final permissionLocation = APP_PAGE.permission.toPath;

      final isInitialized = AppService().initialized;
      final isPermitted = AppService().permitted;

      final isGoingToSplash = state.subloc == splashLocation;
      final isGoingToPermission = state.subloc == permissionLocation;
      //final isGoingToHome = state.subloc == homeLocation;

      /// 앱 시작전 권한, 로그인 여부, 세팅 등을 체크하고 route 한다.
      if (!isInitialized && !isGoingToSplash) {
        return splashLocation;
      } else if (isInitialized && !isPermitted && !isGoingToPermission) {
        return permissionLocation;
      } else if ((isInitialized && isGoingToSplash) ||
          (isPermitted && isGoingToPermission)) {
        return homeLocation; //위 체크가 끝나면 home으로!
      } else {
        // Else Don't do anything
        return null;
      }
    },
  );
}
~~~dart
</div>
  
</details>
<details><summary><b>RestApi</b></summary>
</details>
<details><summary><b>Scroller controller</b></summary>
</details>

## 회고 / 느낀 점

