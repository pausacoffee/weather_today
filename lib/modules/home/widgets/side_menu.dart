import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../service/condition_service.dart';
import '../../../utils/text.dart';
import '../model/home_view_model.dart';

/// Drawer
/// TODO: C <-> F 기온 바꾸기
class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    HomeViewModel data = Provider.of<HomeViewModel>(context);

    return Drawer(
      //backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.amber,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Image.asset(
                    ConditionService()
                        .iconPath(data.currentData.condition.code),
                    width: 60.w,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  '오늘의 날씨',
                  style:
                      TextStylePath.title24w800.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
