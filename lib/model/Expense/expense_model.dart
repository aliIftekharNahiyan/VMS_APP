class Expense {
  int? id;
  int? serviceTypeId;
  String? expenseAmount;
  String? description;
  String? image;
  String? date;
  int? status;
  int? userId;
  int? vechileId;

  Expense(
      {this.id,
      this.serviceTypeId,
      this.expenseAmount,
      this.description,
      this.image,
      this.date,
      this.status,
      this.userId,
      this.vechileId});

  Expense.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    serviceTypeId = json['ServiceTypeId'];
    expenseAmount = json['ExpenseAmount'];
    description = json['Description'];
    image = json['Image'];
    date = json['Date'];
    status = json['Status'];
    userId = json['UserId'];
    vechileId = json['VechileId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'Id': this.id,
      'ServiceTypeId': this.serviceTypeId,
      'ExpenseAmount': this.expenseAmount,
      'Description': this.description,
      'Image': this.image,
      'Date': this.date,
      'Status': this.status,
      'UserId': this.userId,
      'VechileId': this.vechileId
    };
    return data;
  }
}
