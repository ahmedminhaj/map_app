import 'dart:async';

import 'package:get/get.dart';
import 'package:google_map/model/location_model.dart';
import 'package:geolocator/geolocator.dart' as geo;

class LocationController extends GetxController{
  final location = Location().obs;

  geo.Position currentLocation;
  var time = 15;

  Future<geo.Position> getCurrentLocation() async {
    geo.Position position = await geo.Geolocator()
        .getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);
    return position;
  }

  fetchLocation() {
    findLocation();
    var timer = Duration(seconds: time);
    Timer.periodic(timer, (t) {
      findLocation();
    });
  }
  
  findLocation() async{
    currentLocation = await getCurrentLocation();
    updateLocation();
  }

  updateLocation(){
    location.update((value) {
      value.latitude = currentLocation.latitude;
      value.longitude = currentLocation.longitude;
     });
  }
}