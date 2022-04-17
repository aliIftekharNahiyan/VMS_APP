class VehicleListModel {
  int? id;
  int? vechileTypeId;
  int? ownerId;
  String? vechileImage;
  String? vechileNumber;
  String? engineNumber;
  String? chasisNumber;
  String? modelName;
  String? brandName;
  String? vechileTierSize;
  String? registrationDate;
  String? registrationExpireDate;
  int? vechileRentId;
  String? cC;
  String? milage;
  int? vechileEnergySourceId;
  int? status;
  int? createdBy;
  String? timeStamp;

  VehicleListModel(
      {this.id,
      this.vechileTypeId,
      this.ownerId,
      this.vechileImage,
      this.vechileNumber,
      this.engineNumber,
      this.chasisNumber,
      this.modelName,
      this.brandName,
      this.vechileTierSize,
      this.registrationDate,
      this.registrationExpireDate,
      this.vechileRentId,
      this.cC,
      this.milage,
      this.vechileEnergySourceId,
      this.status,
      this.createdBy,
      this.timeStamp});

  VehicleListModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    vechileTypeId = json['VechileTypeId'];
    ownerId = json['OwnerId'];
    vechileImage = json['VechileImage'];
    vechileNumber = json['VechileNumber'];
    engineNumber = json['EngineNumber'];
    chasisNumber = json['ChasisNumber'];
    modelName = json['ModelName'];
    brandName = json['BrandName'];
    vechileTierSize = json['VechileTierSize'];
    registrationDate = json['RegistrationDate'];
    registrationExpireDate = json['RegistrationExpireDate'];
    vechileRentId = json['VechileRentId'];
    cC = json['CC'];
    milage = json['Milage'];
    vechileEnergySourceId = json['VechileEnergySourceId'];
    status = json['Status'];
    createdBy = json['CreatedBy'];
    timeStamp = json['TimeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['VechileTypeId'] = this.vechileTypeId;
    data['OwnerId'] = this.ownerId;
    data['VechileImage'] = this.vechileImage;
    data['VechileNumber'] = this.vechileNumber;
    data['EngineNumber'] = this.engineNumber;
    data['ChasisNumber'] = this.chasisNumber;
    data['ModelName'] = this.modelName;
    data['BrandName'] = this.brandName;
    data['VechileTierSize'] = this.vechileTierSize;
    data['RegistrationDate'] = this.registrationDate;
    data['RegistrationExpireDate'] = this.registrationExpireDate;
    data['VechileRentId'] = this.vechileRentId;
    data['CC'] = this.cC;
    data['Milage'] = this.milage;
    data['VechileEnergySourceId'] = this.vechileEnergySourceId;
    data['Status'] = this.status;
    data['CreatedBy'] = this.createdBy;
    data['TimeStamp'] = this.timeStamp;
    return data;
  }
}