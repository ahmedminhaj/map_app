import 'dart:async';

import 'package:geolocator/geolocator.dart' as geo;

class LocationService {
  var timer = Duration(seconds: 2);
  geo.Position currentLocation;
  StreamController<geo.Position> _locationController =
      StreamController<geo.Position>();

  Stream<geo.Position> get getLocation => _locationController.stream;

  LocationService(){
    findLocation();
    Timer.periodic(timer, (t) {
      findLocation();
    });
  }

  Future<geo.Position> getCurrentLocation() async {
    geo.Position position = await geo.Geolocator()
        .getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);
    return position;
  }

  findLocation() async {
    currentLocation = await getCurrentLocation();
    _locationController.add(currentLocation);
  }
}
