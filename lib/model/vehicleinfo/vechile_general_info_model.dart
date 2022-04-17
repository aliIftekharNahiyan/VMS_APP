class VehicleGeneralInfoModel {
  VehicleGeneralInfoModel({
      List<Result>? result,}){
    _result = result;
}

  VehicleGeneralInfoModel.fromJson(dynamic json) {
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(Result.fromJson(v));
      });
    }
  }
  List<Result>? _result;

  List<Result>? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Result {
  Result({
      int? id, 
      String? text, 
      int? hasChild,}){
    _id = id;
    _text = text;
    _hasChild = hasChild;
}

  Result.fromJson(dynamic json) {
    _id = json['Id'];
    _text = json['Text'];
    _hasChild = json['HasChild'];
  }
  int? _id;
  String? _text;
  int? _hasChild;

  int? get id => _id;
  String? get text => _text;
  int? get hasChild => _hasChild;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['Text'] = _text;
    map['HasChild'] = _hasChild;
    return map;
  }

}