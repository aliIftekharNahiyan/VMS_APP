class ExpenseResponse {
  String? result;
  List<ExpenseDTO>? data;

  ExpenseResponse({this.result, this.data});

  ExpenseResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['data'] != null) {
      data = <ExpenseDTO>[];
      json['data'].forEach((v) {
        data!.add(new ExpenseDTO.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExpenseDTO {
  int? id;
  int? serviceTypeId;
  String? date;
  String? description;
  String? image;
  String? expenseAmount;
  String? name;
  int? vechileId;
  int? status;

  ExpenseDTO(
      {this.id,
      this.serviceTypeId,
      this.date,
      this.description,
      this.image,
      this.expenseAmount,
      this.name, this.vechileId, this.status});

  ExpenseDTO.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    serviceTypeId = json['ServiceTypeId'];
    date = json['Date'];
    description = json['Description'];
    image = json['Image'];
    expenseAmount = json['ExpenseAmount'];
    name = json['Name'];
    vechileId = json['VechileId'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ServiceTypeId'] = this.serviceTypeId;
    data['Date'] = this.date;
    data['Description'] = this.description;
    data['Image'] = this.image;
    data['ExpenseAmount'] = this.expenseAmount;
    data['Name'] = this.name;
    data['VechileId'] = this.vechileId;
    data['Status'] = this.status;
    return data;
  }
}