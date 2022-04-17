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
      dynamic registrationDate, 
      String? registrationExpireDate, 
      String? timeStamp, 
      String? vechileNumber, 
      String? vechileTierSize, 
      String? fitnessExpireDate, 
      String? insuranceExpireDate, 
      String? taxTokenExpireDate, 
      dynamic routePermitExpireDate,}){
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
  dynamic _registrationDate;
  String? _registrationExpireDate;
  String? _timeStamp;
  String? _vechileNumber;
  String? _vechileTierSize;
  String? _fitnessExpireDate;
  String? _insuranceExpireDate;
  String? _taxTokenExpireDate;
  dynamic _routePermitExpireDate;

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
  dynamic get registrationDate => _registrationDate;
  String? get registrationExpireDate => _registrationExpireDate;
  String? get timeStamp => _timeStamp;
  String? get vechileNumber => _vechileNumber;
  String? get vechileTierSize => _vechileTierSize;
  String? get fitnessExpireDate => _fitnessExpireDate;
  String? get insuranceExpireDate => _insuranceExpireDate;
  String? get taxTokenExpireDate => _taxTokenExpireDate;
  dynamic get routePermitExpireDate => _routePermitExpireDate;

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
    return map;
  }

}