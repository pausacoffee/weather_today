import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

import '../../routes/app_page.dart';
import '../../service/app_service.dart';

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

  void onStartUp() async {
    await _appService.onAppStart();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Lottie.network(
              'https://assets10.lottiefiles.com/packages/lf20_3xfpxnp9.json'),
        ),
      ),
    );
  }
}
