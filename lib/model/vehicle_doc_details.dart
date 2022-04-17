class VehicleDocDetailsModel {
  VehicleDocDetailsModel({
      int? id, 
      int? status, 
      int? documentId, 
      int? vechileId, 
      String? coverageDetails, 
      String? insuranceImg,
      String? expiryDate,
      String? timeStamp, 
      String? brandName, 
      String? cc, 
      String? chasisNumber, 
      String? engineNumber, 
      String? ownerName, 
      String? documentName, 
      int? ownerId, 
      String? jsonData, 
      String? regdate,
    String? otherExpense,
    String? feesAmount,
    String? registrationNumber,}){
    _id = id;
    _status = status;
    _documentId = documentId;
    _vechileId = vechileId;
    _coverageDetails = coverageDetails;
    _insuranceImg = insuranceImg;
    _expiryDate = expiryDate;
    _timeStamp = timeStamp;
    _brandName = brandName;
    _cc = cc;
    _chasisNumber = chasisNumber;
    _engineNumber = engineNumber;
    _ownerName = ownerName;
    _documentName = documentName;
    _ownerId = ownerId;
    _jsonData = jsonData;
    _regdate = regdate;
    _otherExpense = otherExpense;
    _feesAmount = feesAmount;
    _registrationNumber = registrationNumber;
}

  VehicleDocDetailsModel.fromJson(dynamic json) {
    _id = json['Id'];
    _status = json['Status'];
    _documentId = json['DocumentId'];
    _vechileId = json['VechileId'];
    _coverageDetails = json['CoverageDetails'];
    _insuranceImg = json['InsuranceImg'];
    _expiryDate = json['ExpiryDate'];
    _timeStamp = json['TimeStamp'];
    _brandName = json['BrandName'];
    _cc = json['CC'];
    _chasisNumber = json['ChasisNumber'];
    _engineNumber = json['EngineNumber'];
    _ownerName = json['OwnerName'];
    _documentName = json['DocumentName'];
    _ownerId = json['OwnerId'];
    _jsonData = json['JsonData'];
    _regdate = json['Regdate'];
    _otherExpense = json['OtherExpense'];
    _feesAmount = json['FeesAmount'];
    _registrationNumber = json['RegistrationNumber'];
  }
  int? _id;
  int? _status;
  int? _documentId;
  int? _vechileId;
  String? _coverageDetails;
  String? _insuranceImg;
  String? _expiryDate;
  String? _timeStamp;
  String? _brandName;
  String? _cc;
  String? _chasisNumber;
  String? _engineNumber;
  String? _ownerName;
  String? _documentName;
  int? _ownerId;
  String? _jsonData;
  String? _regdate;
  String? _otherExpense;
  String? _feesAmount;
  String? _registrationNumber;

  int? get id => _id;
  int? get status => _status;
  int? get documentId => _documentId;
  int? get vechileId => _vechileId;
  String? get coverageDetails => _coverageDetails;
  String? get insuranceImg => _insuranceImg;
  String? get expiryDate => _expiryDate;
  String? get timeStamp => _timeStamp;
  String? get brandName => _brandName;
  String? get cc => _cc;
  String? get chasisNumber => _chasisNumber;
  String? get engineNumber => _engineNumber;
  String? get ownerName => _ownerName;
  String? get documentName => _documentName;
  int? get ownerId => _ownerId;
  String? get jsonData => _jsonData;
  String? get regdate => _regdate;
  String? get otherExpense => _otherExpense;
  String? get feesAmount => _feesAmount;
  String? get registrationNumber => _registrationNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['Status'] = _status;
    map['DocumentId'] = _documentId;
    map['VechileId'] = _vechileId;
    map['CoverageDetails'] = _coverageDetails;
    map['InsuranceImg'] = _insuranceImg;
    map['ExpiryDate'] = _expiryDate;
    map['TimeStamp'] = _timeStamp;
    map['BrandName'] = _brandName;
    map['CC'] = _cc;
    map['ChasisNumber'] = _chasisNumber;
    map['EngineNumber'] = _engineNumber;
    map['OwnerName'] = _ownerName;
    map['DocumentName'] = _documentName;
    map['OwnerId'] = _ownerId;
    map['JsonData'] = _jsonData;
    map['Regdate'] = _regdate;
    map['OtherExpense'] = _otherExpense;
    map['FeesAmount'] = _feesAmount;
    map['RegistrationNumber'] = _registrationNumber;
    return map;
  }

}