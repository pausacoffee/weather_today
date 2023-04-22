import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/locale_util.dart';
import '../../../utils/text.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: _appBar(context),
        body: _body(),
      ),
    );
  }
}

/// body
Widget _body() {
  return Builder(builder: (_) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        ListTile(
          title: Text(translation(_).scale),
        ), //단위
        ListTile(
          title: Text(translation(_).arlarm),
        ), //알림
        ListTile(
          title: Text(translation(_).display),
        ),
        ListTile(
          title: Text(translation(_).review_app),
        ), //응원하기
        ListTile(
          title: Text(translation(_).improvements),
        ), //개선사항 보내기
        ListTile(
          title: Text(translation(_).share_app),
        ), //친구에게 앱 공유하기

        ListTile(
          title: Text(translation(_).version),
        ), //버전
      ],
    );
  });
}

///appbar
AppBar _appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    title: Text(
      translation(context).setting,
      style: TextStylePath.title18w800,
    ),
    centerTitle: true,
  );
}
