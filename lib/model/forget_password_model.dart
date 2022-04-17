class ForgetPasswordModel {
  ForgetPasswordModel({
      String? result, 
      String? otp, 
      String? reason,}){
    _result = result;
    _otp = otp;
    _reason = reason;
}

  ForgetPasswordModel.fromJson(dynamic json) {
    _result = json['result'];
    _otp = json['otp'];
    _reason = json['reason'];
  }
  String? _result;
  String? _otp;
  String? _reason;

  String? get result => _result;
  String? get otp => _otp;
  String? get reason => _reason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = _result;
    map['otp'] = _otp;
    map['reason'] = _reason;
    return map;
  }

}