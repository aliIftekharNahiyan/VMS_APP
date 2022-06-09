import 'package:amargari/get_state/selected_dropdown.dart';
import 'package:amargari/model/AddDriver/search_driver_model.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/common_view/all_drop_down_Item.dart';
import 'package:amargari/view/common_view/edit_List_Item.dart';
import 'package:amargari/view/profile/adddriver/DriverAddRemoveWidget.dart';
import 'package:amargari/view/profile/adddriver/search_driver.dart';
import 'package:amargari/view/profile/my_account_details_view.dart';
import 'package:amargari/widgets/TextEditingControllerWithEndCursor.dart';
import 'package:amargari/widgets/drop_down_list_border.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:provider/provider.dart';
import 'package:amargari/providers/auth.dart';
import 'package:amargari/widgets/widgets.dart';

class DriverRegistration extends StatefulWidget {
  @override
  _DriverRegistrationState createState() => _DriverRegistrationState();
}

void _loadData(BuildContext context) async {
  Provider.of<ServiceProvider>(context, listen: false)
      .getUserType(type: "DRIVER");
  Future<UserInfoModel> getUserData() => UserPreferences().getUser();
  getUserData().then((value) => {
        print("UserId::::::: ${value.id}"),
        Provider.of<ServiceProvider>(context, listen: false)
            .getSearchDriverList(value.id!)
      });
}

void _driverAllocationDeallocation(BuildContext context, {driverId: String}) {
  Future<UserInfoModel> getUserData() => UserPreferences().getUser();
  getUserData().then((value) => {
        print("UserId::::::: ${value.id}"),
        Provider.of<ServiceProvider>(context, listen: false)
            .getAllocationDeallocation(ownerId: value.id!, driverId: driverId)
            .then((value) {
          if (value) {
            _loadData(context);
          }
        })
      });
}

class _DriverRegistrationState extends State<DriverRegistration> {
  final formKey = new GlobalKey<FormState>();
  late String _username, _userNumber, _password, _confirmPassword;
  bool userTypeLoad = true;

  var id = new TextEditingControllerWithEndCursor(text: '0');
  var fullName = new TextEditingControllerWithEndCursor(text: '');
  var mobileNumber = new TextEditingControllerWithEndCursor(text: '');
  var password = new TextEditingControllerWithEndCursor(text: '1234');

  void update(SearchDriverModel searchDriverModel) {
    setState(() {
      id.text = searchDriverModel.id.toString();
      fullName.text = searchDriverModel.name!;
      mobileNumber.text = searchDriverModel.mobileNo!;
      password.text = searchDriverModel.password.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    if (userTypeLoad) {
      _loadData(context);
    }
    SelectedDropDown _selectedDropItem = Get.find();

    final fullNameField = TextFormField(
      autofocus: false,
      focusNode: FocusNode(),
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
      initialValue: '1234',
      enabled: false,
      validator: (value) =>
          value!.isEmpty ? "Please enter password".tr() : null,
      onSaved: (value) => _password = value!,
      decoration: buildInputDecoration("Password Default".tr(), Icons.lock),
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      validator: (value) =>
          value!.isEmpty ? "Please enter password".tr() : null,
      onSaved: (value) => _confirmPassword = value!,
      textInputAction: TextInputAction.done,
      obscureText: true,
      decoration: buildInputDecoration("Confirm password".tr(), Icons.lock),
    );

    var doRegister = () {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
        Future<UserInfoModel> getUserData() => UserPreferences().getUser();
        getUserData().then((value) {
          if (_selectedDropItem.userTypeId != "" &&
              fullName.text != "" &&
              mobileNumber.text != "") {
            auth
                .register(
                    int.parse(id.text),
                    _selectedDropItem.userTypeId,
                    fullName.text,
                    mobileNumber.text,
                    password.text,
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    value.id!)
                .then((response) {
              print("response " + response.toString());
              if (response['status']) {
                setState(() {
                  id.text = "";
                  fullName.text = "";
                  mobileNumber.text = "";
                  password.text = "1234";
                });
                _loadData(context);
              } else {
                Flushbar(
                  title: "Registration Failed",
                  message: response['message'],
                  duration: Duration(seconds: 10),
                ).show(context);
              }
            });
          } else {
            Flushbar(
              title: "Registration Failed",
              message: "Please fill up all field",
              duration: Duration(seconds: 10),
            ).show(context);
          }
        });
      } else {
        Flushbar(
          title: "Invalid form",
          message: "Please Complete the form properly",
          duration: Duration(seconds: 10),
        ).show(context);
      }
    };

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Driver Create"),
      ),
      body: Stack(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  color: Colors.white) //linearGradientDecoration(),
              ),
          SingleChildScrollView(
            // padding: EdgeInsets.all(4.0),
            child:
                Consumer<ServiceProvider>(builder: (context, services, child) {
              if (_selectedDropItem.userTypeId == "") {
                if (services.userTypeModel.isNotEmpty) {
                  _selectedDropItem.userTypeId =
                      services.userTypeModel[0].id.toString();
                  print(
                      "vechileId 2  ${services.userTypeModel[0].id.toString()}");
                }
              } else {
                if (services.userTypeModel.isNotEmpty) {
                  bool exists = services.userTypeModel
                      .any((file) => file.id == _selectedDropItem.userTypeId);

                  if (!exists) {
                    _selectedDropItem.userTypeId =
                        services.userTypeModel[0].id.toString();
                  }
                }
              }
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      child: Container(
                        // padding: EdgeInsets.all(16.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(height: 15.0),
                              // label("Full name".tr()),
                              SizedBox(height: 5.0),
                              // fullNameField,
                              EditListItem(
                                  text: 'Full Name',
                                  nameController: fullName,
                                  hintText: "Enter full name",
                                  isRequired: true),
                              SizedBox(height: 15.0),
                              // label("Mobile Number".tr()),
                              // SizedBox(height: 5.0),
                              // usernameField,
                              EditListItem(
                                  text: 'Mobile Number',
                                  nameController: mobileNumber,
                                  hintText: "Enter mobile number",
                                  isRequired: true),
                              SizedBox(height: 15.0),
                              EditListItem(
                                  text: 'Password (Default: 1234)',
                                  nameController: password,
                                  hintText: "Enter password",
                                  obscureText: true,
                                  isEditAble: false,
                                  isRequired: true),
                              SizedBox(height: 15.0),
                              AllDropDownItem(
                                  textTitle: "User Type",
                                  list: services.userTypeModel,
                                  requestType: "UserType",
                                  isRequired: true,
                                  selectedItem: _selectedDropItem.userTypeId),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: longButtons(
                                    "${id.text == "0" ? "Create" : "Update"}"
                                        .tr(),
                                    doRegister),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    services.searchDriverModel.length != 0
                        ? new ListView.builder(
                            itemCount: services.searchDriverModel.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () {
                                  update(services.searchDriverModel[i]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Card(
                                    child: new ListTile(
                                      leading: services.searchDriverModel[i]
                                                      .profilePicture !=
                                                  "" &&
                                              services.searchDriverModel[i]
                                                      .profilePicture !=
                                                  null
                                          ? new CircleAvatar(
                                              backgroundImage: new NetworkImage(
                                                  services.searchDriverModel[i]
                                                      .profilePicture))
                                          : CircleAvatar(
                                              child: Image.asset(
                                                  "assets/images/profile.png"),
                                            ),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 8,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(services
                                                          .searchDriverModel[i]
                                                          .name ??
                                                      ""),
                                                  Text(services
                                                          .searchDriverModel[i]
                                                          .mobileNo ??
                                                      ""),
                                                ]),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _driverAllocationDeallocation(
                                                  context,
                                                  driverId: services
                                                      .searchDriverModel[i].id);
                                            },
                                            child: Text(
                                              "${services.searchDriverModel[i].isDriverAllocated == 1 ? "Activate" : "Deactivate"}",
                                              style: TextStyle(
                                                  color: services
                                                              .searchDriverModel[
                                                                  i]
                                                              .isDriverAllocated ==
                                                          1
                                                      ? Colors.blue
                                                      : Colors.red),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    margin: const EdgeInsets.all(0.0),
                                  ),
                                ),
                              );
                            },
                          )
                        : new ListView.builder(
                            itemCount: services.searchDriverModel.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              return new Card(
                                child: new ListTile(
                                    leading: services.searchDriverModel[i]
                                                .profilePicture ==
                                            ""
                                        ? new CircleAvatar(
                                            backgroundImage: new NetworkImage(
                                              services.searchDriverModel[i]
                                                  .profilePicture,
                                            ),
                                          )
                                        : CircleAvatar(
                                            child: Image.asset(
                                                "assets/images/profile.png"),
                                          ),
                                    title: Row(
                                      children: [
                                        Expanded(
                                          flex: 8,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                label(services
                                                        .searchDriverModel[i]
                                                        .name ??
                                                    ""),
                                                label(services
                                                        .searchDriverModel[i]
                                                        .mobileNo ??
                                                    ""),
                                              ]),
                                        ),
                                        DriverAddRemoveWidget(
                                            searchDriverModel:
                                                services.searchDriverModel[i])
                                      ],
                                    )),
                                margin: const EdgeInsets.all(0.0),
                              );
                            },
                          ),
                  ]);
            }),
          ),
        ],
      ),
    );
  }
}
