import 'package:amargari/model/garage/GarageModel.dart';
import 'package:amargari/model/service/service_model.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/utility.dart';
import 'package:amargari/view/Service/component/AddServiceItemDialog.dart';
import 'package:amargari/view/Service/service_list_view.dart';
import 'package:amargari/view/common_view/all_drop_down_Item.dart';
import 'package:amargari/view/common_view/edit_List_Item.dart';
import 'package:amargari/view/common_view/image_upload_view_item.dart';
import 'package:amargari/view/garage/add_update_garage_details_view.dart';
import 'package:amargari/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:amargari/get_state/selected_dropdown.dart';
import 'package:amargari/model/RequestModel/request_service_model.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/widgets/TextEditingControllerWithEndCursor.dart';
import 'package:amargari/widgets/widgets.dart';

class AddServiceView extends StatefulWidget {
  AddServiceView(
      {required this.serviceDataModel,
      required this.vehicleId,
      this.initial = false});

  final ServiceDataModel serviceDataModel;
  final String vehicleId;
  final bool initial;

  @override
  _AddServiceViewState createState() => _AddServiceViewState();
}

class _AddServiceViewState extends State<AddServiceView> {
  var dateText = new TextEditingControllerWithEndCursor(text: '');
  var nextDateText = new TextEditingControllerWithEndCursor(text: '');

  var expenseSlip = new TextEditingControllerWithEndCursor(text: '');
  var partsImage = new TextEditingControllerWithEndCursor(text: '');

  List<Widget> _children = [];
  List<TextEditingControllerWithEndCursor> controllers = [];
  List<TextEditingControllerWithEndCursor> controllers2 = [];
  List<TextEditingControllerWithEndCursor> controllers3 =
      []; //the controllers list
  bool initialForm = true;

  SelectedDropDown _selectedDropItem = Get.find();

  @override
  void initState() {
    EasyLoading.show();
    initialForm = widget.initial;
    _selectedDropItem.vehicleId = "";
    _selectedDropItem.garageId = "";
    _selectedDropItem.driverId = "";

    _loadData(context);
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
              .fetchDriverList(value.id.toString()),
          Provider.of<ServiceProvider>(context, listen: false)
              .getServiceListDropDown(value.id.toString())
        });
  }

  void removeItem(int position) {
    AppConstant.requestList..removeAt(position);
    _children = List.from(_children)..removeAt(position);
    controllers.removeAt(position);
    controllers2.removeAt(position);
    controllers3.removeAt(position);
    // initialForm = false;
  }

  void editItem(int position) {
    AddServiceItemDialog(context, widget.serviceDataModel,
        "${AppConstant.userId}", position, initialForm);
  }

  void add(RequestServiceModel requestList) {
    TextEditingControllerWithEndCursor serviceName =
        TextEditingControllerWithEndCursor(text: '');
    TextEditingControllerWithEndCursor serviceDetails =
        TextEditingControllerWithEndCursor(text: '');
    TextEditingControllerWithEndCursor serviceCost =
        TextEditingControllerWithEndCursor(text: '');

    print("requestList  ${AppConstant.requestList.length}");
    serviceDetails.text = requestList.details ?? "";
    serviceCost.text = requestList.Amount.toString();
    serviceName.text = requestList.ServiceName.toString();

    controllers.add(serviceName);
    controllers2.add(serviceCost);
    controllers3.add(serviceDetails);

    _children = List.from(_children)
      ..add(Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: Align(
            alignment: Alignment.topRight,
            child: new Stack(children: <Widget>[
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text("Service Name: ${serviceName.text} ")),
                  Divider(
                    color: Colors.grey,
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child:
                          Text("Service Description: ${serviceDetails.text} ")),
                  Divider(
                    color: Colors.grey,
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text("Service Cost: ${serviceCost.text} tk.")),
                  SizedBox(
                    height: 10,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextFormField(
                  //     enabled: false,
                  //     controller: serviceName,
                  //     textInputAction: TextInputAction.next,
                  //     decoration: InputDecoration(hintText: "Service Name"),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextFormField(
                  //     controller: serviceDetails,
                  //     enabled: false,
                  //     textInputAction: TextInputAction.next,
                  //     decoration: InputDecoration(hintText: "Service Details"),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextFormField(
                  //     controller: serviceCost,
                  //     enabled: false,
                  //     textInputAction: TextInputAction.next,
                  //     keyboardType: TextInputType.number,
                  //     decoration: InputDecoration(hintText: "Service Cost"),
                  //   ),
                  // )
                ],
              ),
              new Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 25.0,
                      width: 25.0,
                      child: FittedBox(
                        child: IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            setState(() {
                              for (int i = 0; i < controllers.length; i++) {
                                if (serviceName.text == controllers[i].text) {
                                  print(
                                      "removeView   ${i}    ${serviceDetails.text}");
                                  removeItem(i);
                                }
                                //   print("controllers   ${controllers[i].text}   ${serviceName.text}" ); //printing the values to show that it's working
                              }

                              print(
                                  "calling after click ${_children.length}   ${serviceDetails.text}");
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 25.0,
                      width: 25.0,
                      child: FittedBox(
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            print(
                                "calling after  ${_children.length}   ${serviceDetails.text}");

                            for (int i = 0; i < controllers.length; i++) {
                              print(
                                  "controllers   ${controllers[i].text}   ${serviceName.text}");
                              if (serviceName.text == controllers[i].text) {
                                print(
                                    "EditView   ${i}    ${serviceDetails.text}");
                                editItem(i);
                              }
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ));
    // setState(() => ++_count);
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  Future<dynamic>? serviceModel;

  @override
  Widget build(BuildContext context) {
    int totalCost = 0;

    var doUpdate = () {
      if (isRedundantClick(DateTime.now())) {
        print('hold on, processing');
        return;
      }
      print('run process');
      for (int i = 0; i < AppConstant.requestList.length; i++) {
        totalCost = totalCost +
            double.parse(AppConstant.requestList[i].Amount ?? "0").toInt();
      }

      if (_selectedDropItem.garageId != "" &&
          _selectedDropItem.vehicleId != "" &&
          _selectedDropItem.driverId != "" &&
          AppConstant.requestList.length > 0) {
        Future<UserInfoModel> getUserData() => UserPreferences().getUser();

        getUserData().then((value) => {
              if (widget.serviceDataModel.serviceList != null)
                {
                  serviceModel =
                      Provider.of<ServiceProvider>(context, listen: false)
                          .serviceUpdate(
                              widget.serviceDataModel.serviceList!.servicingId
                                  .toString(),
                              _selectedDropItem.garageId,
                              _selectedDropItem.vehicleId,
                              "",
                              _selectedDropItem.driverId,
                              "1",
                              dateText.text,
                              nextDateText.text,
                              totalCost.toString(),
                              AppConstant.expenseSlipURL,
                              AppConstant.partsImageURL,
                              AppConstant.requestList),
                  serviceModel?.whenComplete(() => {
                        snackBar(context, "Services Updated Successfully",
                            success: true),
                        // widget.serviceDataModel.serviceList = null,
                        _selectedDropItem.garageId = "",
                        _selectedDropItem.vehicleId = "",
                        _selectedDropItem.driverId,
                        dateText.text = "",
                        nextDateText.text = "",
                        totalCost = 0,
                        AppConstant.expenseSlipURL = "",
                        AppConstant.partsImageURL = "",
                        AppConstant.requestList = [],
                        Navigator.pop(context),
                        Get.off(ServiceListView(title: "Vehicle Servicing"))
                      })
                }
              else
                {
                  serviceModel =
                      Provider.of<ServiceProvider>(context, listen: false)
                          .serviceUpdate(
                              "",
                              _selectedDropItem.garageId,
                              _selectedDropItem.vehicleId,
                              "",
                              _selectedDropItem.driverId,
                              "1",
                              dateText.text,
                              nextDateText.text,
                              totalCost.toString(),
                              AppConstant.expenseSlipURL,
                              AppConstant.partsImageURL,
                              AppConstant.requestList),
                  serviceModel?.whenComplete(() => {
                        snackBar(context, "Services Saved Successfully",
                            success: true),
                        // widget.serviceDataModel.serviceList = null,
                        _selectedDropItem.garageId = "",
                        _selectedDropItem.vehicleId = "",
                        _selectedDropItem.driverId,
                        dateText.text = "",
                        nextDateText.text = "",
                        totalCost = 0,
                        AppConstant.expenseSlipURL = "",
                        AppConstant.partsImageURL = "",
                        AppConstant.requestList = [],
                        Navigator.pop(context),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServiceListView(
                                    title: "Vehicle Servicing")))
                      })
                }
            });
      } else {
        snackBar(context, "Required field should not empty", success: false);
      }
    };

    if (widget.serviceDataModel.serviceList != null) {
      dateText.text =
          convertDate2(widget.serviceDataModel.serviceList?.date ?? "");
      nextDateText.text = convertDate2(
          widget.serviceDataModel.serviceList?.nextServiceDate ?? "");
      _selectedDropItem.vehicleId =
          widget.serviceDataModel.serviceList!.vechileId.toString();
      _selectedDropItem.garageId =
          widget.serviceDataModel.serviceList!.gargeId.toString();
      _selectedDropItem.driverId =
          widget.serviceDataModel.serviceList!.driverId.toString();
      if (!initialForm) {
        AppConstant.expenseSlipURL =
            widget.serviceDataModel.serviceList!.expenseSlip.toString();
        AppConstant.partsImageURL =
            widget.serviceDataModel.serviceList!.partsImg.toString();
      }

      //expenseSlip.text =  widget.serviceDataModel.serviceList!.expenseSlip.toString();
    } else {
      // AppConstant.expenseSlipURL = "";
      // AppConstant.partsImageURL = "";
      _selectedDropItem.vehicleId = widget.vehicleId;
    }

    if ((widget.serviceDataModel.serviceCost?.length ?? 0) > 0) {
      // _children.clear();
      // AppConstant.requestList.clear();
      print("isCalling everytime ");
      if (!initialForm) {
        for (var i = 0;
            i < (widget.serviceDataModel.serviceCost?.length ?? 0);
            i++) {
          RequestServiceModel requestServiceModel = new RequestServiceModel();
          requestServiceModel.Id =
              widget.serviceDataModel.serviceCost![i].id.toString();
          requestServiceModel.ServiceName =
              widget.serviceDataModel.serviceCost![i].serviceName.toString();
          requestServiceModel.Amount =
              widget.serviceDataModel.serviceCost![i].cost.toString();
          requestServiceModel.details =
              widget.serviceDataModel.serviceCost![i].details.toString();
          requestServiceModel.serviceNameListId =
              widget.serviceDataModel.serviceCost![i].servicingId.toString();
          AppConstant.requestList.add(requestServiceModel);
          add(requestServiceModel);
        }
        initialForm = true;
      } else {
        _children.clear();
        for (int i = 0; i < AppConstant.requestList.length; i++) {
          add(AppConstant.requestList[i]);
        }
      }
    } else {
      _children.clear();
      for (int i = 0; i < AppConstant.requestList.length; i++) {
        add(AppConstant.requestList[i]);
      }
    }

    EasyLoading.dismiss();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Add Service Details"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Consumer<ServiceProvider>(builder: (context, services, child) {
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
          if (_selectedDropItem.garageId == "") {
            if (services.garageList.isNotEmpty) {
              _selectedDropItem.garageId = services.garageList[0].id.toString();
            }
          } else {
            if (services.garageList.isNotEmpty) {
              bool exists = services.garageList
                  .any((file) => file.id == _selectedDropItem.garageId);
              if (!exists) {
                _selectedDropItem.garageId =
                    services.garageList[0].id.toString();
              }
            }
          }
          if (_selectedDropItem.serviceNameListId == "") {
            if (services.serviceNameList.isNotEmpty) {
              _selectedDropItem.serviceNameListId =
                  services.serviceNameList.first.id.toString();
            }
          } else {
            if (services.serviceNameList.isNotEmpty) {
              bool exists = services.serviceNameList.any(
                  (file) => file.id == _selectedDropItem.serviceNameListId);
              if (!exists) {
                _selectedDropItem.serviceNameListId =
                    services.serviceNameList.first.id.toString();
              }
            }
          }

          return Column(
            children: [
              SizedBox(height: 20),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 10,
                      child: AllDropDownItem(
                          textTitle: "Garage Info",
                          list: services.garageList,
                          requestType: "garageList",
                          isRequired: true,
                          selectedItem: _selectedDropItem.garageId),
                    ),
                    Expanded(
                        flex: 2,
                        child: MaterialButton(
                          height: 30.0,
                          minWidth: 30.0,
                          color: MyTheme.buttonColor,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GarageDetailsView(
                                          vcDataModel: GarageModel(),
                                          requestType: "addFromService",
                                          serviceDataModel:
                                              widget.serviceDataModel,
                                          vehicleId: widget.vehicleId,
                                        )));
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
              EditListItem(
                text: 'Date',
                nameController: dateText,
                isDate: true,
                isRequired: true,
                hintText: 'Click to select date',
              ),
              SizedBox(height: 10),
              EditListItem(
                text: 'Next Service Date',
                nameController: nextDateText,
                isDate: true,
                isFutureDate: true,
                hintText: 'Click to select date',
              ),
              SizedBox(height: 10),
              ImageUploadViewItem(
                text: 'Expense Slip',
                nameController: expenseSlip,
                isVisible: true,
                images: AppConstant.expenseSlip,
              ),
              ImageUploadViewItem(
                  text: 'Parts Image',
                  nameController: partsImage,
                  isVisible: true,
                  images: AppConstant.partsImage),
              SizedBox(height: 10),
              Card(
                  child: Column(children: <Widget>[
                SizedBox(height: 15),
                Text(
                  "Service Section",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  child: ListView(
                      primary: false, shrinkWrap: true, children: _children),
                ),
                ElevatedButton(
                  onPressed: () {
                    // add(null, services.serviceNameList);
                    AddServiceItemDialog(context, widget.serviceDataModel,
                        "${AppConstant.userId}", -1, initialForm);
                  },
                  child: Text("Add New"),
                ),
                SizedBox(height: 15),
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
                SizedBox(height: 10),
              ])),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: longButtons(
                    "${widget.serviceDataModel.serviceList != null ? "Update" : "Save"}",
                    doUpdate),
              ),
            ],
          );
        }),
      ),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
