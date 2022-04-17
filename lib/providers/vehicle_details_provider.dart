import 'dart:async';
import 'dart:convert';

import 'package:amargari/model/vehicleinfo/add_brand_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:amargari/model/common_dropdown_model.dart';
import 'package:amargari/model/vehicleinfo/vehicle_info_model.dart';
import 'package:amargari/uril/app_url.dart';
import 'package:amargari/widgets/widgets.dart';

//profile update
class VehicleInfoProvider with ChangeNotifier {
  List<CommonDropDownModel> _vehicleShortList = [];
  //List<VehicleInfoDataModel> vehicleModelList ;

  Future<List<VehicleInfoDataModel>> fetchVehicleDetails(String userId) async {
    final response = await http
        .get(Uri.parse(AppUrl.getVehicleList.replaceAll("_userId", userId)));
    print("VehicleInfo url $userId  " +AppUrl.getVehicleList.replaceAll("_userId", userId) );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("VehicleInfo  $userId  " +AppUrl.getVehicleList.replaceAll("_userId", userId) +
          "  " +
          VehicleInfoModel.fromJson(jsonDecode(response.body)).toString() +
          "  " +
          response.body);

return VehicleInfoModel
    .fromJson(jsonDecode(response.body))
    .data!;
      // VehicleInfoModel vi = ;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<dynamic> getVehicleDetails(String userId) async {

    return await post(
        Uri.parse(AppUrl.getVehicleList.replaceAll("_userId", userId)),
        headers: {'Content-Type': 'application/json'})
        .then(onValueUpdate)
        .catchError(onError);
  }

  Future<FutureOr> onValueUpdate(Response response) async {

    print(response);
    var result;
    final VehicleInfoModel responseData = json.decode(response.body);

    // VehicleInfoModel vehicleInfoModel = VehicleInfoModel.fromJson(responseData);

    print("VehicleInfo  " +
        "" +
        responseData.result! +
        "  " +
        responseData.toString());
    if (responseData.result == "success") {
      result = {'status': true, 'message': 'Successful', 'data': responseData};
    } else {
      result = {'status': false, 'message': "fail to update profile"};
      return result;
    }
  }

//vehicle details update
  Future<dynamic> vehicleDetailsUpdate(String Id,
      String VechileTypeId,
      String OwnerId,
      String VechileImage,
      String VechileNumber,
      String EngineNumber,
      String ChasisNumber,
      String ModelName,
      String BrandName,
      String VechileTierSize,
      String RegistrationDate,
      String RegistrationExpireDate,
      String VechileRentId,
      String CC,
      String tierNumber,
      String Milage,
      String VechileEnergySourceId,
      String Status,
      String ColorName,
      String ModelYear,) async {
    final Map<String, dynamic> registrationData = {
      'Id': Id,
      'VechileTypeId': VechileTypeId,
      'OwnerId': OwnerId,
      'VechileImage': VechileImage,
      "VechileNumber": VechileNumber,
      "EngineNumber": EngineNumber,
      "ChasisNumber": ChasisNumber,
      "ModelName": ModelName,
      "BrandName": BrandName,
      "VechileTierSize": VechileTierSize,
      "RegistrationDate": RegistrationDate,
      "RegistrationExpireDate": RegistrationExpireDate,
      "VechileRentId": VechileRentId,
      "CC": CC,
      "TierNumber": tierNumber,
      "Milage": Milage,
      "VechileEnergySourceId": VechileEnergySourceId,
      "Status": Status,
      "ColorName": ColorName,
      "ModelYear": ModelYear,
    };
    return await post(Uri.parse(AppUrl.vehicleInfoAddUpdate),
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

  //vehicle details update
  Future<dynamic> addVehicleBrandModel(String Id,
      String RawUtilityId,
      String Text,
      String ParentId,
      String VechileTypeForModelId,
      String OwnerId,
     ) async {
    final Map<String, dynamic> registrationData = {
      'Id': Id,
      'RawUtilityId': RawUtilityId,
      'Text': Text,
      'ParentId': ParentId,
      "VechileTypeForModelId": VechileTypeForModelId,
      "OwnerId": OwnerId,
    };

    print("AddModel  $registrationData");

    return await post(Uri.parse(AppUrl.addVehicleBrandModel),
        body: json.encode(registrationData),
        headers: {'Content-Type': 'application/json'})
        .then(onBrandModelUpdate)
        .catchError(onError);
  }

  Future<FutureOr> onBrandModelUpdate(Response response) async {
    var result;

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      AddBrandModel vehicleGeneralInfoModel = AddBrandModel.fromJson(
          responseData);
      result = {'status': true, 'message': 'Successful', 'details': vehicleGeneralInfoModel};
    }else{
      result = {'status': false, 'message': 'fail', 'details': ""};
    }
    return result;
  }
}