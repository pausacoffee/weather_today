import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_today/utils/text.dart';

import 'color.dart';

class APPINPUTDECORATION {
  static InputDecoration base(String hintText,
          {Widget? suffix, Widget? suffixIcon}) =>
      InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 10.w,
          horizontal: 14.w,
        ),
        isCollapsed: true,
        suffix: suffix ?? null,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffDCD7C9),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4.r),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffDCD7C9),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorPath.textDisableColor3,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4.r),
        ),
        hintText: hintText,
        hintStyle: TextStylePath.small14w400
            .copyWith(color: ColorPath.textDisableColor3),
      );
}