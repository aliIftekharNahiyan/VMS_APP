
class CommonDropDownModel {
  String? id;
  String? name;
  String? title;

  CommonDropDownModel({this.id, this.name, this.title});

  bool isEqual(CommonDropDownModel model) {
    return this.name == model.name;
  }
}