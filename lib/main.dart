import 'package:amargari/notification/my_notification.dart';
import 'package:amargari/providers/VehicleDocumentInfoProvider.dart';
import 'package:amargari/providers/trip_list%20_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/view/subscription/check_subscription.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:amargari/get_state/selected_dropdown.dart';
import 'package:amargari/providers/auth.dart';
import 'package:amargari/providers/common_provider.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/providers/user_provider.dart';
import 'package:amargari/providers/vehicle_details_provider.dart';
import 'package:amargari/uril/routes.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/authentication/pin_code_verification_screen.dart';
import 'package:amargari/view/dashboard_view.dart';
import 'package:amargari/view/authentication/login_view.dart';
import 'package:amargari/view/profile/my_account_details_view.dart';
import 'package:amargari/view/profile/profile_screen.dart';
import 'package:amargari/view/authentication/register_view.dart';
import 'package:amargari/view/vehicles_info/vehicles_list_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:amargari/widgets/themes.dart';
import 'package:amargari/widgets/widgets.dart';
import 'model/user_model.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final NotificationAppLaunchDetails? notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
  }
  await MyNotification.initialize(flutterLocalNotificationsPlugin);
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

  await EasyLocalization.ensureInitialized();
  Get.lazyPut(() => SelectedDropDown());
  configLoading();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('bn', 'BD')],
        path: 'assets/translation', // <-- change the path of the translation files
        fallbackLocale: Locale('en', 'US'),
        child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CommonProvider()),
        ChangeNotifierProvider(create: (_) => ServiceProvider()),
        ChangeNotifierProvider(create: (_) => TripListProvider()),
        ChangeNotifierProvider(create: (_) => VehicleInfoProvider()),
        ChangeNotifierProvider(create: (_) => VehicleDocumentInfoProvider()),
      ],
      child: GetMaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: MyTheme.lightTheme(context),
          darkTheme: MyTheme.darkTheme(context),
          home: FutureBuilder<UserInfoModel>(
              future: getUserData(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else if (snapshot.data!.id == null)
                      return Login();
                    else
                      AppConstant.userId = snapshot.data!.id ?? 0;
                      AppConstant.userTypeId = snapshot.data!.userTypeId ?? 0;
                      print( "snapshot   ${snapshot.data!.userTypeId ?? 0}  ${snapshot.data!.id ?? 0}");
                      return CheckSubscription();
                }
              }),
          builder: EasyLoading.init(),
          routes: {
            MyRoutes.dashboardRoute: (context) => DashBoard(),
            MyRoutes.subscriptionRoute: (context) => CheckSubscription(),
            MyRoutes.loginRoute: (context) => Login(),
            MyRoutes.registrationRoute: (context) => Register(),
            MyRoutes.oTPRoute: (context) => PinCodeVerificationScreen(""),
            MyRoutes.vehicleInfo: (context) => VehicleInfo(title: '',),
            MyRoutes.profileRoute: (context) => ProfileScreen(),
            MyRoutes.profileDetailsRoute: (context) => MyProfileScreen(),
          }),
    );
  }
}
