import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:amargari/model/fuel_list_model.dart';
import 'package:amargari/uril/app_url.dart';
import 'package:amargari/widgets/widgets.dart';

Future<List<FuelListModel>> getFuelList(String userId) async {

  final responseData = await http.get(Uri.parse(AppUrl.getFuelList.replaceAll("_ownerId", userId)));
  if (responseData.statusCode == 200) {
    Iterable l = json.decode(responseData.body)['data'];
    List<FuelListModel> insurancePolicy = List<FuelListModel>.from(l.map((model)=> FuelListModel.fromJson(model)));
    print("insurancePolicy  "+insurancePolicy.length.toString());
    return insurancePolicy;

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}


//vehicle details update
Future<dynamic> addUpdateFuelList(
    String Id,
    String VechileId,
    String DriveId,
    String EnergyType,
    String StationName,
    String Amount,
    String SlipImg,
    String HaveFuelAlert,
    String FuelTime,
    String fuelTaken
    ) async {
  final Map<String, dynamic> registrationData = {
    'Id': Id,
    'VechileId': VechileId,
    'DriveId': DriveId,
    'EnergyType': EnergyType,
    "StationName": StationName,
    "Amount": Amount,
    'SlipImg': SlipImg,
    "HaveFuelAlert": HaveFuelAlert,
    "FuelTime": FuelTime,
    "FuleTaken" : fuelTaken
  };
  print("addUpdateFuelList  ${registrationData}");
  return await post(Uri.parse(AppUrl.addUpdateFuelList),
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