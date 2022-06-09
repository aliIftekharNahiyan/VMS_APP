import 'package:amargari/get_state/selected_dropdown.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/widgets/drop_down_list_border.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:provider/provider.dart';
import 'package:amargari/model/registration_model.dart';
import 'package:amargari/providers/Status.dart';
import 'package:amargari/providers/auth.dart';
import 'package:amargari/uril/routes.dart';
import 'package:amargari/widgets/widgets.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}
void _loadData(BuildContext context) async {
    Provider.of<ServiceProvider>(context, listen: false)
        .getUserType();
}

class _RegisterState extends State<Register> {
  final formKey = new GlobalKey<FormState>();
  late String _username, _userNumber, _password, _confirmPassword;
    bool userTypeLoad = true;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    if(userTypeLoad) {
     _loadData(context);
    }
    SelectedDropDown _selectedDropItem = Get.find();

    final fullNameField = TextFormField(
      autofocus: true,
      focusNode: FocusNode(),
      //validator: va,
      //style: TextStyle(color: Colors.white),
      onSaved: (value) => _username = value!,
      textInputAction: TextInputAction.next,
      decoration: buildInputDecoration(
          "Type your full name".tr(), CupertinoIcons.profile_circled),
    );
    final usernameField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      onSaved: (value) => _userNumber = value!,
      decoration:
          buildInputDecoration("Type Number".tr(), Icons.mobile_friendly),
      keyboardType: TextInputType.number,
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      textInputAction: TextInputAction.next,
      validator: (value) => value!.isEmpty ? "Please enter password".tr() : null,
      onSaved: (value) => _password = value!,
      decoration: buildInputDecoration("Password".tr(), Icons.lock),
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      validator: (value) => value!.isEmpty ? "Please enter password".tr() : null,
      onSaved: (value) => _confirmPassword = value!,
      textInputAction: TextInputAction.done,
      obscureText: true,
      decoration: buildInputDecoration("Confirm password".tr(), Icons.lock),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text("Registering ... Please wait")
      ],
    );
    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(
          //  padding: EdgeInsets.all(0.0),
          child: label("Forgot password?".tr()),
          onPressed: () {
            displayTextInputDialog(context);

          },
        ),
        TextButton(
          //  padding: EdgeInsets.only(left: 0.0),
          child:
          label("Login".tr()),
          onPressed: () {
            Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
          },
        ),
      ],
    );
    var doRegister = () {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();

        if(_selectedDropItem.userTypeId != "" && _username != "" && _userNumber != "" && _password != "") {
          auth
              .register(
              _selectedDropItem.userTypeId,
              _username,
              _userNumber,
              _password,
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              "")
              .then((response) {
            print("response " + response.toString());
            if (response['status']) {
              // Navigator.pushReplacementNamed(context, MyRoutes.oTPRoute);
              RegistrationModel registrationModel = response['data'];
              registrationModel.result = _userNumber;
              Navigator.pushNamed(
                context,
                MyRoutes.oTPRoute,
                arguments: registrationModel,
              );
            } else {
              Flushbar(
                title: "Registration Failed",
                message: response['message'],
                duration: Duration(seconds: 10),
              ).show(context);
            }
          });
        }else{
          Flushbar(
            title: "Registration Failed",
            message: "Please fill up all field",
            duration: Duration(seconds: 10),
          ).show(context);
        }
      } else {
        Flushbar(
          title: "Invalid form",
          message: "Please Complete the form properly",
          duration: Duration(seconds: 10),
        ).show(context);
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
              child: Consumer<ServiceProvider>(
              builder: (context, services, child) {

                if(_selectedDropItem.userTypeId == ""){
                  if (services.userTypeModel.isNotEmpty){
                    _selectedDropItem.userTypeId = services.userTypeModel[0].id.toString();
                    print("vechileId 2  ${services.userTypeModel[0].id.toString()}");
                  }
                }else{
                  if (services.userTypeModel.isNotEmpty) {
                    bool exists = services.userTypeModel.any((file) => file.id == _selectedDropItem.userTypeId);

                    if (!exists){
                      _selectedDropItem.userTypeId = services.userTypeModel[0].id.toString();
                    }
                  }
                }
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logo.png',
                          height: 100, width: 100),
                      SizedBox(height: 5.0),
                      //titleLabel("Amar Gari".tr()),
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
                                  label("Full name".tr()),
                                  SizedBox(height: 5.0),
                                  fullNameField,
                                  SizedBox(height: 15.0),
                                  label("Mobile Number".tr()),
                                  SizedBox(height: 5.0),
                                  usernameField,
                                  SizedBox(height: 15.0),
                                  label("Password".tr()),
                                  SizedBox(height: 10.0),
                                  passwordField,
                                  SizedBox(height: 15.0),
                                  label("User Type".tr()),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: DropDownBorderItem(
                                        textTitle: "UserType :",
                                        list: services.userTypeModel,
                                        requestType: "UserType", selectedItem:   _selectedDropItem.userTypeId),
                                  ),
                                  auth.loggedInStatus == Status.Authenticating
                                      ? loading
                                      : longButtons("Sign up".tr(), doRegister),
                                  forgotLabel
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]);
              }
              ),
            ),
          ),
        ],
      ),
    );
  }



/*  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }*/
}
