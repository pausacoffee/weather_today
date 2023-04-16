import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../routes/app_router.dart';
import '../../routes/app_service.dart';
import '../../page/address/model/address_view_model.dart';
import '../../page/home/model/home_view_model.dart';

class AppProviderConfig {
  AppProviderConfig._();

  static List<SingleChildWidget> providers() {
    return [
      ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel()),
      ChangeNotifierProvider<AddressViewModel>(
          create: (context) => AddressViewModel()),
      ChangeNotifierProvider<AppService>(create: (_) => AppService()),
      Provider<AppRouter>(create: (_) => AppRouter()),
    ];
  }
}
