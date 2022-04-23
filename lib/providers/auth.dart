import 'dart:async';
import 'dart:convert';
import 'package:amargari/model/forget_password_model.dart';
import 'package:amargari/model/o_t_p_confirm.dart';
import 'package:amargari/model/usertypemodel.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:amargari/model/login_model.dart';
import 'package:amargari/model/registration_model.dart';
import 'package:amargari/providers/Status.dart';
import 'package:amargari/uril/app_url.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/widgets/widgets.dart';

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;

  Status get registeredInStatus => _registeredInStatus;

  Future<Map<String, dynamic>> login(String mobileNo, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      'MobileNo': mobileNo,
      'Password': password
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.login),
      body: json.encode(loginData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      //var result = responseData;

      // var userData = responseData['userinfo'];

      LoginModel authUser = LoginModel.fromJson(responseData);

      print("LoginModel  " + authUser.toString());
      if (authUser.result == "failed") {
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
        result = {
          'status': false,
          'message': "Username password not match, please try again"
        };
      } else {
        print(
            "saveUser   ${authUser.userinfo!.id ?? 0}    ${authUser.userinfo!.userTypeId ?? 0}");
        UserPreferences().saveUser(authUser.userinfo!);
        AppConstant.userId = authUser.userinfo!.id ?? 0;
        AppConstant.userTypeId = authUser.userinfo!.userTypeId ?? 0;

        print("saveUser   ${AppConstant.userId}    ${AppConstant.userTypeId}");
        _loggedInStatus = Status.LoggedIn;
        notifyListeners();

        result = {
          'status': true,
          'message': 'Successful',
          'user': authUser.userinfo
        };
      }
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': "Something went wrong, please try again after sometime "
      };
    }
    return result;
  }

  Future<dynamic> register(
      String UserTypeId,
      String name,
      String mobileNo,
      String password,
      String nid,
      String occupation,
      String address,
      String gender,
      String drivingLicense,
      String licenseExpiryDate,
      String salary,
      String bouns,
      String tradeLicense,
      String tin_Bin) async {
    final Map<String, dynamic> registrationData = {
      'UserTypeId': UserTypeId,
      'Name': name,
      'MobileNo': mobileNo,
      "Password": password,
      "Nid": nid,
      "Occupation": occupation,
      "Address": address,
      "Gender": gender,
      "DrivingLicense": drivingLicense,
      "LicenseExpiryDate": licenseExpiryDate,
      "Salary": salary,
      "Bouns": bouns,
      "TradeLicense": tradeLicense,
      "Tin_Bin": tin_Bin,
      "OwnerId": 0
    };
    print("registrationData ${registrationData}");
    return await post(Uri.parse(AppUrl.register),
            body: json.encode(registrationData),
            headers: {'Content-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
  }

  static Future<FutureOr> onValue(Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);

    RegistrationModel authUser = RegistrationModel.fromJson(responseData);

    print(response.statusCode);
    if (response.statusCode == 200) {
      if (authUser.result == "success") {
        result = {
          'status': true,
          'message': 'Successfully registered',
          'data': authUser
        };
      } else {
        result = {
          'status': false,
          'message': authUser.reason,
          'data': authUser
        };
      }
    } else {
      result = {
        'status': false,
        'message': 'Registration failed',
        'data': "Something went wrong, please try again"
      };
    }

    return result;
  }

  // reset password

  Future<ForgetPasswordModel> resetPassword(String number) async {
    Response response = await get(
      Uri.parse(AppUrl.forgotPassword.replaceAll("_phoneNumber", number)),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      ForgetPasswordModel forgetPasswordModel =
          ForgetPasswordModel.fromJson(responseData);
      print("responseData " + forgetPasswordModel.toString());
      return forgetPasswordModel;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<OTPConfirm> updatePassword(
    String MobileNo,
    String Password,
    String OTPCode,
  ) async {
    final Map<String, dynamic> registrationData = {
      'MobileNo': MobileNo,
      'Password': Password,
      'OTPCode': OTPCode,
    };

    return await post(Uri.parse(AppUrl.updatePassword),
            body: json.encode(registrationData),
            headers: {'Content-Type': 'application/json'})
        .then(onPasswordUpdate)
        .catchError(onError);
  }

  Future<OTPConfirm> onPasswordUpdate(Response response) async {
    final Map<String, dynamic> responseData = json.decode(response.body);
    OTPConfirm otpConfirm = OTPConfirm.fromJson(responseData);
    print(responseData);
    if (response.statusCode == 200) {
      return otpConfirm;
    } else {
      return otpConfirm;
    }
  }

//otp_verify

  Future<Map<String, dynamic>> otpVerify(String number) async {
    var result;

    Response response = await get(
      Uri.parse(AppUrl.otpVerify.replaceAll("_phoneNumber", number)),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print("responseData " + responseData.toString());
      result = {"status": responseData};
    } else {
      result = {"status": "fail"};
    }
    return result;
  }

  //profile update
  Future<dynamic> profileUpdate(
      String userTypeId,
      String name,
      String mobileNo,
      String nid,
      String occupation,
      String address,
      String gender,
      String drivingLicense,
      String licenseExpiryDate,
      String salary,
      String bouns,
      String tradeLicense,
      String tinBin,
      String profilePicture,
      String joiningDate,
      String birthCertificate1,
      String birthCertificate2,
      String chairmanCertificate1,
      String chairmanCertificate2,
      String drivarProfileImage,
      String bioData,
      String fatherMobile,
      String spouseMobile) async {
    final Map<String, dynamic> registrationData = {
      'UserTypeId': userTypeId,
      'Name': name,
      'MobileNo': mobileNo,
      "Nid": nid,
      "Occupation": occupation,
      "Address": address,
      "Gender": gender,
      "DrivingLicense": drivingLicense,
      "LicenseExpiryDate": licenseExpiryDate,
      "Salary": salary,
      "Bouns": bouns,
      "TradeLicense": tradeLicense,
      "Tin_Bin": tinBin,
      "ProfilePicture": profilePicture,
      "DriverJoinDate": joiningDate,
      "BirthCertificateImg1": birthCertificate1,
      "ChairmanCertificateImg1": chairmanCertificate1,
      "BioData": bioData,
      "DriverPictureImg1": drivarProfileImage,
      "FathersMobileNumber": fatherMobile,
      "BirthCertificateImg2": birthCertificate2,
      "ChairmanCertificateImg2": chairmanCertificate2,
      "DriverPictureImg2": drivarProfileImage,
      "SpouseMobileNumber": spouseMobile
    };
    return await post(Uri.parse(AppUrl.profileUpdate),
            body: json.encode(registrationData),
            headers: {'Content-Type': 'application/json'})
        .then(onValueUpdate)
        .catchError(onError);
  }

  static Future<FutureOr> onValueUpdate(Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);
    LoginModel authUser = LoginModel.fromJson(responseData);
    print("LoginModel  " +
        "" +
        authUser.result! +
        "  " +
        authUser.userinfo!.salary.toString());
    if (authUser.result == "updated") {
      result = {
        'status': true,
        'message': 'Successful',
        'user': authUser.userinfo
      };
      AppConstant.profileImageUrl = authUser.userinfo?.profilePicture ?? "";
      print("profilepicture  ${AppConstant.profileImageUrl}");
      UserPreferences().removeUser();
      UserPreferences().saveUser(authUser.userinfo!);
    } else {
      result = {'status': false, 'message': "fail to update profile"};
      return result;
    }
  }

  Future<dynamic> updateFireBaseToken(
    String UserId,
    String Token,
  ) async {
    final Map<String, dynamic> registrationData = {
      'UserId': UserId,
      'Token': Token,
    };

    return await post(Uri.parse(AppUrl.updateFireBaseToken),
            body: json.encode(registrationData),
            headers: {'Content-Type': 'application/json'})
        .then(onVehicleUpdate)
        .catchError(onError);
  }

  Future<FutureOr> onVehicleUpdate(Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    if (responseData["result"] == "updated") {
      result = {'status': true, 'message': 'Successful', 'user': responseData};
    } else {
      result = {'status': false, 'message': "fail to update profile"};
      return result;
    }
  }

  Future<String?> getDeviceToken() async {
    String? _deviceToken = await FirebaseMessaging.instance.getToken();
    if (_deviceToken != null) {
      print('--------Device Token---------- ' + _deviceToken);
    }
    return _deviceToken;
  }
}
