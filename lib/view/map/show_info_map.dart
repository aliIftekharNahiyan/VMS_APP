
import 'package:flutter/material.dart';

class ShowInfoOnMap extends StatefulWidget {
  final infoTypeId;
  const ShowInfoOnMap({Key? key, this.infoTypeId}) : super(key: key);

  @override
  State<ShowInfoOnMap> createState() => _ShowInfoOnMapState();
}

class _ShowInfoOnMapState extends State<ShowInfoOnMap> {
  var isLoaded = true;

  // static const String _kLocationServicesDisabledMessage =
  //     'Location services are disabled.';
  // static const String _kPermissionDeniedMessage = 'Permission denied.';
  // static const String _kPermissionDeniedForeverMessage =
  //     'Permission denied forever.';
  // static const String _kPermissionGrantedMessage = 'Permission granted.';

  // final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  // // final List<_PositionItem> _positionItems = <_PositionItem>[];
  // StreamSubscription<Position>? _positionStreamSubscription;
  // StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;
  // bool positionStreamStarted = false;

  // Future<void> _getCurrentPosition() async {
  //   final hasPermission = await _handlePermission();

  //   if (!hasPermission) {
  //     return;
  //   }

  //   final position = await _geolocatorPlatform.getCurrentPosition();

  //   print(position.latitude);
  //   print(position.longitude);

  //   // _updatePositionList(
  //   //   _PositionItemType.position,
  //   //   position.toString(),
  //   // );
  // }

  // Future<bool> _handlePermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     // _updatePositionList(
  //     //   _PositionItemType.log,
  //     //   _kLocationServicesDisabledMessage,
  //     // );

  //     return false;
  //   }

  //   permission = await _geolocatorPlatform.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await _geolocatorPlatform.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       // _updatePositionList(
  //       //   _PositionItemType.log,
  //       //   _kPermissionDeniedMessage,
  //       // );

  //       return false;
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     // _updatePositionList(
  //     //   _PositionItemType.log,
  //     //   _kPermissionDeniedForeverMessage,
  //     // );

  //     return false;
  //   }

  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   // _updatePositionList(
  //   //   _PositionItemType.log,
  //   //   _kPermissionGrantedMessage,
  //   // );
  //   return true;
  // }

  // // void _updatePositionList(_PositionItemType type, String displayValue) {
  // //   _positionItems.add(_PositionItem(type, displayValue));
  // //   setState(() {});
  // // }

  @override
  void initState() {
    // _getCurrentPosition();

    // CommonProvider commonProvider = Provider.of<CommonProvider>(context);
    // if (isLoaded) {
    //   commonProvider.getLocalInfoList("").then((value) {});
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(),
      ),
    );
  }
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
