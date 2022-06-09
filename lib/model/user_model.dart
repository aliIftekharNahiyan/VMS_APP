class UserInfoModel {
  int? id;
  int? userTypeId;
  String? name;
  String? mobileNo;
  String? nid;

  String? joiningDate;
  String? bc1;
  String? bc2;
  String? cc1;
  String? cc2;
  String? driverImg1;
  String? driverImg2;
  String? bioData;
  String? fatherMobile;
  String? spouseMobile;

  String? occupation;
  String? address;
  String? gender;
  String? drivingLicense;
  String? licenseExpiryDate;
  double? salary;
  double? bouns;
  String? tradeLicense;
  String? tinBin;
  String? createdBy;
  String? timeStamp;
  String? password;
  int? isOtpVerified;
  int? ownerId;
  String? profilePicture;
  String? reference;

  UserInfoModel(
      {this.id,
      this.userTypeId,
      this.name,
      this.mobileNo,
      this.nid,
      this.joiningDate,
      this.bc1,
      this.bc2,
      this.cc1,
      this.cc2,
      this.driverImg1,
      this.driverImg2,
      this.bioData,
      this.fatherMobile,
      this.spouseMobile,
      this.occupation,
      this.address,
      this.gender,
      this.drivingLicense,
      this.licenseExpiryDate,
      this.salary,
      this.bouns,
      this.tradeLicense,
      this.tinBin,
      this.createdBy,
      this.timeStamp,
      this.password,
      this.isOtpVerified,
      this.ownerId,
      this.profilePicture, 
      this.reference});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userTypeId = json['UserTypeId'];
    name = json['Name'];
    mobileNo = json['MobileNo'];
    nid = json['Nid'];
    joiningDate = json['DriverJoinDate'] == "null" ? "" : json['DriverJoinDate'];
    bc1 = json['BirthCertificateImg1'];
    bc2 = json['BirthCertificateImg2'];
    cc1 = json['ChairmanCertificateImg1'];
    cc2 = json['ChairmanCertificateImg2'];
    driverImg1 = json['DriverPictureImg1'];
    driverImg2 = json['DriverPictureImg2'];
    bioData = json['BioData'];
    fatherMobile = json['FathersMobileNumber'] == "null" ? "" : json['FathersMobileNumber'];
    spouseMobile = json['SpouseMobileNumber']== "null" ? "" : json['SpouseMobileNumber'];
    occupation = json['Occupation']== "null" ? "" : json['Occupation'];
    address = json['Address']== "null" ? "" : json['Address'];
    gender = json['Gender']== "null" ? "" : json['Gender'];
    drivingLicense = json['DrivingLicense'];
    licenseExpiryDate = json['LicenseExpiryDate']== "null" ? "" : json['LicenseExpiryDate'];
    salary = json['Salary']== "null" ? "" : json['Salary'];
    bouns = json['Bouns']== "null" ? "" : json['Bouns'];
    tradeLicense = json['TradeLicense'];
    tinBin = json['Tin_Bin'];
    createdBy = json['CreatedBy'];
    timeStamp = json['TimeStamp'];
    password = json['Password'];
    isOtpVerified = json['IsOtpVerified'];
    ownerId = json['OwnerId'];
    profilePicture = json['ProfilePicture'];
    reference = json['Reference']== "null" ? "" : json['Reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['UserTypeId'] = this.userTypeId;
    data['Name'] = this.name;
    data['MobileNo'] = this.mobileNo;
    data['Nid'] = this.nid;
    data['DriverJoinDate'] = this.joiningDate;
    data['BirthCertificateImg1'] = this.bc1;
    data['BirthCertificateImg2'] = this.bc2;
    data['ChairmanCertificateImg1'] = this.cc1;
    data['ChairmanCertificateImg2'] = this.cc2;
    data['DriverPictureImg1'] = this.driverImg1;
    data['DriverPictureImg2'] = this.driverImg2;
    data['BioData'] = this.bioData;
    data['FathersMobileNumber'] = this.fatherMobile;
    data['SpouseMobileNumberdata'] = this.spouseMobile;
    data['Occupation'] = this.occupation;
    data['Address'] = this.address;
    data['Gender'] = this.gender;
    data['DrivingLicense'] = this.drivingLicense;
    data['LicenseExpiryDate'] = this.licenseExpiryDate;
    data['Salary'] = this.salary;
    data['Bouns'] = this.bouns;
    data['TradeLicense'] = this.tradeLicense;
    data['Tin_Bin'] = this.tinBin;
    data['CreatedBy'] = this.createdBy;
    data['TimeStamp'] = this.timeStamp;
    data['Password'] = this.password;
    data['IsOtpVerified'] = this.isOtpVerified;
    data['OwnerId'] = this.ownerId;
    data['profilePicture'] = this.profilePicture;
    data['Reference'] = this.reference;
    return data;
  }
}
