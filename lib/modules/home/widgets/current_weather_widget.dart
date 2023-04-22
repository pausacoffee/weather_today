import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../repositories/code/condition_service.dart';
import '../../../utils/locale_util.dart';
import '../model/home_view_model.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      width: 320.w,
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.only(
        top: 5.h,
        bottom: 5.h,
        right: 20.w,
        left: 20.w,
      ),
      padding: const EdgeInsets.all(20),
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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _locationWithDate(),
              const Spacer(),
              _temperatureWithCondition(),
              const Spacer(),
              Divider(
                height: 30.h,
                color: Colors.white60,
              ),
              _bottomInfo(),
            ],
          ),
        ],
      ),
    );
  }

  ///위치와 시간정보
  Widget _locationWithDate() {
    return Consumer<HomeViewModel>(
      builder: (_, data, __) => SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              data.locationData.name,
              style: GoogleFonts.lato(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              data.locationData.localtime,
              style: GoogleFonts.lato(
                fontSize: 8.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 온도와 icon, condiTion 정보
  Widget _temperatureWithCondition() {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _iconCondition(),
        _temperature(),
      ],
    );
  }

  /// icon과 컨디션
  Widget _iconCondition() {
    return Consumer<HomeViewModel>(
      builder: (_, data, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ConditionRepository().iconPath(
                  code: data.currentData.condition.code,
                  isDay: data.currentData.isDay),
              //width: 120.w,
            ),
            SizedBox(
              width: 10.h,
            ),
            Text(
              ConditionRepository().text(
                  code: data.currentData.condition.code,
                  isDay: data.currentData.isDay),
              style: GoogleFonts.lato(
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _temperature() {
    return Consumer<HomeViewModel>(
      builder: (_, data, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic, //baseline사용시 필!
          children: [
            Text(
              data.currenTemp(),
              style: GoogleFonts.lato(
                fontSize: 60.sp,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              data.getTempScale(),
              style: GoogleFonts.lato(
                fontSize: 16.sp,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  ///하단부
  Widget _bottomInfo() {
    return Consumer<HomeViewModel>(
      builder: (_, data, __) {
        return ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            _bottomInfoItem(
                type: translation(_).wind,
                unit: 'km/h',
                value: '${data.currentData.windKph}'), //TODO: KmH <-> Mph
            SizedBox(
              width: 10.w,
            ),
            _bottomInfoItem(
                type: translation(_).rain,
                unit: 'mm',
                value: '${data.currentData.precipMm}'), //TODO: mm <-> inch
            SizedBox(
              width: 10.w,
            ),
            _bottomInfoItem(
                type: translation(_).humidy,
                unit: '%',
                value: '${data.currentData.humidity}'),
          ],
        );
      },
    );
  }

  /// 하단의 정보 item
  Widget _bottomInfoItem(
      {required String type, required String value, required String unit}) {
    return Column(
      children: [
        Text(
          type,
          style: GoogleFonts.lato(
            fontSize: 14.sp,
            color: Colors.white,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.lato(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          unit,
          style: GoogleFonts.lato(
            fontSize: 14.sp,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
