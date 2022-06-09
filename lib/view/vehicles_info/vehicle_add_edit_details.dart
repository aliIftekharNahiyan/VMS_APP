import 'package:amargari/get_state/selected_dropdown.dart';
import 'package:amargari/model/common_dropdown_model.dart';
import 'package:amargari/model/vehicleinfo/vehicle_info_model.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/view/common_view/all_drop_down_Item.dart';
import 'package:amargari/view/common_view/edit_List_Item.dart';
import 'package:amargari/view/common_view/image_upload_view_item.dart';
import 'package:amargari/view/vehicles_info/vehicle_brand_model_add.dart';
import 'package:amargari/view/vehicles_info/vehicles_list_view.dart';
import 'package:amargari/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/vehicle_details_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/widgets/TextEditingControllerWithEndCursor.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class VehicleAddEditView extends StatefulWidget {
  VehicleAddEditView({required this.vcDataModel});
  final VehicleInfoDataModel vcDataModel;
  @override
  _VehicleAddEditViewState createState() => _VehicleAddEditViewState();
}

class _VehicleAddEditViewState extends State<VehicleAddEditView> {
  var vehicleTypeId = new TextEditingControllerWithEndCursor(text: "");
  var ownerId = new TextEditingControllerWithEndCursor(text: "");
  var vehicleNumber = new TextEditingControllerWithEndCursor(text: "");
  var engineNumber = new TextEditingControllerWithEndCursor(text: "");
  var chasisNumber = new TextEditingControllerWithEndCursor(text: '');
  var modelName = new TextEditingControllerWithEndCursor(text: '');
  var brandName = new TextEditingControllerWithEndCursor(text: '');
  var vehicleTierSize = new TextEditingControllerWithEndCursor(text: '');
  var registrationDate = new TextEditingControllerWithEndCursor(text: '');
  var registrationExpireDate = new TextEditingControllerWithEndCursor(text: '');
  var vehicleRentId = new TextEditingControllerWithEndCursor(text: '');
  var cC = new TextEditingControllerWithEndCursor(text: '');
  var tierNumber = new TextEditingControllerWithEndCursor(text: '');
  var millage = new TextEditingControllerWithEndCursor(text: '');
  var vehicleEnergySourceId = new TextEditingControllerWithEndCursor(text: '');
  var status = new TextEditingControllerWithEndCursor(text: '');
  var modelYear = new TextEditingControllerWithEndCursor(text: '');
  Future<dynamic>? vehicleList;

  List<CommonDropDownModel> vehicleStatus = [];
  SelectedDropDown _selectedDropItem = Get.find();
  var isVisible = false;

  @override
  void initState() {
    print("init  ${_selectedDropItem.vehicleBrandId}");
    _selectedDropItem.vehicleTypeId = "";

    _selectedDropItem.vehicleTypeId = "";
    _selectedDropItem.vehicleBrandId = "";
    _selectedDropItem.vehicleModelId = "";
    _selectedDropItem.vehicleColourId = "";

    vehicleStatus
        .add(new CommonDropDownModel(id: "1", name: "Active", title: ""));
    vehicleStatus
        .add(new CommonDropDownModel(id: "-1", name: "InActive", title: ""));
    if (widget.vcDataModel.id != null) {
      vehicleTypeId = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.vechileTypeId.toString());
      vehicleNumber = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.vechileNumber.toString());
      AppConstant.vehicleImageURL = widget.vcDataModel.vechileImage.toString();
      engineNumber = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.engineNumber.toString());
      chasisNumber = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.chasisNumber.toString());
      modelName = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.modelName.toString());
      brandName = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.brandName.toString());
      vehicleTierSize = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.vechileTierSize.toString());
      registrationDate = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.registrationDate.toString());
      registrationExpireDate = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.registrationExpireDate.toString());
      vehicleRentId = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.vechileRentId.toString());
      cC = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.cc.toString());
      tierNumber = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.tierNumber.toString());
      millage = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.milage.toString());
      vehicleEnergySourceId = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.vechileEnergySourceId.toString());
      status = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.status.toString());

      modelYear = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.modelYear.toString());

      _selectedDropItem.vehicleTypeId =
          widget.vcDataModel.vechileTypeId.toString();
      _selectedDropItem.vehicleBrandId = widget.vcDataModel.brandId.toString();
      _selectedDropItem.vehicleModelId = widget.vcDataModel.modelId.toString();
      _selectedDropItem.vehicleColourId = widget.vcDataModel.colorId.toString();

      _selectedDropItem.vehicleBrandFullName =
          widget.vcDataModel.brandName.toString();
      _selectedDropItem.vehicleModelFullName =
          widget.vcDataModel.modelName.toString();
      _selectedDropItem.vehicleColourFullName =
          widget.vcDataModel.colorName.toString();

      print(
          "vehicleColourName 3 ${_selectedDropItem.vehicleColourId}  ${widget.vcDataModel.colorId.toString()}");
    } else {
      AppConstant.vehicleImageURL = "";
    }
    super.initState();
  }

  void _loadData(BuildContext context) async {
    print(
        "_selectedDropItem    ${_selectedDropItem.vehicleTypeId}   ${_selectedDropItem.vehicleBrandId}    ${_selectedDropItem.vehicleModelId}   ${_selectedDropItem.vehicleColourId}");

    Provider.of<ServiceProvider>(context, listen: false).getVehicleType();
    Provider.of<ServiceProvider>(context, listen: false).getVehicleGeneralInfo(
        "1", "", _selectedDropItem.vehicleTypeId, "${AppConstant.userId}");
    Provider.of<ServiceProvider>(context, listen: false).getVehicleGeneralInfo(
        "2", _selectedDropItem.vehicleBrandId, "", "${AppConstant.userId}");
    print(_selectedDropItem.vehicleTypeId);
    print(_selectedDropItem.vehicleBrandId);
    print(_selectedDropItem.vehicleModelId);
    Provider.of<ServiceProvider>(context, listen: false)
        .getVehicleGeneralInfo("3", "", "", "${AppConstant.userId}");
  }

  @override
  Widget build(BuildContext context) {
    _loadData(context);

    var doUpdate = () {
      if (isRedundantClick(DateTime.now())) {
        print('hold on, processing');
        return;
      }
      print(
          'run process   ${_selectedDropItem.vehicleTypeId}  ${_selectedDropItem.vehicleBrandId}   ${_selectedDropItem.vehicleModelId}');

      if (_selectedDropItem.vehicleTypeId != "" &&
          _selectedDropItem.vehicleTypeId != "-1" &&
          _selectedDropItem.vehicleBrandId != "" &&
          _selectedDropItem.vehicleBrandId != "-1" &&
          _selectedDropItem.vehicleModelId != "" &&
          _selectedDropItem.vehicleModelId != "-1") {
        Future<UserInfoModel> getUserData() => UserPreferences().getUser();
        getUserData().then((value) => {
              if (widget.vcDataModel.id == null)
                {
                  print("userId " + value.id.toString()),
                  vehicleList = VehicleInfoProvider().vehicleDetailsUpdate(
                      "",
                      _selectedDropItem.vehicleTypeId,
                      value.id.toString(),
                      AppConstant.vehicleImageURL,
                      vehicleNumber.text,
                      engineNumber.text,
                      chasisNumber.text,
                      _selectedDropItem.vehicleModelFullName,
                      _selectedDropItem.vehicleBrandFullName,
                      vehicleTierSize.text,
                      registrationDate.text,
                      registrationExpireDate.text,
                      vehicleRentId.text,
                      cC.text,
                      tierNumber.text,
                      millage.text,
                      vehicleEnergySourceId.text,
                      _selectedDropItem.vehicleStatusId,
                      _selectedDropItem.vehicleColourFullName,
                      modelYear.text),
                  // vehicleList?.then((value) => {
                  //   snackBar(context, "Successfully save you vehicle details")
                  // })

                  vehicleList?.whenComplete(() => {
                        snackBar(
                            context, "Successfully save you vehicle details"),
                        Navigator.pop(context),
                        Navigator.pop(context),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    VehicleInfo(title: "Vehicle Info")))
                      })
                }
              else
                {
                  vehicleList = VehicleInfoProvider().vehicleDetailsUpdate(
                      widget.vcDataModel.id.toString(),
                      _selectedDropItem.vehicleTypeId,
                      value.id.toString(),
                      AppConstant.vehicleImageURL,
                      vehicleNumber.text,
                      engineNumber.text,
                      chasisNumber.text,
                      _selectedDropItem.vehicleModelFullName,
                      _selectedDropItem.vehicleBrandFullName,
                      vehicleTierSize.text,
                      registrationDate.text,
                      registrationExpireDate.text,
                      vehicleRentId.text,
                      cC.text,
                      tierNumber.text,
                      millage.text,
                      vehicleEnergySourceId.text,
                      _selectedDropItem.vehicleStatusId,
                      _selectedDropItem.vehicleColourFullName,
                      modelYear.text),
                  vehicleList?.whenComplete(() => {
                        Navigator.pop(context),
                        Navigator.pop(context),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    VehicleInfo(title: "Vehicle Info")))
                      })
                }
            });
      } else {
        snackBar(context, "Please select mandatory filed ");
      }
    };
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Vehicle Details"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Consumer<ServiceProvider>(
          builder: (context, services, child) {
            print("_selectedDropItem  11111 ");
            if (_selectedDropItem.vehicleTypeId == "") {
              if (services.vehicleTypeComList.isNotEmpty) {
                _selectedDropItem.vehicleTypeId =
                    services.vehicleTypeComList[0].id.toString();
                _selectedDropItem.vehicleStatusId = '1';
                print(
                    "vechileId 2  ${services.vehicleTypeComList[0].id.toString()}");
              }
            } else {
              if (services.vehicleTypeComList.isNotEmpty) {
                bool exists = services.vehicleTypeComList
                    .any((file) => file.id == _selectedDropItem.vehicleTypeId);
                if (!exists) {
                  _selectedDropItem.vehicleTypeId =
                      services.vehicleTypeComList[0].id.toString();
                  print(
                      "vechileId 2  ${services.vehicleTypeComList[0].id.toString()}");
                }
              }
            }

            if (_selectedDropItem.vehicleBrandId == "") {
              if (services.vehicleBrandNameList.isNotEmpty) {
                _selectedDropItem.vehicleBrandId =
                    services.vehicleBrandNameList[0].id.toString();

                print("vehicleBrandName 2 ${_selectedDropItem.vehicleBrandId}");
              }
              print(
                  "vehicleBrandName 3 ${_selectedDropItem.vehicleBrandId}  ${services.vehicleBrandNameList.toString()}");

              for (var i = 0; i < services.vehicleBrandNameList.length; i++) {
                print("vehicleBrandName 4  " +
                    services.vehicleBrandNameList[i].id.toString());
              }
            } else if (_selectedDropItem.vehicleBrandId == "-1") {
              if (widget.vcDataModel.id != null) {
                _selectedDropItem.vehicleBrandId =
                    widget.vcDataModel.brandId.toString();
                bool exists = services.vehicleBrandNameList
                    .any((file) => file.id == _selectedDropItem.vehicleBrandId);
                print(
                    "vehicleBrandName  5 " + _selectedDropItem.vehicleBrandId);
                if (!exists) {
                  _selectedDropItem.vehicleBrandId =
                      services.vehicleBrandNameList[0].id.toString();
                }
              }
            } else {
              if (services.vehicleBrandNameList.isNotEmpty) {
                bool exists = services.vehicleBrandNameList
                    .any((file) => file.id == _selectedDropItem.vehicleBrandId);
                print(
                    "vehicleBrandName  5 " + _selectedDropItem.vehicleBrandId);
                if (!exists) {
                  _selectedDropItem.vehicleBrandId =
                      services.vehicleBrandNameList[0].id.toString();
                }
                print(
                    "vehicleBrandName  6 " + _selectedDropItem.vehicleBrandId);
              }
            }

            if (_selectedDropItem.vehicleModelId == "") {
              if (services.vehicleModelNameList.isNotEmpty) {
                _selectedDropItem.vehicleModelId =
                    services.vehicleModelNameList[0].id.toString();
              }
            } else if (_selectedDropItem.vehicleModelId == "-1") {
              if (widget.vcDataModel.id != null) {
                _selectedDropItem.vehicleModelId =
                    widget.vcDataModel.modelId.toString();
                if (services.vehicleModelNameList.isNotEmpty) {
                  bool exists = services.vehicleModelNameList.any(
                      (file) => file.id == _selectedDropItem.vehicleModelId);
                  if (!exists) {
                    _selectedDropItem.vehicleModelId =
                        services.vehicleModelNameList[0].id.toString();
                  }
                }
              }
            } else {
              if (services.vehicleModelNameList.isNotEmpty) {
                bool exists = services.vehicleModelNameList
                    .any((file) => file.id == _selectedDropItem.vehicleModelId);
                if (!exists) {
                  _selectedDropItem.vehicleModelId =
                      services.vehicleModelNameList[0].id.toString();
                }
              }
            }
            print(
                "vehicleModelName  ${_selectedDropItem.vehicleModelId}  ${services.vehicleModelNameList.length}");

            if (_selectedDropItem.vehicleColourId == "") {
              if (services.vehicleColourNameList.isNotEmpty) {
                _selectedDropItem.vehicleColourId =
                    services.vehicleColourNameList[0].id.toString();
                print(
                    "vehicleColourName  ${_selectedDropItem.vehicleColourId}  ${services.vehicleColourNameList.length}");
              }
            } else {
              if (services.vehicleColourNameList.isNotEmpty) {
                print(
                    "vehicleColourName 1 ${_selectedDropItem.vehicleColourId}  ${services.vehicleColourNameList.length}");
                bool exists = services.vehicleColourNameList.any(
                    (file) => file.id == _selectedDropItem.vehicleColourId);
                if (!exists) {
                  _selectedDropItem.vehicleColourId =
                      services.vehicleColourNameList[0].id.toString();
                  print(
                      "vehicleColourName 2 ${_selectedDropItem.vehicleColourId}  ${services.vehicleColourNameList.length}");
                }
              }
            }

            print(
                "_selectedDropItem after data load   ${_selectedDropItem.vehicleTypeId}   ${_selectedDropItem.vehicleBrandId}    ${_selectedDropItem.vehicleModelId}   ${_selectedDropItem.vehicleColourId}");

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                AllDropDownItem(
                  textTitle: "Vehicle Type",
                  list: services.vehicleTypeComList,
                  requestType: "vehicleType",
                  selectedItem: _selectedDropItem.vehicleTypeId,
                  isRequired: true,
                ),
                SizedBox(height: 15),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 10,
                        child: AllDropDownItem(
                          textTitle: "Brand Name",
                          list: services.vehicleBrandNameList,
                          requestType: "BrandName",
                          selectedItem: _selectedDropItem.vehicleBrandId,
                          isRequired: true,
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: MaterialButton(
                            height: 30.0,
                            minWidth: 30.0,
                            color: MyTheme.buttonColor,
                            textColor: Colors.white,
                            onPressed: () {
                              vehicleBrandModelAdd(context, "Add New Brand");
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 2.0, 0.0, 2.0),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                            shape: CircleBorder(),
                          ))
                    ]),
                SizedBox(height: 15),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 10,
                          child: AllDropDownItem(
                            textTitle: "Model Name",
                            list: services.vehicleModelNameList,
                            requestType: "ModelName",
                            selectedItem: _selectedDropItem.vehicleModelId,
                            isRequired: true,
                          )),
                      Expanded(
                          flex: 2,
                          child: MaterialButton(
                            height: 30.0,
                            minWidth: 30.0,
                            color: MyTheme.buttonColor,
                            textColor: Colors.white,
                            onPressed: () {
                              vehicleBrandModelAdd(context, "Add New Model");
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 2.0, 0.0, 2.0),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                            shape: CircleBorder(),
                          ))
                    ]),
                SizedBox(height: 10),
                EditListItem(
                  text: 'Manufacturing Year',
                  nameController: modelYear,
                  isYear: true,
                  hintText: "Click to select year",
                ),
                SizedBox(height: 10),
                AllDropDownItem(
                  textTitle: "Vehicle Colour",
                  list: services.vehicleColourNameList,
                  requestType: "VehicleColour",
                  selectedItem: _selectedDropItem.vehicleColourId,
                ),
                SizedBox(height: 10),
                EditListItem(
                  text: 'Number Plate',
                  nameController: vehicleNumber,
                  hintText: "Type number plate",
                ),
                SizedBox(height: 10),
                EditListItem(
                  text: 'CC',
                  nameController: cC,
                  hintText: "Type CC",
                ),
                SizedBox(height: 10),
                EditListItem(
                  text: 'Tier Number',
                  nameController: tierNumber,
                  hintText: "Type Tier Number",
                ),
                SizedBox(height: 10),
                EditListItem(
                    text: 'Chassis Number',
                    nameController: chasisNumber,
                    hintText: "Type chassis number"),
                SizedBox(height: 10),
                EditListItem(
                    text: 'Engine Number',
                    nameController: engineNumber,
                    hintText: "Type engine number"),
                SizedBox(height: 10),
                ImageUploadViewItem(
                    text: 'Vehicle Image',
                    nameController: vehicleNumber,
                    isVisible: true,
                    images: "VehicleImage"),
                SizedBox(height: 10),
                AllDropDownItem(
                    textTitle: "Status",
                    list: vehicleStatus,
                    requestType: "vehicleStatus",
                    selectedItem: _selectedDropItem.vehicleStatusId),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: longButtons(
                      (widget.vcDataModel.id == null) ? "SAVE" : "UPDATE",
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
