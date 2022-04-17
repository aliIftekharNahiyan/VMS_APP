import 'package:amargari/model/accident_list_model.dart';
import 'package:amargari/uril/utility.dart';
import 'package:amargari/view/accident_management/accident_management.dart';
import 'package:amargari/view/common_view/all_drop_down_Item.dart';
import 'package:amargari/view/common_view/edit_List_Item.dart';
import 'package:amargari/view/common_view/image_upload_view_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:amargari/get_state/selected_dropdown.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/accident_provider.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/widgets/TextEditingControllerWithEndCursor.dart';
import 'package:amargari/widgets/widgets.dart';

class AddUpdateAccidentView extends StatefulWidget {
  AddUpdateAccidentView({required this.vcDataModel, required this.vehicleId});
  final AccidentListModel vcDataModel;
  final String vehicleId;
  @override
  _AddUpdateAccidentViewState createState() => _AddUpdateAccidentViewState();
}

class _AddUpdateAccidentViewState extends State<AddUpdateAccidentView> {
  var accidentLocation = new TextEditingControllerWithEndCursor(text: '');
  var others = new TextEditingControllerWithEndCursor(text: '');
  var fine = new TextEditingControllerWithEndCursor(text: '');
  var accidentTime = new TextEditingControllerWithEndCursor(text: '');
  var accidentDetails = new TextEditingControllerWithEndCursor(text: '');
  var accidentImage = new TextEditingControllerWithEndCursor(text: '');
  var vehical = new TextEditingControllerWithEndCursor(text: '');
  var vehicalObj = new TextEditingControllerWithEndCursor(text: '');

  late Future<dynamic> accidentAddUpdate;

  bool insuranceCover = true;
  SelectedDropDown _selectedDropItem = Get.find();
  @override
  void initState() {
    print(widget.vehicleId);

    _selectedDropItem.vehicleId = "";
    _selectedDropItem.driverId = "";

    if (widget.vcDataModel.id != null) {
      accidentLocation = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.accidentLocation.toString());
      others = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.others.toString());
      fine = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.fine.toString());
      accidentTime = new TextEditingControllerWithEndCursor(
          text: "${convertDate2(widget.vcDataModel.accidentTime.toString())}");
      accidentDetails = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.accidentDetails.toString());
      accidentImage = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.accidentImg.toString());

      vehical = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.accidentImg.toString());

      // vehicalObj = new TextEditingControllerWithEndCursor(
      //     text: widget.vcDataModel.accidentImg.toString());

      AppConstant.accidentImageURL = widget.vcDataModel.accidentImg.toString();
      _selectedDropItem.vehicleId = widget.vcDataModel.vechileId.toString();
      _selectedDropItem.driverId = widget.vcDataModel.driveId.toString();
    } else {
      AppConstant.accidentImageURL = "";
    }
    super.initState();
  }

  void _loadData(BuildContext context) async {
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) => {
          Provider.of<ServiceProvider>(context, listen: false)
              .fetchVehicleDetails(value.id.toString(), ""),
          Provider.of<ServiceProvider>(context, listen: false)
              .fetchGarageList(value.id.toString()),
          Provider.of<ServiceProvider>(context, listen: false)
              .fetchDriverList(value.id.toString())
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
      //isEditAble = true;
      if (_selectedDropItem.driverId != "" &&
          _selectedDropItem.vehicleId != "" &&
          fine.text != "" &&
          accidentTime.text != "") {
        Future<UserInfoModel> getUserData() => UserPreferences().getUser();
        getUserData().then((value) => {
              if (widget.vcDataModel.id == null)
                {
                  accidentAddUpdate = addUpdateAccident(
                      widget.vcDataModel.id.toString(),
                      _selectedDropItem.driverId,
                      _selectedDropItem.vehicleId,
                      widget.vcDataModel.tripId.toString(),
                      AppConstant.accidentImageURL,
                      accidentLocation.text,
                      others.text,
                      insuranceCover ? "1" : "-1",
                      fine.text,
                      accidentTime.text,
                      accidentDetails.text)
                }
              else
                {
                  accidentAddUpdate = addUpdateAccident(
                      widget.vcDataModel.id.toString(),
                      _selectedDropItem.driverId,
                      _selectedDropItem.vehicleId,
                      widget.vcDataModel.tripId.toString(),
                      AppConstant.accidentImageURL,
                      accidentLocation.text,
                      others.text,
                      insuranceCover ? "1" : "-1",
                      fine.text,
                      accidentTime.text,
                      accidentDetails.text),
                },
              accidentAddUpdate.whenComplete(() => {
                    //snackBar(context, "Successfully save you police case"),
                    Navigator.pop(context),
                    Navigator.pop(context),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccidentManagementView(
                                title: "Accident Management")))
                  })
            });
      } else {
        snackBar(context, "Please add all required field");
      }
    };
    return Scaffold(
      appBar: AppBar(
        title: Text("Accident Details"),
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
            return Column(
              children: [
                SizedBox(height: 20),
                EditListItem(
                  text: 'Accident Date',
                  nameController: accidentTime,
                  isDate: true,
                  isRequired: true,
                  hintText: 'Type accident date',
                ),
                SizedBox(height: 5),
                EditListItem(
                  text: 'Accident Details',
                  nameController: accidentDetails,
                  hintText: 'Type accident details',
                ),
                SizedBox(height: 5),
                EditListItem(
                  text: 'Accident Location',
                  nameController: accidentLocation,
                  hintText: 'Type your accident location',
                ),
                SizedBox(height: 10),
                ImageUploadViewItem(
                    text: 'Accident Image',
                    nameController: accidentImage,
                    isVisible: true,
                    images: AppConstant.accidentImage),
                SizedBox(height: 10),
                EditListItem(
                  text: 'fine',
                  nameController: fine,
                  isNumber: true,
                  isRequired: true,
                  hintText: 'Type your given fine',
                ),
                SizedBox(height: 10),
                EditListItem(
                    text: 'Others',
                    nameController: others,
                    hintText: 'Type if you have any other comments'),
                SizedBox(height: 10),
                AllDropDownItem(
                        textTitle: "Vehicle",
                        list: _selectedDropItem.vehicleId == "" ? services.vehicleShortList : services.vehicleShortList.where((e)=> e.id == _selectedDropItem.vehicleId).toList(),
                        requestType: "vehicleList",
                        isRequired: true,
                        selectedItem: _selectedDropItem.vehicleId),
                SizedBox(height: 10),
                AllDropDownItem(
                  textTitle: "Driver",
                  list: services.driverCommonList,
                  requestType: "driverCommonList",
                  isRequired: true,
                  selectedItem: _selectedDropItem.driverId,
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: longButtons("SAVE", doUpdate),
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
