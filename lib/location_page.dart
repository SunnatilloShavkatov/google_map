import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Position? _position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Location Page",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 1,
        toolbarHeight: 60,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: _position != null
                ? Text(
                    "${_position?.latitude ?? 0} ${_position?.longitude ?? 0}")
                : Container(),
          ),
          SizedBox(height: 30),
          Center(
            child: RaisedButton(
              onPressed: () => _currentLocation(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Current Location"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _currentLocation() async {
    bool isLocation = await Geolocator.isLocationServiceEnabled();
    if (isLocation) {
      Position _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _position = _currentPosition;
        print("$_position");
      });
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
}
