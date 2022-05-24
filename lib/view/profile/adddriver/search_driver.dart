import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/uril/routes.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/authentication/driver_registration.dart';
import 'package:amargari/view/profile/adddriver/DriverAddRemoveWidget.dart';
import 'package:amargari/view/profile/my_account_details_view.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchDriver extends StatefulWidget {
  @override
  _SearchDriverState createState() => new _SearchDriverState();
}

class _SearchDriverState extends State<SearchDriver> {
  TextEditingController controller = new TextEditingController();

  void _loadData(BuildContext context, String mobile, String name) async {
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) => {
          Provider.of<ServiceProvider>(context, listen: false)
              .getSearchDriverList(mobile, name, value.id!)
        });
  }

  @override
  void initState() {
    super.initState();

    // getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    _loadData(context, "", "");

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Search'),
        elevation: 0.0,
      ),
      body: Consumer<ServiceProvider>(builder: (context, services, child) {
        return new Column(
          children: <Widget>[
            new Container(
              color: Theme.of(context).primaryColor,
              child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Card(
                  child: new ListTile(
                    leading: new Icon(Icons.search),
                    title: new TextField(
                      controller: controller,
                      decoration: new InputDecoration(
                          hintText: 'Search', border: InputBorder.none),
                      onChanged: onSearchTextChanged,
                    ),
                    trailing: new IconButton(
                      icon: new Icon(Icons.cancel),
                      onPressed: () {
                        controller.clear();
                        onSearchTextChanged('');
                      },
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: MaterialButton(
                  onPressed: () {
                    // removeDriver(context, widget.searchDriverModel);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DriverRegistration()),
                        ModalRoute.withName('/'));
                  },
                  child: Text("New Driver"),
                  color: Colors.white,
                ),
              ),
            ),
            new Expanded(
              child: services.searchDriverModel.length != 0 ||
                      controller.text.isNotEmpty
                  ? new ListView.builder(
                      itemCount: services.searchDriverModel.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyProfileScreen(userId: "${services.searchDriverModel[i].id}",)));
                            // snackBar2(
                            //     context, "${services.searchDriverModel[i].id}",
                            //     success: false);
                          },
                          child: new Card(
                            child: new ListTile(
                              leading: services.searchDriverModel[i]
                                              .profilePicture !=
                                          "" &&
                                      services.searchDriverModel[i]
                                              .profilePicture !=
                                          null
                                  ? new CircleAvatar(
                                      backgroundImage: new NetworkImage(services
                                          .searchDriverModel[i].profilePicture))
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
                                                  .searchDriverModel[i].name ??
                                              ""),
                                          Text(services.searchDriverModel[i]
                                                  .mobileNo ??
                                              ""),
                                        ]),
                                  ),
                                  DriverAddRemoveWidget(
                                      searchDriverModel:
                                          services.searchDriverModel[i])
                                ],
                              ),
                            ),
                            margin: const EdgeInsets.all(0.0),
                          ),
                        );
                      },
                    )
                  : new ListView.builder(
                      itemCount: services.searchDriverModel.length,
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
                                                  .searchDriverModel[i].name ??
                                              ""),
                                          label(services.searchDriverModel[i]
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
            ),
          ],
        );
      }),
    );
  }

  onSearchTextChanged(String text) async {
    print("onSearchTextChanged");
    //services.searchDriverModel.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    if (isNumeric(text)) {
      _loadData(context, text, "");
      // Provider.of<ServiceProvider>(context, listen: false)
      //     .getSearchDriverList(text, "");
    } else {
      _loadData(context, "", text);
      // Provider.of<ServiceProvider>(context, listen: false)
      //     .getSearchDriverList("", text);
    }
    // _userDetails.forEach((userDetail) {
    //   if (userDetail.firstName.contains(text) || userDetail.lastName.contains(text))
    //     _searchResult.add(userDetail);
    // });

    //  setState(() {});
  }
}
