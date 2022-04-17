class AddBrandModel {
  AddBrandModel({
      Result? result,}){
    _result = result;
}

  AddBrandModel.fromJson(dynamic json) {
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  Result? _result;

  Result? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_result != null) {
      map['result'] = _result?.toJson();
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