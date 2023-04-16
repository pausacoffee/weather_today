import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../routes/app_service.dart';
import '../../utils/text.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AppService _appService;

  /// 현재 시간
  DateTime currentDateTime = DateTime.now();

  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    onStartUp();

    super.initState();
  }

  ///appService init을 시작하고 완료되면  redirect됨.
  void onStartUp() async {
    await _appService.onAppStart();
  }

  @override
  Widget build(BuildContext context) {
    Widget title = Text(
      '오늘의 날씨',
      textAlign: TextAlign.center,
      style: TextStylePath.title56w800.copyWith(
        letterSpacing: -5,
      ),
    );

    title = title
        .animate() //onPlay: (controller) => controller.repeat(reverse: true)
        .fadeIn(curve: Curves.easeIn, duration: 2.seconds)
        .saturate(duration: 2.seconds)
        .then() // set baseline time to previous effect's end time
        .tint(color: Colors.black);

    // .then()
    // .fadeOut(curve: Curves.easeOut);

    return WillPopScope(
      onWillPop: () => handlePrevBack(context),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.amber,
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: Animate(
                    effects: [
                      FadeEffect(
                        duration: 3.seconds,
                        curve: Curves.fastOutSlowIn,
                        begin: 0.0,
                        end: 1.0,
                      )
                    ],
                    child: Lottie.asset('assets/splash-image.json',
                        fit: BoxFit.contain), //@syeda_maimoona
                  ),
                ),
                Expanded(child: title),
              ],
              //),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> handlePrevBack(BuildContext context) async {
    // 메인 화면에서 뒤로가기 막기
    final DateTime now = DateTime.now();

    if (now.difference(currentDateTime) > const Duration(milliseconds: 1000)) {
      currentDateTime = now;
      Fluttertoast.showToast(
        msg: '한번 더 누르면 앱이 종료됩니다',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black.withOpacity(0.7),
        textColor: Colors.white,
      );
    } else {
      exit(0);
    }

    return false;
  }
}
