import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/view/profile/adddriver/DriverAddRemoveWidget.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchDriver extends StatefulWidget {
  @override
  _SearchDriverState createState() => new _SearchDriverState();
}

class _SearchDriverState extends State<SearchDriver> {
  TextEditingController controller = new TextEditingController();

  void _loadData(BuildContext context) async {
    Provider.of<ServiceProvider>(context, listen: false)
        .getSearchDriverList("","");

  }
  @override
  void initState() {
    super.initState();

    // getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    _loadData(context);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Search'),
        elevation: 0.0,
      ),
      body: Consumer<ServiceProvider>(builder: (context, services, child) {
        return new Column(
          children: <Widget>[
            new Container(
              color: Theme
                  .of(context)
                  .primaryColor,
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Card(
                  child: new ListTile(
                    leading: new Icon(Icons.search),
                    title: new TextField(
                      controller: controller,
                      decoration: new InputDecoration(
                          hintText: 'Search', border: InputBorder.none),
                      onChanged: onSearchTextChanged,
                    ),
                    trailing: new IconButton(icon: new Icon(Icons.cancel),
                      onPressed: () {
                        controller.clear();
                        onSearchTextChanged('');
                      },),
                  ),
                ),
              ),
            ),
            new Expanded(
              child: services.searchDriverModel.length != 0 || controller.text.isNotEmpty
                  ? new ListView.builder(
                itemCount: services.searchDriverModel.length,
                itemBuilder: (context, i) {
                  return new Card(
                    child: new ListTile(
                      leading: new CircleAvatar(
                        backgroundImage: new NetworkImage(
                          services.searchDriverModel[i].profilePicture ?? "",),),
                      title: Row(
                        children:[ Expanded(
                          flex: 8,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                              [Text(services.searchDriverModel[i].name ?? ""),
                                Text(services.searchDriverModel[i].mobileNo ?? ""),]),
                        ),  DriverAddRemoveWidget(searchDriverModel: services.searchDriverModel[i])],
                      ),
                    ),
                    margin: const EdgeInsets.all(0.0),
                  );
                },
              )
                  : new ListView.builder(
                itemCount: services.searchDriverModel.length,
                itemBuilder: (context, i) {
                  return new Card(
                    child: new ListTile(
                        leading: new CircleAvatar(
                          backgroundImage: new NetworkImage(
                            services.searchDriverModel[i].profilePicture,),),
                        title: Row(
                          children:[ Expanded(
                            flex: 8,
                            child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                children: [label(services.searchDriverModel[i].name ?? ""),
                                  label(services.searchDriverModel[i].mobileNo ?? ""), ]),
                          ),
                            DriverAddRemoveWidget(searchDriverModel: services.searchDriverModel[i])],
                        )
                    ),
                    margin: const EdgeInsets.all(0.0),
                  );
                },
              ),
            ),
          ],
        );

      }
      ),
    );
  }

  onSearchTextChanged(String text) async {
    print("onSearchTextChanged");
    //services.searchDriverModel.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    if (isNumeric(text)){
      Provider.of<ServiceProvider>(context, listen: false)
          .getSearchDriverList(text,"");
    }else {
      Provider.of<ServiceProvider>(context, listen: false)
          .getSearchDriverList("", text);
    }
    // _userDetails.forEach((userDetail) {
    //   if (userDetail.firstName.contains(text) || userDetail.lastName.contains(text))
    //     _searchResult.add(userDetail);
    // });

    //  setState(() {});
  }
}



