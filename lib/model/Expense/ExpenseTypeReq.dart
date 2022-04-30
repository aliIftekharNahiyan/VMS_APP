class ExpenseTypeReq {
  int? id;
  String? name;
  int? userId;
  int? status;

  ExpenseTypeReq({this.id, this.name, this.userId, this.status});

  ExpenseTypeReq.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    userId = json['UserId'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['UserId'] = this.userId;
    data['Status'] = this.status;
    return data;
  }
}