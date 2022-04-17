class SendRequestRes {
  SendRequestRes({
      String? result, 
      Data? data, 
      String? otp, 
      String? reason,}){
    _result = result;
    _data = data;
    _otp = otp;
    _reason = reason;
}

  SendRequestRes.fromJson(dynamic json) {
    _result = json['result'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _otp = json['otp'];
    _reason = json['reason'];
  }
  String? _result;
  Data? _data;
  String? _otp;
  String? _reason;

  String? get result => _result;
  Data? get data => _data;
  String? get otp => _otp;
  String? get reason => _reason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = _result;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['otp'] = _otp;
    map['reason'] = _reason;
    return map;
  }

}

class Data {
  Data({
      int? id, 
      int? driverId, 
      int? ownerId, 
      int? vechileId, 
      String? otp, 
      String? timeStamp,}){
    _id = id;
    _driverId = driverId;
    _ownerId = ownerId;
    _vechileId = vechileId;
    _otp = otp;
    _timeStamp = timeStamp;
}

  Data.fromJson(dynamic json) {
    _id = json['Id'];
    _driverId = json['DriverId'];
    _ownerId = json['OwnerId'];
    _vechileId = json['VechileId'];
    _otp = json['OTP'];
    _timeStamp = json['TimeStamp'];
  }
  int? _id;
  int? _driverId;
  int? _ownerId;
  int? _vechileId;
  String? _otp;
  String? _timeStamp;

  int? get id => _id;
  int? get driverId => _driverId;
  int? get ownerId => _ownerId;
  int? get vechileId => _vechileId;
  String? get otp => _otp;
  String? get timeStamp => _timeStamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['DriverId'] = _driverId;
    map['OwnerId'] = _ownerId;
    map['VechileId'] = _vechileId;
    map['OTP'] = _otp;
    map['TimeStamp'] = _timeStamp;
    return map;
  }

}