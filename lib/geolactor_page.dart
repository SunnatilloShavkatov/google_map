import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class GeolocatorPage extends StatefulWidget {
  @override
  _GeolocatorPageState createState() => _GeolocatorPageState();
}

class _GeolocatorPageState extends State<GeolocatorPage> {
  LatLng? _position;
  GoogleMapController? _controller;
  List<Marker> _marker = [];
  String _address = '';
  final Geolocator _geolocator = Geolocator();

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
        _controller?.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: _position ?? LatLng(0, 0), zoom: 15.4647),
          ),
        );
      BitmapDescriptor descriptor = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(12, 12)),
        "assets/png/location.png",
      );
      _marker.add(Marker(
        markerId: MarkerId("location"),
        position: _position ?? LatLng(0, 0),
        icon: descriptor,
      ));
      setState(() {});
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
      body: Stack(
        children: [
          _position == null
              ? SizedBox()
              : GoogleMap(
                  onTap: (newLatLng) async {
                    await addMarker(newLatLng);
                  },
                  markers: _marker.toSet(),
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _position ?? LatLng(0, 0),
                    zoom: 14.4647,
                  ),
                  zoomGesturesEnabled: true,
                  onCameraMove: (CameraPosition position) async {
                    await addMarker(position.target);
                  },
                  myLocationEnabled: false,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.grey,
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: Center(child: Text(_address)),
            ),
          )
        ],
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

  Future<void> addMarker(latLng) async {
    BitmapDescriptor descriptor = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(12, 12)),
      "assets/png/location.png",
    );
    final coordinates =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    setState(() {
      _marker.clear();
      _address = coordinates[0].name ?? '';
      _marker.add(Marker(
        markerId: MarkerId("location"),
        position: latLng ?? LatLng(0, 0),
        icon: descriptor,
      ));
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }
}
