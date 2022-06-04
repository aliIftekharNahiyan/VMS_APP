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
  SearchDriver({this.title, this.isSettings = false});
  final title;
  final isSettings;
  @override
  _SearchDriverState createState() => new _SearchDriverState();
}

class _SearchDriverState extends State<SearchDriver> {
  TextEditingController controller = new TextEditingController();

  void _loadData(BuildContext context, String mobile, String name) async {
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) => {
          print("UserId::::::: ${value.id}"),
          Provider.of<ServiceProvider>(context, listen: false)
              .getSearchDriverList(value.id!)
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _loadData(context, "", "");

    return new Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: new Text(widget.title),
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
            SizedBox(
              height: 10,
            ),
            new Expanded(
              child: services.searchDriverModel.length != 0 ||
                      controller.text.isNotEmpty
                  ? new ListView.builder(
                      itemCount: services.searchDriverModel.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {},
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
                                  widget.isSettings
                                      ? DriverAddRemoveWidget(
                                          searchDriverModel:
                                              services.searchDriverModel[i])
                                      : MaterialButton(
                                          minWidth: 20,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyProfileScreen(
                                                          userId:
                                                              "${services.searchDriverModel[i].id}",
                                                        )));
                                            // addDriver(
                                            //     context, widget.searchDriverModel);
                                          },
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.white),
                                          ),
                                          color: Colors.blue,
                                        ),
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
                              leading: services.searchDriverModel[i].profilePicture == "" || services.searchDriverModel[i].profilePicture == "null"
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
