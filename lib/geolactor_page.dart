import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeolocatorPage extends StatefulWidget {
  @override
  _GeolocatorPageState createState() => _GeolocatorPageState();
}

class _GeolocatorPageState extends State<GeolocatorPage> {
  LatLng _position;
  GoogleMapController _controller;

  _getCurrentLoaction() async {
    bool isLocation = await Geolocator.isLocationServiceEnabled();
    if (isLocation) {
      Position _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _position =
            LatLng(_currentPosition.latitude, _currentPosition.longitude);
        print("$_position");
      });
      if (_controller != null)
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: _position, zoom: 15.4647),
          ),
        );
    } else {
      toastMessage("Loction yoqilmagan");
    }
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      fontSize: 18.0,
      backgroundColor: Colors.grey,
    );
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLoaction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Google Map",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        toolbarHeight: 60,
        elevation: 1.0,
      ),
      body: _position == null
          ? Container()
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _position,
                zoom: 14.4647,
              ),
              zoomGesturesEnabled: true,
              onCameraMove: null,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => _getCurrentLoaction(),
        child: Icon(
          Icons.location_on_outlined,
          color: Colors.white,
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }
}
