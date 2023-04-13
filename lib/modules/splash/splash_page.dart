import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../service/app_service.dart';
import '../../utils/text.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AppService _appService;

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
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .saturate(duration: 1.seconds)
        .then() // set baseline time to previous effect's end time
        .tint(color: Colors.black)
        .then()
        .fadeOut(curve: Curves.easeOut);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber,
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: Lottie.network(
                    'https://assets10.lottiefiles.com/packages/lf20_3xfpxnp9.json',
                    fit: BoxFit.contain),
              ),
              Expanded(child: title),
            ],
            //),
          ),
        ),
      ),
    );
  }
}
