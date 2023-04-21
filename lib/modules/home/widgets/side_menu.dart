import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../config/app_config.dart';
import '../../../global/global_toggle_switch.dart';
import '../../../service/condition_service.dart';
import '../../../utils/locale_util.dart';
import '../../../utils/text.dart';
import '../model/home_view_model.dart';

/// Drawer
class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (_, data, __) {
        return data.isLoading
            ? const Drawer()
            : Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(8),
                        ),
                      ),
                      child: DrawerHeader(
                        margin: EdgeInsets.zero,
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
                              translation(_).app_title,
                              style: TextStylePath.title24w800,
                            ),
                          ],
                        ),
                      ),
                    ),
                    _switchScale(),
                    ListTile(
                      title: Text(data.currenTempScale()),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Item 2'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
      },
    );
  }

  Widget _switchScale() {
    return Consumer<HomeViewModel>(
      builder: (_, data, __) {
        return ListTile(
          leading: Text(
            translation(_).temperate_scale,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          title: Container(
            padding: EdgeInsets.only(
              left: 30.w,
              right: 30.w,
            ),
            child: GlobalToggleSwitch(
              current: AppConfig().temperatureScale,
              first: false,
              second: true,
              firstString: '°F',
              secondString: '°C',
              onChanged: (value) {
                data.setScale(value);
              },
              height: 40.h,
            ),
          ),
        );
      },
    );
  }
}
