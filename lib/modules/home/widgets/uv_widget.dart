import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_today/utils/locale_util.dart';

import '../../../utils/text.dart';
import '../../../utils/utils.dart';
import '../model/home_view_model.dart';

/// 자외선 지수 카드
class UvWidget extends StatelessWidget {
  const UvWidget({super.key});

  //final HomeViewModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
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
      child: Builder(builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              translation(_).uv_index,
              style: TextStylePath.small14w600,
            ),
            Divider(
              height: 15.h,
              color: Colors.white60,
            ),
            _uvToday(context),
          ],
        );
      }),
    );
  }

  ///자외선 지수 Tile : icon, level, 안내 문구
  Widget _uvToday(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (_, data, __) {
        return Expanded(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: 5.h,
              bottom: 5.h,
            ),
            width: double.infinity,
            child: ListTile(
              onTap: () async {
                _showBottomSheet(context);
              },
              leading: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: getUvColor(data.currentData.uv),
                    size: 50.sp,
                  ),
                ],
              ),
              title: Text(
                getUvLevel(data.currentData.uv, _),
                style: TextStylePath.base16w600
                    .copyWith(color: getUvColor(data.currentData.uv)),
              ),
              subtitle: Text(
                getUvMsg(data.currentData.uv, _),
                style: TextStylePath.small12w400,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              isThreeLine: true,
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// show Bottom Sheet
  Future _showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      enableDrag: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            right: 20.w,
            left: 20.w,
          ),
          height: 340.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _sheetHandle(),
              _sheetTitle(),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          _sheetItem(2.0),
                          _sheetItem(5.0),
                          _sheetItem(7.0),
                          _sheetItem(10.0),
                          _sheetItem(11.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sheetTitle() {
    return Consumer<HomeViewModel>(
      builder: (_, data, __) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              translation(_).uv_current_index,
              style: TextStylePath.title18w600,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              getUvLevel(data.currentData.uv, _),
              style: TextStylePath.title18w600.copyWith(
                color: getUvColor(data.currentData.uv),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _sheetItem(double uv) {
    return Builder(builder: (context) {
      return Container(
        margin: EdgeInsets.only(
          top: 2.h,
          bottom: 2.h,
        ),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: getUvColor(uv),
              width: 2.w,
            ),
          ),
        ),
        child: ExpansionTile(
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          title: Text(
            getUvLevel(uv, context),
            style: TextStylePath.base16w600.copyWith(
              color: getUvColor(uv),
            ),
          ),
          children: <Widget>[
            ListTile(
              title:
                  Text(getUvMsg(uv, context), style: TextStylePath.small12w400),
            ),
          ],
        ),
      );
    });
  }

  //Bottom Sheet의 귀여운 핸들바
  Widget _sheetHandle() {
    return SizedBox(
      height: 32.h,
      child: Center(
        child: Container(
          height: 1.h,
          width: 28.w,
          decoration: const BoxDecoration(
              color: Color(0xFF979797),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
        ),
      ),
    );
  }
}
