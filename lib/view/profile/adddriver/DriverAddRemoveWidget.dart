import 'dart:ui';

import 'package:amargari/get_state/selected_dropdown.dart';
import 'package:amargari/model/AddDriver/search_driver_model.dart';
import 'package:amargari/model/AddDriver/send_request_res.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/common_view/all_drop_down_Item.dart';
import 'package:amargari/view/common_view/all_drop_down_Item_withOut_padding.dart';
import 'package:amargari/view/common_view/dropdownMultiSelect.dart';
import 'package:amargari/view/profile/adddriver/search_driver.dart';
import 'package:amargari/widgets/drop_down_list_item.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DriverAddRemoveWidget extends StatefulWidget {
  final SearchDriverModel searchDriverModel;
  DriverAddRemoveWidget({required this.searchDriverModel});

  @override
  State<DriverAddRemoveWidget> createState() => _DriverAddRemoveWidgetState();
}

class _DriverAddRemoveWidgetState extends State<DriverAddRemoveWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.searchDriverModel.ownerId == AppConstant.userId &&
        widget.searchDriverModel.isDriverAllocated != null &&
        widget.searchDriverModel.isDriverAllocated != -1) {
      return Row(
        children: [
          MaterialButton(
            minWidth: 20,
            onPressed: () {
              addDriver(context, widget.searchDriverModel);
            },
            child: Text(
              "Edit",
              style: TextStyle(fontSize: 11, color: Colors.white),
            ),
            color: Colors.orange,
          ),
          SizedBox(
            width: 2,
          ),
          MaterialButton(
            minWidth: 20,
            onPressed: () {
              removeDriver(context, widget.searchDriverModel);
            },
            child: Text(
              "Remove",
              style: TextStyle(fontSize: 11, color: Colors.white),
            ),
            color: Colors.red,
          ),
        ],
      );
    } else {
      return MaterialButton(
        onPressed: () {
          addDriver(context, widget.searchDriverModel);
        },
        child: Text("Add Vehicle", style: TextStyle(color: Colors.white),),
        color: Colors.orange,
      );
    }
  }

  removeDriver(BuildContext context, SearchDriverModel searchDriverModel) {
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) => {
          Provider.of<ServiceProvider>(context, listen: false)
              .removeDriverFromAllocation(
                  value.id.toString(), searchDriverModel.id.toString()),
          snackBar(context, "Successfully remove driver from you account",
              success: true),
          Navigator.pop(context),
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchDriver()))
        });
  }

  addDriver(BuildContext context, SearchDriverModel searchDriverModel) {
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) =>
        {displayVehicle(context, searchDriverModel, value.id.toString())});
  }
}

Future<void> displayVehicle(BuildContext context,
    SearchDriverModel searchDriverModel, String userId) async {
  Provider.of<ServiceProvider>(context, listen: false)
      .fetchVehicleDetails(userId, "");

  Provider.of<ServiceProvider>(context, listen: false).fetchAssignedVehicle(
      driverId: searchDriverModel.id.toString(), ownerId: userId);

  String otpCode = "";
  bool isInit = false;

  List<String> vList = [];
  _onAdded(v) {
    vList.add(v);
  }

  _onRemove(v) {
    vList.remove(v);
  }

  SelectedDropDown _selectedDropItem = Get.find();
  return showDialog(
    context: context,
    builder: (context) {
      return Consumer<ServiceProvider>(builder: (context, services, child) {
        if (services.vehicleShortList.isNotEmpty) {
          bool exists = services.vehicleShortList
              .any((file) => file.id == _selectedDropItem.vehicleTypeId);
          if (!exists) {
            _selectedDropItem.vehicleTypeId =
                services.vehicleShortList[0].id.toString();
          }
        }

        if (services.vehicleAssignedShortList.isNotEmpty) {
          if (!isInit) {
            vList.clear();
            isInit = true;
            services.vehicleAssignedShortList.forEach((e) {
              vList.add(e.id.toString());
            });
          }
        }

        return AlertDialog(
          title: Text('Add Vehicle'),
          content: ContantChip(
            list: services.vehicleShortList,
            selectedList: vList,
            selected: _selectedDropItem.vehicleTypeId,
            onAdded: _onAdded,
            onRemove: _onRemove,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                _selectedDropItem.vehicleTypeId = "";
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                print(vList.length);
                if (vList.isNotEmpty) {
                  Provider.of<ServiceProvider>(context, listen: false)
                      .sendListOfDriverAllocateRequest(
                          searchDriverModel.id.toString(), userId, vList);

                  Navigator.pop(context);
                  snackBar(context, "Success fully added", success: true);

                  // confirmRequest(context, services.sendRequestRes);
                } else {
                  snackBar(context, "Please select vehicle", success: false);
                }
              },
            ),
          ],
        );
      });
    },
  );
}

TextEditingController _textFieldController = TextEditingController();

Future<void> confirmRequest(
    BuildContext context, SendRequestRes sendRequestRes) async {
  _textFieldController.text = "";
  String otpCode = "";
  return showDialog(
    context: context,
    builder: (context) {
      return Consumer<ServiceProvider>(builder: (context, services, child) {
        return AlertDialog(
          title: Text(
            'OTP validation. OPT send to driver number, Please collect OTP from your driver!!',
            style: TextStyle(fontSize: 12),
          ),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Enter OTP number"),
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text('Cancel '),
              color: Colors.orange,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              child: Text('Confirm'),
              color: Colors.orange,
              onPressed: () {
                if (_textFieldController.text != "") {
                  print(services.sendRequestRes.otp);
                  print(_textFieldController.text);
                  if (services.sendRequestRes.data!.isNotEmpty) {
                    if (services.sendRequestRes.data![0].oTP ==
                        _textFieldController.text) {
                      Provider.of<ServiceProvider>(context, listen: false)
                          .confirmDriverAllocateRequest(
                              services.sendRequestRes.data![0].id.toString());
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchDriver()));
                      snackBar(context, "Success fully added", success: true);
                    } else {
                      snackBar(context, "Please type input correct otp",
                          success: false);
                    }
                  } else {
                    if (services.sendRequestRes.otp ==
                        _textFieldController.text) {
                      Provider.of<ServiceProvider>(context, listen: false)
                          .confirmDriverAllocateRequest(
                              services.sendRequestRes.data![0].id.toString());
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchDriver()));
                      snackBar(context, "Success fully added", success: true);
                    } else {
                      snackBar(context, "Please type input correct otp",
                          success: false);
                    }
                  }

                  // Navigator.pop(context);
                } else {
                  snackBar(context, "Please input otp", success: false);
                }
              },
            ),
          ],
        );
      });
    },
  );
}

class ContantChip extends StatefulWidget {
  final list;
  final selected;
  final selectedList;
  Function onAdded;
  Function onRemove;
  ContantChip(
      {Key? key,
      this.list,
      this.selected,
      this.selectedList,
      required this.onAdded,
      required this.onRemove})
      : super(key: key);

  @override
  State<ContantChip> createState() => _ContantChipState();
}

class _ContantChipState extends State<ContantChip> {
  var vList = [];
  @override
  void initState() {
    super.initState();
    vList = widget.selectedList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownMultiSelect(
            textTitle: "Vehicle",
            list: widget.list,
            requestType: "vehicleType",
            selectedItem: widget.selected,
            onCallback: (v) {
              if (!vList.contains(v)) {
                // setState(() {
                // vList.add(v);
                widget.onAdded(v);
                // });
              } else {
                snackBar(context, "Already Added", success: false);
              }
            },
          ),
          Divider(
            height: 5,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Wrap(spacing: 4.0, runSpacing: 0.0, children: [
              ...vList.map((e) => Chip(
                  onDeleted: () {
                    setState(() {
                      vList.remove(e);
                      widget.onRemove(e);
                    });
                  },
                  elevation: 3,
                  backgroundColor: Colors.amber[200],
                  label: Text(widget.list.length == 0
                      ? ""
                      : widget.list
                          .firstWhere((l) => l.id == e)
                          .name
                          .toString())))
            ]),
          )
        ],
      ),
    );
  }
}
