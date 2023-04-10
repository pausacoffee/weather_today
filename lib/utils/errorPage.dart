import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../global/global_appbar.dart';
import 'color.dart';
import 'text.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(
        "에러 발생",
        isBack: true,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            Container(
              alignment: Alignment.center,
              child: Icon(
                Icons.info_outline_rounded,
                size: 100,
                color: ColorPath.textDisableColor1,
              ),
            ),
            SizedBox(height: 20.w),
            Text("404 오류",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorPath.textDisableColor1,
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            Text(
              "유저분에게 불편을 드려 죄송합니다.\n 서버에서 요청하신 페이지를 찾을 수 없습니다",
              textAlign: TextAlign.center,
              style: TextStylePath.base16w600.copyWith(
                color: ColorPath.textDisableColor1,
                height: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
