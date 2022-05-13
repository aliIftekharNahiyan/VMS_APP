class SendRequestRes {
  String? result;
  List<Data>? data;
  String? otp;
  String? reason;
  List<String>? errors;

  SendRequestRes({this.result, this.data, this.otp, this.reason, this.errors});

  SendRequestRes.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    otp = json['otp'];
    reason = json['reason'];
    if (json['errors'] != null) {
      errors = <String>[];
      json['errors'].forEach((v) {
        errors!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['otp'] = this.otp;
    data['reason'] = this.reason;
    if (this.errors != null) {
      data['errors'] = this.errors!.map((v) => v).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? driverId;
  int? ownerId;
  int? vechileId;
  String? oTP;
  String? timeStamp;

  Data(
      {this.id,
      this.driverId,
      this.ownerId,
      this.vechileId,
      this.oTP,
      this.timeStamp});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    driverId = json['DriverId'];
    ownerId = json['OwnerId'];
    vechileId = json['VechileId'];
    oTP = json['OTP'];
    timeStamp = json['TimeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['DriverId'] = this.driverId;
    data['OwnerId'] = this.ownerId;
    data['VechileId'] = this.vechileId;
    data['OTP'] = this.oTP;
    data['TimeStamp'] = this.timeStamp;
    return data;
  }
}