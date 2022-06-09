class FuelComsumptionData {
  String? result;
  List<Data>? data;

  FuelComsumptionData({this.result, this.data});

  FuelComsumptionData.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? fuelTime;
  int? fuelMonthNumber;
  String? fuelTimeMonthName;
  String? fuelTimeYear;
  int? count;
  double? amount;
  double? fuleTaken;

  Data(
      {this.fuelTime,
      this.fuelMonthNumber,
      this.fuelTimeMonthName,
      this.fuelTimeYear,
      this.count,
      this.amount,
      this.fuleTaken});

  Data.fromJson(Map<String, dynamic> json) {
    fuelTime = json['FuelTime'];
    fuelMonthNumber = json['FuelMonthNumber'];
    fuelTimeMonthName = json['FuelTimeMonthName'];
    fuelTimeYear = json['FuelTimeYear'];
    count = json['Count'];
    amount = json['Amount'];
    fuleTaken = json['FuleTaken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FuelTime'] = this.fuelTime;
    data['FuelMonthNumber'] = this.fuelMonthNumber;
    data['FuelTimeMonthName'] = this.fuelTimeMonthName;
    data['FuelTimeYear'] = this.fuelTimeYear;
    data['Count'] = this.count;
    data['Amount'] = this.amount;
    data['FuleTaken'] = this.fuleTaken;
    return data;
  }
}