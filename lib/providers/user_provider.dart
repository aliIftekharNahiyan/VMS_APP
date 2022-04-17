import 'package:flutter/foundation.dart';
import 'package:amargari/model/user_model.dart';

class UserProvider with ChangeNotifier {
  UserInfoModel _user = new UserInfoModel();

  UserInfoModel get user => _user;

  void setUser(UserInfoModel user) {
    _user = user;
    notifyListeners();
  }
}
