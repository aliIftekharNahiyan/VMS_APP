import 'package:amargari/uril/utility.dart';
import 'package:amargari/widgets/ImageFullScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:amargari/model/fuel_list_model.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/fuel_provider.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/Service/component/service_list_item.dart';
import 'package:amargari/view/fuel_management/add_update_fuel_management.dart';

class FuelManagementView extends StatefulWidget {
  final String title;
  final String vehicleId;

  // In the constructor, require a Todo.
  FuelManagementView({ required this.title, required this.vehicleId});

  @override
  _FuelManagementViewState createState() => _FuelManagementViewState();
}

class _FuelManagementViewState extends State<FuelManagementView> {
  Future<List<FuelListModel>>? fuelList;
  var isVisible = true;

  @override
  void initState() {
    super.initState();
    print("calling fuel 2");
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    /*   getUserData()
        .then((value) => {policeCaseList = fetchPoliceCaseList(value.id.toString())});*/
    getUserData().then((value) => {fuelList = getFuelList(value.id.toString())});
    new Future.delayed(new Duration(seconds: 3), () {
      setState(() {
        isVisible = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var addFuelInfo = (FuelListModel insurancePolicyModel) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AddUpdateFuelManagement(vcDataModel: insurancePolicyModel, vehicleId: '',)));
    };

    print("calling fuel ");

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<FuelListModel>>(
        future: fuelList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data!.isEmpty
                ? Center(child: Text('Empty'))
                : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      FuelListModel fuelList = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0,2,0,0),
                        child: Card(
                          child: new InkResponse(
                              onTap: () {
                                print(index);
                                addFuelInfo(fuelList);
                              },
                              child: Row(
                                children:[ Expanded(
                                    flex: 2,
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ImageFullScreen(imageURL: fuelList.slipImg.toString())));
                                      },
                                      child: fuelList.slipImg == "" ? Image.asset(
                                                  "assets/icons/edit_image.png",
                                                  height: 100,
                                                  width: 100,
                                                  fit: BoxFit.contain,
                                                  color: Colors.black,
                                                  ): CachedNetworkImage(
                                        imageUrl: fuelList.slipImg.toString(),
                                        placeholder: (context, url) =>  Center(
                                          child: SizedBox(
                                            width: 30.0,
                                            height: 30.0,
                                            child: new CircularProgressIndicator(),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>  ImageIcon(AssetImage("assets/icons/edit_image.png")),
                                        width: 90,
                                        height: 90,
                                      ),
                                    )
                                ),
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 5),
                                      ServiceItem(
                                          textTitle: 'Driver Name',
                                          text: fuelList.driverName.toString()),
                                      ServiceItem(
                                          textTitle: 'Vehicle Name',
                                          text: fuelList.brandName.toString()),

                                      ServiceItem(
                                          textTitle: 'Station Name',
                                          text: fuelList.stationName.toString()),

                                      ServiceItem(
                                          textTitle: 'Fuel Amount',
                                          text: fuelList.fuleTaken.toString()),

                                      ServiceItem(
                                          textTitle: 'Fuel Date',
                                          text: convertDate(fuelList.timeStamp.toString())),

                                      ServiceItem(
                                          textTitle: 'Amount',
                                          text: "${fuelList.amount.toString()} Taka" ),
                                      SizedBox(height: 5),
                                    ],
                                ),
                                  ),]
                              )),
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
     /* floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: () {
            addFuelInfo(new FuelListModel());
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
