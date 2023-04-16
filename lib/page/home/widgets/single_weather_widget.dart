import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../provider/view_model/home_view_model.dart';

class SingleWeatherWidget extends StatelessWidget {
  const SingleWeatherWidget({super.key, required this.data});

  final HomeViewModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420.h,
      width: 320.w,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.black12,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1.r,
            blurRadius: 1,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.black38),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80.h,
                ),
                _locationWithDate(),
                const Spacer(),
                _temperatureWithDay(),
                Divider(
                  height: 30.h,
                  color: Colors.white,
                ),
                _bottomInfo(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationWithDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.locationData!.name,
          style: GoogleFonts.lato(
            fontSize: 35.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          data.locationData!.localtime,
          style: GoogleFonts.lato(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _temperatureWithDay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${data.currentData!.tempC}\u2103', //TODO: c <-> f
          style: GoogleFonts.lato(
            fontSize: 85.sp,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.nightlight_outlined,
              color: Colors.white,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              data.currentData!.condition.text,
              style: GoogleFonts.lato(
                fontSize: 15.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _bottomInfo() {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceBetween,
      children: [
        _bottomInfoItem(
            type: 'Wind',
            unit: 'km/h',
            value: '${data.currentData!.windKph}'), //TODO: KmH <-> Mph
        SizedBox(
          width: 10.w,
        ),
        _bottomInfoItem(
            type: 'Rain',
            unit: 'mm',
            value: '${data.currentData!.precipMm}'), //TODO: mm <-> inch
        SizedBox(
          width: 10.w,
        ),
        _bottomInfoItem(
            type: 'Humidy', unit: '%', value: '${data.currentData!.humidity}'),
      ],
    );
  }

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
