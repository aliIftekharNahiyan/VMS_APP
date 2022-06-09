import 'dart:async';
import 'dart:convert';

import 'package:amargari/model/garage/GarageModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:amargari/uril/app_url.dart';
import 'package:amargari/widgets/widgets.dart';

//profile update
class GarageProvider with ChangeNotifier {
  List<GarageModel> garageList = [];

  Future<List<GarageModel>> fetchGarageList(String userId) async {
    final responseData = await http
        .get(Uri.parse(AppUrl.garageList.replaceAll("_userId", userId)));
    var result;
    if (responseData.statusCode == 200) {
      Iterable l = json.decode(responseData.body)['data'];
      List<GarageModel> garageModel = List<GarageModel>.from(
          l.map((model) => GarageModel.fromJson(model)));
      //result = {'status': true, 'message': 'Successful', 'data': garageModel};
      print("fetchGarageList  " + garageModel.toString());
      // VehicleInfoModel vi = ;
      garageList = garageList;
      notifyListeners();
      return garageModel;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


//vehicle details update
  Future<dynamic> garageDetailsUpdate(String Id,
      String GargeName,
      String GargeNameLocation,
      String Status,
      String UserID,
      String OwnerId,
      String GargeOwnerName,
      String ContactPerson1Name,
      String ContactPerson1Mobile,
      String ContactPerson2Name,
      String ContactPerson2Mobile,
      ) async {
    final Map<String, dynamic> registrationData = {
      'Id': Id,
      'GargeName': GargeName,
      'GargeNameLocation': GargeNameLocation,
      'Status': Status,
      "UserID": UserID,
      "OwnerId": OwnerId,
      'GargeOwnerName': GargeOwnerName,
      'ContactPerson1Name': ContactPerson1Name,
      'ContactPerson1Mobile': ContactPerson1Mobile,
      'ContactPerson2Name': ContactPerson2Name,
      'ContactPerson2Mobile': ContactPerson2Mobile,
    };

    print("garageDetailsUpdate  $registrationData");
    return await post(Uri.parse(AppUrl.garageInfoEntryUpdate),
        body: json.encode(registrationData),
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