class LocalInfoReq {
  int? localInfoSaveId;
  String? lat;
  String? lon;

  LocalInfoReq({this.localInfoSaveId, this.lat, this.lon});

  LocalInfoReq.fromJson(Map<String, dynamic> json) {
    localInfoSaveId = json['LocalInfoSaveId'];
    lat = json['Lat'];
    lon = json['Lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LocalInfoSaveId'] = this.localInfoSaveId;
    data['Lat'] = this.lat;
    data['Lon'] = this.lon;
    return data;
  }
}