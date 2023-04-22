# weather_today

'오늘의 날씨'를 확인하게 도와주는 모바일 서비스입니다.

## 제작 기간 & 참여 인원
- 시작일 : 2023년 4월 11일
- 개인프로젝트

## 사용한 기술
- language : dart
- framework : flutter
> provider, goRouter, dio, http

## 사용한 API 
- Free Weather API
> https://www.weatherapi.com/
- Doc
> https://www.weatherapi.com/docs/

## 핵심 기능 
- 관심지역의 날씨를 알 수 있습니다.
- 사용자는 관심지역을 설정할 수 있습니다.
- 날씨 정보에는 다음을 포함.
  > 기온, 체감온도, 바람, 강수확률, 자외선 지수 
- dark mode, light mode를 설정할 수 있다.
- 사용자는 scale을 지정할 수 있다.(바람 속도 단위, 기온 단위)

## 자랑하고 싶은 코드

<details><summary><b>앱 initialize 후 리다이렉트</b></summary>
  - goRouter를 사용하여 redirect를 구현하였습니다. 
  예를들어 app의 시작후 splahPage가 보여지는데, 데이터를 불러오기가 마치면 home page로 redirect하였습니다.
  혹은 permission을 사용자로부터 요청하는 page로 redirec합니다.
  로그인이 필요한 경우 login page 로 이동하는 redirect 또한 이 곳에서 처리가 가능합니다.
  
```dart
/// goRouter 을 사용하여 navigation 과 조건에 따라 redirect를 수행
class AppRouter {
  GoRouter get router => _goRouter;

  AppRouter();

  late final GoRouter _goRouter = GoRouter(
    refreshListenable: AppService(),
    initialLocation: APP_PAGE.splash.toPath,//앱의 시작시 splash Page로!
    ...
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
AppService는 redirect를 지원하는 Service이고, 변수 값을 가지고 있습니다.
```dart
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

  ///앱을 시작하기 위해 필요한 데이터와 세팅 로딩(오래 걸리는 것) 
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 2));

    // 최초 permission 체크 한번
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _permissionState = prefs.getBool('initialize_permission') ?? false;

    //load condition data from json
    ConditionService().init();

    // Config 초기화
    AppConfig().init();
  }
}

```
</details>
  
<details><summary><b>RestApi</b></summary>
  weatherapi.com 와 통신할 공통 API를 만들어 관리하였습니다. 
  앱 어디에서건  WeatherApi 클래스를 통해 weatherapi.com으로부터 data를 얻어 올 수 있습니다. 
  
<bt></br>
```dart
/// 날씨 API
class WeatherApi {
  // Singleton ▼ ==========================================
  static final WeatherApi _singleton = WeatherApi._();
  factory WeatherApi() => _singleton;
  WeatherApi._();

  // Function ▼ ==========================================
  /// Fetch Weather Api Data (type : current)
  /// url parameter
  /// q : Pass US Zipcode, UK Postcode, Canada Postalcode, IP address, Latitude/Longitude (decimal degree) or city name.
  /// aqi : Get air quality data
  Future<BaseResponseModel?> handleFetchCurrent(String location) async {
    try {
      BaseResponseModel response = await BaseHttp.dio(
          method: 'GET',
          url:
              '${dotenv.env["APP_API_URL"]}current.json?aqi=yes&key=${dotenv.env['APP_API_KEY']!}&q=$location');

      switch (response.statusCode) {
        case 200:
          if (kDebugMode) {
            Logger().d(response.toString());
          }

          return response;

          break;
        case 400:
        case 401:
        case 402:
        case 403:
          if (response.body['error'] != null) {
            ErrorModel errorData = ErrorModel.fromJson(response.body['error']);

            throw Exception(errorData.message);
          }
          break;
        default:
        //throw Exception(response.message);
      }
    } catch (e) {
      GlobalToastWidget(message: e.toString().substring(11));
      Logger().d(e.toString());
    }
    return null;
  }

  /// Fetch Weather Api Data (type : forcast)
  /// url parameter
  /// q : Pass US Zipcode, UK Postcode, Canada Postalcode, IP address, Latitude/Longitude (decimal degree) or city name.
  /// days : Number of days of weather forecast. Value ranges from 1 to 10
  /// aqi : Get air quality data
  /// alerts : Get weather alert data
  Future<BaseResponseModel?> handleFetchForcast(String location) async {
    try {
      BaseResponseModel response = await BaseHttp.dio(
          method: 'GET',
          url:
              '${dotenv.env["APP_API_URL"]}forecast.json?key=${dotenv.env['APP_API_KEY']!}&q=$location&days=3&aqi=yes&alerts=yes');

      switch (response.statusCode) {
        case 200:
          if (kDebugMode) {
            Logger().d(response.toString());
          }

          return response;

          break;
        case 400:
        case 401:
        case 402:
        case 403:
          if (response.body['error'] != null) {
            ErrorModel errorData = ErrorModel.fromJson(response.body['error']);

            throw Exception(errorData.message);
          }
          break;
        default:
        //throw Exception(response.message);
      }
    } catch (e) {
      GlobalToastWidget(message: e.toString().substring(11));
      Logger().d(e.toString());
    }
    return null;
  }
}

```
</details>
  
<details><summary><b>pagination</b></summary>
  주소 검색 기능을 개발하며 pagination을 구현하였습니다.
  주소 검색 API를 통해 첫 데이터를 받아오고, update를 통해 추가 데이터를 받아오게 구성하였습니다.
  
 <bt></br> 
  
```dart
//address_search_widget.dart
  /// 주소 검색창
  Widget _searchAddress() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      ...,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: Colors.grey[400],
      ),
      child: Column(
        children: [
          //검색창
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  focusNode: _focusNode,
                  controller: _editController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.w,
                      horizontal: 10.w,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _editController.clear();

                        setState(() {
                          _isExpanded = false;
                        });
                      },
                      icon: Icon(
                        Icons.cancel_rounded,
                        color: Colors.grey,
                        size: 20.sp,
                      ),
                    ),
                    hintText: '지역 검색',
                    hintStyle: TextStylePath.small14w400,
                  ),
                ),
              ),
              //indicator and icon button
              SizedBox(
                height: 40.h,
                width: 40.w,
                child: addressViewModel.isLoading
                    ? Transform.scale(
                        scale: 0.5,
                        child: const CircularProgressIndicator(),
                      )
                    : IconButton(
                        onPressed: () async {
                          await addressViewModel
                              .fetchAddressData(_editController.text);//이곳에서 fetch를 시작

                          setState(() {
                            if (_editController.text.isNotEmpty) {
                              _isExpanded = !_isExpanded;
                            }
                          });
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 30.sp,
                        ),
                      ),
              ),
            ],
          ),

          //검색결과
          _resultAddress(),
        ],
      ),
    );
  }

  /// 주소 검색 결과 List
  Widget _resultAddress() {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,//_scrollController을 연결하여 scroll의 마지막에서 data를 update!
        scrollDirection: Axis.vertical,
        itemCount: addressViewModel.jusoList.length,
        itemBuilder: (context, index) {
          JusoModel item = addressViewModel.jusoList[index];
          return Container(
            padding: EdgeInsets.only(right: 10.w, left: 10.w),
            child: InkWell(
              onTap: () {
              },
              child: ListTile(
                title: Text(
                  item.roadAddrPart1,
                  style: TextStylePath.title18w400.copyWith(
                    color: Colors.grey[50],
                  ),
                ),
                subtitle: Text(
                  item.jibunAddr,
                  style: TextStylePath.small12w400.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Override ▼ ========================================
  @override
  void initState() {
  
    _scrollController.addListener(() {
      if (!addressViewModel.isProcess &&
          (addressViewModel.currentPage * addressViewModel.cntPerPage <
              addressViewModel.totalCount) &&
          _scrollController.offset >=
              _scrollController.position.maxScrollExtent - 300) {
  //data를 받아오는 중이 아니고, api에서 더 받아올 데이터가 있다면 update
        addressViewModel.updateAddressData();
      }
    });
    super.initState();
  }
```
  
</details>

## 회고 / 느낀 점

