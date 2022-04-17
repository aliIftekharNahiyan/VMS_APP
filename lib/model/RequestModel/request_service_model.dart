class RequestServiceModel {
  String ? Id;
  String ? ServiceName;
  String ? Amount;
  String ? details;
  String ? serviceNameListId;
  RequestServiceModel({this.Id, this.ServiceName, this.Amount, this.details, this.serviceNameListId});

  Map<String,dynamic> toJson(){
    return {
      "Id": this.Id,
      "ServiceName": this.ServiceName,
      "Amount": this.Amount,
      "Details": this.details,
    };
  }

  static List encondeToJson(List<RequestServiceModel>list){
    List jsonList = [];
    list.map((item)=>
        jsonList.add(item.toJson())
    ).toList();
    return jsonList;
  }
}