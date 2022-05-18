import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:amargari/model/user_model.dart';

class UserPreferences {
  Future<bool> saveUser(UserInfoModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("id", user.id ?? 0);
    prefs.setInt("UserTypeId", user.userTypeId ?? 0);
    prefs.setString("name", user.name.toString());
    prefs.setString("mobileNo", user.mobileNo.toString());
    prefs.setString("nid", user.nid.toString());

    prefs.setString("joiningDate", user.joiningDate.toString());
    prefs.setString("bc1", user.bc1.toString());
    prefs.setString("bc2", user.bc2.toString());
    prefs.setString("cc1", user.cc1.toString());
    prefs.setString("cc2", user.cc2.toString());
    prefs.setString("dp1", user.driverImg1.toString());
    prefs.setString("dp2", user.driverImg2.toString());
    prefs.setString("bioData", user.bioData.toString());
    prefs.setString("fatherNumber", user.fatherMobile.toString());
    prefs.setString("spouseNumber", user.spouseMobile.toString());


    prefs.setString("occupation", user.occupation.toString());
    prefs.setString("address", user.address.toString());
    prefs.setString("gender", user.gender.toString());
    prefs.setString("drivingLicense", user.drivingLicense.toString());
    prefs.setString("licenseExpiryDate", user.licenseExpiryDate.toString() );
    prefs.setDouble("salary", user.salary ?? 0.0);
    prefs.setDouble("bouns", user.bouns ?? 0.0);
    prefs.setString("tradeLicense", user.tradeLicense.toString());
    prefs.setString("tinBin", user.tinBin.toString());
    prefs.setString("createdBy", user.createdBy.toString());
    prefs.setString("profilePicture", user.profilePicture.toString());

    print("object prefere");
    //print(user.renewalToken);

    return prefs.commit();
  }

  Future<UserInfoModel> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? userId = prefs.getInt("id");
    int? userTypeId = prefs.getInt("UserTypeId");
    String? name = prefs.getString("name");
    String? mobileNo = prefs.getString("mobileNo");
    String? nid = prefs.getString("nid");
    String? occupation = prefs.getString("occupation");
    String? address = prefs.getString("address");
    String? gender = prefs.getString("gender");
    String? drivingLicense = prefs.getString("drivingLicense");
    String? licenseExpiryDate = prefs.getString("licenseExpiryDate");
    double? salary = prefs.getDouble("salary");
    double? bouns = prefs.getDouble("bouns");
    String? tradeLicense = prefs.getString("tradeLicense");
    String? tinBin = prefs.getString("tinBin");
    String? createdBy = prefs.getString("createdBy");
    String? profilePicture = prefs.getString("profilePicture");

    String? joiningDate = prefs.getString("joiningDate");
    String? bc1 = prefs.getString("bc1");
    String? bc2 = prefs.getString("bc2");
    String? cc1 = prefs.getString("cc1");
    String? cc2 = prefs.getString("cc2");
    String? dp1 = prefs.getString("dp1");
    String? dp2 = prefs.getString("dp2");
    String? bioData = prefs.getString("bioData");
    String? fatherNumber = prefs.getString("fatherNumber");
    String? spouseNumber = prefs.getString("spouseNumber");


    return UserInfoModel(
      id: userId,
      userTypeId: userTypeId,
      name: name,
      mobileNo: mobileNo,
      nid: nid,
      joiningDate: joiningDate,
      cc1: cc1,
      cc2: cc2,
      bc1: bc1,
      bc2: bc2,
      driverImg1: dp1,
      driverImg2: dp2,
      bioData: bioData,
      fatherMobile: fatherNumber,
      spouseMobile: spouseNumber,
      occupation: occupation,
      address: address,
      gender: gender,
      drivingLicense: drivingLicense,
      licenseExpiryDate: licenseExpiryDate,
      salary: salary,
      bouns: bouns,
      tradeLicense: tradeLicense,
      tinBin: tinBin,
      createdBy: createdBy,
      profilePicture: profilePicture,

    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

  }

  Future<String?> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("userId");
    return token;
  }
}
