class VechileListResponse {
  String? result;
  List<VechileList>? data;

  VechileListResponse({this.result, this.data});

  VechileListResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['data'] != null) {
      data = <VechileList>[];
      json['data'].forEach((v) {
        data!.add(new VechileList.fromJson(v));
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

class VechileList {
  int? id;
  String? modelName;
  String? brandName;

  VechileList(
      {this.id,
      this.modelName,
      this.brandName});

  VechileList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    modelName = json['ModelName'];
    brandName = json['BrandName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ModelName'] = this.modelName;
    data['BrandName'] = this.brandName;
    return data;
  }
}