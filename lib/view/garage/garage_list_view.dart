import 'package:amargari/model/garage/GarageModel.dart';
import 'package:amargari/model/service/service_model.dart';
import 'package:amargari/view/Service/service_list_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/model/vehicleinfo/vehicle_info_model.dart';
import 'package:amargari/providers/garage_provider.dart';
import 'package:amargari/providers/vehicle_details_provider.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/Service/component/service_list_item.dart';
import 'package:amargari/view/garage/add_update_garage_details_view.dart';
import 'package:amargari/view/vehicles_info/vehicle_add_edit_details.dart';
import 'package:amargari/widgets/widgets.dart';

class GarageInfoView extends StatefulWidget {
  final String title;

  // In the constructor, require a Todo.
  GarageInfoView({ required this.title});

  @override
  _GarageInfoState createState() => _GarageInfoState();
}

class _GarageInfoState extends State<GarageInfoView> {
  Future<List<GarageModel>>? vehicleList;
  var isVisible = true;
   Future<dynamic>? garageList;
  @override
  void initState() {
    super.initState();
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) =>
    {vehicleList = GarageProvider().fetchGarageList(value.id.toString())});
    new Future.delayed(new Duration(seconds: 3), () {
      setState(() {
        isVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var addGarageInfo = (GarageModel garageModel) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  GarageDetailsView(vcDataModel: garageModel,requestType: "GarageAdd",serviceDataModel: ServiceDataModel(),vehicleId: "",)));
    };

    var removeItem = (GarageModel garageModel) {
      garageList = GarageProvider().garageDetailsUpdate(
          garageModel.id.toString(),
          garageModel.gargeName.toString(),
          garageModel.gargeNameLocation.toString(),
          "-1",
          garageModel.userID.toString(),
          "",
        garageModel.ownerName.toString(),
        garageModel.contactPerson1Name.toString(),
        garageModel.contactPerson1Mobile.toString(),
        garageModel.contactPerson2Name.toString(),
        garageModel.contactPerson2Mobile.toString(),);
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children:<Widget>[Expanded(
          flex: 1,
          child: InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ServiceListView(title: "Vehicle Servicing")));
            },
            child: Card(
                color: Colors.blueGrey,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [ // for (var string in snapshot.data!.data!.monthlyReport.analytics[0].data.fuel)
                    Text(
                      "Vehicle Servicing Details",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                )),
          ),
        ),
          Expanded(
              flex: 9,
              child: FutureBuilder<List<GarageModel>>(
                  future: vehicleList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return snapshot.data!.isEmpty
                          ? Center(child: Text('Empty'))
                          : ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          GarageModel garageModel = snapshot.data![index];
                          return Card(
                            child: new InkResponse(
                              onTap: () {
                                print(index);
                                addGarageInfo(garageModel);
                              },
                              child: Row(
                                children:[ Expanded(
                                  flex: 10,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 5),
                                      ServiceItem(
                                          textTitle: 'Garage Name: ',
                                          text: garageModel.gargeName ?? ""),
                                      ServiceItem(
                                          textTitle: 'Garage Location: ',
                                          text: garageModel.gargeNameLocation  ?? ""),
                                      SizedBox(height: 5),
                                    ],
                                  ),
                                ),
                                  Expanded(
                                    flex: 2,
                                    child:  TextButton(
                                      child: Text('Delete'),
                                      onPressed: () {
                                        removeItem(garageModel);
                                        snapshot.data!.removeWhere((item) => item.id == garageModel.id);
                                        setState(() {
                                        });
                                      },
                                    ),)
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
                  }))] ,

      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: () {
            addGarageInfo(new GarageModel());
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
