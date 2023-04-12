import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_today/models/weather_location.dart';

class SingleWeatherWidget extends StatelessWidget {
  const SingleWeatherWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _backgroundImg(),
        Container(
          decoration: const BoxDecoration(color: Colors.black38),
        ),
        //_dotIndicator(),
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
              const Divider(
                height: 30,
                color: Colors.white,
              ),
              _bottomInfo(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _locationWithDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locationList[index].city,
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
          locationList[index].dateTime,
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
          locationList[index].temparature,
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
              locationList[index].weatherType,
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
            value: locationList[index].wind.toString()),
        SizedBox(
          width: 10.w,
        ),
        _bottomInfoItem(
            type: 'Rain',
            unit: '%',
            value: locationList[index].rain.toString()),
        SizedBox(
          width: 10.w,
        ),
        _bottomInfoItem(
            type: 'Humidy',
            unit: '%',
            value: locationList[index].humidity.toString()),
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

  Widget _backgroundImg() {
    return Image.asset(
      locationList[index].bgImg,
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      gaplessPlayback: true,
    );
  }
}
