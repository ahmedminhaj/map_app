import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final Position realtimePosition;
  final Set<Marker> setMarker;

  const MapScreen({Key key, this.realtimePosition, this.setMarker}) : super(key: key);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.realtimePosition.latitude,
                widget.realtimePosition.longitude),
        zoom: 10.0,
      ),
      mapType: MapType.hybrid,
      myLocationEnabled: true,
      markers: widget.setMarker,
    );
  }
}
