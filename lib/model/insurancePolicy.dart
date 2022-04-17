class InsurancePolicyModel {
  int? id;
  int? vechileId;
  String? coverageDetails;
  String? insuranceImg;
  String? expiryDate;
  int? status;
  String? timeStamp;

  InsurancePolicyModel(
      {this.id,
        this.vechileId,
        this.coverageDetails,
        this.insuranceImg,
        this.expiryDate,
        this.status,
        this.timeStamp});

  InsurancePolicyModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    vechileId = json['VechileId'];
    coverageDetails = json['CoverageDetails'];
    insuranceImg = json['InsuranceImg'];
    expiryDate = json['ExpiryDate'];
    status = json['Status'];
    timeStamp = json['TimeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['VechileId'] = this.vechileId;
    data['CoverageDetails'] = this.coverageDetails;
    data['InsuranceImg'] = this.insuranceImg;
    data['ExpiryDate'] = this.expiryDate;
    data['Status'] = this.status;
    data['TimeStamp'] = this.timeStamp;
    return data;
  }
}