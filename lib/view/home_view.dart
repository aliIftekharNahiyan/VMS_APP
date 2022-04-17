import 'package:amargari/model/home_data_model.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/pie_chart/lineChart/line_chart_sample1.dart';
import 'package:amargari/providers/common_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/TripManagement/TripManagementHome.dart';
import 'package:amargari/view/monthly_report.dart';
import 'package:flutter/material.dart';
import 'package:amargari/view/Service/service_list_view.dart';
import 'package:amargari/view/accident_management/accident_management.dart';
import 'package:amargari/view/fuel_management/fuel_management.dart';
import 'package:amargari/view/garage/garage_list_view.dart';
import 'package:amargari/view/insurance_policy/insurance_policy.dart';
import 'package:amargari/view/police_case/police_case_list.dart';
import 'package:amargari/view/vehicles_info/vehicles_list_view.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isLoaded = true;

  HomeDataModel homeData = HomeDataModel();

  Future<HomeDataModel>? homeDataModel ;

  @override
  Widget build(BuildContext context) {
    CommonProvider commonProvider = Provider.of<CommonProvider>(context);
    if (isLoaded){
      Future<UserInfoModel> getUserData() => UserPreferences().getUser();
      homeDataModel = commonProvider.getHomeData(AppConstant.userId.toString());
      homeDataModel!.then((value) => {
        setState(() {
          homeData = value;
          isLoaded = false ;
          print("homeDataModel  ${homeData.data!.needToknow!.length}");
        })
      });
    };

    final myImageAndCaption = [
      ["assets/images/Vehicle Info.png", "Vehicle List"],
      ["assets/images/Trip Management.png", "Trip Management"],
      //["assets/images/03.png", "Vehicle Servicing"],
      ["assets/images/Fuel Analysis.png", "Fuel Analysis"],
      ["assets/images/Police Case.png", "Police Case"],
      //["assets/images/06.png", "Insurance Policy"],
      ["assets/images/Workshop Expense.png", "Workshop Expense"],
      ["assets/images/Accident Management.png", "Accident Management"],
    ];

    return Scaffold(
      body: FutureBuilder<HomeDataModel>(
        future: homeDataModel,
        builder: (BuildContext context, AsyncSnapshot<HomeDataModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {

            return  homeDataModel == null
                ? Center(child: CircularProgressIndicator()) : ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 51,
                        child: Container(
                          height: 200,
                          child: Card(
                              semanticContainer: true,
                              color: Color.fromARGB(255, 245, 184, 105),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5),
                                    Text(
                                      "You may need",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    Divider(height: 10, color: Colors.white,),
                                    for (var string in snapshot.data!.data!.needToknow ?? [])
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(" * $string", style: TextStyle(fontSize: 13),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,),
                                        )
                                ],
                                ),
                              )),
                        ),
                      ),
                      Expanded(
                        flex: 49,
                        child: Container(
                          height: 200,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MonthlyReportView()));
                            },
                            child: Card(
                                color: Color.fromARGB(255, 210, 226, 62),
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5),
                                      Text(
                                        "Monthly Report",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      Divider(height: 10, color: Colors.white,),
                                      SizedBox(height: 5),
                                      Text("Total Fuel: ${snapshot.data!.data!.monthlyReport!.analytics![0].data!.fuel}", style: TextStyle(fontSize: 13)),
                                      SizedBox(height: 5),
                                      Text("Fuel Cost: ${snapshot.data!.data!.monthlyReport!.analytics![0].data!.fuelCost}", style: TextStyle(fontSize: 13)),
                                      SizedBox(height: 5),
                                      Text("Accident: ${snapshot.data!.data!.monthlyReport!.analytics![0].data!.accident} ", style: TextStyle(fontSize: 13)),
                                      SizedBox(height: 5),
                                      Text("Total Earn: ${snapshot.data!.data!.monthlyReport!.analytics![0].data!.totalEarned}",style: TextStyle(fontSize: 13),),
                                      SizedBox(height: 5),
                                      Text("Servicing: ${snapshot.data!.data!.monthlyReport!.analytics![0].data!.servicing}",style: TextStyle(fontSize: 13),),
                                      SizedBox(height: 5),
                                      Text("Servicing Cost: ${snapshot.data!.data!.monthlyReport!.analytics![0].data!.servicingCost}",style: TextStyle(fontSize: 13),),
                                      SizedBox(height: 5),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ],

                  ),
                ),
                Visibility(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LineChartSample1(snapshot.data!.data!.fuelReport),
                  ),
                  visible: snapshot.data!.data!.fuelReport![0].dataAvailable ?? false,
                ),
                GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
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
                                          VehicleInfo(title: "Vehicle List")));
                            } else if (i.last == "Trip Management") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TripManagementHome()));
                            } else if (i.last == "Vehicle Servicing") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ServiceListView(title: i.last)));
                            } else if (i.last == "Workshop Expense") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          GarageInfoView(title: i.last)));
                            } else if (i.last == "Police Case") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PoliceCaseView(
                                          title: i.last, vehicleId: "")));
                            } else if (i.last == "Accident Management") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AccidentManagementView(title: i.last)));
                            } else if (i.last == "Insurance Policy") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InsurancePolicyView(
                                        title: i.last,
                                        vehicleId: "1",
                                      )));
                            } else if (i.last == "Fuel Analysis") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FuelManagementView(
                                          title: i.last, vehicleId: "1")));
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
                                  style: TextStyle(fontSize: 10),
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
              ],
            );
          }else {
            return Center(child: CircularProgressIndicator());
          }
        },

      ),
    );
  }
}
