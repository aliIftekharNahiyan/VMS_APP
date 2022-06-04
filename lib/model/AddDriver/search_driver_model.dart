class SearchDriverModel {
  SearchDriverModel({
      int? id, 
      int? userTypeId, 
      String? name, 
      String? mobileNo, 
      String? nid, 
      String? occupation, 
      String? address, 
      String? gender, 
      String? drivingLicense, 
      dynamic licenseExpiryDate, 
      dynamic salary, 
      dynamic bouns, 
      String? tradeLicense, 
      String? tinBin, 
      String? createdBy, 
      String? timeStamp, 
      String? password, 
      int? isOtpVerified, 
      int? ownerId, 
      dynamic profilePicture, 
      int? status, 
      dynamic vechileId, 
      dynamic isDriverAllocated,}){
    _id = id;
    _userTypeId = userTypeId;
    _name = name;
    _mobileNo = mobileNo;
    _nid = nid;
    _occupation = occupation;
    _address = address;
    _gender = gender;
    _drivingLicense = drivingLicense;
    _licenseExpiryDate = licenseExpiryDate;
    _salary = salary;
    _bouns = bouns;
    _tradeLicense = tradeLicense;
    _tinBin = tinBin;
    _createdBy = createdBy;
    _timeStamp = timeStamp;
    _password = password;
    _isOtpVerified = isOtpVerified;
    _ownerId = ownerId;
    _profilePicture = profilePicture;
    _status = status;
    _vechileId = vechileId;
    _isDriverAllocated = isDriverAllocated;
}

  SearchDriverModel.fromJson(dynamic json) {
    _id = json['Id'];
    _userTypeId = json['UserTypeId'];
    _name = json['Name'];
    _mobileNo = json['MobileNo'];
    _nid = json['Nid'];
    _occupation = json['Occupation'];
    _address = json['Address'];
    _gender = json['Gender'];
    _drivingLicense = json['DrivingLicense'];
    _licenseExpiryDate = json['LicenseExpiryDate'];
    _salary = json['Salary'];
    _bouns = json['Bouns'];
    _tradeLicense = json['TradeLicense'];
    _tinBin = json['Tin_Bin'];
    _createdBy = json['CreatedBy'];
    _timeStamp = json['TimeStamp'];
    _password = json['Password'];
    _isOtpVerified = json['IsOtpVerified'];
    _ownerId = json['OwnerId'];
    _profilePicture = json['ProfilePicture'] == "null" ? "" : json['ProfilePicture'];
    _status = json['Status'];
    _vechileId = json['VechileId'];
    _isDriverAllocated = json['IsDriverAllocated'];
  }
  int? _id;
  int? _userTypeId;
  String? _name;
  String? _mobileNo;
  String? _nid;
  String? _occupation;
  String? _address;
  String? _gender;
  String? _drivingLicense;
  dynamic _licenseExpiryDate;
  dynamic _salary;
  dynamic _bouns;
  String? _tradeLicense;
  String? _tinBin;
  String? _createdBy;
  String? _timeStamp;
  String? _password;
  int? _isOtpVerified;
  int? _ownerId;
  dynamic _profilePicture;
  int? _status;
  dynamic _vechileId;
  dynamic _isDriverAllocated;

  int? get id => _id;
  int? get userTypeId => _userTypeId;
  String? get name => _name;
  String? get mobileNo => _mobileNo;
  String? get nid => _nid;
  String? get occupation => _occupation;
  String? get address => _address;
  String? get gender => _gender;
  String? get drivingLicense => _drivingLicense;
  dynamic get licenseExpiryDate => _licenseExpiryDate;
  dynamic get salary => _salary;
  dynamic get bouns => _bouns;
  String? get tradeLicense => _tradeLicense;
  String? get tinBin => _tinBin;
  String? get createdBy => _createdBy;
  String? get timeStamp => _timeStamp;
  String? get password => _password;
  int? get isOtpVerified => _isOtpVerified;
  int? get ownerId => _ownerId;
  dynamic get profilePicture => _profilePicture;
  int? get status => _status;
  dynamic get vechileId => _vechileId;
  dynamic get isDriverAllocated => _isDriverAllocated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['UserTypeId'] = _userTypeId;
    map['Name'] = _name;
    map['MobileNo'] = _mobileNo;
    map['Nid'] = _nid;
    map['Occupation'] = _occupation;
    map['Address'] = _address;
    map['Gender'] = _gender;
    map['DrivingLicense'] = _drivingLicense;
    map['LicenseExpiryDate'] = _licenseExpiryDate;
    map['Salary'] = _salary;
    map['Bouns'] = _bouns;
    map['TradeLicense'] = _tradeLicense;
    map['Tin_Bin'] = _tinBin;
    map['CreatedBy'] = _createdBy;
    map['TimeStamp'] = _timeStamp;
    map['Password'] = _password;
    map['IsOtpVerified'] = _isOtpVerified;
    map['OwnerId'] = _ownerId;
    map['ProfilePicture'] = _profilePicture;
    map['Status'] = _status;
    map['VechileId'] = _vechileId;
    map['IsDriverAllocated'] = _isDriverAllocated;
    return map;
  }

}