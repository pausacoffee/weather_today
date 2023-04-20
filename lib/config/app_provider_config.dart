import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../routes/app_router.dart';
import '../service/app_service.dart';
import '../modules/address/model/address_view_model.dart';
import '../modules/home/model/home_view_model.dart';
import '../service/theme_service.dart';

class AppProviderConfig {
  AppProviderConfig._();

  static List<SingleChildWidget> providers() {
    return [
      ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel()),
      ChangeNotifierProvider<AddressViewModel>(
          create: (context) => AddressViewModel()),
      ChangeNotifierProvider<AppService>(create: (_) => AppService()),
      ChangeNotifierProvider<ThemeService>(create: (context) => ThemeService()),
      Provider<AppRouter>(create: (_) => AppRouter()),
    ];
  }
}
