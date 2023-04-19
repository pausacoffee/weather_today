import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_today/models/weather/hour_model.dart';

import '../../../global/global_button.dart';
import '../../../models/weather/wind_degree_indicator.dart';
import '../../../service/condition_service.dart';
import '../../../utils/color.dart';
import '../../../utils/text.dart';
import '../../../utils/utils.dart';
import '../model/home_view_model.dart';
import 'filled_icon.dart';

// ignore: must_be_immutable
class WeatherPerHourWidget extends StatelessWidget {
  WeatherPerHourWidget({super.key, required this.data});

  /// homw page 업데이트 data
  final HomeViewModel data;

  /// forcastlist - hourlist를 일렬화 시킨 list
  late List<HourModel> hourList;

  @override
  Widget build(BuildContext context) {
    hourList = data.forcastList.expand((element) => element.hour).toList();

    return Container(
      height: 220.h,
      width: 320.w,
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.only(
        top: 5.h,
        bottom: 5.h,
        right: 20.w,
        left: 20.w,
      ),
      padding: EdgeInsets.only(
        top: 5.h,
        bottom: 5.h,
        right: 20.w,
        left: 20.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: Colors.black12,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1.r,
            blurRadius: 1.r,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: _tab(),
    );
  }

  Widget _tab() {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Column(
        children: [
          TabBar(
            tabs: forcastTabs,
            dividerColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            //indicatorWeight: 3.h,
          ),
          Divider(
            height: 0.h,
            color: Colors.white60,
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _conditionView(),
                _windView(),
                _humidityView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///날씨 탭 뷰
  Widget _conditionView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: hourList.length,
      itemBuilder: (context, index) {
        return _conditionItem(index);
      },
    );
  }

  /// 날씨 item
  Widget _conditionItem(int index) {
    return SizedBox(
      width: 56.w,
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            formatWeatherTime(hourList[index].time),
            style: TextStylePath.small12w600.copyWith(color: Colors.white),
          ),
          SizedBox(
            height: 10.h,
          ),
          Image.asset(
            ConditionService().iconPath(
                code: hourList[index].condition.code,
                isDay: hourList[index].isDay),
          ),
          SizedBox(
            height: 8.h,
          ),
          _temperature(index),
          SizedBox(
            height: 8.w,
          ),
          _chanceRain(index),
        ],
      ),
    );
  }

  Widget _temperature(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic, //baseline사용시 필!
      children: [
        Text(
          '${hourList[index].tempC}', //TODO: c <-> f
          style: TextStylePath.small12w300.copyWith(color: Colors.white),
        ),
        SizedBox(
          width: 2.w,
        ),
        Text(
          '\u2103', //TODO: c <-> f
          style: TextStylePath.small12w300.copyWith(color: Colors.white),
        ),
      ],
    );
  }

  Widget _chanceRain(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic, //baseline사용시 필!
      children: [
        Icon(
          Icons.umbrella_outlined,
          size: 10.sp,
          color: Colors.white,
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          '${hourList[index].chanceOfRain}',
          style: TextStylePath.small12w300.copyWith(color: Colors.white),
        ),
        SizedBox(
          width: 2.w,
        ),
        Text(
          '%',
          style: TextStylePath.small12w300.copyWith(color: Colors.white),
        ),
      ],
    );
  }

  /// 바람 탭 뷰
  Widget _windView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: hourList.length,
      itemBuilder: (context, index) {
        return _windItem(index);
      },
    );
  }

  /// 바람 item
  Widget _windItem(int index) {
    return SizedBox(
      width: 56.w,
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            formatWeatherTime(hourList[index].time),
            style: TextStylePath.small12w600.copyWith(color: Colors.white),
          ),
          SizedBox(
            height: 10.h,
          ),
          WindDirectionIndicator(
            windDegree: hourList[index].windDegree,
          ),

          SizedBox(
            height: 8.h,
          ),
          Text(
            convertWindDirection(hourList[index].windDir), //TODO: c <-> f
            style: TextStylePath.small12w300.copyWith(color: Colors.white),
          ),
          SizedBox(
            height: 8.w,
          ),
          _windSpeed(index), //속도
        ],
      ),
    );
  }

  Widget _windSpeed(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic, //baseline사용시 필!
      children: [
        Text(
          '${hourList[index].windKph}', //TODO: kph <-> mph
          style: TextStylePath.small12w300.copyWith(color: Colors.white),
        ),
        SizedBox(
          width: 2.w,
        ),
        Text(
          'km/h', //TODO: c <-> f
          style: TextStylePath.small8w300.copyWith(color: Colors.white),
        ),
      ],
    );
  }

  /// 습도 탭뷰
  Widget _humidityView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: hourList.length,
      itemBuilder: (context, index) {
        return _humidityItem(index);
      },
    );
  }

  Widget _humidityItem(int index) {
    return SizedBox(
      width: 56.w,
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            formatWeatherTime(hourList[index].time),
            style: TextStylePath.small12w600.copyWith(color: Colors.white),
          ),
          SizedBox(
            height: 10.h,
          ),
          FilledIcon(
            color: Colors.white,
            icon: Icons.water_drop_sharp,
            size: 32.sp,
            value: hourList[index].humidity,
          ),
          SizedBox(
            height: 8.h,
          ),
          _humidityPer(index),
          SizedBox(
            height: 8.w,
          ),
        ],
      ),
    );
  }

  Widget _humidityPer(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic, //baseline사용시 필!
      children: [
        Text(
          '${hourList[index].humidity}',
          style: TextStylePath.small12w300.copyWith(color: Colors.white),
        ),
        SizedBox(
          width: 2.w,
        ),
        Text(
          '%',
          style: TextStylePath.small12w300.copyWith(color: Colors.white),
        ),
      ],
    );
  }

// Variable ▼ ========================================
  final List<Tab> forcastTabs = <Tab>[
    Tab(
      child: Text(
        '날씨',
        style: TextStylePath.small14w600.copyWith(color: Colors.white),
      ),
    ),
    Tab(
      child: Text(
        '바람',
        style: TextStylePath.small14w600.copyWith(color: Colors.white),
      ),
    ),
    Tab(
      child: Text(
        '습도',
        style: TextStylePath.small14w600.copyWith(color: Colors.white),
      ),
    ),
  ];
}
