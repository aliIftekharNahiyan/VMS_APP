import 'package:get/get.dart';

class SelectedDropDown extends GetxController {
  String _vehicleId = "";
  String get vehicleId => _vehicleId;

  String _garageId = "";
  String get garageId => _garageId;

  String _driverId = "";
  String get driverId => _driverId;


  String _vehicleEnergyTypeId = "";
  String get vehicleEnergyTypeId => _vehicleEnergyTypeId;


  set vehicleId(String vehicleId) {
    _vehicleId = vehicleId;
    update();
  }

  set garageId(String garageId) {
    _garageId = garageId;
    update();
  }

  set driverId(String driverId) {
    _driverId = driverId;
    update();
  }

  set vehicleEnergyTypeId(String vehicleEnergyTypeId) {
    _vehicleEnergyTypeId = vehicleEnergyTypeId;
    update();
  }



  String _userTypeId = "";
  String get userTypeId => _userTypeId;
  set userTypeId(String userTypeId) {
    _userTypeId = userTypeId;
    update();
  }

  String _vehicleTypeId = "";
  String get vehicleTypeId => _vehicleTypeId;
  set vehicleTypeId(String vehicleTypeId) {
    _vehicleTypeId = vehicleTypeId;
    update();
  }


  String _vehicleStatusId = "1";
  String get vehicleStatusId => _vehicleStatusId;
  set vehicleStatusId(String vehicleStatusId) {
    _vehicleStatusId = vehicleStatusId;
    update();
  }

  String _vehicleBrandId = "";
  String get vehicleBrandId => _vehicleBrandId;
  set vehicleBrandId(String vehicleBrandId) {
    _vehicleBrandId = vehicleBrandId;
    update();
  }

  String _vehicleModelId = "";
  String get vehicleModelId => _vehicleModelId;
  set vehicleModelId(String vehicleModelId) {
    _vehicleModelId = vehicleModelId;
    update();
  }

  String _vehicleColourId = "";
  String get vehicleColourId => _vehicleColourId;
  set vehicleColourId(String vehicleColourId) {
    _vehicleColourId = vehicleColourId;
    update();
  }


  String _vehicleBrandFullName = "";
  String get vehicleBrandFullName => _vehicleBrandFullName;
  set vehicleBrandFullName(String vehicleBrandFullName) {
    _vehicleBrandFullName = vehicleBrandFullName;
    update();
  }

  String _vehicleModelFullName = "";
  String get vehicleModelFullName => _vehicleModelFullName;
  set vehicleModelFullName(String vehicleModelFullName) {
    _vehicleModelFullName = vehicleModelFullName;
    update();
  }

  String _vehicleColourFullName = "";
  String get vehicleColourFullName => _vehicleColourFullName;
  set vehicleColourFullName(String vehicleColourFullName) {
    _vehicleColourFullName = vehicleColourFullName;
    update();
  }


  String _serviceType = "";
  String get serviceType => _serviceType;
  set serviceType(String serviceType) {
    _serviceType = serviceType;
    update();
  }

  String _policeFreezingDoc = "";
  String get policeFreezingDoc => _policeFreezingDoc;
  set policeFreezingDoc(String policeFreezingDoc) {
    _policeFreezingDoc = policeFreezingDoc;
    update();
  }



  String _serviceNameListName = "";
  String get serviceNameListName => _serviceNameListName;
  set serviceNameListName(String serviceNameListName) {
    _serviceNameListName = serviceNameListName;
    update();
  }

  String _serviceNameListId = "";
  String get serviceNameListId => _serviceNameListId;
  set serviceNameListId(String serviceNameListId) {
    _serviceNameListId = serviceNameListId;
    update();
  }
}

