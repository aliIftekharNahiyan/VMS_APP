class VechielDriveReq {
  String? driverId;
  String? ownerId;
  String? vechileId;
  String? hash;

  VechielDriveReq({this.driverId, this.ownerId, this.vechileId, this.hash});

  VechielDriveReq.fromJson(Map<String, dynamic> json) {
    driverId = json['driverId'];
    ownerId = json['ownerId'];
    vechileId = json['vechileId'];
    hash = json['hash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driverId'] = this.driverId;
    data['ownerId'] = this.ownerId;
    data['vechileId'] = this.vechileId;
    data['hash'] = this.hash;
    return data;
  }
}
