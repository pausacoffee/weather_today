import 'dart:io';

//import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_today/utils/text.dart';

import '../../../provider/view_model/home_view_model.dart';
import '../../../routes/app_page.dart';
import '../widgets/single_weather_widget.dart';

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
        extendBodyBehindAppBar: true,
        appBar: _appBar(),
        body: homeViewModel.isLoding ? _loadingView() : _body(),
      ),
    );
  }

  /// body
  Widget _body() {
    return !Platform.isIOS
        ? RefreshIndicator(
            onRefresh: () async =>
                //await Future.delayed(const Duration(seconds: 1)),
                await homeViewModel.fetchViewModel(),
            child: _contents(),
          )
        : _contents();
  }

  /// 날씨 데이터에 의해 갱신되는 widget
  Widget _contents() {
    return CustomScrollView(
      slivers: [
        if (Platform.isIOS)
          CupertinoSliverRefreshControl(
              onRefresh: () async =>
                  await Future.delayed(const Duration(seconds: 1))),
        SliverToBoxAdapter(
          child: Text(homeViewModel.locationData.country), //TODO: 위치 바꾸기 기능 구현
        ),
        SliverToBoxAdapter(
          child: SingleWeatherWidget(
            data: homeViewModel,
          ),
        ),
      ],
    );
  }

  /// appbar
  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.black,
          size: 30.sp,
        ),
        onPressed: () {}, //TODO:메뉴 - drawer
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
            size: 30.sp,
            color: Colors.black,
          ),
          onPressed: () {
            context.pushNamed(APP_PAGE.geo.toName);
          },
        ),
      ], //TODO: 검색
    );
  }

  //data가 fetch 되기 전 화면
  Widget _loadingView() {
    //TODO: shimmer
    return const Center(child: Text('로딩 중'));
  }

  // Override ▼ ========================================
  @override
  void initState() {
    Provider.of<HomeViewModel>(context, listen: false).fetchViewModel();

    super.initState();
  }
}
