import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapsDemo extends StatefulWidget {
  @override
  _GoogleMapsDemoState createState() => _GoogleMapsDemoState();
}

class _GoogleMapsDemoState extends State<GoogleMapsDemo> {
  GoogleMapController mapController;
  Location location = Location();

  Marker marker;

  @override
  void initState() {
    super.initState();
    location.onLocationChanged.listen((location) async {
      mapController?.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              location.latitude,
              location.longitude,
            ),
            zoom: 9.4647,
          ),
        ),
      );
      print("$location");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                  target: LatLng(37.4219999, -122.0862462), zoom: 9.4647),
              zoomGesturesEnabled: true,
              onCameraMove: null,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
            ),
          ),
        ],
      ),
    );
  }
}
