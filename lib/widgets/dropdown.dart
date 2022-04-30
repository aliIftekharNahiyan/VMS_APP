import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amargari/get_state/selected_dropdown.dart';
import 'package:amargari/model/common_dropdown_model.dart';
import 'package:provider/provider.dart';

class DropDown extends StatefulWidget {
  bool isExpanded;
  bool isUnderline;
  List<CommonDropDownModel> list;
  String? requestType;
  String? selectedItem;

  DropDown(this.list,
      {this.isExpanded = false,
      this.isUnderline = true,
      this.requestType,
      this.selectedItem});

  @override
  State<StatefulWidget> createState() =>
      _DropDownState(list, isExpanded, isUnderline, requestType, selectedItem);
}

class _DropDownState extends State<DropDown> {
  List<CommonDropDownModel> _list;
  // String? _selecteditem;
  bool? expanded;
  bool? underline;
  String? requestType;
  String? selectedItem;
  _DropDownState(this._list, this.expanded, this.underline, this.requestType,
      this.selectedItem);

  @override
  Widget build(BuildContext context) {
    SelectedDropDown _selectedDropItem = Get.find();

    print("dropdown  ${widget.requestType}   ${widget.selectedItem}");
    return DropdownButton(
      isDense: true,
      underline: underline == true ? null : SizedBox(),
      isExpanded: expanded!,
      hint: label(_list.first.name ?? ""),
      value: widget.selectedItem!.isNotEmpty ? widget.selectedItem : null,
      onChanged: (newValue) {
        setState(() {
          print("DropdownSelect $widget.selectedItem  $requestType  $newValue ");
          
          widget.selectedItem = newValue as String;
          if (requestType == "vehicleList") {
            _selectedDropItem.vehicleId = newValue;
          } else if (requestType == "expenseTypeStatus") {
            _selectedDropItem.expenseStatusId = newValue;
          } else if (requestType == "garageList") {
            _selectedDropItem.garageId = newValue;
          } else if (requestType == "driverCommonList") {
            _selectedDropItem.driverId = newValue;
          } else if (requestType == "getVehicleEnergyType") {
            _selectedDropItem.vehicleEnergyTypeId = newValue;
          } else if (requestType == "UserType") {
            _selectedDropItem.userTypeId = newValue;
          } else if (requestType == "expenseTypeList") {
            _selectedDropItem.expenseId = newValue;
          } else if (requestType == "vehicleType") {
            _selectedDropItem.vehicleTypeId = newValue;
            _selectedDropItem.vehicleBrandId = "";
            print("vehicleBrandName   ${_selectedDropItem.vehicleBrandId}");

            Provider.of<ServiceProvider>(context, listen: false)
                .getVehicleGeneralInfo("1", "", _selectedDropItem.vehicleTypeId,
                    "${AppConstant.userId}");
          } else if (requestType == "vehicleStatus") {
            _selectedDropItem.vehicleStatusId = newValue;
          } else if (requestType == "BrandName") {
            _selectedDropItem.vehicleBrandFullName = _list
                .where((oldValue) =>
                    newValue.toString() == (oldValue.id.toString()))
                .first
                .name
                .toString();
            _selectedDropItem.vehicleBrandId = newValue;
            _selectedDropItem.vehicleModelId = "";
            Provider.of<ServiceProvider>(context, listen: false)
                .getVehicleGeneralInfo("2", _selectedDropItem.vehicleBrandId,
                    "", "${AppConstant.userId}");

            // _list.where((oldValue) => newValue.toString() == (oldValue.id.toString())).first.name.toString();
            // print(_list.where((oldValue) => newValue.toString() == (oldValue.id.toString())).first.name.toString());

            //   print("AllSelectedType  ${ _selectedDropItem.vehicleTypeId}  brand ${ _selectedDropItem.vehicleBrandName}  model ${_selectedDropItem.vehicleModelName}");
          } else if (requestType == "ModelName") {
            _selectedDropItem.vehicleModelFullName = _list
                .where((oldValue) =>
                    newValue.toString() == (oldValue.id.toString()))
                .first
                .name
                .toString();
            _selectedDropItem.vehicleModelId = newValue;
          } else if (requestType == "VehicleColour") {
            _selectedDropItem.vehicleColourId = newValue;
            _selectedDropItem.vehicleColourFullName = _list
                .where((oldValue) =>
                    newValue.toString() == (oldValue.id.toString()))
                .first
                .name
                .toString();
            print(_selectedDropItem.vehicleColourFullName);
          } else if (requestType == "serviceType") {
            _selectedDropItem.serviceType = newValue;
            Provider.of<ServiceProvider>(context, listen: false)
                .getMonthlyReport(
                    AppConstant.startDate,
                    AppConstant.endDate,
                    _selectedDropItem.vehicleId,
                    _selectedDropItem.serviceType,
                    "${AppConstant.userId}");
          } else if (requestType == "reportVehicleList") {
            _selectedDropItem.vehicleId = newValue;

            if (_selectedDropItem.vehicleId == "0") {
              Provider.of<ServiceProvider>(context, listen: false)
                  .getMonthlyReport(
                      AppConstant.startDate,
                      AppConstant.endDate,
                      _selectedDropItem.vehicleId,
                      _selectedDropItem.serviceType,
                      "${AppConstant.userId}");
            } else {
              Provider.of<ServiceProvider>(context, listen: false)
                  .getMonthlyReport(
                      AppConstant.startDate,
                      AppConstant.endDate,
                      _selectedDropItem.vehicleId,
                      _selectedDropItem.serviceType,
                      "0");
            }
          } else if (requestType == "policeFreezingList") {
            _selectedDropItem.policeFreezingDoc = newValue;
          } else if (requestType == AppConstant.serviceNameList) {
            _selectedDropItem.serviceNameListId = newValue;
            _selectedDropItem.serviceNameListName = _list
                .where((oldValue) =>
                    newValue.toString() == (oldValue.id.toString()))
                .first
                .name
                .toString();
            print(
                "serviceNameListName   ${_selectedDropItem.serviceNameListName}");
          }
        });
      },
      items: _list.map((list) {
        return DropdownMenuItem(child: label(list.name ?? ""), value: list.id);
      }).toList(),
    );
  }
}
