class GarageModel {
  GarageModel({
    int? id,
    String? gargeName,
    String? gargeNameLocation,
    String? contactPerson1Mobile,
    String? contactPerson1Name,
    String? contactPerson2Mobile,
    String? contactPerson2Name,
    String? otherExpense,
    int? ownerId,
    String? registrationDate,
    int? status,
    String? timeStamp,
    int? userID,
    String? ownerName,
  }) {
    _id = id;
    _gargeName = gargeName;
    _gargeNameLocation = gargeNameLocation;
    _contactPerson1Mobile = contactPerson1Mobile;
    _contactPerson1Name = contactPerson1Name;
    _contactPerson2Mobile = contactPerson2Mobile;
    _contactPerson2Name = contactPerson2Name;
    _otherExpense = otherExpense;
    _ownerId = ownerId;
    _registrationDate = registrationDate;
    _status = status;
    _timeStamp = timeStamp;
    _userID = userID;
    _ownerName = ownerName;
  }

  GarageModel.fromJson(dynamic json) {
    _id = json['Id'];
    _gargeName = json['GargeName'];
    _gargeNameLocation = json['GargeNameLocation'];
    _contactPerson1Mobile = json['ContactPerson1Mobile'];
    _contactPerson1Name = json['ContactPerson1Name'];
    _contactPerson2Mobile = json['ContactPerson2Mobile'];
    _contactPerson2Name = json['ContactPerson2Name'];
    _otherExpense = json['OtherExpense'];
    _ownerId = json['OwnerId'];
    _registrationDate = json['RegistrationDate'];
    _status = json['Status'];
    _timeStamp = json['TimeStamp'];
    _userID = json['UserID'];
    _ownerName = json['OwnerName'];
  }

  int? _id;
  String? _gargeName;
  String? _gargeNameLocation;
  dynamic _contactPerson1Mobile;
  dynamic _contactPerson1Name;
  dynamic _contactPerson2Mobile;
  dynamic _contactPerson2Name;
  dynamic _otherExpense;
  int? _ownerId;
  dynamic _registrationDate;
  int? _status;
  String? _timeStamp;
  int? _userID;
  String? _ownerName;

  int? get id => _id;

  String? get gargeName => _gargeName;

  String? get gargeNameLocation => _gargeNameLocation;

  String? get contactPerson1Mobile => _contactPerson1Mobile;

  String? get contactPerson1Name => _contactPerson1Name;

  String? get contactPerson2Mobile => _contactPerson2Mobile;

  String? get contactPerson2Name => _contactPerson2Name;

  String? get otherExpense => _otherExpense;

  int? get ownerId => _ownerId;

  String? get registrationDate => _registrationDate;

  int? get status => _status;

  String? get timeStamp => _timeStamp;

  int? get userID => _userID;

  String? get ownerName => _ownerName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['GargeName'] = _gargeName;
    map['GargeNameLocation'] = _gargeNameLocation;
    map['ContactPerson1Mobile'] = _contactPerson1Mobile;
    map['ContactPerson1Name'] = _contactPerson1Name;
    map['ContactPerson2Mobile'] = _contactPerson2Mobile;
    map['ContactPerson2Name'] = _contactPerson2Name;
    map['OtherExpense'] = _otherExpense;
    map['OwnerId'] = _ownerId;
    map['RegistrationDate'] = _registrationDate;
    map['Status'] = _status;
    map['TimeStamp'] = _timeStamp;
    map['UserID'] = _userID;
    map['OwnerName'] = _ownerName;
    return map;
  }
}
