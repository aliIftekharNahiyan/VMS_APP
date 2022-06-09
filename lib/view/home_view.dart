import 'package:amargari/model/LocalInfo/local_info_type.dart';
import 'package:amargari/model/home_data_model.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/pie_chart/lineChart/line_chart_sample1.dart';
import 'package:amargari/providers/common_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/TripManagement/TripManagementHome.dart';
import 'package:amargari/view/map/show_info_map.dart';
import 'package:amargari/view/monthly_report.dart';
import 'package:amargari/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:amargari/view/Service/service_list_view.dart';
import 'package:amargari/view/accident_management/accident_management.dart';
import 'package:amargari/view/fuel_management/fuel_management.dart';
import 'package:amargari/view/garage/garage_list_view.dart';
import 'package:amargari/view/insurance_policy/insurance_policy.dart';
import 'package:amargari/view/police_case/police_case_list.dart';
import 'package:amargari/view/vehicles_info/vehicles_list_view.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class DataSet {
  DataSet(this.year, this.sales);
  final String year;
  final double sales;
}

class _MyHomePageState extends State<MyHomePage> {
  var isLoaded = true;
  late TooltipBehavior _tooltipBehavior;
  HomeDataModel homeData = HomeDataModel();

  Future<HomeDataModel>? homeDataModel;

  List<Result> typeList = [];

  List<DataSet> dataList = [];

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CommonProvider commonProvider = Provider.of<CommonProvider>(context);

    if (isLoaded) {
      Future<UserInfoModel> getUserData() => UserPreferences().getUser();
      getUserData().then((value) {
        commonProvider.getFuelData(value.id.toString()).then((value) {
          value.data?.forEach((e) {
            setState(() {
              dataList.add(DataSet(
                  e.fuelTimeMonthName.toString(), e.amount!.toDouble()));
              // dataList.add(DataSet("May", e.amount!.toDouble()-100));
              // dataList.add(DataSet("June", e.amount!.toDouble()+200));
            });
          });
        });
      });
      homeDataModel = commonProvider.getHomeData(AppConstant.userId.toString());
      homeDataModel!.then((value) => {
            setState(() {
              homeData = value;
              print("homeDataModel  ${homeData.data!.needToknow!.length}");
            })
          });

      commonProvider.getLocalInfoTypeList().then((value) {
        typeList.clear();
        setState(() {
          value.result?.forEach((element) {
            typeList.add(element);
          });
        });
      });
      isLoaded = false;
    }

    final myImageAndCaption = [
      ["assets/images/Vehicle Info.png", "Vehicle List"],
      ["assets/images/Trip Management.png", "Trip Management"],
      ["assets/images/Fuel Analysis.png", "Fuel Info"],
      ["assets/images/Police Case.png", "Police Case"],
      ["assets/images/Workshop Expense.png", "Workshop Expense"],
      ["assets/images/Accident Management.png", "Accident List"],
    ];

    return Scaffold(
      body: FutureBuilder<HomeDataModel>(
        future: homeDataModel,
        builder: (BuildContext context, AsyncSnapshot<HomeDataModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return homeDataModel == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 50,
                                child: Card(
                                  elevation: 3,
                                  child: Container(
                                    height: 190,
                                    color: MyTheme.buttonColor,
                                    child: SfCartesianChart(
                                        // plotAreaBorderColor: Colors.black,
                                        primaryXAxis: CategoryAxis(),
                                        borderColor: Colors.white,
                                        title: ChartTitle(
                                            text: 'Fuel cost',
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.white)),
                                        tooltipBehavior: _tooltipBehavior,
                                        series: <ChartSeries<DataSet, String>>[
                                          LineSeries<DataSet, String>(
                                              dataSource: dataList,
                                              xAxisName: "Month",
                                              yAxisName: "Cost",
                                              xValueMapper:
                                                  (DataSet sales, _) =>
                                                      sales.year,
                                              yValueMapper:
                                                  (DataSet sales, _) =>
                                                      sales.sales,
                                              dataLabelSettings:
                                                  DataLabelSettings(
                                                      isVisible: true,
                                                      color: Colors.black),
                                              markerSettings: MarkerSettings(
                                                  color: Colors.green),
                                              color: Colors.blueGrey[800])
                                        ]),
                                  ),
                                )
                                // Container(
                                //   height: 200,
                                //   child: Card(
                                //       semanticContainer: true,
                                //       color: Color.fromARGB(255, 245, 184, 105),
                                //       child: Padding(
                                //         padding: const EdgeInsets.all(8.0),
                                //         child: Column(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.start,
                                //           crossAxisAlignment:
                                //               CrossAxisAlignment.start,
                                //           children: [
                                //             SizedBox(height: 5),
                                //             Text(
                                //               "You may need",
                                //               textAlign: TextAlign.center,
                                //               style: TextStyle(
                                //                   fontSize: 18,
                                //                   fontWeight: FontWeight.bold),
                                //             ),
                                //             Divider(
                                //               height: 10,
                                //               color: Colors.white,
                                //             ),
                                //             for (var string in snapshot
                                //                     .data!.data!.needToknow ??
                                //                 [])
                                //               Padding(
                                //                 padding:
                                //                     const EdgeInsets.all(2.0),
                                //                 child: Text(
                                //                   " * $string",
                                //                   style: TextStyle(fontSize: 13),
                                //                   maxLines: 2,
                                //                   overflow: TextOverflow.ellipsis,
                                //                 ),
                                //               )
                                //           ],
                                //         ),
                                //       )),
                                // ),
                                ),
                            Expanded(
                              flex: 50,
                              child: Container(
                                height: 200,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MonthlyReportView()));
                                  },
                                  child: Card(
                                      elevation: 3,
                                      color: MyTheme.buttonColor,
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 5),
                                            Text(
                                              "Monthly Report",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            Divider(
                                              height: 10,
                                              color: Colors.white,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                                "Total Fuel: ${snapshot.data!.data!.monthlyReport!.analytics![0].data!.fuel}",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white)),
                                            SizedBox(height: 5),
                                            Text(
                                                "Fuel Cost: ${snapshot.data!.data!.monthlyReport!.analytics![0].data!.fuelCost}",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white)),
                                            SizedBox(height: 5),
                                            Text(
                                                "Accident: ${snapshot.data!.data!.monthlyReport!.analytics![0].data!.accident} ",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white)),
                                            SizedBox(height: 5),
                                            Text(
                                              "Total Earn: ${snapshot.data!.data!.monthlyReport!.analytics![0].data!.totalEarned}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Servicing: ${snapshot.data!.data!.monthlyReport!.analytics![0].data!.servicing}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Servicing Cost: ${snapshot.data!.data!.monthlyReport!.analytics![0].data!.servicingCost}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white),
                                            ),
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
                          child: Container()
                              //LineChartSample1(snapshot.data!.data!.fuelReport),
                        ),
                        visible:
                            snapshot.data!.data!.fuelReport![0].dataAvailable ??
                                false,
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
                                            builder: (context) => VehicleInfo(
                                                title: "Vehicle List")));
                                  } else if (i.last == "Trip Management") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TripManagementHome()));
                                  } else if (i.last == "Vehicle Servicing") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ServiceListView(
                                                    title: i.last)));
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
                                            builder: (context) =>
                                                PoliceCaseView(
                                                    title: i.last,
                                                    vehicleId: "")));
                                  } else if (i.last == "Accident List") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AccidentManagementView(
                                                    title: i.last)));
                                  } else if (i.last == "Insurance Policy") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InsurancePolicyView(
                                                  title: i.last,
                                                  vehicleId: "1",
                                                )));
                                  } else if (i.last == "Fuel Info") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FuelManagementView(
                                                    title: i.last,
                                                    vehicleId: "1")));
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Emergency"),
                      ),
                      GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        children: [
                          ...typeList.reversed.map((e) {
                            return Container(
                              padding: EdgeInsets.all(0),
                              child: InkWell(
                                onTap: () {
                                  if (e.informationTypeName == "Report") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MonthlyReportView()));
                                    // Get.to(MonthlyReportView());
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ShowInfoOnMap(infoTypeId: e.id)));
                                    // Get.to(ShowInfoOnMap(infoTypeId: e.id));
                                  }
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Material(
                                            shape: CircleBorder(),
                                            elevation: 1.0,
                                            child: Image.asset(
                                              e.informationTypeName == "Report"
                                                  ? "assets/images/statistics.png"
                                                  : e.informationTypeName ==
                                                          "Petrol Pump"
                                                      ? "assets/images/petrol-pump.png"
                                                      : "assets/images/mechanic.png",
                                              fit: BoxFit.fitWidth,
                                              height: 80,
                                              width: 80,
                                              // color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 6.0),
                                          Text(
                                            e.informationTypeName.toString(),
                                            style: TextStyle(fontSize: 10),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                            // Container(
                            //   padding: EdgeInsets.all(0),
                            //   child: Card(
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: Center(
                            //         child: Column(
                            //           mainAxisSize: MainAxisSize.min,
                            //           children: [
                            //             Material(
                            //               shape: CircleBorder(),
                            //               elevation: 1.0,
                            //               child: Image.asset(
                            //                 "assets/images/mechanic.png",
                            //                 fit: BoxFit.fitWidth,
                            //                 height: 50,
                            //                 width: 50,
                            //               ),
                            //             ),
                            //             SizedBox(height: 6.0),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Container(
                            //   padding: EdgeInsets.all(0),
                            //   child: Card(
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: Center(
                            //         child: Column(
                            //           mainAxisSize: MainAxisSize.min,
                            //           children: [
                            //             Material(
                            //               shape: CircleBorder(),
                            //               elevation: 1.0,
                            //               child: Image.asset(
                            //                 "assets/images/statistics.png",
                            //                 fit: BoxFit.fitWidth,
                            //                 height: 50,
                            //                 width: 50,
                            //               ),
                            //             ),
                            //             SizedBox(height: 6.0),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          })
                        ],
                      )
                    ],
                  );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
