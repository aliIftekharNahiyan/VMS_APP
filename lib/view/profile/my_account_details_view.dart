import 'package:flutter/material.dart';
import 'package:amargari/view/profile/components/details_body.dart';

class MyProfileScreen extends StatelessWidget {
  MyProfileScreen({this.userId});
  final userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text( userId == "" ? "My Profile": "Driver Profile"),
      ),
      body: DetailsBody(
        userId: userId,
      ),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
