class VehicleInfoModel {
  VehicleInfoModel({
      String? result, 
      List<VehicleInfoDataModel>? data,}){
    _result = result;
    _data = data;
}

  VehicleInfoModel.fromJson(dynamic json) {
    _result = json['result'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(VehicleInfoDataModel.fromJson(v));
      });
    }
  }
  String? _result;
  List<VehicleInfoDataModel>? _data;

  String? get result => _result;
  List<VehicleInfoDataModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = _result;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
class VehicleInfoDataModel {
  VehicleInfoDataModel({
    int? ownerId,
    int? id,
    String? brandName,
    int? brandId,
    String? cc,
    String? chasisNumber,
    String? engineNumber,
    String? modelName,
    int? modelId,
    int? vechileEnergySourceId,
    String? vechileImage,
    int? vechileTypeId,
    int? createdBy,
    String? milage,
    int? vechileRentId,
    int? status,
    String? colorName,
    int? colorId,
    String? registrationDate,
    String? registrationExpireDate,
    String? timeStamp,
    String? vechileNumber,
    String? vechileTierSize,
    String? fitnessExpireDate,
    String? insuranceExpireDate,
    String? taxTokenExpireDate,
    String? routePermitExpireDate,
   String? modelYear,
   String? tierNumber,
  }){
    _ownerId = ownerId;
    _id = id;
    _brandName = brandName;
    _brandId = brandId;
    _cc = cc;
    _chasisNumber = chasisNumber;
    _engineNumber = engineNumber;
    _modelName = modelName;
    _modelId = modelId;
    _vechileEnergySourceId = vechileEnergySourceId;
    _vechileImage = vechileImage;
    _vechileTypeId = vechileTypeId;
    _createdBy = createdBy;
    _milage = milage;
    _vechileRentId = vechileRentId;
    _status = status;
    _colorName = colorName;
    _colorId = colorId;
    _registrationDate = registrationDate;
    _registrationExpireDate = registrationExpireDate;
    _timeStamp = timeStamp;
    _vechileNumber = vechileNumber;
    _vechileTierSize = vechileTierSize;
    _fitnessExpireDate = fitnessExpireDate;
    _insuranceExpireDate = insuranceExpireDate;
    _taxTokenExpireDate = taxTokenExpireDate;
    _routePermitExpireDate = routePermitExpireDate;
    _modelYear = modelYear;
    _tierNumber = tierNumber;

  }

  VehicleInfoDataModel.fromJson(dynamic json) {
    _ownerId = json['OwnerId'];
    _id = json['Id'];
    _brandName = json['BrandName'];
    _brandId = json['BrandId'];
    _cc = json['CC'];
    _chasisNumber = json['ChasisNumber'];
    _engineNumber = json['EngineNumber'];
    _modelName = json['ModelName'];
    _modelId = json['ModelId'];
    _vechileEnergySourceId = json['VechileEnergySourceId'];
    _vechileImage = json['VechileImage'];
    _vechileTypeId = json['VechileTypeId'];
    _createdBy = json['CreatedBy'];
    _milage = json['Milage'];
    _vechileRentId = json['VechileRentId'];
    _status = json['Status'];
    _colorName = json['ColorName'];
    _colorId = json['ColorId'];
    _registrationDate = json['RegistrationDate'];
    _registrationExpireDate = json['RegistrationExpireDate'];
    _timeStamp = json['TimeStamp'];
    _vechileNumber = json['VechileNumber'];
    _vechileTierSize = json['VechileTierSize'];
    _fitnessExpireDate = json['FitnessExpireDate'];
    _insuranceExpireDate = json['InsuranceExpireDate'];
    _taxTokenExpireDate = json['TaxTokenExpireDate'];
    _routePermitExpireDate = json['RoutePermitExpireDate'];
    _modelYear = json['ModelYear'];
    _tierNumber = json['TierNumber'];

  }
  int? _ownerId;
  int? _id;
  String? _brandName;
  int? _brandId;
  String? _cc;
  String? _chasisNumber;
  String? _engineNumber;
  String? _modelName;
  int? _modelId;
  int? _vechileEnergySourceId;
  String? _vechileImage;
  int? _vechileTypeId;
  int? _createdBy;
  String? _milage;
  int? _vechileRentId;
  int? _status;
  String? _colorName;
  int? _colorId;
  String? _registrationDate;
  String? _registrationExpireDate;
  String? _timeStamp;
  String? _vechileNumber;
  String? _vechileTierSize;
  String? _fitnessExpireDate;
  String? _insuranceExpireDate;
  String? _taxTokenExpireDate;
  String? _routePermitExpireDate;
  String? _modelYear;
  String? _tierNumber;
  int? get ownerId => _ownerId;
  int? get id => _id;
  String? get brandName => _brandName;
  int? get brandId => _brandId;
  String? get cc => _cc;
  String? get chasisNumber => _chasisNumber;
  String? get engineNumber => _engineNumber;
  String? get modelName => _modelName;
  int? get modelId => _modelId;
  int? get vechileEnergySourceId => _vechileEnergySourceId;
  String? get vechileImage => _vechileImage;
  int? get vechileTypeId => _vechileTypeId;
  int? get createdBy => _createdBy;
  String? get milage => _milage;
  int? get vechileRentId => _vechileRentId;
  int? get status => _status;
  String? get colorName => _colorName;
  int? get colorId => _colorId;
  String? get registrationDate => _registrationDate;
  String? get registrationExpireDate => _registrationExpireDate;
  String? get timeStamp => _timeStamp;
  String? get vechileNumber => _vechileNumber;
  String? get vechileTierSize => _vechileTierSize;
  String? get fitnessExpireDate => _fitnessExpireDate;
  String? get insuranceExpireDate => _insuranceExpireDate;
  String? get taxTokenExpireDate => _taxTokenExpireDate;
  String? get routePermitExpireDate => _routePermitExpireDate;
  String? get modelYear => _modelYear;
  String? get tierNumber => _tierNumber;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OwnerId'] = _ownerId;
    map['Id'] = _id;
    map['BrandName'] = _brandName;
    map['BrandId'] = _brandId;
    map['CC'] = _cc;
    map['ChasisNumber'] = _chasisNumber;
    map['EngineNumber'] = _engineNumber;
    map['ModelName'] = _modelName;
    map['ModelId'] = _modelId;
    map['VechileEnergySourceId'] = _vechileEnergySourceId;
    map['VechileImage'] = _vechileImage;
    map['VechileTypeId'] = _vechileTypeId;
    map['CreatedBy'] = _createdBy;
    map['Milage'] = _milage;
    map['VechileRentId'] = _vechileRentId;
    map['Status'] = _status;
    map['ColorName'] = _colorName;
    map['ColorId'] = _colorId;
    map['RegistrationDate'] = _registrationDate;
    map['RegistrationExpireDate'] = _registrationExpireDate;
    map['TimeStamp'] = _timeStamp;
    map['VechileNumber'] = _vechileNumber;
    map['VechileTierSize'] = _vechileTierSize;
    map['FitnessExpireDate'] = _fitnessExpireDate;
    map['InsuranceExpireDate'] = _insuranceExpireDate;
    map['TaxTokenExpireDate'] = _taxTokenExpireDate;
    map['RoutePermitExpireDate'] = _routePermitExpireDate;
    map['ModelYear'] = _modelYear;
    map['TierNumber'] = _tierNumber;
    return map;
  }
  set vechileImage(String? vechileImage) {
    _vechileImage = vechileImage;
  }
  set registrationDate(String? registrationDate) {
    _registrationDate = registrationDate;
  }
  set registrationExpireDate(String? registrationExpireDate) {
    _registrationExpireDate = registrationExpireDate;
  }
  set fitnessExpireDate(String? fitnessExpireDate) {
    _fitnessExpireDate = fitnessExpireDate;
  }

  set insuranceExpireDate(String? insuranceExpireDate) {
    _insuranceExpireDate = insuranceExpireDate;
  }
  set taxTokenExpireDate(String? taxTokenExpireDate) {
    _taxTokenExpireDate = taxTokenExpireDate;
  }
  set routePermitExpireDate(String? routePermitExpireDate) {
    _routePermitExpireDate = routePermitExpireDate;
  }
}