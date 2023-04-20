import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
                    ConditionService().iconPath(
                        code: data.currentData.condition.code,
                        isDay: data.currentData.isDay),
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
          _switchScale(),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _switchScale() {
    return ToggleSwitch(
      minWidth: 90.0,
      minHeight: 70.0,
      initialLabelIndex: 2,
      cornerRadius: 20.0,
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.white,
      iconSize: 30.0,
      borderWidth: 2.0,
      borderColor: const [Colors.blueGrey],
      totalSwitches: 2,
      labels: ['°F', '°C'],
      activeBgColors: [
        [Colors.blue],
        [Colors.pink],
      ],
      onToggle: (index) {
        print('switched to: $index');
      },
    );
  }
}
