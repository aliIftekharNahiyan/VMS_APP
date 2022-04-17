
class UserInfoModel {
  int? id;
  int? userTypeId;
  String? name;
  String? mobileNo;
  String? nid;
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

  UserInfoModel(
      {this.id,
        this.userTypeId,
        this.name,
        this.mobileNo,
        this.nid,
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
        this.profilePicture
      });


  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userTypeId = json['UserTypeId'];
    name = json['Name'];
    mobileNo = json['MobileNo'];
    nid = json['Nid'];
    occupation = json['Occupation'];
    address = json['Address'];
    gender = json['Gender'];
    drivingLicense = json['DrivingLicense'];
    licenseExpiryDate = json['LicenseExpiryDate'];
    salary = json['Salary'];
    bouns = json['Bouns'];
    tradeLicense = json['TradeLicense'];
    tinBin = json['Tin_Bin'];
    createdBy = json['CreatedBy'];
    timeStamp = json['TimeStamp'];
    password = json['Password'];
    isOtpVerified = json['IsOtpVerified'];
    ownerId = json['OwnerId'];
    profilePicture = json['ProfilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['UserTypeId'] = this.userTypeId;
    data['Name'] = this.name;
    data['MobileNo'] = this.mobileNo;
    data['Nid'] = this.nid;
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
    return data;
  }
}