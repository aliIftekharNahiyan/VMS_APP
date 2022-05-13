class LocalInfoRes {
  String? result;
  List<Data>? data;

  LocalInfoRes({this.result, this.data});

  LocalInfoRes.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? details;
  String? lat;
  String? lon;
  int? id;
  String? others;
  String? informationTypeName;
  String? mobileNo;
  int? localTypeId;

  Data(
      {this.name,
      this.details,
      this.lat,
      this.lon,
      this.id,
      this.others,
      this.informationTypeName,
      this.mobileNo,
      this.localTypeId});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    details = json['Details'];
    lat = json['Lat'];
    lon = json['Lon'];
    id = json['Id'];
    others = json['Others'];
    informationTypeName = json['InformationTypeName'];
    mobileNo = json['MobileNo'];
    localTypeId = json['LocalTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Details'] = this.details;
    data['Lat'] = this.lat;
    data['Lon'] = this.lon;
    data['Id'] = this.id;
    data['Others'] = this.others;
    data['InformationTypeName'] = this.informationTypeName;
    data['MobileNo'] = this.mobileNo;
    data['LocalTypeId'] = this.localTypeId;
    return data;
  }
}