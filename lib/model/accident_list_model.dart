/// Id : 20011
/// DriveId : 42
/// VechileId : 1
/// TripId : 0
/// AccidentImg : ""
/// AccidentLocation : ""
/// Others : ""
/// InsuranceCover : null
/// Fine : 500.00
/// AccidentTime : null
/// Status : 1
/// TimeStamp : "2021-11-30T12:35:05.743"
/// DriverName : "tariquul"
/// BrandName : "sample string 7"
/// CC : "sample string 9"
/// ChasisNumber : "sample string 5"
/// EngineNumber : "24324345342312"
/// OwnerId : 20051

class AccidentListModel {
  AccidentListModel({
      int? id, 
      int? driveId, 
      int? vechileId, 
      int? tripId, 
      String? accidentImg, 
      String? accidentLocation, 
      String? others, 
      dynamic insuranceCover, 
      double? fine, 
      dynamic accidentTime, 
      int? status, 
      String? timeStamp, 
      String? driverName, 
      String? brandName, 
      String? cc, 
      String? chasisNumber, 
      String? engineNumber, 
      int? ownerId,
    String? accidentDetails,}){
    _id = id;
    _driveId = driveId;
    _vechileId = vechileId;
    _tripId = tripId;
    _accidentImg = accidentImg;
    _accidentLocation = accidentLocation;
    _others = others;
    _insuranceCover = insuranceCover;
    _fine = fine;
    _accidentTime = accidentTime;
    _status = status;
    _timeStamp = timeStamp;
    _driverName = driverName;
    _brandName = brandName;
    _cc = cc;
    _chasisNumber = chasisNumber;
    _engineNumber = engineNumber;
    _ownerId = ownerId;
    _accidentDetails = accidentDetails;
}

  AccidentListModel.fromJson(dynamic json) {
    _id = json['Id'];
    _driveId = json['DriveId'];
    _vechileId = json['VechileId'];
    _tripId = json['TripId'];
    _accidentImg = json['AccidentImg'];
    _accidentLocation = json['AccidentLocation'];
    _others = json['Others'];
    _insuranceCover = json['InsuranceCover'];
    _fine = json['Fine'];
    _accidentTime = json['AccidentTime'];
    _status = json['Status'];
    _timeStamp = json['TimeStamp'];
    _driverName = json['DriverName'];
    _brandName = json['BrandName'];
    _cc = json['CC'];
    _chasisNumber = json['ChasisNumber'];
    _engineNumber = json['EngineNumber'];
    _ownerId = json['OwnerId'];
    _accidentDetails = json['AccidentDetails'];
  }
  int? _id;
  int? _driveId;
  int? _vechileId;
  int? _tripId;
  String? _accidentImg;
  String? _accidentLocation;
  String? _others;
  dynamic _insuranceCover;
  double? _fine;
  dynamic _accidentTime;
  int? _status;
  String? _timeStamp;
  String? _driverName;
  String? _brandName;
  String? _cc;
  String? _chasisNumber;
  String? _engineNumber;
  int? _ownerId;
  String? _accidentDetails;
  int? get id => _id;
  int? get driveId => _driveId;
  int? get vechileId => _vechileId;
  int? get tripId => _tripId;
  String? get accidentImg => _accidentImg;
  String? get accidentLocation => _accidentLocation;
  String? get others => _others;
  dynamic get insuranceCover => _insuranceCover;
  double? get fine => _fine;
  dynamic get accidentTime => _accidentTime;
  int? get status => _status;
  String? get timeStamp => _timeStamp;
  String? get driverName => _driverName;
  String? get brandName => _brandName;
  String? get cc => _cc;
  String? get chasisNumber => _chasisNumber;
  String? get engineNumber => _engineNumber;
  int? get ownerId => _ownerId;
  String? get accidentDetails => _accidentDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['DriveId'] = _driveId;
    map['VechileId'] = _vechileId;
    map['TripId'] = _tripId;
    map['AccidentImg'] = _accidentImg;
    map['AccidentLocation'] = _accidentLocation;
    map['Others'] = _others;
    map['InsuranceCover'] = _insuranceCover;
    map['Fine'] = _fine;
    map['AccidentTime'] = _accidentTime;
    map['Status'] = _status;
    map['TimeStamp'] = _timeStamp;
    map['DriverName'] = _driverName;
    map['BrandName'] = _brandName;
    map['CC'] = _cc;
    map['ChasisNumber'] = _chasisNumber;
    map['EngineNumber'] = _engineNumber;
    map['OwnerId'] = _ownerId;
    map['AccidentDetails'] = _accidentDetails;

    return map;
  }

}