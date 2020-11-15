import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_1/location_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'demo_location_page.dart';

void main() {
  runApp(MyApp());
}
// void main() {
//   runApp(BaseflowPluginExample(
//     pluginName: 'Geolocator',
//     githubURL: 'https://github.com/Baseflow/flutter-geolocator',
//     pubDevURL: 'https://pub.dev/packages/geolocator',
//     pages: [HomePage()],
//   ));
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController _controller;

  LatLng _center;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    // _controller.animateCamera(
    //   CameraUpdate.newCameraPosition(
    //     CameraPosition(target: LatLng(_center.latitude,_center.longitude), zoom: 15.4647),
    //   ),
    // );
  }

  getCurrentLoaction() async {
    Position _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _center = LatLng(_currentPosition.latitude, _currentPosition.longitude);
      print("$_center");
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLoaction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps Sample App'),
        backgroundColor: Colors.green[700],
      ),
      body: _center == null
          ? Container()
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 14.4647,
              ),
              zoomGesturesEnabled: true,
              onCameraMove: null,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
            ),
    );
  }
}
