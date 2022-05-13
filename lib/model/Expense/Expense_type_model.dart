class ExpenseTypeModel {
  String? result;
  List<Data>? data;

  ExpenseTypeModel({this.result, this.data});

  ExpenseTypeModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  int? userId;
  String? timeStamp;
  int? status;

  Data({this.id, this.name, this.userId, this.timeStamp, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    userId = json['UserId'];
    timeStamp = json['TimeStamp'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['UserId'] = this.userId;
    data['TimeStamp'] = this.timeStamp;
    data['Status'] = this.status;
    return data;
  }
}