import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:amargari/widgets/themes.dart';
import 'package:amargari/widgets/widgets.dart';
//import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:easy_localization/easy_localization.dart';


class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imageUrl =
        "https://avatars.githubusercontent.com/u/12619420?s=460&u=26db98cbde1dd34c7c67b85c240505a436b2c36d&v=4";
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: MyTheme.buttonColor
    // ));

 //   FlutterStatusbarcolor.setStatusBarColor(MyTheme.statusBarColor);

    return Drawer(
      child: Container(
        decoration: linearGradientDecoration(),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: MyTheme.buttonColor,
                ),
                margin: EdgeInsets.zero,
                accountName: Text("Tariqul Islam"),
                accountEmail: Text("tariqul1993@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
            ),
            drawerLabel("Home".tr(), CupertinoIcons.home),
            drawerLabel("Profile".tr(), CupertinoIcons.profile_circled),
            drawerLabel("Vehicle Info".tr(), CupertinoIcons.info),
            drawerLabel("Vehicle Details".tr(), CupertinoIcons.info),
            drawerLabel("Trip Management".tr(), CupertinoIcons.info),
            drawerLabel("Vehicle Servicing".tr(), CupertinoIcons.settings),
            drawerLabel("Police Case Management".tr(), CupertinoIcons.book),
            drawerLabel("Insurance Policy".tr(), CupertinoIcons.info),
            drawerLabel("Workshop Expense".tr(), CupertinoIcons.shopping_cart),


          ],
        ),
      ),
    );
  }
}
