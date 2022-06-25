import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripMapShow extends StatefulWidget {
  @override
  State<TripMapShow> createState() => TripMapShowState();
}

class TripMapShowState extends State<TripMapShow> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set();
  static final double lat = 23.8709538;
  static final double long = 90.3838478;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(lat, long),
    zoom: 15.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(lat, long),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {


    Marker resultMarker = Marker(
      markerId: MarkerId("Dhaka"),
      infoWindow: InfoWindow(
          title: "Dhaka",
          snippet: "Dhaka"),
      position: LatLng(lat,
          long),

    );
// Add it to Set
    markers.add(resultMarker);

    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}