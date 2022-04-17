class UserTypeModel {
  UserTypeModel({
      List<Result>? result,}){
    _result = result;
}

  UserTypeModel.fromJson(dynamic json) {
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
      String? userTypeName,}){
    _id = id;
    _userTypeName = userTypeName;
}

  Result.fromJson(dynamic json) {
    _id = json['Id'];
    _userTypeName = json['UserTypeName'];
  }
  int? _id;
  String? _userTypeName;

  int? get id => _id;
  String? get userTypeName => _userTypeName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['UserTypeName'] = _userTypeName;
    return map;
  }

}