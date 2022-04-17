import 'package:amargari/view/vehicles_info/vehicles_list_view.dart';
import 'package:flutter/material.dart';

class VehicleDashboard extends StatefulWidget {
  @override
  State<VehicleDashboard> createState() => _VehicleDashboardState();
}

class _VehicleDashboardState extends State<VehicleDashboard> {
  var isLoaded = true;


  @override
  Widget build(BuildContext context) {


    final myImageAndCaption = [
      ["assets/images/Vehicle Info.png", "Vehicle List"],
      ["assets/images/Trip Management.png", "Tax token"],
      //["assets/images/03.png", "Vehicle Servicing"],
      ["assets/images/Fuel Analysis.png", "Registration"],
      ["assets/images/Police Case.png", "Fitness"],
      //["assets/images/06.png", "Insurance Policy"],
      ["assets/images/Workshop Expense.png", "Route"],
      ["assets/images/Accident Management.png", "Insurance"],
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text("Vehicle Dashboard"),
        ),
      body: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: [
                    ...myImageAndCaption.map(
                          (i) => Card(
                        child: new InkResponse(
                          onTap: () {
                            print("InkResponse " + i.last);
                            //Navigator.pushNamed(context, MyRoutes.vehicleInfo);

                            if (i.last == "Vehicle List") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          VehicleInfo(title: i.last)));
                            }else  if (i.last == "Tax token") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          VehicleInfo(title: i.last)));
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
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                                SizedBox(height: 6.0),
                                Text(
                                  i.last,
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )

    );
  }
}
