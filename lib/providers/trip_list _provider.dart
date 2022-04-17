import 'dart:async';
import 'dart:convert';

import 'package:amargari/model/trip_list_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:amargari/model/vehicleinfo/vehicle_info_model.dart';
import 'package:amargari/uril/app_url.dart';
import 'package:amargari/widgets/widgets.dart';

//profile update
class TripListProvider with ChangeNotifier {
  //List<TripListModel> tripList = [];

  Future<List<TripListModel>> fetchTripList(String statusId, String ownerId) async {
    final responseData = await http
        .get(Uri.parse(AppUrl.tripList.replaceAll("_statusId", statusId).replaceAll("_ownerId", ownerId)));
    var result;
    print("fetchTripList "+ AppUrl.tripList.replaceAll("_statusId", statusId).replaceAll("_ownerId", ownerId));
    if (responseData.statusCode == 200) {
      Iterable l = json.decode(responseData.body)['data'];
      //print("fetchTripList 1 " + l.toString());
      // List<TripListModel> tripListData = List<TripListModel>.from(
      //     l.map((model) => TripListModel.fromJson(model)));

      var tagsJson = jsonDecode(responseData.body)['data'];
      print("fetchTripList 2 " + tagsJson.toString());
     // tagsJson[0].toString()
      List<TripListModel> tripListData = List<TripListModel>.from(
          tagsJson.map((model) => TripListModel.fromJson(model)));

      print("fetchTripList 3 "+ tripListData.length.toString());
      return tripListData;
    } else {
      print("fetchTripList "+ "error");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


  Future<dynamic> addUpdateTrip(
      String Id,
      String VechileId,
      String DriverId,
      String StartPoint,
      String EndPoint,
      String MapImg,
      String Status,
      String StartPointName,
      String EndPointName,
      String TripStartTime,

      ) async {
    final Map<String, dynamic> addUpdateTripData = {
      'Id': Id,
      'VechileId': VechileId,
      'DriverId': DriverId,
      'StartPoint': StartPoint,
      "EndPoint": EndPoint,
      "MapImg": MapImg,
      "Status": Status,
      "StartPointName": StartPointName,
      "EndPointName": EndPointName,
      "TripStartTime": TripStartTime,
    };
    print("addTripData  ${addUpdateTripData}");
    return await post(Uri.parse(AppUrl.addTripList),
        body: json.encode(addUpdateTripData),
        headers: {'Content-Type': 'application/json'})
        .then(onVehicleUpdate)
        .catchError(onError);
  }

  Future<FutureOr> onVehicleUpdate(Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    if (responseData["result"] == "updated") {
      result = {'status': true, 'message': 'Successful', 'user': responseData};
    } else {
      result = {'status': false, 'message': "fail to update profile"};
      return result;
    }
  }

}