import 'dart:async';
import 'dart:convert';

import 'package:amargari/model/police_doc_request_model.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:amargari/model/police_case_model.dart';
import 'package:amargari/model/vehicleinfo/vehicle_info_model.dart';
import 'package:amargari/uril/app_url.dart';
import 'package:amargari/widgets/widgets.dart';

//profile update
Future<List<PoliceCaseModel>> fetchPoliceCaseList(String vehicleId, String ownerId) async {
  final responseData = await http
      .get(Uri.parse(AppUrl.policeCaseList.replaceAll("_vehicleId", vehicleId).replaceAll("_ownerId", ownerId)));
      print(AppUrl.policeCaseList.replaceAll("_vehicleId", vehicleId).replaceAll("_ownerId", ownerId));
  if (responseData.statusCode == 200) {
    Iterable l = json.decode(responseData.body)['data'];
    List<PoliceCaseModel> policeCaseModel = List<PoliceCaseModel>.from(
        l.map((model) => PoliceCaseModel.fromJson(model)));
    //result = {'status': true, 'message': 'Successful', 'data': garageModel};
   // print("fetchGarageList  " + policeCaseModel[0].img.toString());
    // VehicleInfoModel vi = ;
    return policeCaseModel;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

//vehicle details update
Future<dynamic> updatePoliceCaseUpdate(
    String id,
  String caseName,
  String caseAmount,
  String driverId,
  String vehicleId,
  String caseDate,
  String status,
  String Img,
  String OtherImg,
  String CaseDetails,
  String PoliceStation,
  String Location,
    String PaperHandOver,
   List<PoliceDocRequestModel> policeDocRequestModel,
    String IsClear,
    String SubmissionLastDate,
) async {
  final Map<String, dynamic> registrationData = {
    "Id" : id,
    'CaseName': caseName,
    'CaseAmount': caseAmount,
    'DriverId': driverId,
    'VechileId': vehicleId,
    "CaseDate": caseDate,
    "Status": status,
    "Img": Img,
    "OtherImg": OtherImg,
    "CaseDetails": CaseDetails,
    "PoliceStation": PoliceStation,
    "Location": Location,
    "PaperHandOver": PaperHandOver,
    "PoliceFreezingDocumentList": PoliceDocRequestModel.encondeToJson(policeDocRequestModel),
    "IsClear": IsClear,
    "SubmissionLastDate": SubmissionLastDate,
  };
  print("updatePoliceCaseUpdate  "+registrationData.toString());
  return await post(Uri.parse(AppUrl.addUpdatePoliceCase),
          body: json.encode(registrationData),
          headers: {'Content-Type': 'application/json'})
      .then(onVehicleUpdate)
      .catchError(onError);
}

Future<FutureOr> onVehicleUpdate(Response response) async {
  var result;
  final Map<String, dynamic> responseData = json.decode(response.body);
  print(responseData);
  if (responseData["result"] == "success") {
    result = {'status': true, 'message': 'Successful', 'user': responseData};
  } else {
    result = {'status': false, 'message': "fail to update profile"};
    return result;
  }
}
