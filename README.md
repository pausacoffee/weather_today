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
  - goRouter를 사용하여 redirect를 구현하였습니다. 예를들어 app의 시작후 splahPage가 보여지는데, 데이터를 불러오기가 마치면 home page로 redirect하였습니다.
  
```dart
/// goRouter 을 사용하여 navigation 과 조건에 따라 redirect를 수행
class AppRouter {
  GoRouter get router => _goRouter;

  AppRouter();

  late final GoRouter _goRouter = GoRouter(
    refreshListenable: AppService(),
    initialLocation: APP_PAGE.splash.toPath,//앱의 시작시 splash Page로!
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
        ...
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
        return permissionLocation;//init 후에 App의 Permission이 필요시 Permission Page로!
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
```
</details>
  
<details><summary><b>RestApi</b></summary>
</details>
  
<details><summary><b>Scroller controller</b></summary>
</details>

## 회고 / 느낀 점

