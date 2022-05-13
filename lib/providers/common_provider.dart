import 'dart:async';
import 'dart:convert';

import 'package:amargari/model/LocalInfo/local_info_type.dart';
import 'package:amargari/model/home_data_model.dart';
import 'package:amargari/model/notification_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:amargari/uril/app_url.dart';
import 'package:amargari/widgets/widgets.dart';

class CommonProvider with ChangeNotifier {
  Future<String> uploadImage(
      String Type, String number, String FilePath) async {
    print("uploadImage  ${Type}  ${number}  ${FilePath}");
    var result = "";
    var request = http.MultipartRequest('POST', Uri.parse(AppUrl.fileUpload));
    request.fields['Type'] = Type;
    request.fields['User'] = number;
    request.files.add(await http.MultipartFile.fromPath('', FilePath));

    final response = await request.send();
    final responseString = await response.stream.bytesToString();

    print("responseData " + "  " + responseString);

    // print(response);
    if (response.statusCode == 200) {
      // Map<String, dynamic> map = json.decode(response.reasonPhrase);

      print("responseData " + "  " + responseString);

      final Map<String, dynamic> responseData = json.decode(responseString);
      print("responseData " + responseData["url"]);
      result = responseData["url"];
    } else {
      result = "Fail";
    }
    print("result:  " + result);
    return result;
  }

  Future<String> locationRequest(String tripId) async {
    final response = await http
        .get(Uri.parse(AppUrl.locationRequest.replaceAll("_tripId", tripId)));
    print(AppUrl.locationRequest.replaceAll("_tripId", tripId));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      // HomeDataModel homeDataModel = HomeDataModel.fromJson(responseData);
      print(responseData);
      return "success";
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return "fail";
    }
  }

  Future<dynamic> updateLocation(
      String id, String currentLatitude, String currentLongitude) async {
    final Map<String, dynamic> registrationData = {
      "Id": id,
      'CurrentLatitude': currentLatitude,
      'CurrentLongitude': currentLongitude
    };
    print("registrationData  " + registrationData.toString());
    return await post(Uri.parse(AppUrl.locationUpdate),
            body: json.encode(registrationData),
            headers: {'Content-Type': 'application/json'})
        .then(onLocationUpdate)
        .catchError(onError);
  }

  Future<FutureOr> onLocationUpdate(Response response) async {
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

  Future<NotificationList> getNotificationList(String userId) async {
    final response = await http
        .get(Uri.parse(AppUrl.notificationList.replaceAll("_ownerId", userId)));
    print(AppUrl.notificationList.replaceAll("_ownerId", userId));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      NotificationList notificationList =
          NotificationList.fromJson(responseData);
      print(notificationList.unread);
      notifyListeners();
      return notificationList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<HomeDataModel> getHomeData(String userId) async {
    final response = await http
        .get(Uri.parse(AppUrl.featureForHome.replaceAll("_ownerId", userId)));
    print(AppUrl.featureForHome.replaceAll("_ownerId", userId));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      HomeDataModel homeDataModel = HomeDataModel.fromJson(responseData);
      print(homeDataModel.result);
      return homeDataModel;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<void> updateNotification(String id) async {
    final response = await http
        .get(Uri.parse(AppUrl.updateNotification.replaceAll("_id", id)));
    print(AppUrl.updateNotification.replaceAll("_id", id));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      // HomeDataModel homeDataModel = HomeDataModel.fromJson(responseData);
      print(responseData);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<LocalInfoType> getLocalInfoTypeList() async {
    final response = await get(Uri.parse(AppUrl.localInfoType));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return LocalInfoType.fromJson(data);
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<LocalInfoType> getLocalInfoList(var lat) async {
    print(lat);
    final response = await post(Uri.parse(AppUrl.localInfo));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return LocalInfoType.fromJson(data);
    } else {
      throw Exception('Failed to load album');
    }
  }
}
