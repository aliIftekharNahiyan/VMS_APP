class SubscriptionCheck {
  String? result;
  String? url;

  SubscriptionCheck({this.result, this.url});

  SubscriptionCheck.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['url'] = this.url;
    return data;
  }
}