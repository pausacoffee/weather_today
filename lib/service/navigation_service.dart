import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> naviKey = GlobalKey<NavigatorState>();

  Future<dynamic> toNamed(String routeName) {
    return naviKey.currentState!.pushNamed(routeName);
  }

  void back() {
    naviKey.currentState!.pop();
  }
}
