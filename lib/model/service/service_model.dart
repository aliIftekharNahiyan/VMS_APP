class ServiceModel {
  List<ServiceDataModel>? data;

  ServiceModel({
    this.data,
  });

  ServiceModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] as List?)?.map((dynamic e) => ServiceDataModel.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['data'] = data?.map((e) => e.toJson()).toList();
    return json;
  }
}

class ServiceDataModel {
  ServiceList? serviceList;
  List<ServiceCost>? serviceCost;

  ServiceDataModel({
    this.serviceList,
    this.serviceCost,
  });

  ServiceDataModel.fromJson(Map<String, dynamic> json) {
    serviceList = (json['ServiceList'] as Map<String,dynamic>?) != null ? ServiceList.fromJson(json['ServiceList'] as Map<String,dynamic>) : null;
    serviceCost = (json['ServiceCost'] as List?)?.map((dynamic e) => ServiceCost.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['ServiceList'] = serviceList?.toJson();
    json['ServiceCost'] = serviceCost?.map((e) => e.toJson()).toList();
    return json;
  }
}

class ServiceList {
  ServiceList({
    int? servicingId,
    String? gargeName,
    String? gargeNameLocation,
    String? serviceNo,
    String? date,
    String? nextServiceDate,
    double? totalAmount,
    String? engineNumber,
    String? brandName,
    String? milage,
    String? modelName,
    String? vechileNumber,
    String? driverName,
    String? drivingLicense,
    String? vechileId,
    String? ownerId,
    String? otherImg,
    String? expenseSlip,
    String? partsImg,
    int? gargeId,
    int? driverId,
  }){
    _servicingId = servicingId;
    _gargeName = gargeName;
    _gargeNameLocation = gargeNameLocation;
    _serviceNo = serviceNo;
    _date = date;
    _nextServiceDate = nextServiceDate;
    _totalAmount = totalAmount;
    _engineNumber = engineNumber;
    _brandName = brandName;
    _milage = milage;
    _modelName = modelName;
    _vechileNumber = vechileNumber;
    _driverName = driverName;
    _drivingLicense = drivingLicense;
    _vechileId = vechileId;
    _ownerId = ownerId;
    _otherImg = otherImg;
    _expenseSlip = expenseSlip;
    _partsImg = partsImg;
    _gargeId = gargeId;
    _driverId = driverId;
  }

  ServiceList.fromJson(dynamic json) {
    _servicingId = json['ServicingId'];
    _gargeName = json['GargeName'];
    _gargeNameLocation = json['GargeNameLocation'];
    _serviceNo = json['ServiceNo'];
    _date = json['Date'];
    _nextServiceDate = json['NextServiceDate'];
    _totalAmount = json['TotalAmount'];
    _engineNumber = json['EngineNumber'];
    _brandName = json['BrandName'];
    _milage = json['Milage'];
    _modelName = json['ModelName'];
    _vechileNumber = json['VechileNumber'];
    _driverName = json['DriverName'];
    _drivingLicense = json['DrivingLicense'];
    _vechileId = json['VechileId'];
    _ownerId = json['OwnerId'];
    _otherImg = json['OtherImg'];
    _expenseSlip = json['ExpenseSlip'];
    _partsImg = json['PartsImg'];
    _gargeId = json['GargeId'];
    _driverId = json['DriverId'];
  }
  int? _servicingId;
  String? _gargeName;
  String? _gargeNameLocation;
  String? _serviceNo;
  String? _date;
  String? _nextServiceDate;
  double? _totalAmount;
  String? _engineNumber;
  String? _brandName;
  String? _milage;
  String? _modelName;
  String? _vechileNumber;
  String? _driverName;
  String? _drivingLicense;
  String? _vechileId;
  String? _ownerId;
  String? _otherImg;
  String? _expenseSlip;
  String? _partsImg;
  int? _gargeId;
  int? _driverId;

  int? get servicingId => _servicingId;
  String? get gargeName => _gargeName;
  String? get gargeNameLocation => _gargeNameLocation;
  String? get serviceNo => _serviceNo;
  String? get date => _date;
  String? get nextServiceDate => _nextServiceDate;
  double? get totalAmount => _totalAmount;
  String? get engineNumber => _engineNumber;
  String? get brandName => _brandName;
  String? get milage => _milage;
  String? get modelName => _modelName;
  String? get vechileNumber => _vechileNumber;
  String? get driverName => _driverName;
  String? get drivingLicense => _drivingLicense;
  String? get vechileId => _vechileId;
  String? get ownerId => _ownerId;
  String? get otherImg => _otherImg;
  String? get expenseSlip => _expenseSlip;
  String? get partsImg => _partsImg;
  int? get gargeId => _gargeId;
  int? get driverId => _driverId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ServicingId'] = _servicingId;
    map['GargeName'] = _gargeName;
    map['GargeNameLocation'] = _gargeNameLocation;
    map['ServiceNo'] = _serviceNo;
    map['Date'] = _date;
    map['NextServiceDate'] = _nextServiceDate;
    map['TotalAmount'] = _totalAmount;
    map['EngineNumber'] = _engineNumber;
    map['BrandName'] = _brandName;
    map['Milage'] = _milage;
    map['ModelName'] = _modelName;
    map['VechileNumber'] = _vechileNumber;
    map['DriverName'] = _driverName;
    map['DrivingLicense'] = _drivingLicense;
    map['VechileId'] = _vechileId;
    map['OwnerId'] = _ownerId;
    map['OtherImg'] = _otherImg;
    map['ExpenseSlip'] = _expenseSlip;
    map['PartsImg'] = _partsImg;
    map['GargeId'] = _gargeId;
    map['DriverId'] = _driverId;
    return map;
  }

}

class ServiceCost {
  ServiceCost({
    int? id,
    int? servicingId,
    String? serviceName,
    double? cost,
    String? date,
    String? timeStamp,
    dynamic img,
    String? details,
  }){
    _id = id;
    _servicingId = servicingId;
    _serviceName = serviceName;
    _cost = cost;
    _date = date;
    _timeStamp = timeStamp;
    _img = img;
    _details = details;
  }

  ServiceCost.fromJson(dynamic json) {
    _id = json['Id'];
    _servicingId = json['ServicingId'];
    _serviceName = json['ServiceName'];
    _cost = json['Cost'];
    _date = json['Date'];
    _timeStamp = json['TimeStamp'];
    _img = json['Img'];
    _details = json['Details'];
  }
  int? _id;
  int? _servicingId;
  String? _serviceName;
  double? _cost;
  String? _date;
  String? _timeStamp;
  dynamic _img;
  String? _details;

  int? get id => _id;
  int? get servicingId => _servicingId;
  String? get serviceName => _serviceName;
  double? get cost => _cost;
  String? get date => _date;
  String? get timeStamp => _timeStamp;
  dynamic get img => _img;
  String? get details => _details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['ServicingId'] = _servicingId;
    map['ServiceName'] = _serviceName;
    map['Cost'] = _cost;
    map['Date'] = _date;
    map['TimeStamp'] = _timeStamp;
    map['Img'] = _img;
    map['Details'] = _details;

    return map;
  }

}