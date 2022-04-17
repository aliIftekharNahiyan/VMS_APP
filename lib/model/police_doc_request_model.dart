class PoliceDocRequestModel {
  String ? FreeZingId;
  PoliceDocRequestModel({this.FreeZingId});

  Map<String,dynamic> toJson(){
    return {
      "FreeZingId": this.FreeZingId,
    };
  }

  static List encondeToJson(List<PoliceDocRequestModel>list){
    List jsonList = [];
    list.map((item)=>
        jsonList.add(item.toJson())
    ).toList();
    return jsonList;
  }
}