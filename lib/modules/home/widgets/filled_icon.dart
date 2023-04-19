///ShaderMask 기억!

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilledIcon extends StatelessWidget {
  const FilledIcon(
      {super.key,
      required this.icon,
      this.size,
      required this.color,
      required this.value});

  final IconData icon;
  final double? size;
  final Color color;
  final int value; //0~100

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white70,
              Colors.white70,
              Colors.lightBlue,
            ],
            stops: [
              0,
              1 - (value / 100),
              0
            ]),
      ),
      child: Icon(
        icon,
        size: size ?? 28.sp,
        color: Colors.white,
      ),
    );
  }
}
