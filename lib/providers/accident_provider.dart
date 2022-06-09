import 'dart:async';
import 'dart:convert';
import 'package:amargari/model/accident_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:amargari/uril/app_url.dart';
import 'package:amargari/widgets/widgets.dart';

Future<List<AccidentListModel>> getAccidentList(String vehicleId, String userId) async {
  final responseData = await http.get(Uri.parse(AppUrl.getAccidentList.replaceAll("_vehicleId", vehicleId).replaceAll("_ownerId", userId)));
  var result;

  print("fetchGarageList  "+responseData.toString() +"  "+ AppUrl.getAccidentList.replaceAll("_vehicleId", vehicleId).replaceAll("_ownerId", userId));
  if (responseData.statusCode == 200) {


    // Iterable l = json.decode(responseData.body)['data'];
    // List<AccidentListModel> policeCaseModel = List<AccidentListModel>.from(l.map((model)=> AccidentListModel.fromJson(model)));

    final List parsedList = json.decode(responseData.body)['data'];

    List<AccidentListModel> policeCaseModel = parsedList.map((val) =>  AccidentListModel.fromJson(val)).toList();

    //result = {'status': true, 'message': 'Successful', 'data': garageModel};
    print("fetchGarageList  "+policeCaseModel.length.toString());
    // VehicleInfoModel vi = ;
    return policeCaseModel;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}


//vehicle details update
Future<dynamic> addUpdateAccident(
    String? Id,
    String? DriveId,
    String? VechileId,
    String? TripId,
    String? AccidentImg,
    String? AccidentLocation,
    String? Others,
    String? InsuranceCover,
    String? Fine,
    String? AccidentTime,
    String? AccidentDetails,
    ) async {
  final Map<String, dynamic> registrationData = {
    'Id': Id,
    'DriveId': DriveId,
    'VechileId': VechileId,
    'TripId': TripId,
    "AccidentImg": AccidentImg,
    "AccidentLocation": AccidentLocation,
    'Others': Others,
    "InsuranceCover": InsuranceCover,
    "Fine": Fine,
    "AccidentTime": AccidentTime,
    "AccidentDetails": AccidentDetails
  };

  print("addUpdateAccident  $registrationData");
  return await post(Uri.parse(AppUrl.addUpdateAccident),
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