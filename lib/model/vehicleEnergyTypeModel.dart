class VehicleEnergyTypeModel {
  int? id;
  String? energySourceType;
  String? createdBy;
  String? timeStamp;

  VehicleEnergyTypeModel(
      {this.id, this.energySourceType, this.createdBy, this.timeStamp});

  VehicleEnergyTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    energySourceType = json['EnergySourceType'];
    createdBy = json['CreatedBy'];
    timeStamp = json['TimeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['EnergySourceType'] = this.energySourceType;
    data['CreatedBy'] = this.createdBy;
    data['TimeStamp'] = this.timeStamp;
    return data;
  }
}