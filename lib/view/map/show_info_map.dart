import 'dart:async';

import 'package:amargari/model/LocalInfo/local_info_req.dart';
import 'package:amargari/model/LocalInfo/local_info_res.dart';
import 'package:amargari/providers/common_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

const LatLng SOURCE_LOCATION = LatLng(23.775992, 90.399856);
const LatLng DEST_LOCATION = LatLng(23.7937, 90.4066);
const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

class ShowInfoOnMap extends StatefulWidget {
  final infoTypeId;
  final title;
  const ShowInfoOnMap({Key? key, this.infoTypeId, this.title})
      : super(key: key);

  @override
  State<ShowInfoOnMap> createState() => _ShowInfoOnMapState();
}

class _ShowInfoOnMapState extends State<ShowInfoOnMap> {
  var isLoaded = true;

  static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  // final List<_PositionItem> _positionItems = <_PositionItem>[];
  // StreamSubscription<Position>? _positionStreamSubscription;
  // StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;
  bool positionStreamStarted = false;

  Future<LocalInfoReq> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return LocalInfoReq();
    }

    final position = await _geolocatorPlatform.getCurrentPosition();

    print(position.latitude);
    print(position.longitude);

    //   {

//   "LocalInfoSaveId": 2, //get from GetLocalInfoTypes API
//   "Lat": "23.77874627553697",
//   "Lon": "90.39283832699954"

// }

    return LocalInfoReq(
        localInfoSaveId: widget.infoTypeId,
        lat: position.latitude.toString(),
        lon: position.longitude.toString());

    // return LocalInfoReq(
    //     localInfoSaveId: 2, lat: "23.77874627553697", lon: "90.39283832699954");
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // _updatePositionList(
      //   _PositionItemType.log,
      //   _kLocationServicesDisabledMessage,
      // );

      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // _updatePositionList(
        //   _PositionItemType.log,
        //   _kPermissionDeniedMessage,
        // );

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // _updatePositionList(
      //   _PositionItemType.log,
      //   _kPermissionDeniedForeverMessage,
      // );

      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // _updatePositionList(
    //   _PositionItemType.log,
    //   _kPermissionGrantedMessage,
    // );
    return true;
  }

  Completer<GoogleMapController> mapController = Completer();
  // String googleAPIKey = "AIzaSyBJC85dIw6OmepJFtLdxiLfPSYApfXdc_g";

  Set<Marker> _markers = Set<Marker>();
  late LatLng currentLocation;
  late LatLng destinationLocation;

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  Future<String>? locationRequest;

  CameraPosition initialLocation = CameraPosition(
      zoom: CAMERA_ZOOM,
      bearing: CAMERA_BEARING,
      tilt: CAMERA_TILT,
      target: SOURCE_LOCATION);

  @override
  void initState() {
    polylinePoints = PolylinePoints();
    currentLocation = LatLng(0, 0);
    destinationLocation = LatLng(0, 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CommonProvider commonProvider = Provider.of<CommonProvider>(context);
    _getCurrentPosition().then((value) => {
          print(value),
          if (isLoaded)
            {
              commonProvider.getLocalInfoList(value).then((val) {
                showMarker(val.data!);
                isLoaded = false;
              })
            }
        });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(widget.title ?? ""),
        ),
        body: GoogleMap(
          myLocationEnabled: true,
          compassEnabled: false,
          tiltGesturesEnabled: false,
          polylines: _polylines,
          markers: _markers,
          onMapCreated: (GoogleMapController controller) {
            mapController.complete(controller);
          },
          initialCameraPosition: initialLocation,
        ),
      ),
    );
  }

  void showMarker(List<Data> data) {
    // {required String name, required LatLng latLng}

    // name: val.name.toString(),
    // latLng: LatLng(double.parse(val.lat.toString()),
    //     double.parse(val.lon.toString())

    print(data);

    for (int i = 0; i < data.length; i++) {
      setState(() {
        _markers.add(Marker(
            markerId: MarkerId('${data[i].name}'),
            position: LatLng(double.parse(data[i].lat.toString()),
                double.parse(data[i].lon.toString())),
            icon: BitmapDescriptor.defaultMarker,
            onTap: () {
              // snackBar(context, "Start point");
            }));
      });
    }
  }

  // void setPolylines(LatLng latLng) async {
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //       AppConstant.ApiKey,
  //       PointLatLng(latLng.latitude, latLng.longitude),
  //       PointLatLng(
  //           destinationLocation.latitude, destinationLocation.longitude));

  //   if (result.status == 'OK') {
  //     result.points.forEach((PointLatLng point) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     });

  //     setState(() {
  //       _polylines.add(Polyline(
  //           width: 3,
  //           polylineId: PolylineId('polyLine'),
  //           color: Color(0xFF08A5CB),
  //           points: polylineCoordinates));
  //     });
  //   }
  // }
}

// class _PositionItem {
//   _PositionItem(this.type, this.displayValue);

//   final _PositionItemType type;
//   final String displayValue;
// }

// enum _PositionItemType {
//   log,
//   position,
// }
