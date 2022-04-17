import 'dart:async';
import 'dart:convert';

import 'package:amargari/model/vehicle_doc_details.dart';
import 'package:amargari/uril/app_url.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class VehicleDocumentInfoProvider with ChangeNotifier {

//vehicle details update
  Future<dynamic> vehicleDocumentUpdate(String Id,String vehicleId,
      String coverageDetails,
      String image,
      String documentId,
      String expiryDate,

      String RegDate,
      String OtherExpense,
      String FeesAmount,
      String RegistrationNumber,

     ) async {
    final Map<String, dynamic> requestData = {
      'Id': Id,
      'VechileId': vehicleId,
      'CoverageDetails': coverageDetails,
      'InsuranceImg': image,
      'DocumentId': documentId,
      "ExpiryDate": expiryDate,
      "JsonData": "",
      "RegDate": RegDate,
      "OtherExpense": OtherExpense,
      "FeesAmount": FeesAmount,
      "RegistrationNumber": RegistrationNumber,
    };
    print(requestData);

    print(AppUrl.vehicleDocumentManager);
    return await post(Uri.parse(AppUrl.vehicleDocumentManager),
        body: json.encode(requestData),
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

  Future<List<VehicleDocDetailsModel>> fetchDocumentHistory(String vehicleId, String documentId, String ownerId) async {
    final responseData = await http
        .get(Uri.parse(AppUrl.getDocumentHistory.replaceAll("_vechileId", vehicleId).replaceAll("_documentId", documentId).replaceAll("_ownerId", ownerId)));

    print("fetchTripList "+ AppUrl.getDocumentHistory.replaceAll("_vechileId", vehicleId).replaceAll("_documentId", documentId).replaceAll("_ownerId", ownerId));

    if (responseData.statusCode == 200) {

      var tagsJson = jsonDecode(responseData.body)['data'];
      print("fetchTripList 2 " + tagsJson.toString());
      List<VehicleDocDetailsModel> vehicleDocumentList = List<VehicleDocDetailsModel>.from(
          tagsJson.map((model) => VehicleDocDetailsModel.fromJson(model)));

      print("fetchTripList 3 "+ vehicleDocumentList.length.toString());
      return vehicleDocumentList;
    } else {
      print("fetchTripList "+ "error");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


}