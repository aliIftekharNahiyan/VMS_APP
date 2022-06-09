class ReportServiceDropdownResponse {
  String? result;
  List<ReportServiceDropdownDTO>? data;

  ReportServiceDropdownResponse({this.result, this.data});

  ReportServiceDropdownResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['data'] != null) {
      data = <ReportServiceDropdownDTO>[];
      json['data'].forEach((v) {
        data!.add(new ReportServiceDropdownDTO.fromJson(v));
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

class ReportServiceDropdownDTO {
  int? id;
  String? reportName;
  String? timeStamp;

  ReportServiceDropdownDTO({this.id, this.reportName, this.timeStamp});

  ReportServiceDropdownDTO.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    reportName = json['ReportName'];
    timeStamp = json['TimeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ReportName'] = this.reportName;
    data['TimeStamp'] = this.timeStamp;
    return data;
  }
}