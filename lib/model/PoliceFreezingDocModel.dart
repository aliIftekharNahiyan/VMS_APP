class PoliceFreezingDocModel {
  PoliceFreezingDocModel({
      int? id, 
      String? policeFreezingDocName, 
      dynamic timeStamp,}){
    _id = id;
    _policeFreezingDocName = policeFreezingDocName;
    _timeStamp = timeStamp;
}

  PoliceFreezingDocModel.fromJson(dynamic json) {
    _id = json['Id'];
    _policeFreezingDocName = json['PoliceFreezingDocName'];
    _timeStamp = json['TimeStamp'];
  }
  int? _id;
  String? _policeFreezingDocName;
  dynamic _timeStamp;

  int? get id => _id;
  String? get policeFreezingDocName => _policeFreezingDocName;
  dynamic get timeStamp => _timeStamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['PoliceFreezingDocName'] = _policeFreezingDocName;
    map['TimeStamp'] = _timeStamp;
    return map;
  }

}