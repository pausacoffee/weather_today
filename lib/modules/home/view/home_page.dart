import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../global/global_skeleton_loader.dart';
import '../../../service/theme_service.dart';
import '../../../utils/text.dart';
import '../model/home_view_model.dart';
import '../../../routes/app_page.dart';
import '../widgets/weather_per_hour_widget.dart';
import '../widgets/side_menu.dart';
import '../widgets/current_weather_widget.dart';
import '../widgets/uv_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) {
    homeViewModel = Provider.of<HomeViewModel>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        drawer: const SideMenu(),
        body: homeViewModel.isLoading ? _loadingView() : _body(),
      ),
    );
  }

  /// body
  Widget _body() {
    return !Platform.isIOS
        ? RefreshIndicator(
            onRefresh: () async => await homeViewModel.fetchViewModel(),
            child: _contents(),
          )
        : _contents();
  }

  /// 날씨 데이터에 의해 갱신되는 widget
  Widget _contents() {
    return Stack(children: [
      //_backgroundImg(),
      CustomScrollView(
        slivers: [
          if (Platform.isIOS)
            CupertinoSliverRefreshControl(
                onRefresh: () async => await homeViewModel.fetchViewModel()),
          _appBar(),
          const SliverToBoxAdapter(
            child: CurrentWeatherWidget(),
          ),
          const SliverToBoxAdapter(
            child: UvWidget(),
          ),
          SliverToBoxAdapter(
            child: WeatherPerHourWidget(),
          ),
          SliverToBoxAdapter(
            child: _copyright(),
          ),
        ],
      ),
    ]);
  }

  ///Home Page의 배경화면 이미지
  Widget _backgroundImg() {
    return Container(
      color: Colors.amber,
    );
  }

  //appbar
  Widget _appBar() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero, //vertical center
            centerTitle: true,
            title: DropdownButton(
              dropdownColor: Colors.black,
              borderRadius: BorderRadius.circular(25.r),
              underline: const SizedBox(),
              elevation: 0,
              value: homeViewModel.userLocation,
              items: homeViewModel.userLocationList.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style:
                        TextStylePath.title18w800.copyWith(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (String? item) {
                if (item! == '+') {
                  context.pushNamed(APP_PAGE.address.toName);
                  return;
                }
                setState(() {
                  homeViewModel.userLocation = item;
                });
              },
              iconSize: 24.sp,
              iconEnabledColor: Colors.white,
            ),
          ),
        ),
      ),
      leading: Builder(builder: (context) {
        return IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: 30.sp,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      }),
      actions: [
        Consumer<ThemeService>(
          builder: (_, themeNotifier, __) {
            return IconButton(
              icon: themeNotifier.themeMode == ThemeMode.light
                  ? Icon(
                      Icons.light_mode_rounded,
                      size: 30.sp,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.dark_mode_rounded,
                      size: 30.sp,
                      color: Colors.white,
                    ),
              onPressed: () {
                if (themeNotifier.themeMode == ThemeMode.light) {
                  themeNotifier.themeMode = ThemeMode.dark;
                } else {
                  themeNotifier.themeMode = ThemeMode.light;
                }
              },
            );
          },
        ),
      ],
      pinned: true,
      centerTitle: true,
    );
  }

  //data가 fetch 되기 전 화면
  Widget _loadingView() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          //appbar
          SizedBox(
            height: 50.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                  onPressed: () {},
                ),
                const Spacer(),
                GlobalSkeletonLoader(
                  height: 30.h,
                  width: 150.w,
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 30.sp,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          //current weather card
          GlobalSkeletonLoader(
            height: 420.h,
            width: 320.w,
            radius: 25.r,
          ),
        ],
      ),
    );
  }

  Widget _copyright() {
    return Container(
      padding: EdgeInsets.only(
        top: 10.h,
        bottom: 10.h,
        right: 60.w,
        left: 60.w,
      ),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '오늘의 날씨',
            style: TextStylePath.base16w600.copyWith(color: Colors.white70),
            softWrap: true,
          ),
          Text(
            '데이터 권한 : Copyright © Weather API',
            style: TextStylePath.small12w300.copyWith(color: Colors.white54),
            softWrap: true,
          ),
          Text(
            '이 자료는 인증받지 않은 자료로 표출방식에 따라 차이가 있을 수 있습니다.',
            style: TextStylePath.small12w300.copyWith(color: Colors.white54),
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        ],
      ),
    );
  }

  // Override ▼ ========================================
  @override
  void initState() {
    Provider.of<HomeViewModel>(context, listen: false).initialize();

    super.initState();
  }
}
