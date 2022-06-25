import 'package:amargari/providers/common_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/authentication/login_view.dart';
import 'package:amargari/view/dashboard_view.dart';
import 'package:amargari/view/subscription/custom_webview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CheckSubscription extends StatefulWidget {
  const CheckSubscription({Key? key}) : super(key: key);

  @override
  State<CheckSubscription> createState() => _CheckSubscriptionState();
}

class _CheckSubscriptionState extends State<CheckSubscription> {
  bool isLoading = false;

  openDialog(ctx, url) {
    showDialog(
        barrierDismissible: false,
        context: ctx,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Subscription"),
            content: Text("Payment required as  RegDate Expired."),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.offAll(CustomWebView(url: url));
                  },
                  child: Text("Subscription")),
              TextButton(
                  onPressed: () {
                    UserPreferences().removeUser();
                    Get.offAll(Login());
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.grey),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    CommonProvider commonProvider = Provider.of<CommonProvider>(context);

    if (!isLoading) {
      commonProvider
          .checkSubscription(AppConstant.userId.toString())
          .then((value) {
        setState(() {
          print(value.url);
          if (value.result == "failed") {
            openDialog(context, value.url);
          } else {
            Get.to(DashBoard());
          }
          isLoading = true;
        });
      });
    }

    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
