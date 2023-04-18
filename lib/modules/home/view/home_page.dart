import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_today/utils/text.dart';

import '../../../global/global_skeleton_loader.dart';
import '../model/home_view_model.dart';
import '../../../routes/app_page.dart';
import '../widgets/side_menu.dart';
import '../widgets/single_weather_widget.dart';
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
        drawer: homeViewModel.isLoading ? null : const SideMenu(),
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
      _backgroundImg(),
      CustomScrollView(
        slivers: [
          if (Platform.isIOS)
            CupertinoSliverRefreshControl(
                onRefresh: () async => await homeViewModel.fetchViewModel()),
          _appBar(),
          SliverToBoxAdapter(
            child: SingleWeatherWidget(
              data: homeViewModel,
            ),
          ),
          SliverToBoxAdapter(
            child: UvWidget(
              data: homeViewModel,
            ),
          )
        ],
      ),
    ]);
  }

  Widget _backgroundImg() {
    return Container(
      color: Colors.amber,
    );
  }

  //appbar
  Widget _appBar() {
    return SliverToBoxAdapter(
      child: Container(
        height: 50.h,
        width: double.infinity,
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Builder(builder: (context) {
              return IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30.sp,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                }, //TODO:메뉴 - drawer
              );
            }),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(25.r)),
              child: DropdownButton(
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
                      style: TextStylePath.title18w800
                          .copyWith(color: Colors.white),
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
            const Spacer(),
            IconButton(
              icon: Icon(
                Icons.search,
                size: 30.sp,
                color: Colors.white,
              ),
              onPressed: () {
                context
                    .pushNamed(APP_PAGE.address.toName)
                    .then((value) => homeViewModel.fetchViewModel());
              },
            ),
          ],
        ),
      ),
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

  // Override ▼ ========================================
  @override
  void initState() {
    Provider.of<HomeViewModel>(context, listen: false).initialize();

    super.initState();
  }
}
