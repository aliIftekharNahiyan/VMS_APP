class OTPConfirm {
  OTPConfirm({
      String? result, 
      String? reason,}){
    _result = result;
    _reason = reason;
}

  OTPConfirm.fromJson(dynamic json) {
    _result = json['result'];
    _reason = json['reason'];
  }
  String? _result;
  String? _reason;

  String? get result => _result;
  String? get reason => _reason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = _result;
    map['reason'] = _reason;
    return map;
  }

}