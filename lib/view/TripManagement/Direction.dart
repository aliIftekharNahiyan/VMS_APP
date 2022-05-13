import 'dart:async';

import 'package:amargari/model/trip_list_model.dart';
import 'package:amargari/providers/common_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

const LatLng SOURCE_LOCATION = LatLng(23.775992, 90.399856);
const LatLng DEST_LOCATION = LatLng(23.7937, 90.4066);
const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

class Direction extends StatefulWidget {
  TripListModel? tripListModel;
  final title;
  Direction({this.title, required this.tripListModel});

  @override
  _DirectionState createState() => _DirectionState();
}

class _DirectionState extends State<Direction> {
  Completer<GoogleMapController> mapController = Completer();
  // String googleAPIKey = "AIzaSyBJC85dIw6OmepJFtLdxiLfPSYApfXdc_g";

  Set<Marker> _markers = Set<Marker>();
  late LatLng currentLocation;
  late LatLng destinationLocation;

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  Future<String>? locationRequest;

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    this.setInitialLocation();
  }

  void setInitialLocation() {
    if (widget.tripListModel!.startPoint != "" &&
        widget.tripListModel!.endPoint != "") {
      if (widget.tripListModel!.startPoint!.contains(",")) {
        var latlong = widget.tripListModel!.startPoint!.split(",");
        double latitude = double.parse(latlong[0]);
        double longitude = double.parse(latlong[1]);
        currentLocation = LatLng(latitude, longitude);
      }

      if (widget.tripListModel!.endPoint!.contains(",")) {
        var endLatLong = widget.tripListModel!.endPoint!.split(",");
        double endLatitude = double.parse(endLatLong[0]);
        double endLongitude = double.parse(endLatLong[1]);
        destinationLocation = LatLng(endLatitude, endLongitude);
      }
    } else {
      currentLocation =
          LatLng(currentLocation.latitude, currentLocation.longitude);
      destinationLocation =
          LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    void _onLocationRequest(BuildContext context) {
      CommonProvider commonProvider =
          Provider.of<CommonProvider>(context, listen: false);
      locationRequest = commonProvider
          .locationRequest(widget.tripListModel!.driverId.toString());
      locationRequest?.whenComplete(
          () => {snackBar(context, "Send location request successfully")});
    }

    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: SOURCE_LOCATION);

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title}"),
        actions: [
          IconButton(
            icon: new Icon(Icons.location_searching),
            onPressed: () {
              _onLocationRequest(context);
            },
          ),
        ],
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        compassEnabled: false,
        tiltGesturesEnabled: false,
        polylines: _polylines,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          mapController.complete(controller);

          showMarker();
          setPolylines();
        },
        initialCameraPosition: initialLocation,
      ),
    );
  }

  void showMarker() {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: currentLocation,
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            snackBar(context,
                "Start point, ${widget.tripListModel?.StartPointName.toString()} ");
          }));

      _markers.add(Marker(
          markerId: MarkerId('destinationPin'),
          position: destinationLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(90),
          onTap: () {
            snackBar(context,
                "End point, ${widget.tripListModel?.EndPointName.toString()} ");
          }));
    });
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        AppConstant.ApiKey,
        PointLatLng(currentLocation.latitude, currentLocation.longitude),
        PointLatLng(
            destinationLocation.latitude, destinationLocation.longitude));

    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
            width: 3,
            polylineId: PolylineId('polyLine'),
            color: Color(0xFF08A5CB),
            points: polylineCoordinates));
      });
    }
  }
}
