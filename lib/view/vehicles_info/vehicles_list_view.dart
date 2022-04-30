import 'package:amargari/model/vehicleinfo/vehicle_info_model.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/utility.dart';
import 'package:amargari/view/vehicles_info/vehicle_details.dart';
import 'package:amargari/view/vehicles_info/vehicle_list_item.dart';
import 'package:amargari/widgets/themes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/vehicle_details_provider.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/vehicles_info/vehicle_add_edit_details.dart';
import 'package:flutter/services.dart';

class VehicleInfo extends StatefulWidget {
  final String title;

  // In the constructor, require a Todo.
  VehicleInfo({required this.title});

  @override
  _VehicleInfoState createState() => _VehicleInfoState();
}

class _VehicleInfoState extends State<VehicleInfo> {
  Future<List<VehicleInfoDataModel>>? vehicleList;
  Future<dynamic>? vehicleListUpdate;
  var isVisible = true;

  @override
  void initState() {
    super.initState();

    new Future.delayed(new Duration(seconds: 3), () {
      setState(() {
        isVisible = false;
      });
    });
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) => {
          vehicleList =
              VehicleInfoProvider().fetchVehicleDetails(value.id.toString())
        });
  }

  @override
  Widget build(BuildContext context) {
    var viewVehicleInfo = (VehicleInfoDataModel vehicleInfoDataModel) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VehicleDetailsScreen(vcDataModel: vehicleInfoDataModel)));
    };
    var addVehicleInfo = (VehicleInfoDataModel vehicleInfoDataModel) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VehicleAddEditView(vcDataModel: vehicleInfoDataModel)));
    };
    // var removeItem = (VehicleInfoDataModel vehicleInfoDataModel) {
    //   vehicleListUpdate = VehicleInfoProvider().vehicleDetailsUpdate(
    //       "",
    //       vehicleInfoDataModel.vechileTypeId,
    //       vehicleInfoDataModel.id.toString(),
    //       vehicleInfoDataModel.vechileImage,
    //       vehicleInfoDataModel.vechileNumber,
    //       vehicleInfoDataModel.engineNumber,
    //       vehicleInfoDataModel.chasisNumber,
    //       vehicleInfoDataModel.modelName,
    //       vehicleInfoDataModel.brandName,
    //       vehicleInfoDataModel.vechileTierSize,
    //       vehicleInfoDataModel.registrationDate,
    //       vehicleInfoDataModel.registrationExpireDate,
    //       vehicleInfoDataModel.vechileRentId,
    //       vehicleInfoDataModel.cc,
    //       vehicleInfoDataModel.milage,
    //       vehicleInfoDataModel.milage,
    //       _selectedDropItem.vehicleStatusId,
    //       _selectedDropItem.vehicleColourName
    //   ),
    // };
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<VehicleInfoDataModel>>(
        future: vehicleList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data!.isEmpty
                ? Center(child: Text('Empty'))
                : ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      VehicleInfoDataModel? vehicleInfoDataModel =
                          snapshot.data?[index];
                      return Card(
                        child: new InkResponse(
                          onTap: () {
                            print(index);
                            viewVehicleInfo(vehicleInfoDataModel!);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: vehicleInfoDataModel
                                                    ?.vechileImage ==
                                                ""
                                            ? Container(
                                                child: Image.asset(
                                                "assets/icons/edit_image.png",
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.contain,
                                                color: Colors.black,
                                              ))
                                            : CachedNetworkImage(
                                                fit: BoxFit.contain,
                                                imageUrl: vehicleInfoDataModel
                                                        ?.vechileImage ??
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
                                                width: 70,
                                                height: 120,
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                                VehicleListItem(
                                    textTitle: 'Brand: ',
                                    text:
                                        vehicleInfoDataModel?.brandName ?? ""),
                                VehicleListItem(
                                    textTitle: 'Model: ',
                                    text:
                                        vehicleInfoDataModel?.modelName ?? ""),
                                VehicleListItem(
                                    textTitle: 'Manuf. year:',
                                    text:
                                        vehicleInfoDataModel?.modelYear ?? ""),
                                VehicleListItem(
                                    textTitle: 'Reg. Date:',
                                    text:
                                        "${convertDate2(vehicleInfoDataModel?.registrationDate ?? "")}"),
                                VehicleListItem(
                                    textTitle: 'Registration number:',
                                    text: vehicleInfoDataModel?.vechileNumber ??
                                        ""),
                                VehicleListItem(
                                    textTitle: 'Fitness Expire date:',
                                    text:"${convertDate2(vehicleInfoDataModel?.fitnessExpireDate ?? "")}"),
                                VehicleListItem(
                                    textTitle: 'Tax Token Expire date:',
                                    text:"${convertDate2(vehicleInfoDataModel?.taxTokenExpireDate ?? "")}"),
                                
                                vehicleInfoDataModel?.routePermitExpireDate != null ?
                                VehicleListItem(
                                    textTitle: 'Road Permit Expire date:',
                                    text:
                                        "${convertDate2(vehicleInfoDataModel?.routePermitExpireDate ?? "")}"): Container(),
                                vehicleInfoDataModel?.insuranceExpireDate != null ?
                                VehicleListItem(
                                    textTitle: 'Insurance Expire date:',
                                    text:
                                        "${convertDate2(vehicleInfoDataModel?.insuranceExpireDate ?? "")}"): Container(),
                                VehicleListItem(
                                    textTitle: 'Cc:',
                                    text: vehicleInfoDataModel?.cc ?? ""),
                                VehicleListItem(
                                    textTitle: 'Chassis no:',
                                    text: vehicleInfoDataModel?.vechileNumber ??
                                        ""),
                                VehicleListItem(
                                    textTitle: 'Engine no:',
                                    text: vehicleInfoDataModel?.vechileNumber ??
                                        ""),
                                VehicleListItem(
                                    textTitle: 'Tire size:',
                                    text:
                                        vehicleInfoDataModel?.tierNumber ?? "")
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
          } else {
            return Center(
                child: SizedBox(
                    width: 25, height: 25, child: CircularProgressIndicator()));
          }
        },
      ),
      floatingActionButton: AppConstant.userTypeId != 2
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                onPressed: () {
                  addVehicleInfo(new VehicleInfoDataModel());
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
