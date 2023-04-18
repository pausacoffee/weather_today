import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../service/condition_service.dart';
import '../model/home_view_model.dart';

class SingleWeatherWidget extends StatelessWidget {
  const SingleWeatherWidget({super.key, required this.data});

  final HomeViewModel data;

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
                color: Colors.white,
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
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            data.locationData.name,
            style: GoogleFonts.lato(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            data.locationData.localtime,
            style: GoogleFonts.lato(
              fontSize: 5.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          ConditionService().iconPath(data.currentData.condition.code),
          //width: 120.w,
        ),
        SizedBox(
          width: 10.h,
        ),
        Text(
          ConditionService().dayText(data.currentData.condition.code),
          style: GoogleFonts.lato(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _temperature() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic, //baseline사용시 필!
      children: [
        Text(
          '${data.currentData.tempC}', //TODO: c <-> f
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
          '\u2103', //TODO: c <-> f
          style: GoogleFonts.lato(
            fontSize: 16.sp,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  ///하단부
  Widget _bottomInfo() {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceBetween,
      children: [
        _bottomInfoItem(
            type: 'Wind',
            unit: 'km/h',
            value: '${data.currentData.windKph}'), //TODO: KmH <-> Mph
        SizedBox(
          width: 10.w,
        ),
        _bottomInfoItem(
            type: 'Rain',
            unit: 'mm',
            value: '${data.currentData.precipMm}'), //TODO: mm <-> inch
        SizedBox(
          width: 10.w,
        ),
        _bottomInfoItem(
            type: 'Humidy', unit: '%', value: '${data.currentData.humidity}'),
      ],
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
