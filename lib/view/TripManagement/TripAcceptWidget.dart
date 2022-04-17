import 'package:amargari/model/trip_list_model.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/trip_list%20_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:flutter/material.dart';

class TripAcceptWidget extends StatelessWidget {

  String statusId;
  int userTypeId;
  Future<dynamic>? accidentAddUpdate;
  TripListModel tripListModel;
  TripAcceptWidget({required this.statusId, required this.userTypeId, required this.tripListModel});
  Future<UserInfoModel> getUserData() => UserPreferences().getUser();

  @override
  Widget build(BuildContext context) {
    print("userTypeId   ${userTypeId}");
    if (statusId == "-1" && userTypeId == 2) {
      return  MaterialButton(
        onPressed:  () {
          updateTripList(context);
        },
        child: Text(  "Accept Trip", style: TextStyle(color: Colors.white),),
        color: Colors.orange,
      );
    } else if (statusId == "1" ) {
      return  MaterialButton(
        onPressed:  () {
          updateTripList(context);
        },
        child: Text("Complete Trip", style: TextStyle(color: Colors.white),),
        color: Colors.orange,
      );
    } else {
      return Text("");
    }
  }

  updateTripList(BuildContext context ) {
   String updateStatusID = "";
    if (statusId == "-1") {
      updateStatusID = "1";
    }else if (statusId == "1") {
      updateStatusID = "2";
    }
    accidentAddUpdate = TripListProvider().addUpdateTrip(
        tripListModel.id.toString(),
        tripListModel.vechileId.toString(),
        tripListModel.driverId.toString(),
        tripListModel.startPoint.toString(),
        tripListModel.endPoint.toString(),
        "",
        updateStatusID,
      tripListModel.StartPointName.toString(),
      tripListModel.EndPointName.toString(),
      tripListModel.tripStartTime.toString(),
    );
    accidentAddUpdate?.whenComplete(() => {
      Navigator.pop(context)
    });
  }
}