class VehicleType {
  VehicleType({
    required this.Id,
    required this.VechileType,
    required this.CreatedBy,
    required this.TimeStamp,
  });
  late final int Id;
  late final String VechileType;
  late final String CreatedBy;
  late final String TimeStamp;

  VehicleType.fromJson(Map<String, dynamic> json){
    Id = json['Id'];
    VechileType = json['VechileType'];
    CreatedBy = json['CreatedBy'];
    TimeStamp = json['TimeStamp'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Id'] = Id;
    _data['VechileType'] = VechileType;
    _data['CreatedBy'] = CreatedBy;
    _data['TimeStamp'] = TimeStamp;
    return _data;
  }
}