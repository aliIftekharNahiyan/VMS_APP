import 'dart:async';
import 'dart:convert';

import 'package:amargari/model/AddDriver/search_driver_model.dart';
import 'package:amargari/model/AddDriver/send_request_res.dart';
import 'package:amargari/model/Driver/vechiel_driver.dart';
import 'package:amargari/model/Expense/Expense_type_model.dart';
import 'package:amargari/model/PoliceFreezingDocModel.dart';
import 'package:amargari/model/ServiceNameModel.dart';
import 'package:amargari/model/expense_report_model.dart';
import 'package:amargari/model/garage/GarageModel.dart';
import 'package:amargari/model/login_model.dart';
import 'package:amargari/model/rtp/ReportServiceDropdownResponse.dart';
import 'package:amargari/model/service/service_model.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/model/usertypemodel.dart';
import 'package:amargari/model/vechile_list_res.dart';
import 'package:amargari/model/vehicleinfo/vechile_general_info_model.dart';
import 'package:amargari/model/vehicleinfo/vehicle_type.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:amargari/model/RequestModel/request_service_model.dart';
import 'package:amargari/model/common_dropdown_model.dart';
import 'package:amargari/model/driver_list_model.dart';
import 'package:amargari/model/vehicleEnergyTypeModel.dart';
import 'package:amargari/model/vehicleinfo/vehicle_info_model.dart';
import 'package:amargari/uril/app_url.dart';
import 'package:amargari/widgets/widgets.dart';

//profile update
class ServiceProvider with ChangeNotifier {
  List<CommonDropDownModel> vehicleShortList = [];
  List<CommonDropDownModel> vehicleAssignedShortList = [];
  List<CommonDropDownModel> garageList = [];
  List<CommonDropDownModel> driverCommonList = [];
  List<CommonDropDownModel> vehicleEnergyType = [];
  List<CommonDropDownModel> vehicleTypeComList = [];
  List<CommonDropDownModel> vehicleBrandNameList = [];
  List<CommonDropDownModel> vehicleModelNameList = [];
  List<CommonDropDownModel> vehicleColourNameList = [];
  List<CommonDropDownModel> policeFreezingList = [];
  List<CommonDropDownModel> locationTypes = [];
  List<CommonDropDownModel> serviceNameList = [];
  List<CommonDropDownModel> userTypeModel = [];
  List<VehicleInfoDataModel> vehicleModelList = [];
  List<VechileList> vehiclelList = [];

  List<SearchDriverModel> searchDriverModel = [];
  List<ExpenseReportModel> expenseReportModel = [];
  List<CommonDropDownModel> expenseTypeList = [];
  List<CommonDropDownModel> expenseTypeStatusList = [];
  List<CommonDropDownModel> reportServiceList = [];

  UserInfoModel userInfo = new UserInfoModel();

  SendRequestRes sendRequestRes = new SendRequestRes();

  Future<void> getExpenseTypeStatus() async {
    expenseTypeStatusList.clear();
    CommonDropDownModel service1 =
        new CommonDropDownModel(id: "1", name: "Active");
    CommonDropDownModel service2 =
        new CommonDropDownModel(id: "-1", name: "Inactive");

    expenseTypeStatusList.addAll([service1, service2]);
    notifyListeners();
  }

  Future<void> getReportServiceDropdownList(String userId) async {
    reportServiceList.clear();
    final response = await http.get(Uri.parse(
        AppUrl.reportServiceDropdownList.replaceAll("_userId", userId)));
    print(AppUrl.getVehicleType);
    if (response.statusCode == 200) {
      var result =
          ReportServiceDropdownResponse.fromJson(json.decode(response.body));

      if (result.data != null) {
        reportServiceList.clear();
        for (var _list in result.data as List<ReportServiceDropdownDTO>) {
          CommonDropDownModel service = new CommonDropDownModel(
              id: _list.id.toString(), name: _list.reportName);
          if (!reportServiceList.any((x) => x.id == service.id)) {
            reportServiceList.add(service);
          }
        }
      }
      notifyListeners();
    } else {
      throw Exception('Failed to expense type');
    }
  }

  Future<void> getExpenseType(String userId) async {
    expenseTypeList.clear();
    final response = await http.get(Uri.parse(AppUrl.getExpenseTypeList
        .replaceAll("_userId", userId)
        .replaceAll("_active", "1")));
    print(AppUrl.getVehicleType);
    if (response.statusCode == 200) {
      var result = ExpenseTypeModel.fromJson(json.decode(response.body));

      if (result.data != null) {
        for (var _list in result.data ?? []) {
          CommonDropDownModel service = new CommonDropDownModel(
              id: _list.id.toString(), name: _list.name);
          expenseTypeList.add(service);
        }
      }
      notifyListeners();
    } else {
      throw Exception('Failed to expense type');
    }
  }

  Future<List<ServiceDataModel>> getServicingList(
      String vehicleId, String userId) async {
    final responseData = await http.get(Uri.parse(AppUrl.getServicingList
        .replaceAll("_vehicleId", vehicleId)
        .replaceAll("_ownerId", userId)));
    print("fetchGarageList  1 " + responseData.toString());
    if (responseData.statusCode == 200) {
      // Iterable l = json.decode(responseData.body)['data'];
      // List<ServiceDataModel> serviceList = List<ServiceDataModel>.from(l.map((model)=> ServiceDataModel.fromJson(model)));
      List<ServiceDataModel>? serviceList =
          ServiceModel.fromJson(jsonDecode(responseData.body)).data;

      return serviceList!;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> getVehicleType() async {
    final response = await http.get(Uri.parse(AppUrl.getVehicleType));
    print(AppUrl.getVehicleType);
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body)['data'];
      List<VehicleType> vehicleTypeList =
          List<VehicleType>.from(l.map((model) => VehicleType.fromJson(model)));

      vehicleTypeComList.clear();
      CommonDropDownModel service =
          new CommonDropDownModel(id: "-1", name: "Please select", title: "");
      vehicleTypeComList.add(service);

      for (var _list in vehicleTypeList) {
        CommonDropDownModel service = new CommonDropDownModel(
            id: _list.Id.toString(),
            name: _list.VechileType,
            title: _list.CreatedBy);
        vehicleTypeComList.add(service);
      }

      notifyListeners();
      print(vehicleTypeList);
      //  this.sendRequestRes = sendRequestRes;
      notifyListeners();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> getLocationType() async {
    final response = await http.get(Uri.parse(AppUrl.getLocationType));
    print(AppUrl.getLocationType);
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body)['data'];
      List<VehicleType> vehicleTypeList =
          List<VehicleType>.from(l.map((model) => VehicleType.fromJson(model)));

      vehicleTypeComList.clear();
      CommonDropDownModel service =
          new CommonDropDownModel(id: "-1", name: "Please select", title: "");
      vehicleTypeComList.add(service);

      for (var _list in vehicleTypeList) {
        CommonDropDownModel service = new CommonDropDownModel(
            id: _list.Id.toString(),
            name: _list.VechileType,
            title: _list.CreatedBy);
        vehicleTypeComList.add(service);
      }

      notifyListeners();
      print(vehicleTypeList);
      //  this.sendRequestRes = sendRequestRes;
      notifyListeners();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> fetchVehicleDetails(String userId, String? requestType) async {
    final response = await http
        .get(Uri.parse(AppUrl.getVehicleList.replaceAll("_userId", userId)));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("VehicleInfo  $userId" +
          "" +
          VehicleInfoModel.fromJson(jsonDecode(response.body)).toString() +
          "  " +
          response.body);
      vehicleModelList = VehicleInfoModel.fromJson(jsonDecode(response.body))
          .data as List<VehicleInfoDataModel>;
      vehicleShortList.clear();
      if (requestType == "report") {
        vehicleShortList
            .add(new CommonDropDownModel(id: "0", name: "All", title: ""));
      }
      for (var _list in vehicleModelList) {
        CommonDropDownModel service = new CommonDropDownModel(
            id: _list.id.toString(),
            name: "${_list.brandName}-${_list.modelName}",
            title: _list.modelName);
        vehicleShortList.add(service);
      }

      notifyListeners();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> fetchAssignedVehicle({String? driverId, String? ownerId}) async {
    vehicleAssignedShortList.clear();
    final response = await http.get(Uri.parse(AppUrl.getAssignedVehicle
        .replaceAll("_driverid", driverId.toString())
        .replaceAll("_ownerid", ownerId.toString())));

    if (response.statusCode == 200) {
      vehiclelList = VechileListResponse.fromJson(jsonDecode(response.body))
          .data as List<VechileList>;
      vehicleAssignedShortList.clear();
      for (var _list in vehiclelList) {
        CommonDropDownModel service = new CommonDropDownModel(
            id: _list.id.toString(),
            name: "${_list.brandName}-${_list.modelName}",
            title: _list.brandName);
        vehicleAssignedShortList.add(service);
      }

      notifyListeners();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> fetchGarageList(String userId) async {
    final responseData = await http
        .get(Uri.parse(AppUrl.garageList.replaceAll("_userId", userId)));
    var result;
    if (responseData.statusCode == 200) {
      Iterable l = json.decode(responseData.body)['data'];
      List<GarageModel> garageModel =
          List<GarageModel>.from(l.map((model) => GarageModel.fromJson(model)));
      print("fetchGarageList  " + garageModel.toString());

      garageList.clear();
      for (var _list in garageModel) {
        CommonDropDownModel service = new CommonDropDownModel(
            id: _list.id.toString(),
            name: _list.gargeName,
            title: _list.gargeNameLocation);
        garageList.add(service);
      }

      notifyListeners();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<void> getServiceListDropDown(String userId) async {
    final responseData = await http.get(
        Uri.parse(AppUrl.getServiceListDropDown.replaceAll("_userId", userId)));
    var result;
    if (responseData.statusCode == 200) {
      Iterable l = json.decode(responseData.body)['data'];
      List<ServiceNameModel> serviceNameModel = List<ServiceNameModel>.from(
          l.map((model) => ServiceNameModel.fromJson(model)));
      print("getServiceListDropDown  " + serviceNameModel.toString());

      serviceNameList.clear();
      for (var _list in serviceNameModel) {
        CommonDropDownModel service = new CommonDropDownModel(
            id: _list.id.toString(),
            name: _list.serviceName,
            title: _list.timeStamp);
        serviceNameList.add(service);
      }

      notifyListeners();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<void> fetchDriverList(String userId) async {
    final responseData = await http
        .get(Uri.parse(AppUrl.getDriverList.replaceAll("_userId", userId)));
    var result;
    if (responseData.statusCode == 200) {
      Iterable l = json.decode(responseData.body)['data'];
      List<DriverListModel> driverList = List<DriverListModel>.from(
          l.map((model) => DriverListModel.fromJson(model)));
      print("fetchGarageList  " + driverList.toString());

      driverCommonList.clear();
      for (var _list in driverList) {
        CommonDropDownModel service = new CommonDropDownModel(
            id: _list.Id.toString(), name: _list.Name, title: _list.MobileNo);
        driverCommonList.add(service);
      }

      notifyListeners();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> getVehicleEnergyType() async {
    final responseData = await http.get(Uri.parse(AppUrl.getVehicleEnergyType));
    var result;
    if (responseData.statusCode == 200) {
      Iterable l = json.decode(responseData.body)['data'];
      List<VehicleEnergyTypeModel> energyType =
          List<VehicleEnergyTypeModel>.from(
              l.map((model) => VehicleEnergyTypeModel.fromJson(model)));
      print("fetchGarageList  " + energyType.toString());

      vehicleEnergyType.clear();
      for (var _list in energyType) {
        CommonDropDownModel service = new CommonDropDownModel(
            id: _list.id.toString(),
            name: "${_list.energySourceType} (${_list.unit?.toLowerCase()})",
            title: _list.createdBy);
        vehicleEnergyType.add(service);
      }

      notifyListeners();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<dynamic> serviceUpdate(
      String Id,
      String GargeInfoId,
      String VechileId,
      String ServiceCostId,
      String DriverId,
      String Status,
      String Date,
      String NextServiceDate,
      String TotalAmount,
      String ExpenseSlip,
      String partsImg,
      List<RequestServiceModel> ServiceLists) async {
    final Map<String, dynamic> registrationData = {
      'Id': Id,
      'GargeInfoId': GargeInfoId,
      'VechileId': VechileId,
      'ServiceCostId': ServiceCostId,
      "DriverId": DriverId,
      "Status": Status,
      'Date': Date,
      'NextServiceDate': NextServiceDate,
      'TotalAmount': TotalAmount,
      'ExpenseSlip': ExpenseSlip,
      'PartsImg': partsImg,
      'ServiceLists': RequestServiceModel.encondeToJson(ServiceLists),
    };
    print(registrationData);
    return await post(Uri.parse(AppUrl.serviceInfo),
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

  Future<void> getUserType({type: String}) async {
    Response response = await get(
      Uri.parse(AppUrl.getusertype),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      UserTypeModel userType = UserTypeModel.fromJson(responseData);

      userTypeModel.clear();
      for (var _list in userType.result!) {
        if (type == "DRIVER") {
          if (_list.id == 2) {
            CommonDropDownModel service = new CommonDropDownModel(
                id: _list.id.toString(), name: _list.userTypeName, title: "");
            userTypeModel.add(service);
          }
        } else {
          if (_list.id != 2) {
            CommonDropDownModel service = new CommonDropDownModel(
                id: _list.id.toString(), name: _list.userTypeName, title: "");
            userTypeModel.add(service);
          }
        }
      }
      notifyListeners();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<void> getSearchDriverList(int ownerId) async {
    final response = await http.get(Uri.parse(AppUrl.searchDriverQ
        // .replaceAll("_mobileno", mobileNo)
        // .replaceAll("_name", name)
        .replaceAll("_ownerId", ownerId.toString())));
    // print(AppUrl.searchDriver.replaceAll("_mobileno", mobileNo));
    if (response.statusCode == 200) {
      // final Map<String, dynamic> responseData = json.decode(response.body);
      Iterable l = json.decode(response.body)['data'];
      List<SearchDriverModel> driverList = List<SearchDriverModel>.from(
          l.map((model) => SearchDriverModel.fromJson(model)));
      print(driverList.length);
      this.searchDriverModel = driverList;

      notifyListeners();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<void> getPoliceFreezingList(String _userId, String _ownerId) async {
    final responseData = await http.get(Uri.parse(AppUrl
        .getPoliceFreezingDocList
        .replaceAll("_userId", _userId)
        .replaceAll("_ownerId", _ownerId)));
    print("policeFreezingListApi url " +
        AppUrl.getPoliceFreezingDocList
            .replaceAll("_userId", _userId)
            .replaceAll("_ownerId", _ownerId));

    var result;
    if (responseData.statusCode == 200) {
      Iterable l = json.decode(responseData.body)['data'];
      List<PoliceFreezingDocModel> policeFreezing =
          List<PoliceFreezingDocModel>.from(
              l.map((model) => PoliceFreezingDocModel.fromJson(model)));
      print("policeFreezingListApi  " + policeFreezing.toString());
      policeFreezingList.clear();
      for (var _list in policeFreezing) {
        CommonDropDownModel policeFreeing = new CommonDropDownModel(
            id: _list.id.toString(),
            name: _list.policeFreezingDocName,
            title: _list.timeStamp);
        policeFreezingList.add(policeFreeing);
      }

      notifyListeners();
    } else {
      throw Exception('Failed to load album');
    }
  }

  // Future<void> sendDriverAllocateRequest(
  //     String driverId, String ownerId, String vechileId) async {
  //   final response = await http.get(Uri.parse(AppUrl.sendDriverAllocateRequest
  //       .replaceAll("_driverId", driverId)
  //       .replaceAll("_ownerId", ownerId)
  //       .replaceAll("_vechileId", vechileId)));
  //   print(AppUrl.sendDriverAllocateRequest
  //       .replaceAll("_driverId", driverId)
  //       .replaceAll("_ownerId", ownerId)
  //       .replaceAll("_vechileId", vechileId));
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseData = json.decode(response.body);
  //     SendRequestRes sendRequestRes = SendRequestRes.fromJson(responseData);
  //     print(sendRequestRes.otp);
  //     this.sendRequestRes = sendRequestRes;

  //     notifyListeners();
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load album');
  //   }
  // }

  Future<void> sendListOfDriverAllocateRequest(
      String driverId, String ownerId, List<String> vechileList) async {
    var dataList = vechileList.map((e) {
      return VechielDriveReq(
          driverId: driverId, ownerId: ownerId, vechileId: e, hash: "");
    }).toList();

    print(dataList.length);

    final response = await http.post(
        Uri.parse(AppUrl.sendListOfDriverAllocateRequest),
        body: json.encode(dataList),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      SendRequestRes sendRequestRes = SendRequestRes.fromJson(responseData);
      print(sendRequestRes.otp);
      this.sendRequestRes = sendRequestRes;

      notifyListeners();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<void> confirmDriverAllocateRequest(String Id) async {
    final response = await http.get(
        Uri.parse(AppUrl.confirmDriverAllocateRequest.replaceAll("_id", Id)));
    print(AppUrl.confirmDriverAllocateRequest.replaceAll("_id", Id));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      // SendRequestRes sendRequestRes = SendRequestRes.fromJson(responseData);
      print(responseData);
      //  this.sendRequestRes = sendRequestRes;
      notifyListeners();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<void> removeDriverFromAllocation(
      String _ownerId, String _driverId) async {
    final response = await http.get(Uri.parse(AppUrl.removeDriverFromAllocation
        .replaceAll("_ownerId", _ownerId)
        .replaceAll("_driverId", _driverId)));
    print(AppUrl.removeDriverFromAllocation
        .replaceAll("_ownerId", _ownerId)
        .replaceAll("_driverId", _driverId));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      // SendRequestRes sendRequestRes = SendRequestRes.fromJson(responseData);
      print(responseData);
      //  this.sendRequestRes = sendRequestRes;
      notifyListeners();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<void> getVehicleGeneralInfo(String infoId, String parentId,
      String vehicleTypeForModelId, String ownerId) async {
    print("ownerID   $ownerId  ${AppConstant.userId}");
    final response = await http.get(Uri.parse(AppUrl.vehicleGeneralInfo
        .replaceAll("_infoId", infoId)
        .replaceAll("_parentId", parentId)
        .replaceAll("_vehicleTypeForModelId", vehicleTypeForModelId)
        .replaceAll("_ownerId", ownerId)));
    print(AppUrl.vehicleGeneralInfo
        .replaceAll("_infoId", infoId)
        .replaceAll("_parentId", parentId)
        .replaceAll("_vehicleTypeForModelId", vehicleTypeForModelId)
        .replaceAll("_ownerId", ownerId));
    if (response.statusCode == 200) {
      // final Map<String, dynamic> responseData = json.decode(response.body);

      final Map<String, dynamic> responseData = json.decode(response.body);
      VehicleGeneralInfoModel vehicleGeneralInfoModel =
          VehicleGeneralInfoModel.fromJson(responseData);
      CommonDropDownModel service =
          new CommonDropDownModel(id: "-1", name: "Please select", title: "");
      if (infoId == "1") {
        vehicleBrandNameList.clear();
        vehicleBrandNameList.add(service);
      } else if (infoId == "2") {
        vehicleModelNameList.clear();
        vehicleModelNameList.add(service);
      } else if (infoId == "3") {
        vehicleColourNameList.clear();
        vehicleColourNameList.add(service);
      }
      for (var _list in vehicleGeneralInfoModel.result!) {
        CommonDropDownModel service = new CommonDropDownModel(
            id: _list.id.toString(), name: _list.text, title: "");
        if (infoId == "1") {
          vehicleBrandNameList.add(service);
          print(vehicleBrandNameList.length);
        } else if (infoId == "2") {
          vehicleModelNameList.add(service);
        } else if (infoId == "3") {
          vehicleColourNameList.add(service);
        }
      }
      print(vehicleBrandNameList.length);
      notifyListeners();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<dynamic> getMonthlyReport(
    String fromDate,
    String toDate,
    String vehicleId,
    String servicingType,
    String ownerId,
  ) async {
    final Map<String, dynamic> registrationData = {
      'FromDate': fromDate,
      'Todate': toDate,
      'VechileId': vehicleId,
      'ServicingType': servicingType,
      "OwnerId": ownerId,
    };

    return await post(Uri.parse(AppUrl.getExpenseReport),
            body: json.encode(registrationData),
            headers: {'Content-Type': 'application/json'})
        .then(onServiceReport)
        .catchError(onError);
  }

  Future<String> getRegistrationNo(String vehicleId) async {
    final response = await get(Uri.parse(AppUrl.vehicleRegistrationNo.replaceAll("_vechileId", vehicleId)));
    if (response.statusCode == 200) {
      var data = json.decode(response.body)["regno"] ?? "";
      return data;
    } else {
      return "";
    }
  }

  Future<bool> getAllocationDeallocation({ownerId: String, driverId: String}) async {
    var response = await get(Uri.parse(AppUrl.driverAllocationDeallocation
        .replaceAll("_ownerId", ownerId.toString())
        .replaceAll("_driverId", driverId.toString())));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<FutureOr> onServiceReport(Response response) async {
    if (response.statusCode == 200) {
      expenseReportModel.clear();
      Iterable l = json.decode(response.body)['result'];
      expenseReportModel = List<ExpenseReportModel>.from(
          l.map((model) => ExpenseReportModel.fromJson(model)));
      notifyListeners();
    } else {
      throw Exception('Failed to load album');
    }
  }
}
