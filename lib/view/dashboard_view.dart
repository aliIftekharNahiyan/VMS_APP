import 'package:amargari/model/notification_list.dart';
import 'package:amargari/providers/common_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/view/notification_list_view.dart';
import 'package:amargari/widgets/notification_Icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:amargari/view/profile/profile_screen.dart';
import 'package:provider/provider.dart';

import 'home_view.dart';


class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int currentPage = 0;
  var isLoaded = true;
  NotificationList notification = NotificationList();
  Future<NotificationList>? notificationList;

  void _onProfilePress() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()));
  }
  void _onNotificationPress(NotificationList notification ) {

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotificationListView(title: 'Notifications', notification: notification)));
  }
  @override
  void initState() {
    isLoaded = true;
    // LocationRequest().getCurrentPosition();
    //CommonProvider commonProvider = Provider.of<CommonProvider>(context);
    //notificationList = commonProvider.getNotificationList("10040");
    // NotificationList list = await notificationList ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CommonProvider commonProvider = Provider.of<CommonProvider>(context);


    //  notificationList = commonProvider.getNotificationList("10040");
    if (isLoaded){
      notificationList = commonProvider.getNotificationList(AppConstant.userId.toString());
      notificationList!.then((value) => {
       // setState(() {
          notification = value,
          isLoaded = false ,
          print("notification  ${notification.unread}")
      //  })
      });
    }
    //   User user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Amar Gari".tr(),
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
              child: NotificationIcon(
                iconData: Icons.notifications,
                notificationCount: notification.unread ?? 0,
                onTap: () {
                  print(notification.unread ?? 0);
                  _onNotificationPress(notification);
                },
              ),
            ),
            IconButton(
              icon: new Icon(Icons.account_circle),
              onPressed: (){_onProfilePress();},
            ),

          ],
        ),

        body: FutureBuilder<NotificationList>(
            future: notificationList,
            builder: (BuildContext context, AsyncSnapshot<NotificationList> snapshot) {

              if (snapshot.connectionState == ConnectionState.done) {

                if (notificationList == null) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return MyHomePage();
                }
              }else {
                return Center(child: CircularProgressIndicator());
              }

            })


      // bottomNavigationBar: FancyBottomNavigation(
      //   tabs: [
      //     TabData(iconData: Icons.home, title: "Home"),
      //     TabData(iconData: Icons.search, title: "Search"),
      //     TabData(iconData: Icons.shopping_cart, title: "Basket")
      //   ],
      //   onTabChangedListener: (position) {
      //     setState(() {
      //       currentPage = position;
      //     });
      //   },
      // ),
      // drawer: MyDrawer(),
    );
  }
}
