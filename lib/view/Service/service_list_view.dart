import 'package:amargari/model/service/service_model.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/Service/component/ServiceImageItem.dart';
import 'package:flutter/material.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/view/Service/add_service.dart';
import 'package:amargari/view/Service/component/service_list_item.dart';
import 'package:intl/intl.dart';

class ServiceListView extends StatefulWidget {
  final String title;

  // In the constructor, require a Todo.
  ServiceListView({required this.title});

  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceListView> {
  Future<List<ServiceDataModel>>? vehicleList;
  var isVisible = false;

  @override
  void initState() {
    super.initState();
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) =>
        {vehicleList = ServiceProvider().getServicingList("", "${value.id}")});
    new Future.delayed(new Duration(seconds: 3), () {
      setState(() {
        isVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var addServiceInfo = (ServiceDataModel serviceDataModel) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddServiceView(
                    serviceDataModel: serviceDataModel,
                    vehicleId: "",
                  )));
    };
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<ServiceDataModel>>(
        future: vehicleList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data?[0].serviceList!.servicingId == 0
                ? Center(child: Text('Empty'))
                : ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      ServiceDataModel serviceDataModel = snapshot.data![index];

                      return Card(
                        child: new InkResponse(
                          onTap: () {
                            print(index);
                            addServiceInfo(serviceDataModel);
                          },
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 10),
                              ServiceItem(
                                  textTitle: 'Entry Date:',
                                  text:
                                      serviceDataModel.serviceList?.date != null
                                          ? DateFormat('yyyy-MM-dd')
                                              .parse(serviceDataModel
                                                      .serviceList?.date
                                                      .toString() ??
                                                  "")
                                              .toString()
                                              .split(" ")[0]
                                          : ""),

                              ServiceItem(
                                  textTitle: 'Driver Name:',
                                  text: serviceDataModel
                                          .serviceList?.driverName ??
                                      ""),
                              ServiceItem(
                                  textTitle: 'Garage Name:',
                                  text:
                                      serviceDataModel.serviceList?.gargeName ??
                                          ""),
                              ServiceItem(
                                  textTitle: 'Garage Location:',
                                  text: serviceDataModel
                                          .serviceList?.gargeNameLocation ??
                                      ""),
                              ServiceItem(
                                  textTitle: 'Vehicle Number:',
                                  text: serviceDataModel
                                          .serviceList?.vechileNumber ??
                                      ""),
                              SizedBox(
                                height: 10,
                              ),
                              ServiceImageItem(
                                textTitle: 'Parts Image:',
                                image: serviceDataModel.serviceList?.partsImg ??
                                    "",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ServiceImageItem(
                                textTitle: 'Expense Slip:',
                                image:
                                    serviceDataModel.serviceList?.expenseSlip ??
                                        "",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Container(
                              //     alignment: Alignment.topLeft,
                              //     child: SizedBox(child: Padding(
                              //       padding: const EdgeInsets.fromLTRB(20.0,0,0,0),
                              //       child: Text("Service Head", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              //     ))),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount:
                                      serviceDataModel.serviceCost?.length,
                                  // ServiceCost serviceDataModel = serviceDataModel.serviceCost![index];

                                  itemBuilder: (context, index) {
                                    return ServiceItem(
                                        textTitle: serviceDataModel
                                                .serviceCost![index]
                                                .serviceName ??
                                            "",
                                        text: serviceDataModel
                                            .serviceCost![index].cost
                                            .toString() + " tk");
                                  }),

                              ServiceItem(
                                  textTitle: 'Total Amount:',
                                  text: serviceDataModel
                                      .serviceList!.totalAmount
                                      .toString() + " tk"),
                              SizedBox(height: 10),
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
      /*  floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: () {
            addServiceInfo(new ServiceDataModel());
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
