import 'package:amargari/model/user_model.dart';

class LoginModel {
  String? result;
  UserInfoModel? userinfo;

  LoginModel({this.result, this.userinfo});

  LoginModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    userinfo = json['data'] != null
        ? new UserInfoModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.userinfo != null) {
      data['data'] = this.userinfo!.toJson();
    }
    return data;
  }
}