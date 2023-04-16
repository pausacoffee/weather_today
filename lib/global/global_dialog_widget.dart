import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../service/permission_service.dart';

class GlobalPermissionDialog extends StatelessWidget {
  const GlobalPermissionDialog({Key? key, required this.controller})
      : super(key: key);
  final PermissionService controller;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: WillPopScope(
        onWillPop: () => Future(() => false),
        child: CupertinoAlertDialog(
          title: const Text('권한을 허용해주세요'),
          content: Column(
            children: [
              SizedBox(height: 10.h),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "접근 권한이 없어 해당 기능을 사용할 수 없습니다. ${dotenv.env["APP_KO_NAME"]}을 원활하게 이용하기 위해서 권한을 허용해주세요",
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(
                    8.r,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        '허용이 필요한 항목',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '위치기반',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(width: 21.w),
                        Text(
                          controller.isLocationPermissionsGranted
                              ? '허용'
                              : '비허용',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                '취소',
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
              onPressed: () {},
              //TODO: controller.handlePermissionDialogCancelOnPressed(),
            ),
            CupertinoDialogAction(
              child: const Text('설정'),
              onPressed:
                  () {}, //TODO: controller.handlePermissionReOnPressed(),
            ),
          ],
        ),
      ),
    );
  }
}
