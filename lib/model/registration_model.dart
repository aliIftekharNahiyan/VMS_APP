class RegistrationModel {
  String? result;
  String? otp;
  String? reason;

  RegistrationModel({this.result, this.otp, this.reason});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    otp = json['otp'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['otp'] = this.otp;
    data['reason'] = this.reason;
    return data;
  }
}