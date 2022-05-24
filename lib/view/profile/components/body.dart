
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/authentication/login_view.dart';
import 'package:amargari/view/help_center_view.dart';
import 'package:amargari/view/profile/adddriver/search_driver.dart';
import 'package:flutter/material.dart';

import '../my_account_details_view.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic("menu"),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/MyAccount.png",
            press: () => {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyProfileScreen(userId: "",)))
            },
          ),
          if (AppConstant.userTypeId != 2) ...[
            ProfileMenu(
              text: "Drivers",
              icon: "assets/icons/driver.png",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchDriver()));
              },
            ),
          ],

          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/HelpCenter.png",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpCenter()));
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/LogOut.png",
            press: () {
              UserPreferences().removeUser();
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()));
            },
          ),
        ],
      ),
    );
  }
}
