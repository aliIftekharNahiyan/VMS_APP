class PoliceCaseModel {
  PoliceCaseModel({
      PoliceCaseList? policeCaseList, 
      List<DocumentFreezeingMapList>? documentFreezeingMapList,}){
    _policeCaseList = policeCaseList;
    _documentFreezeingMapList = documentFreezeingMapList;
}


  PoliceCaseModel.fromJson(Map<String, dynamic> json) {
    _policeCaseList = (json['PoliceCaseList'] as Map<String,dynamic>?) != null ? PoliceCaseList.fromJson(json['PoliceCaseList'] as Map<String,dynamic>) : null;
    _documentFreezeingMapList = (json['DocumentFreezeingMapList'] as List?)?.map((dynamic e) => DocumentFreezeingMapList.fromJson(e as Map<String,dynamic>)).toList();
  }


  PoliceCaseList? _policeCaseList;
  List<DocumentFreezeingMapList>? _documentFreezeingMapList;

  PoliceCaseList? get policeCaseList => _policeCaseList;
  List<DocumentFreezeingMapList>? get documentFreezeingMapList => _documentFreezeingMapList;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['PoliceCaseList'] = _policeCaseList;
    if (_documentFreezeingMapList != null) {
      json['DocumentFreezeingMapList'] = _documentFreezeingMapList?.map((v) => v.toJson()).toList();
    }
    return json;
  }
}

class DocumentFreezeingMapList {
  DocumentFreezeingMapList({
      int? id, 
      int? caseId, 
      int? policeFreeZingDocumentId, 
      String? timeStamp,}){
    _id = id;
    _caseId = caseId;
    _policeFreeZingDocumentId = policeFreeZingDocumentId;
    _timeStamp = timeStamp;
}

  DocumentFreezeingMapList.fromJson(dynamic json) {
    _id = json['Id'];
    _caseId = json['CaseId'];
    _policeFreeZingDocumentId = json['PoliceFreeZingDocumentId'];
    _timeStamp = json['TimeStamp'];
  }
  int? _id;
  int? _caseId;
  int? _policeFreeZingDocumentId;
  String? _timeStamp;

  int? get id => _id;
  int? get caseId => _caseId;
  int? get policeFreeZingDocumentId => _policeFreeZingDocumentId;
  String? get timeStamp => _timeStamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['CaseId'] = _caseId;
    map['PoliceFreeZingDocumentId'] = _policeFreeZingDocumentId;
    map['TimeStamp'] = _timeStamp;
    return map;
  }

}

class PoliceCaseList {
  PoliceCaseList({
      int? status, 
      int? vechileId, 
      double? caseAmount, 
      String? caseDate, 
      String? caseName, 
      int? driverId, 
      int? id, 
      String? timeStamp, 
      dynamic tripId, 
      String? brandName, 
      String? chasisNumber, 
      String? engineNumber, 
      String? modelName, 
      int? ownerId, 
      String? driverName, 
      String? cc, 
      String? img, 
      String? otherImg, 
      String? caseDetails, 
      String? policeStation, 
      String? location, 
      dynamic lastPaymentDate, 
      String? paperHandOver, 
      String? policeFreezingDocName, 
      int? isClear, 
      String? submissionLastDate,}){
    _status = status;
    _vechileId = vechileId;
    _caseAmount = caseAmount;
    _caseDate = caseDate;
    _caseName = caseName;
    _driverId = driverId;
    _id = id;
    _timeStamp = timeStamp;
    _tripId = tripId;
    _brandName = brandName;
    _chasisNumber = chasisNumber;
    _engineNumber = engineNumber;
    _modelName = modelName;
    _ownerId = ownerId;
    _driverName = driverName;
    _cc = cc;
    _img = img;
    _otherImg = otherImg;
    _caseDetails = caseDetails;
    _policeStation = policeStation;
    _location = location;
    _lastPaymentDate = lastPaymentDate;
    _paperHandOver = paperHandOver;
    _policeFreezingDocName = policeFreezingDocName;
    _isClear = isClear;
    _submissionLastDate = submissionLastDate;
}

  PoliceCaseList.fromJson(dynamic json) {
    _status = json['Status'];
    _vechileId = json['VechileId'];
    _caseAmount = json['CaseAmount'];
    _caseDate = json['CaseDate'];
    _caseName = json['CaseName'];
    _driverId = json['DriverId'];
    _id = json['Id'];
    _timeStamp = json['TimeStamp'];
    _tripId = json['TripId'];
    _brandName = json['BrandName'];
    _chasisNumber = json['ChasisNumber'];
    _engineNumber = json['EngineNumber'];
    _modelName = json['ModelName'];
    _ownerId = json['OwnerId'];
    _driverName = json['DriverName'];
    _cc = json['CC'];
    _img = json['Img'];
    _otherImg = json['OtherImg'];
    _caseDetails = json['CaseDetails'];
    _policeStation = json['PoliceStation'];
    _location = json['Location'];
    _lastPaymentDate = json['LastPaymentDate'];
    _paperHandOver = json['PaperHandOver'];
    _policeFreezingDocName = json['PoliceFreezingDocName'];
    _isClear = json['IsClear'];
    _submissionLastDate = json['SubmissionLastDate'];
  }
  int? _status;
  int? _vechileId;
  double? _caseAmount;
  String? _caseDate;
  String? _caseName;
  int? _driverId;
  int? _id;
  String? _timeStamp;
  dynamic _tripId;
  String? _brandName;
  String? _chasisNumber;
  String? _engineNumber;
  String? _modelName;
  int? _ownerId;
  String? _driverName;
  String? _cc;
  String? _img;
  String? _otherImg;
  String? _caseDetails;
  String? _policeStation;
  String? _location;
  dynamic _lastPaymentDate;
  String? _paperHandOver;
  String? _policeFreezingDocName;
  int? _isClear;
  String? _submissionLastDate;

  int? get status => _status;
  int? get vechileId => _vechileId;
  double? get caseAmount => _caseAmount;
  String? get caseDate => _caseDate;
  String? get caseName => _caseName;
  int? get driverId => _driverId;
  int? get id => _id;
  String? get timeStamp => _timeStamp;
  dynamic get tripId => _tripId;
  String? get brandName => _brandName;
  String? get chasisNumber => _chasisNumber;
  String? get engineNumber => _engineNumber;
  String? get modelName => _modelName;
  int? get ownerId => _ownerId;
  String? get driverName => _driverName;
  String? get cc => _cc;
  String? get img => _img;
  String? get otherImg => _otherImg;
  String? get caseDetails => _caseDetails;
  String? get policeStation => _policeStation;
  String? get location => _location;
  dynamic get lastPaymentDate => _lastPaymentDate;
  String? get paperHandOver => _paperHandOver;
  String? get policeFreezingDocName => _policeFreezingDocName;
  int? get isClear => _isClear;
  String? get submissionLastDate => _submissionLastDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['VechileId'] = _vechileId;
    map['CaseAmount'] = _caseAmount;
    map['CaseDate'] = _caseDate;
    map['CaseName'] = _caseName;
    map['DriverId'] = _driverId;
    map['Id'] = _id;
    map['TimeStamp'] = _timeStamp;
    map['TripId'] = _tripId;
    map['BrandName'] = _brandName;
    map['ChasisNumber'] = _chasisNumber;
    map['EngineNumber'] = _engineNumber;
    map['ModelName'] = _modelName;
    map['OwnerId'] = _ownerId;
    map['DriverName'] = _driverName;
    map['CC'] = _cc;
    map['Img'] = _img;
    map['OtherImg'] = _otherImg;
    map['CaseDetails'] = _caseDetails;
    map['PoliceStation'] = _policeStation;
    map['Location'] = _location;
    map['LastPaymentDate'] = _lastPaymentDate;
    map['PaperHandOver'] = _paperHandOver;
    map['PoliceFreezingDocName'] = _policeFreezingDocName;
    map['IsClear'] = _isClear;
    map['SubmissionLastDate'] = _submissionLastDate;
    return map;
  }

}