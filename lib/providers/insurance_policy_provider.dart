import 'package:amargari/model/insurancePolicy.dart';
import 'package:amargari/uril/app_url.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:amargari/widgets/widgets.dart';


Future<List<InsurancePolicyModel>> getInsurancePolicyList(String userId) async {

  final responseData = await http.get(Uri.parse(AppUrl.getInsuranceList.replaceAll("_vehicleId", userId)));
  var result;
  if (responseData.statusCode == 200) {

    Iterable l = json.decode(responseData.body)['data'];
    List<InsurancePolicyModel> insurancePolicy = List<InsurancePolicyModel>.from(l.map((model)=> InsurancePolicyModel.fromJson(model)));
    print("insurancePolicy  "+insurancePolicy.length.toString());
    return insurancePolicy;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}



Future<dynamic> addUpdateInsurancePolicy(
    String Id,
    String VechileId,
    String CoverageDetails,
    String InsuranceImg,
    String ExpiryDate,

    ) async {
  final Map<String, dynamic> registrationData = {
    'Id': Id,
    'VechileId': VechileId,
    'CoverageDetails': CoverageDetails,
    'InsuranceImg': InsuranceImg,
    "ExpiryDate": ExpiryDate,
  };
  return await post(Uri.parse(AppUrl.addUpdateInsurance),
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