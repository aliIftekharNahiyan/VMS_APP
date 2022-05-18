class SearchTypes {
  List<LocationType>? result;

  SearchTypes({this.result});

  SearchTypes.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <LocationType>[];
      json['result'].forEach((v) {
        result!.add(new LocationType.fromJson(v));
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

class LocationType {
  int? id;
  String? informationTypeName;
  String? timeStamp;

  LocationType({this.id, this.informationTypeName, this.timeStamp});

  LocationType.fromJson(Map<String, dynamic> json) {
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