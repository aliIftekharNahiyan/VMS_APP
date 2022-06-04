import 'package:amargari/uril/utility.dart';
import 'package:amargari/view/common_view/all_drop_down_Item.dart';
import 'package:amargari/view/common_view/edit_List_Item.dart';
import 'package:amargari/view/common_view/image_upload_view_item.dart';
import 'package:amargari/view/fuel_management/fuel_management.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:amargari/get_state/selected_dropdown.dart';
import 'package:amargari/model/fuel_list_model.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/fuel_provider.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/widgets/TextEditingControllerWithEndCursor.dart';
import 'package:amargari/widgets/widgets.dart';

class AddUpdateFuelManagement extends StatefulWidget {
  AddUpdateFuelManagement({required this.vcDataModel, required this.vehicleId});
  final FuelListModel vcDataModel;
  final String vehicleId;

  @override
  _AddUpdateFuelManagementState createState() =>
      _AddUpdateFuelManagementState();
}

class _AddUpdateFuelManagementState extends State<AddUpdateFuelManagement> {
  var stationName = new TextEditingControllerWithEndCursor(text: '');
  var amount = new TextEditingControllerWithEndCursor(text: '');
  var fuelSlipImage = new TextEditingControllerWithEndCursor(text: '');
  var haveFuelAlert = new TextEditingControllerWithEndCursor(text: '0');
  var fuelTime = new TextEditingControllerWithEndCursor(text: '');
  var fuelTaken = new TextEditingControllerWithEndCursor(text: '');

  Future<dynamic>? accidentAddUpdate;
  String driverId = "";
  String vehicleId = "";
  bool insuranceCover = true;
  bool _switchValue = false;
  SelectedDropDown _selectedDropItem = Get.find();
  @override
  void initState() {
    _selectedDropItem.vehicleId = "";
    _selectedDropItem.driverId = "";
    _selectedDropItem.vehicleEnergyTypeId = "";
    if (widget.vcDataModel.id != null) {
      stationName = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.stationName.toString());
      amount = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.amount.toString());

      fuelSlipImage = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.slipImg.toString());
      haveFuelAlert = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.haveFuelAlert.toString());
      if (widget.vcDataModel.haveFuelAlert.toString() == "1") {
        _switchValue = true;
      }

      fuelTime = new TextEditingControllerWithEndCursor(
          text: "${convertDate2(widget.vcDataModel.fuelTime.toString())}");
      fuelTaken = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.fuleTaken.toString());
      AppConstant.fuelSlipImgURL = widget.vcDataModel.slipImg.toString();
      _selectedDropItem.vehicleId = widget.vcDataModel.vechileId.toString();
      _selectedDropItem.driverId = widget.vcDataModel.driveId.toString();
      _selectedDropItem.vehicleEnergyTypeId =
          widget.vcDataModel.energyType.toString();

      print(widget.vcDataModel.driveId.toString());
    } else {
      AppConstant.fuelSlipImgURL = "";
      _selectedDropItem.vehicleId = widget.vehicleId;
    }
    super.initState();
  }

  void _loadData(BuildContext context) async {
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) => {
          Provider.of<ServiceProvider>(context, listen: false)
              .fetchVehicleDetails(value.id.toString(), ""),
          Provider.of<ServiceProvider>(context, listen: false)
              .fetchDriverList(value.id.toString()),
          Provider.of<ServiceProvider>(context, listen: false)
              .getVehicleEnergyType()
        });
  }

  @override
  Widget build(BuildContext context) {
    _loadData(context);

    var doUpdate = () {
      if (isRedundantClick(DateTime.now())) {
        print('hold on, processing');
        return;
      }
      print('run process');
      // if (amount.text == "") {
      //   snackBar(context, "Amount Required", success: false);
      //   return;
      // }

      // if (fuelTime.text == "") {
      //   snackBar(context, "Fuel Date Required", success: false);
      //   return;
      // }

      // if (_selectedDropItem.vehicleId == "") {
      //   snackBar(context, "Vehicle Required", success: false);
      //   return;
      // }

      // if (_selectedDropItem.driverId == "") {
      //   snackBar(context, "Driver Required", success: false);
      //   return;
      // }
      // if (fuelTaken.text == "") {
      //   snackBar(context, "Fuel Taken Required", success: false);
      //   return;
      // }

      if (amount.text != "" &&
          _selectedDropItem.vehicleId != "" &&
          _selectedDropItem.driverId != "" &&
          fuelTaken.text != "" &&
          fuelTime.text != "") {
        Future<UserInfoModel> getUserData() => UserPreferences().getUser();
        getUserData().then((value) {
          if (widget.vcDataModel.id == null) {
            accidentAddUpdate = addUpdateFuelList(
                "",
                _selectedDropItem.vehicleId,
                _selectedDropItem.driverId,
                _selectedDropItem.vehicleEnergyTypeId,
                stationName.text,
                amount.text,
                AppConstant.fuelSlipImgURL,
                haveFuelAlert.text,
                fuelTime.text,
                fuelTaken.text);
          } else {
            accidentAddUpdate = addUpdateFuelList(
                widget.vcDataModel.id.toString(),
                _selectedDropItem.vehicleId,
                _selectedDropItem.driverId,
                _selectedDropItem.vehicleEnergyTypeId,
                stationName.text,
                amount.text,
                AppConstant.fuelSlipImgURL,
                haveFuelAlert.text,
                fuelTime.text,
                fuelTaken.text);
          }
          accidentAddUpdate?.whenComplete(() => {
                Navigator.pop(context),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FuelManagementView(
                            title: "Fuel Analysis",
                            vehicleId: _selectedDropItem.vehicleId.toString())))
              });
        });
      } else {
        snackBar(context, "Required field should not empty");
      }
    };
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Fuel Details"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Consumer<ServiceProvider>(
          builder: (context, services, child) {
            if (_selectedDropItem.vehicleId == "") {
              if (services.vehicleShortList.isNotEmpty) {
                _selectedDropItem.vehicleId =
                    services.vehicleShortList[0].id.toString();
                print(
                    "vechileId 2  ${services.vehicleShortList[0].id.toString()}");
              }
            } else {
              if (services.vehicleShortList.isNotEmpty) {
                bool exists = services.vehicleShortList
                    .any((file) => file.id == _selectedDropItem.vehicleId);

                if (!exists) {
                  _selectedDropItem.vehicleId =
                      services.vehicleShortList[0].id.toString();
                }
              }
            }
            print("vechileId 3  ${_selectedDropItem.vehicleId}");

            if (_selectedDropItem.driverId == "") {
              if (services.driverCommonList.isNotEmpty) {
                _selectedDropItem.driverId =
                    services.driverCommonList[0].id.toString();
              }
            } else {
              if (services.driverCommonList.isNotEmpty) {
                bool exists = services.driverCommonList
                    .any((file) => file.id == _selectedDropItem.driverId);
                if (!exists) {
                  _selectedDropItem.driverId =
                      services.driverCommonList[0].id.toString();
                }
              }
            }
            if (_selectedDropItem.vehicleEnergyTypeId == "") {
              if (services.vehicleEnergyType.isNotEmpty) {
                _selectedDropItem.vehicleEnergyTypeId =
                    services.vehicleEnergyType[0].id.toString();
              }
            }
            return Column(
              children: [
                SizedBox(height: 20),
                EditListItem(
                  text: 'Station Name',
                  nameController: stationName,
                  hintText: "Type station name",
                ),
                SizedBox(height: 10),
                EditListItem(
                  text: 'Money Amount',
                  nameController: amount,
                  isNumber: true,
                  isRequired: true,
                  hintText: 'Type money amount',
                ),
                SizedBox(height: 10),
                EditListItem(
                  text: 'Fuel Volume',
                  nameController: fuelTaken,
                  isRequired: true,
                  hintText: "Type fuel volume",
                  isNumber: true,
                ),
                SizedBox(height: 10),
                ImageUploadViewItem(
                    text: 'Slip Image',
                    nameController: fuelSlipImage,
                    isVisible: true,
                    images: AppConstant.fuelSlipImg),

                // SizedBox(height: 10),
                // AccountItem(
                //     text: 'Have Fuel Alert:',
                //     nameController: haveFuelAlert
                // ),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                //   child: Row(children: [
                //     Expanded(
                //       child: Text("Have Fuel Alert",
                //           style: TextStyle(fontSize: 17)),
                //     ),
                //     SizedBox(width: 1),
                //     CupertinoSwitch(
                //       value: _switchValue,
                //       onChanged: (value) {
                //         setState(() {
                //           _switchValue = value;
                //           if (_switchValue) {
                //             haveFuelAlert.text = "1";
                //           } else {
                //             haveFuelAlert.text = "0";
                //           }
                //         });
                //       },
                //     ),
                //   ]),
                // ),

                SizedBox(height: 10),
                EditListItem(
                  text: 'Fuel Date',
                  nameController: fuelTime,
                  isDate: true,
                  hintText: 'Type fuel date',
                  isRequired: true,
                ),
                SizedBox(height: 10),
                AllDropDownItem(
                    textTitle: "Vehicle Energy Type",
                    list: services.vehicleEnergyType,
                    requestType: "getVehicleEnergyType",
                    selectedItem: _selectedDropItem.vehicleEnergyTypeId),

                SizedBox(height: 10),
                AllDropDownItem(
                    textTitle: "Vehicle",
                    list: _selectedDropItem.vehicleId == ""
                        ? services.vehicleShortList
                        : services.vehicleShortList
                            .where((e) => e.id == _selectedDropItem.vehicleId)
                            .toList(),
                    requestType: "vehicleList",
                    isRequired: true,
                    selectedItem: _selectedDropItem.vehicleId),
                SizedBox(height: 15),
                AllDropDownItem(
                    textTitle: "Driver",
                    list: services.driverCommonList,
                    requestType: "driverCommonList",
                    isRequired: true,
                    selectedItem: _selectedDropItem.driverId),
                SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: longButtons(
                      widget.vcDataModel.id != null ? "UPDATE" : "SAVE",
                      doUpdate),
                ),
              ],
            );
          },
        ),
      ),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
