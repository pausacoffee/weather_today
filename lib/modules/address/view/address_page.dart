import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import '../../../utils/locale_util.dart';
import '../../../utils/text.dart';
import '../widgets/address_search_widget.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          //keyboard 내리기
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: _appBar(context),
          body: _body(),
        ),
      ),
    );
  }
}

/// body
Widget _body() {
  return const AddressSearchWidget();
}

///appbar
AppBar _appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    title: Text(
      translation(context).favorite_location,
      style: TextStylePath.title18w800,
    ),
    centerTitle: true,
    actions: [
      IconButton(
        onPressed: () {
          //TODO: 현재 위치 가져오기
        },
        icon: const Icon(
          Icons.location_searching_rounded,
        ),
      )
    ],
  );
}

Future<void> getLocation() async {
  Position? position = await Geolocator.getLastKnownPosition();
}
