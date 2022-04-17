import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/user_provider.dart';

class Welcome extends StatelessWidget {
  final UserInfoModel user;

  Welcome({required Key key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context).setUser(user);

    return Scaffold(
      body: Container(
        child: Center(
          child: Text("WELCOME PAGE"),
        ),
      ),
    );
  }
}
