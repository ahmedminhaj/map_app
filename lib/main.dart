import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map/screen/home_screen.dart';
import 'package:google_map/screen/map_screen.dart';
import 'package:provider/provider.dart';

import 'service/location_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (context) => LocationService().getLocation,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
