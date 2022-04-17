import 'package:amargari/uril/utility.dart';
import 'package:amargari/widgets/ImageFullScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:amargari/model/police_case_model.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/police_case_provider.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/Service/component/service_list_item.dart';
import 'package:amargari/view/police_case/add_update_police_case_details_view.dart';

class PoliceCaseView extends StatefulWidget {
  final String title;
  final String vehicleId;

  // In the constructor, require a Todo.
  PoliceCaseView({required this.title, required this.vehicleId});

  @override
  _PoliceCaseViewState createState() => _PoliceCaseViewState();
}

class _PoliceCaseViewState extends State<PoliceCaseView> {
  Future<List<PoliceCaseModel>>? policeCaseList;
  var isVisible = true;

  @override
  void initState() {
    super.initState();
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();

    getUserData().then((value) => {
          policeCaseList =
              fetchPoliceCaseList(widget.vehicleId, value.id.toString())
        });

    new Future.delayed(new Duration(seconds: 3), () {
      setState(() {
        isVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var addPoliceCaseInfo = (PoliceCaseModel policeCaseModel) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PoliceCaseDetailsView(
                  vcDataModel: policeCaseModel, vehicleId: "")));
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<PoliceCaseModel>>(
        future: policeCaseList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data!.isEmpty
                ? Center(child: Text('Empty'))
                : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      PoliceCaseModel policeCaseModel = snapshot.data![index];
                      return Card(
                        child: new InkResponse(
                          onTap: () {
                            print(index);
                            addPoliceCaseInfo(policeCaseModel);
                          },
                          child: Row(children: [
                            Expanded(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ImageFullScreen(
                                                    imageURL: policeCaseModel
                                                            .policeCaseList
                                                            ?.img ??
                                                        "")));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child:
                                        policeCaseModel.policeCaseList?.img == ""
                                            ? Image.asset(
                                                "assets/icons/edit_image.png",
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.contain,
                                                color: Colors.black,
                                              )
                                            : CachedNetworkImage(
                                                imageUrl: policeCaseModel
                                                        .policeCaseList?.img ??
                                                    "",
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child: SizedBox(
                                                    width: 30.0,
                                                    height: 30.0,
                                                    child:
                                                        new CircularProgressIndicator(),
                                                  ),
                                                ),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    ImageIcon(AssetImage(
                                                        "assets/icons/edit_image.png")),
                                                width: 90,
                                                height: 90,
                                              ),
                                  ),
                                )),
                            Expanded(
                              flex: 8,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 5),
                                  ServiceItem(
                                      textTitle: 'Case Name',
                                      text: policeCaseModel
                                              .policeCaseList?.caseName ??
                                          ""),
                                  ServiceItem(
                                      textTitle: 'Case Amount',
                                      text:
                                          "${policeCaseModel.policeCaseList?.caseAmount ?? 0.0}"),
                                  ServiceItem(
                                      textTitle: 'Case Date',
                                      text: convertDate2(policeCaseModel
                                              .policeCaseList?.caseDate ??
                                          "")),
                                  ServiceItem(
                                      textTitle: 'Police case clear',
                                      text: convertString(
                                          "${policeCaseModel.policeCaseList?.isClear ?? ""}")),
                                  ServiceItem(
                                      textTitle: 'Paper Handover',
                                      text: policeCaseModel
                                              .policeCaseList?.paperHandOver ??
                                          ""),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      );
                    },
                  );
          } else {
            return Center(child: CircularProgressIndicator());
          }
          // By default, show a loading spinner.
        },
      ),
      /*  floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: () {
            addPoliceCaseInfo(new PoliceCaseModel());
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 29,
          ),
          backgroundColor: Colors.orange,
          tooltip: 'Add More',
          elevation: 5,
          splashColor: Colors.grey,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,*/
    );
  }
}

String convertString(String? request) {
  if (request == "1") {
    return "YES";
  } else {
    return "NO";
  }
}
