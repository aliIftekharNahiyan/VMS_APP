//import 'package:flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/Status.dart';
import 'package:amargari/providers/auth.dart';
import 'package:amargari/providers/user_provider.dart';
import 'package:amargari/uril/routes.dart';
import 'package:amargari/uril/validators.dart';
import 'package:amargari/widgets/widgets.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();

  late String _username, _password;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final usernameField = TextFormField(
      autofocus: true,
      focusNode: FocusNode(),
      initialValue: '',

      //style: TextStyle(color: Colors.white),
      textInputAction: TextInputAction.next,
      onSaved: (value) => _username = value!,
      decoration:
          buildInputDecoration("Type Number".tr(), Icons.mobile_friendly),
      keyboardType: TextInputType.number,
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      initialValue: "",
      textInputAction: TextInputAction.done,
      validator: (value) =>
          value!.isEmpty ? "Please enter password".tr() : null,
      onSaved: (value) => _password = value!,
      decoration: buildInputDecoration("Confirm password".tr(), Icons.lock),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(
          // padding: EdgeInsets.all(0.0),
          child: label("Forgot password?".tr()),
          onPressed: () {
            displayTextInputDialog(context);
          },
        ),
        TextButton(
          //padding: EdgeInsets.only(left: 0.0),
          child: label("Sign up".tr()),
          onPressed: () {
            Navigator.pushReplacementNamed(context, MyRoutes.registrationRoute);
          },
        ),
      ],
    );

    var doLogin = () {
      final form = formKey.currentState;
      // Navigator.pushReplacementNamed(context, MyRoutes.dashboardRoute);
      if (form!.validate()) {
        form.save();

        final Future<Map<String, dynamic>> successfulMessage =
            auth.login(_username, _password);

        successfulMessage.then((response) {
          print("response login " + response.toString() + " ");
          if (response['status']) {
            UserInfoModel user = response['user'];
            print("response login " + user.id.toString() + " ");
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            final Future<String?> aToken = auth.getDeviceToken();

            aToken.then((value) {
              print("aToken" + value!);
              final Future<dynamic> updateToken =
                  auth.updateFireBaseToken(user.id.toString(), value);
              print(updateToken.toString());
            });

            if (user.password == "1234") {
              displayTextInputDialog(context, mobile: user.mobileNo);
            } else {
              Navigator.pushReplacementNamed(context, MyRoutes.dashboardRoute);
            }
          } else {
            Flushbar(
              title: "Failed Login",
              message: response['message'],
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });
      } else {
        print("form is invalid");
      }
    };
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: linearGradientDecoration(),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png',
                        height: 100, width: 100),
                    SizedBox(height: 5.0),
                    // titleLabel("Amar Gari".tr()),
                    SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15.0),
                                label("Mobile Number".tr()),
                                SizedBox(height: 5.0),
                                usernameField,
                                SizedBox(height: 20.0),
                                label("Password".tr()),
                                SizedBox(height: 5.0),
                                passwordField,
                                SizedBox(height: 20.0),
                                auth.loggedInStatus == Status.Authenticating
                                    ? loading
                                    : longButtons("Login".tr(), doLogin),
                                SizedBox(height: 5.0),
                                forgotLabel
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  initState() {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }
}
