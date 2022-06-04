import 'package:amargari/model/notification_list.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/common_provider.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/uril/utility.dart';
import 'package:amargari/view/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationListView extends StatefulWidget {
  final String title;
  final NotificationList notification;

  // In the constructor, require a Todo.
  NotificationListView({required this.title, required this.notification});

  @override
  _NotificationListViewState createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView> {
  // var isVisible = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CommonProvider commonProvider = Provider.of<CommonProvider>(context);

    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then(
        (value) => {commonProvider.updateNotification(value.id.toString())});

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashBoard()),
          (Route<dynamic> route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("Notification"),
        ),
        body: ListView.builder(
          itemCount: widget.notification.data!.length,
          itemBuilder: (context, index) {
            Notifications notifications = widget.notification.data![index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                        'Notification Details: ${notifications.notificationDetails ?? ""}'),
                    SizedBox(height: 5),
                    Text(
                        'Notification Head: ${notifications.notificationHead ?? ""}'),
                    SizedBox(height: 5),
                    Text(
                        'Notification Time: ${convertDateTime(notifications.timeStamp ?? "")}'),
                  ],
                ),
              )),
            );
          },
        ),
      ),
    );
  }
}
