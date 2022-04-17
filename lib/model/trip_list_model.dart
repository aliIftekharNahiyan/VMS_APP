class TripListModel {
  TripListModel({
    int? status,
    int? driverId,
    int? vechileId,
    String? fine,
    String? fuelConsumption,
    int? id,
    String? income,
    int? isAccepted,
    String? mapImg,
    String? startPoint,
    String? endPoint,
    String? poliseCase,
    String? tollFees,
    String? tripAcceptOrRejectTime,
    String? tripStartTime,
    String? tripEndTime,
    int? ownerId,
    String? milage,
    String? modelName,
    String? brandName,
    String? vechileNumber,
    String? driverName,
    String? drivingLicense,
    String? licenseExpiryDate,
    String? mobileNo,
    String? StartPointName,
    String? EndPointName,
  }) {
    _status = status;
    _driverId = driverId;
    _vechileId = vechileId;
    _fine = fine;
    _fuelConsumption = fuelConsumption;
    _id = id;
    _income = income;
    _isAccepted = isAccepted;
    _mapImg = mapImg;
    _startPoint = startPoint;
    _endPoint = endPoint;
    _poliseCase = poliseCase;
    _tollFees = tollFees;
    _tripAcceptOrRejectTime = tripAcceptOrRejectTime;
    _tripStartTime = tripStartTime;
    _tripEndTime = tripEndTime;
    _ownerId = ownerId;
    _milage = milage;
    _modelName = modelName;
    _brandName = brandName;
    _vechileNumber = vechileNumber;
    _driverName = driverName;
    _drivingLicense = drivingLicense;
    _licenseExpiryDate = licenseExpiryDate;
    _mobileNo = mobileNo;
    _StartPointName = StartPointName;
    _EndPointName = EndPointName;
  }

  TripListModel.fromJson(dynamic json) {
    _status = json['Status'];
    _driverId = json['DriverId'];
    _vechileId = json['VechileId'];
    _fine = json['Fine'];
    _fuelConsumption = json['FuelConsumption'];
    _id = json['Id'];
    _income = json['Income'];
    _isAccepted = json['IsAccepted'];
    _mapImg = json['MapImg'];
    _startPoint = json['StartPoint'];
    _endPoint = json['EndPoint'];
    _poliseCase = json['PoliseCase'];
    _tollFees = json['TollFees'];
    _tripAcceptOrRejectTime = json['TripAcceptOrRejectTime'];
    _tripStartTime = json['TripStartTime'];
    _tripEndTime = json['TripEndTime'];
    _ownerId = json['OwnerId'];
    _milage = json['Milage'];
    _modelName = json['ModelName'];
    _brandName = json['BrandName'];
    _vechileNumber = json['VechileNumber'];
    _driverName = json['DriverName'];
    _drivingLicense = json['DrivingLicense'];
    _licenseExpiryDate = json['LicenseExpiryDate'];
    _mobileNo = json['MobileNo'];
    _StartPointName = json['StartPointName'];
    _EndPointName = json['EndPointName'];
  }

  int? _status;
  int? _driverId;
  int? _vechileId;
  dynamic _fine;
  dynamic _fuelConsumption;
  int? _id;
  dynamic _income;
  int? _isAccepted;
  String? _mapImg;
  String? _startPoint;
  String? _endPoint;
  dynamic _poliseCase;
  dynamic _tollFees;
  String? _tripAcceptOrRejectTime;
  dynamic _tripStartTime;
  dynamic _tripEndTime;
  int? _ownerId;
  String? _milage;
  String? _modelName;
  String? _brandName;
  String? _vechileNumber;
  String? _driverName;
  String? _drivingLicense;
  dynamic _licenseExpiryDate;
  String? _mobileNo;
  String? _StartPointName;
  String? _EndPointName;

  int? get status => _status;

  int? get driverId => _driverId;

  int? get vechileId => _vechileId;

  dynamic get fine => _fine;

  dynamic get fuelConsumption => _fuelConsumption;

  int? get id => _id;

  dynamic get income => _income;

  int? get isAccepted => _isAccepted;

  String? get mapImg => _mapImg;

  String? get startPoint => _startPoint;

  String? get endPoint => _endPoint;

  dynamic get poliseCase => _poliseCase;

  dynamic get tollFees => _tollFees;

  String? get tripAcceptOrRejectTime => _tripAcceptOrRejectTime;

  dynamic get tripStartTime => _tripStartTime;

  dynamic get tripEndTime => _tripEndTime;

  int? get ownerId => _ownerId;

  String? get milage => _milage;

  String? get modelName => _modelName;

  String? get brandName => _brandName;

  String? get vechileNumber => _vechileNumber;

  String? get driverName => _driverName;

  String? get drivingLicense => _drivingLicense;

  dynamic get licenseExpiryDate => _licenseExpiryDate;

  String? get mobileNo => _mobileNo;
  String? get StartPointName => _StartPointName;
  String? get EndPointName => _EndPointName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['DriverId'] = _driverId;
    map['VechileId'] = _vechileId;
    map['Fine'] = _fine;
    map['FuelConsumption'] = _fuelConsumption;
    map['Id'] = _id;
    map['Income'] = _income;
    map['IsAccepted'] = _isAccepted;
    map['MapImg'] = _mapImg;
    map['StartPoint'] = _startPoint;
    map['EndPoint'] = _endPoint;
    map['PoliseCase'] = _poliseCase;
    map['TollFees'] = _tollFees;
    map['TripAcceptOrRejectTime'] = _tripAcceptOrRejectTime;
    map['TripStartTime'] = _tripStartTime;
    map['TripEndTime'] = _tripEndTime;
    map['OwnerId'] = _ownerId;
    map['Milage'] = _milage;
    map['ModelName'] = _modelName;
    map['BrandName'] = _brandName;
    map['VechileNumber'] = _vechileNumber;
    map['DriverName'] = _driverName;
    map['DrivingLicense'] = _drivingLicense;
    map['LicenseExpiryDate'] = _licenseExpiryDate;
    map['MobileNo'] = _mobileNo;
    map['StartPointName'] = _StartPointName;
    map['EndPointName'] = _EndPointName;
    return map;
  }
}
