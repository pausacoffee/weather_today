import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../models/weather_location.dart';
import '../../../routes/app_page.dart';
import '../widgets/single_weather_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Center(
            child: Text('Weather App'),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.search, size: 30, color: Colors.white),
            onPressed: () {}, //TODO: 검색
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: 30.sp,
              ),
              onPressed: () {
                context.pushNamed(APP_PAGE.geo.toName);
              }, //TODO:메뉴
            ),
          ],
        ),
        body: SizedBox(
          child: PageView.builder(
            controller: PageController(),
            scrollDirection: Axis.horizontal,
            padEnds: false, //좌우 여백(paading) 제거
            itemCount: locationList.length,
            itemBuilder: (BuildContext context, int index) {
              return SingleWeatherWidget(index: index);
            },
            onPageChanged: null,
          ),
        ),
      ),
    );
  }

//TODO::SmoothPageIndicator
  Widget _dotIndicator() {
    return Container(
      margin: EdgeInsets.only(top: 90, left: 15),
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 5.h,
            decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.all(Radius.circular(5.r))),
          )
        ],
      ),
    );
  }
}
