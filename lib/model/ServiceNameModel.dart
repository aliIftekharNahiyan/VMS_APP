class ServiceNameModel {
  ServiceNameModel({
      int? id, 
      String? serviceName, 
      int? userId, 
      int? ownerId, 
      String? timeStamp,}){
    _id = id;
    _serviceName = serviceName;
    _userId = userId;
    _ownerId = ownerId;
    _timeStamp = timeStamp;
}

  ServiceNameModel.fromJson(dynamic json) {
    _id = json['Id'];
    _serviceName = json['ServiceName'];
    _userId = json['UserId'];
    _ownerId = json['OwnerId'];
    _timeStamp = json['TimeStamp'];
  }
  int? _id;
  String? _serviceName;
  int? _userId;
  int? _ownerId;
  String? _timeStamp;

  int? get id => _id;
  String? get serviceName => _serviceName;
  int? get userId => _userId;
  int? get ownerId => _ownerId;
  String? get timeStamp => _timeStamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['ServiceName'] = _serviceName;
    map['UserId'] = _userId;
    map['OwnerId'] = _ownerId;
    map['TimeStamp'] = _timeStamp;
    return map;
  }
  bool isEqual(ServiceNameModel model) {
    return this.serviceName == model.serviceName;
  }

  static List<ServiceNameModel> fromJsonList(List list) {
    if (list == null);
    return list.map((item) => ServiceNameModel.fromJson(item)).toList();
  }
}