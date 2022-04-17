class DriverListModel {
  int? Id;
  int? UserTypeId;
  String? Name;
  String? MobileNo;
  String? Nid;
  String? Occupation;
  String? Address;
  String? Gender;
  String? DrivingLicense;
  String? LicenseExpiryDate;
  int? Salary;
  int? Bouns;
  String? TradeLicense;
  String? TinBin;
  String? CreatedBy;
  String? TimeStamp;
  String? Password;
  int? IsOtpVerified;
  int? OwnerId;

  DriverListModel({
    this.Id,
    this.UserTypeId,
    this.Name,
    this.MobileNo,
    this.Nid,
    this.Occupation,
    this.Address,
    this.Gender,
    this.DrivingLicense,
    this.LicenseExpiryDate,
    this.Salary,
    this.Bouns,
    this.TradeLicense,
    this.TinBin,
    this.CreatedBy,
    this.TimeStamp,
    this.Password,
    this.IsOtpVerified,
    this.OwnerId,
  });

  DriverListModel.fromJson(Map<String, dynamic> json) {
    Id = json["Id"]?.toInt();
    UserTypeId = json["UserTypeId"]?.toInt();
    Name = json["Name"]?.toString();
    MobileNo = json["MobileNo"]?.toString();
    Nid = json["Nid"]?.toString();
    Occupation = json["Occupation"]?.toString();
    Address = json["Address"]?.toString();
    Gender = json["Gender"]?.toString();
    DrivingLicense = json["DrivingLicense"]?.toString();
    LicenseExpiryDate = json["LicenseExpiryDate"]?.toString();
    Salary = json["Salary"]?.toInt();
    Bouns = json["Bouns"]?.toInt();
    TradeLicense = json["TradeLicense"]?.toString();
    TinBin = json["Tin_Bin"]?.toString();
    CreatedBy = json["CreatedBy"]?.toString();
    TimeStamp = json["TimeStamp"]?.toString();
    Password = json["Password"]?.toString();
    IsOtpVerified = json["IsOtpVerified"]?.toInt();
    OwnerId = json["OwnerId"]?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["Id"] = Id;
    data["UserTypeId"] = UserTypeId;
    data["Name"] = Name;
    data["MobileNo"] = MobileNo;
    data["Nid"] = Nid;
    data["Occupation"] = Occupation;
    data["Address"] = Address;
    data["Gender"] = Gender;
    data["DrivingLicense"] = DrivingLicense;
    data["LicenseExpiryDate"] = LicenseExpiryDate;
    data["Salary"] = Salary;
    data["Bouns"] = Bouns;
    data["TradeLicense"] = TradeLicense;
    data["Tin_Bin"] = TinBin;
    data["CreatedBy"] = CreatedBy;
    data["TimeStamp"] = TimeStamp;
    data["Password"] = Password;
    data["IsOtpVerified"] = IsOtpVerified;
    data["OwnerId"] = OwnerId;
    return data;
  }

}