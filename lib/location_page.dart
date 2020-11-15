import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  LatLng _position;
  GoogleMapController _controller;
  Location _location = Location();

  Future getLocation() async {
    var c = await _location.getLocation();
    setState(() {
      _position = LatLng(c.latitude, c.longitude);
      print("$_position");
    });
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(l.latitude, l.longitude), zoom: 15.4647),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            _position == null
                ? Container(
                    child: Center(
                      child: Text(
                        "not",
                        style: TextStyle(color: Colors.black, fontSize: 36),
                      ),
                    ),
                  )
                : GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: _position, zoom: 15.4647),
                    mapType: MapType.normal,
                    onMapCreated: _onMapCreated,
                    zoomGesturesEnabled: true,
                    onCameraMove: null,
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getLocation(),
      ),
    );
  }
}
