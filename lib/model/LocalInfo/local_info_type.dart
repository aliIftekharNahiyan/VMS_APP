class LocalInfoType {
  List<Result>? result;

  LocalInfoType({this.result});

  LocalInfoType.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? id;
  String? informationTypeName;
  String? timeStamp;

  Result({this.id, this.informationTypeName, this.timeStamp});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    informationTypeName = json['InformationTypeName'];
    timeStamp = json['TimeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['InformationTypeName'] = this.informationTypeName;
    data['TimeStamp'] = this.timeStamp;
    return data;
  }
}