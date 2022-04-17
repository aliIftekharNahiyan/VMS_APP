import 'package:amargari/model/trip_list_model.dart';
import 'package:amargari/providers/trip_list%20_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/utility.dart';
import 'package:amargari/view/TripManagement/Direction.dart';
import 'package:amargari/view/TripManagement/TripAcceptWidget.dart';
import 'package:flutter/material.dart';
import 'package:amargari/view/Service/component/service_list_item.dart';
import 'package:flutter/widgets.dart';

class TripListView extends StatefulWidget {
  final String title;
  final String statusId;
  // In the constructor, require a Todo.
  TripListView({ required this.title, required this.statusId});
  @override
  _TripListViewState createState() => _TripListViewState();
}

class _TripListViewState extends State<TripListView> {
  Future<List<TripListModel>> ? vehicleList ;
  // var isVisible = true;
  Future<dynamic>? accidentAddUpdate;
  String updateStatusID = "";
  @override
  void initState() {
    super.initState();

    vehicleList = TripListProvider().fetchTripList(widget.statusId, AppConstant.userId.toString());

    /*  new Future.delayed(new Duration(seconds: 3), () {
      setState(() {
        isVisible = false;
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    var addGarageInfo = (TripListModel tripListModel) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Direction(tripListModel: tripListModel)));
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<TripListModel>>(
        future: vehicleList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data!.isEmpty
                ? Center(child: Text('Empty'))
                : ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                TripListModel tripListModel = snapshot.data![index];
                return Card(
                  child: new InkResponse(
                    onTap: () {
                      print(index);
                      addGarageInfo(tripListModel);
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 5),


                        ServiceItem(
                            textTitle: 'Driver Name: ',
                            text: tripListModel.driverName ?? ""),
                        ServiceItem(
                            textTitle: 'Model Name: ',
                            text: tripListModel.modelName ?? ""),
                        ServiceItem(
                            textTitle: 'Mobile No: ',
                            text: tripListModel.mobileNo ?? ""),

                        ServiceItem(
                            textTitle: 'Start Point: ',
                            text: tripListModel.StartPointName ?? ""),
                        ServiceItem(
                            textTitle: 'Start Time: ',
                            text: convertDateTime(tripListModel.tripStartTime ?? "")),
                        ServiceItem(
                            textTitle: 'End Point: ',
                            text: tripListModel.EndPointName ?? ""),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: TripAcceptWidget(statusId: widget.statusId, userTypeId: AppConstant.userTypeId, tripListModel: tripListModel),
                          ),
                        ),
                      ],
                    ),
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

    );
  }
}
