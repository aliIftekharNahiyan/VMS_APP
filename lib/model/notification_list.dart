class NotificationList {
  NotificationList({
      String? result, 
      List<Notifications>? data,
      int? unread,}){
    _result = result;
    _data = data;
    _unread = unread;
}

  NotificationList.fromJson(dynamic json) {
    _result = json['result'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Notifications.fromJson(v));
      });
    }
    _unread = json['unread'];
  }
  String? _result;
  List<Notifications>? _data;
  int? _unread;

  String? get result => _result;
  List<Notifications>? get data => _data;
  int? get unread => _unread;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = _result;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['unread'] = _unread;
    return map;
  }

}

class Notifications {
  Notifications({
      int? id, 
      int? vechileId, 
      int? driverId, 
      int? trpId, 
      String? notificationHead, 
      String? notificationDetails, 
      String? timeStamp, 
      int? ownerId,}){
    _id = id;
    _vechileId = vechileId;
    _driverId = driverId;
    _trpId = trpId;
    _notificationHead = notificationHead;
    _notificationDetails = notificationDetails;
    _timeStamp = timeStamp;
    _ownerId = ownerId;
}

  Notifications.fromJson(dynamic json) {
    _id = json['Id'];
    _vechileId = json['VechileId'];
    _driverId = json['DriverId'];
    _trpId = json['TrpId'];
    _notificationHead = json['NotificationHead'];
    _notificationDetails = json['NotificationDetails'];
    _timeStamp = json['TimeStamp'];
    _ownerId = json['OwnerId'];
  }
  int? _id;
  int? _vechileId;
  int? _driverId;
  int? _trpId;
  String? _notificationHead;
  String? _notificationDetails;
  String? _timeStamp;
  int? _ownerId;

  int? get id => _id;
  int? get vechileId => _vechileId;
  int? get driverId => _driverId;
  int? get trpId => _trpId;
  String? get notificationHead => _notificationHead;
  String? get notificationDetails => _notificationDetails;
  String? get timeStamp => _timeStamp;
  int? get ownerId => _ownerId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['VechileId'] = _vechileId;
    map['DriverId'] = _driverId;
    map['TrpId'] = _trpId;
    map['NotificationHead'] = _notificationHead;
    map['NotificationDetails'] = _notificationDetails;
    map['TimeStamp'] = _timeStamp;
    map['OwnerId'] = _ownerId;
    return map;
  }

}