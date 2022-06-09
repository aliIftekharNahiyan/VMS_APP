import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/view/TripManagement/add_modify_trip.dart';
import 'package:amargari/view/TripManagement/trip_list_view.dart';
import 'package:flutter/material.dart';

class TripManagementHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myImageAndCaption = [
      ["assets/icons/On Going Trip.png", "On Going Trip"],
      ["assets/icons/Trip Completed.png", "Trip Completed"],
      ["assets/icons/Trip Request.png", "Trip Request"]
    ];
    addTrip() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddUpdateTrip()));
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Trip Management"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          ...myImageAndCaption.map(
            (i) => Card(
              child: new InkResponse(
                onTap: () {
                  print("InkResponse " + i.last);
                  //Navigator.pushNamed(context, MyRoutes.vehicleInfo);

                  if (i.last == "On Going Trip") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TripListView(
                                title: "On Going Trip", statusId: "1")));
                  } else if (i.last == "Trip Completed") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TripListView(
                                title: "Trip Completed", statusId: "2")));
                  } else if (i.last == "Trip Request") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TripListView(
                                title: "Trip Request", statusId: "-1")));
                  }
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Material(
                        shape: CircleBorder(),
                        elevation: 1.0,
                        child: Image.asset(
                          i.first,
                          fit: BoxFit.fitWidth,
                          height: 100,
                          width: 100,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(i.last),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: AppConstant.userTypeId != 2
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                onPressed: () {
                  addTrip();
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
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
