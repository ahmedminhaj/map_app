import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_map/screen/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Position currentPosition = Provider.of<Position>(context);
    final _formKey = GlobalKey<FormState>();
    String userName;
    LatLng currentLatLng = (currentPosition != null)
        ? LatLng(currentPosition.latitude, currentPosition.longitude)
        : LatLng(23.7594233, 90.4118457);
    final Set<Marker> marker = {};
    marker.add(
      Marker(
          markerId: MarkerId(currentLatLng.toString()),
          position: currentLatLng,
          infoWindow: InfoWindow(
            title:
                "Current Location Lat:${currentLatLng.latitude}, Lng:${currentLatLng.longitude}",
          ),
          onTap: () {
            Get.defaultDialog(
              title: "Current Location",
              content: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                        "Lat:${currentLatLng.latitude}, Lng:${currentLatLng.longitude}"),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Enter your name',
                        labelText: 'NAME',
                      ),
                      onSaved: (String value) {
                        userName = value;
                      },
                      validator: (String value) {
                        return value.contains('@')
                            ? 'Do not use the @ char.'
                            : null;
                      },
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          print("User name::: $userName");
                          print(
                              "Current location::: Lat:${currentLatLng.latitude}, Lng:${currentLatLng.longitude}");
                        }
                      },
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );

    return Scaffold(
      body: Center(
        child: (currentPosition != null)
            ? MapScreen(
                realtimePosition: currentPosition,
                setMarker: marker,
              )
            : Container(
                child: Text("Turn on GPS"),
              ),
      ),
    );
  }
}
