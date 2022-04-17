class FuelListModel {
  FuelListModel({
      int? id, 
      int? vechileId, 
      int? driveId, 
      int? energyType, 
      String? stationName, 
      String? amount, 
      String? slipImg, 
      int? haveFuelAlert, 
      String? fuelTime, 
      int? status, 
      String? timeStamp, 
      String? brandName, 
      String? cc, 
      String? chasisNumber, 
      String? engineNumber, 
      String? fuleTaken, 
      String? driverName, 
      int? ownerId,}){
    _id = id;
    _vechileId = vechileId;
    _driveId = driveId;
    _energyType = energyType;
    _stationName = stationName;
    _amount = amount;
    _slipImg = slipImg;
    _haveFuelAlert = haveFuelAlert;
    _fuelTime = fuelTime;
    _status = status;
    _timeStamp = timeStamp;
    _brandName = brandName;
    _cc = cc;
    _chasisNumber = chasisNumber;
    _engineNumber = engineNumber;
    _fuleTaken = fuleTaken;
    _driverName = driverName;
    _ownerId = ownerId;
}

  FuelListModel.fromJson(dynamic json) {
    _id = json['Id'];
    _vechileId = json['VechileId'];
    _driveId = json['DriveId'];
    _energyType = json['EnergyType'];
    _stationName = json['StationName'];
    _amount = json['Amount'];
    _slipImg = json['SlipImg'];
    _haveFuelAlert = json['HaveFuelAlert'];
    _fuelTime = json['FuelTime'];
    _status = json['Status'];
    _timeStamp = json['TimeStamp'];
    _brandName = json['BrandName'];
    _cc = json['CC'];
    _chasisNumber = json['ChasisNumber'];
    _engineNumber = json['EngineNumber'];
    _fuleTaken = json['FuleTaken'];
    _driverName = json['DriverName'];
    _ownerId = json['OwnerId'];
  }
  int? _id;
  int? _vechileId;
  int? _driveId;
  int? _energyType;
  String? _stationName;
  String? _amount;
  String? _slipImg;
  int? _haveFuelAlert;
  String? _fuelTime;
  int? _status;
  String? _timeStamp;
  String? _brandName;
  String? _cc;
  String? _chasisNumber;
  String? _engineNumber;
  String? _fuleTaken;
  String? _driverName;
  int? _ownerId;

  int? get id => _id;
  int? get vechileId => _vechileId;
  int? get driveId => _driveId;
  int? get energyType => _energyType;
  String? get stationName => _stationName;
  String? get amount => _amount;
  String? get slipImg => _slipImg;
  int? get haveFuelAlert => _haveFuelAlert;
  String? get fuelTime => _fuelTime;
  int? get status => _status;
  String? get timeStamp => _timeStamp;
  String? get brandName => _brandName;
  String? get cc => _cc;
  String? get chasisNumber => _chasisNumber;
  String? get engineNumber => _engineNumber;
  String? get fuleTaken => _fuleTaken;
  String? get driverName => _driverName;
  int? get ownerId => _ownerId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['VechileId'] = _vechileId;
    map['DriveId'] = _driveId;
    map['EnergyType'] = _energyType;
    map['StationName'] = _stationName;
    map['Amount'] = _amount;
    map['SlipImg'] = _slipImg;
    map['HaveFuelAlert'] = _haveFuelAlert;
    map['FuelTime'] = _fuelTime;
    map['Status'] = _status;
    map['TimeStamp'] = _timeStamp;
    map['BrandName'] = _brandName;
    map['CC'] = _cc;
    map['ChasisNumber'] = _chasisNumber;
    map['EngineNumber'] = _engineNumber;
    map['FuleTaken'] = _fuleTaken;
    map['DriverName'] = _driverName;
    map['OwnerId'] = _ownerId;
    return map;
  }

}