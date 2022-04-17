class ExpenseReportModel {
  ExpenseReportModel({
      String? type, 
      String? date, 
      String? eventName, 
      String? cost, 
      String? brandName, 
      String? modelName,}){
    _type = type;
    _date = date;
    _eventName = eventName;
    _cost = cost;
    _brandName = brandName;
    _modelName = modelName;
}

  ExpenseReportModel.fromJson(dynamic json) {
    _type = json['Type'];
    _date = json['Date'];
    _eventName = json['EventName'];
    _cost = json['Cost'];
    _brandName = json['BrandName'];
    _modelName = json['ModelName'];
  }
  String? _type;
  String? _date;
  String? _eventName;
  String? _cost;
  String? _brandName;
  String? _modelName;

  String? get type => _type;
  String? get date => _date;
  String? get eventName => _eventName;
  String? get cost => _cost;
  String? get brandName => _brandName;
  String? get modelName => _modelName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Type'] = _type;
    map['Date'] = _date;
    map['EventName'] = _eventName;
    map['Cost'] = _cost;
    map['BrandName'] = _brandName;
    map['ModelName'] = _modelName;
    return map;
  }

}