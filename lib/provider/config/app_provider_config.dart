import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../routes/app_router.dart';
import '../../routes/app_service.dart';
import '../view_model/home_view_model.dart';

class AppProviderConfig {
  AppProviderConfig._();

  static List<SingleChildWidget> providers() {
    return [
      ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel()),
      ChangeNotifierProvider<AppService>(create: (_) => AppService()),
      Provider<AppRouter>(create: (_) => AppRouter()),
      //Provider<PermissionService>(create: (_) => PermissionService()),
    ];
  }
}
