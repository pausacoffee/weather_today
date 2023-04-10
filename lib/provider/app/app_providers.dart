import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../routes/app_router.dart';
import '../../service/app_service.dart';
import '../home/home_provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  AppProviders._();

  // static final List<SingleChildWidget> providers = [
  //   ChangeNotifierProvider<AppService>(create: (_) => appService),
  //   Provider<AppRouter>(create: (_) => AppRouter(appService)),
  //   ChangeNotifierProvider(create: (BuildContext context) => HomeProvider()),
  // ];
}
