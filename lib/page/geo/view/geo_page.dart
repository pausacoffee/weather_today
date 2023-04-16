import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class GeoPage extends StatelessWidget {
  const GeoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[200],
        appBar: AppBar(
          elevation: 0,
          title: const Center(
            child: Text('Geo'),
          ),
          backgroundColor: Colors.transparent,
          // leading: IconButton(
          //   icon:
          //       const Icon(Icons.arrow_back_ios, size: 30, color: Colors.white),
          //   onPressed: () {
          //     context.pop();
          //   }, //TODO: 검색
          // ),
        ),
        body: Center(
          child: Container(
            child: TextButton(
              onPressed: () {
                getLocation();
              },
              child: Text('print'),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> getLocation() async {
  Position? position = await Geolocator.getLastKnownPosition();
}
