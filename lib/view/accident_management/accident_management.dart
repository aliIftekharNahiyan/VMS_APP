import 'package:amargari/model/accident_list_model.dart';
import 'package:amargari/uril/utility.dart';
import 'package:amargari/view/accident_management/add_locations.dart';
import 'package:flutter/material.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/accident_provider.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/Service/component/service_list_item.dart';
import 'package:amargari/view/accident_management/add_update_accident.dart';
import 'package:get/get.dart';

class AccidentManagementView extends StatefulWidget {
  final String title;

  // In the constructor, require a Todo.
  AccidentManagementView({required this.title});

  @override
  _AccidentManagementViewState createState() => _AccidentManagementViewState();
}

class _AccidentManagementViewState extends State<AccidentManagementView> {
  Future<List<AccidentListModel>>? accidentList;
  var isVisible = true;

  @override
  void initState() {
    super.initState();
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData()
        .then((value) => {accidentList = getAccidentList("",value.id.toString())});

    new Future.delayed(new Duration(seconds: 3), () {
      setState(() {
        isVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var addGarageInfo = (AccidentListModel? garageModel) {
      // Get.to(AddLocation());
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Container(
          //   height: Get.height * .12,
          //   child: ListView(
          //     scrollDirection: Axis.horizontal,
          //     shrinkWrap: true,
          //     children: [
          //       Container(
          //         height: Get.height * .12,
          //         width: Get.width * .3,
          //         margin: EdgeInsets.all(5),
          //         child: Center(child: Text("Hospital", style: TextStyle(color: Colors.white),)),
          //         decoration: BoxDecoration(
          //           color: Colors.blue,
          //           borderRadius: BorderRadius.circular(5),
          //           border: Border.all(color: Colors.grey)
          //         ),
          //       ),
          //       Container(
          //         height: Get.height * .12,
          //         width: Get.width * .3,
          //         margin: EdgeInsets.all(5),
          //         child: Center(child: Text("Police Station", style: TextStyle(color: Colors.white),)),
          //         decoration: BoxDecoration(
          //           color: Colors.red,
          //           borderRadius: BorderRadius.circular(5),
          //           border: Border.all(color: Colors.grey)
          //         ),
          //       ),
          //       Container(
          //         height: Get.height * .12,
          //         width: Get.width * .3,
          //         margin: EdgeInsets.all(5),
          //         child: Center(child: Text("Garage", style: TextStyle(color: Colors.white),)),
          //         decoration: BoxDecoration(
          //           color: Colors.blueGrey[800],
          //           borderRadius: BorderRadius.circular(5),
          //           border: Border.all(color: Colors.grey)
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          Expanded(
            child: FutureBuilder<List<AccidentListModel>>(
              future: accidentList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return snapshot.data!.isEmpty
                      ? Center(child: Text('Empty'))
                      : ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            AccidentListModel accidentListModel =
                                snapshot.data![index];
                            return Card(
                              child: new InkResponse(
                                  onTap: () {
                                    print(index);
                                     addGarageInfo(accidentListModel);
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 5),
                                      ServiceItem(
                                          textTitle: 'Car Name',
                                          text: accidentListModel.brandName.toString()),
                                      ServiceItem(
                                          textTitle: 'Driver Name',
                                          text: accidentListModel.driverName.toString()),

                                      ServiceItem(
                                            textTitle: 'Accident Date',
                                            text: convertDate2(
                                                accidentListModel.accidentTime ?? "2021-12-03T00:00:00")),

                                      ServiceItem(
                                          textTitle: 'Accident Location',
                                          text: accidentListModel.accidentLocation
                                              .toString()),
                                      ServiceItem(
                                          textTitle: 'Accident Fine',
                                          text: accidentListModel.fine.toString()),
                                      SizedBox(height: 5),
                                    ],
                                  )),
                            );
                          },
                        );
                } else {
                  return Center(child: CircularProgressIndicator());
                }

                // By default, show a loading spinner.
              },
            ),
          ),
        ],
      ),
     floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: () {
            addGarageInfo(new AccidentListModel());
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
