import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  double? lng, lat;
  List<Marker> _markers = [];
  bool tf = true;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.5283169, 126.9294254),
    zoom: 11.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      //bearing: 192.8334901395799,
      target: LatLng(36.7697899, 126.9317528),
      //tilt: 59.440717697143555,
      zoom: 14);

  @override
  void initState() {
    _checkPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: _markers.toSet(),
        onTap: (pos) {
          addMark(pos);
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            FloatingActionButton.extended(
              onPressed: _goToTheLake,
              label: Text('Academy'),
              icon: Icon(Icons.school),
            ),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton.extended(
                onPressed: () {},
                label: Text('Mark'),
                icon: Icon(
                  Icons.fmd_good_outlined,
                ))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    _getPosition();
  }

  _getPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    try {
      setState(() {
        lng = position.longitude;
        lat = position.latitude;
      });
    } catch (e) {
      print(e);
    }
  }

  addMark(pos) {
    setState(() {
      if (tf) {
        _markers.clear();
        _markers.add(Marker(position: pos, markerId: MarkerId('1')));
        tf = !tf;
      } else {
        _markers.add(Marker(
            position: pos,
            markerId: MarkerId('2'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue)));
        tf = !tf;
      }
    });
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
