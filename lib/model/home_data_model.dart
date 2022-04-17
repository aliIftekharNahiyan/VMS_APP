class HomeDataModel {
  HomeDataModel({
      String? result,
    HomeData? data,}){
    _result = result;
    _data = data;
}

  HomeDataModel.fromJson(dynamic json) {
    _result = json['result'];
    _data = json['data'] != null ? HomeData.fromJson(json['data']) : null;
  }
  String? _result;
  HomeData? _data;

  String? get result => _result;
  HomeData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = _result;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class HomeData {
  HomeData({
      List<String>? needToknow, 
      MonthlyReport? monthlyReport, 
      List<FuelReport>? fuelReport,}){
    _needToknow = needToknow;
    _monthlyReport = monthlyReport;
    _fuelReport = fuelReport;
}

  HomeData.fromJson(dynamic json) {
    _needToknow = json['needToknow'] != null ? json['needToknow'].cast<String>() : [];
    _monthlyReport = json['monthlyReport'] != null ? MonthlyReport.fromJson(json['monthlyReport']) : null;
    if (json['fuelReport'] != null) {
      _fuelReport = [];
      json['fuelReport'].forEach((v) {
        _fuelReport?.add(FuelReport.fromJson(v));
      });
    }
  }
  List<String>? _needToknow;
  MonthlyReport? _monthlyReport;
  List<FuelReport>? _fuelReport;

  List<String>? get needToknow => _needToknow;
  MonthlyReport? get monthlyReport => _monthlyReport;
  List<FuelReport>? get fuelReport => _fuelReport;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['needToknow'] = _needToknow;
    if (_monthlyReport != null) {
      map['monthlyReport'] = _monthlyReport?.toJson();
    }
    if (_fuelReport != null) {
      map['fuelReport'] = _fuelReport?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class FuelReport {
  FuelReport({
      String? month, 
      int? year,
      bool? dataAvailable,
      List<Fuel>? fuel,}){
    _month = month;
    _year = year;
    _fuel = fuel;
    _dataAvailable = dataAvailable;
}

  FuelReport.fromJson(dynamic json) {
    _month = json['Month'];
    _year = json['Year'];
    _dataAvailable = json['DataAvailable'];
    if (json['Fuel'] != null) {
      _fuel = [];
      json['Fuel'].forEach((v) {
        _fuel?.add(Fuel.fromJson(v));
      });
    }
  }
  String? _month;
  int? _year;
  bool? _dataAvailable;
  List<Fuel>? _fuel;

  String? get month => _month;
  int? get year => _year;
  bool? get dataAvailable => _dataAvailable;
  List<Fuel>? get fuel => _fuel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Month'] = _month;
    map['Year'] = _year;
    map['DataAvailable'] = _dataAvailable;

    if (_fuel != null) {
      map['Fuel'] = _fuel?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Fuel {
  Fuel({
      String? date, 
      String? fuelConsumed,}){
    _date = date;
    _fuelConsumed = fuelConsumed;
}

  Fuel.fromJson(dynamic json) {
    _date = json['Date'];
    _fuelConsumed = json['FuelConsumed'];
  }
  String? _date;
  String? _fuelConsumed;

  String? get date => _date;
  String? get fuelConsumed => _fuelConsumed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Date'] = _date;
    map['FuelConsumed'] = _fuelConsumed;
    return map;
  }

}

class MonthlyReport {
  MonthlyReport({
      List<Analytics>? analytics,}){
    _analytics = analytics;
}

  MonthlyReport.fromJson(dynamic json) {
    if (json['Analytics'] != null) {
      _analytics = [];
      json['Analytics'].forEach((v) {
        _analytics?.add(Analytics.fromJson(v));
      });
    }
  }
  List<Analytics>? _analytics;

  List<Analytics>? get analytics => _analytics;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_analytics != null) {
      map['Analytics'] = _analytics?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Analytics {
  Analytics({
      String? name, 
      String? year, 
      Data? data,}){
    _name = name;
    _year = year;
    _data = data;
}

  Analytics.fromJson(dynamic json) {
    _name = json['Name'];
    _year = json['Year'];
    _data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
  }
  String? _name;
  String? _year;
  Data? _data;

  String? get name => _name;
  String? get year => _year;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Name'] = _name;
    map['Year'] = _year;
    if (_data != null) {
      map['Data'] = _data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      double? fuel, 
      int? accident, 
      int? totalEarned, 
      int? servicing,
     String? fuelCost,
     String? servicingCost}){
    _fuel = fuel;
    _accident = accident;
    _totalEarned = totalEarned;
    _servicing = servicing;
    _fuelCost = fuelCost;
    _servicingCost = servicingCost;
}

  Data.fromJson(dynamic json) {
    _fuel = json['Fuel'];
    _accident = json['Accident'];
    _totalEarned = json['TotalEarned'];
    _servicing = json['Servicing'];
    _fuelCost = json['FuelCost'];
    _servicingCost = json['ServicingCost'];
  }
  double? _fuel;
  int? _accident;
  int? _totalEarned;
  int? _servicing;
  String? _fuelCost;
  String? _servicingCost;

  double? get fuel => _fuel;
  int? get accident => _accident;
  int? get totalEarned => _totalEarned;
  int? get servicing => _servicing;
  String? get fuelCost => _fuelCost;
  String? get servicingCost => _servicingCost;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Fuel'] = _fuel;
    map['Accident'] = _accident;
    map['TotalEarned'] = _totalEarned;
    map['Servicing'] = _servicing;
    map['FuelCost'] = _fuelCost;
    map['ServicingCost'] = _servicingCost;
    return map;
  }

}