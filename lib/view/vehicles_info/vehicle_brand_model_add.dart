import 'package:amargari/get_state/selected_dropdown.dart';
import 'package:amargari/model/vehicleinfo/add_brand_model.dart';
import 'package:amargari/providers/auth.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/providers/vehicle_details_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/view/common_view/all_drop_down_Item.dart';
import 'package:amargari/widgets/drop_down_list_border.dart';
import 'package:amargari/widgets/drop_down_list_item.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

TextEditingController _textFieldController = TextEditingController();

Future<void> vehicleBrandModelAdd(BuildContext context, String? requestType) async {
  Provider.of<ServiceProvider>(context, listen: false)
      .getVehicleType();
  SelectedDropDown _selectedDropItem = Get.find();
  var rawUtilityId = "1";
  var parentId = "0";
  var vehicleTypeForModelId = "";
  var isVisible = false;

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        scrollable: true,
        title: Text(requestType ?? ""),
        content: Consumer<ServiceProvider>(builder: (context, services, child) {
          if(_selectedDropItem.vehicleTypeId == ""){
            if (services.vehicleTypeComList.isNotEmpty){
              _selectedDropItem.vehicleTypeId = services.vehicleTypeComList[0].id.toString();
              _selectedDropItem.vehicleStatusId = '1';
              print("vechileId 2  ${services.vehicleTypeComList[0].id.toString()}");
            }
          }else{
            if (services.vehicleTypeComList.isNotEmpty) {
              bool exists = services.vehicleTypeComList.any((file) => file.id == _selectedDropItem.vehicleTypeId);
              if (!exists){
                _selectedDropItem.vehicleTypeId = services.vehicleTypeComList[0].id.toString();
              }
            }
          }
          if(_selectedDropItem.vehicleBrandId == ""){
            if (services.vehicleBrandNameList.isNotEmpty){
              _selectedDropItem.vehicleBrandId = services.vehicleBrandNameList[0].id.toString();

              print("vehicleBrandName 2 ${_selectedDropItem.vehicleBrandId}");
            }
            print("vehicleBrandName 3 ${_selectedDropItem.vehicleBrandId}  ${services.vehicleBrandNameList.toString()}");

            for (var i = 0; i < services.vehicleBrandNameList.length; i++) {
              print("vehicleBrandNameList   "+services.vehicleBrandNameList[i].id.toString());
            }
          }else{
            if (services.vehicleBrandNameList.isNotEmpty) {
              bool exists = services.vehicleBrandNameList.any((file) => file.id == _selectedDropItem.vehicleBrandId);
              if (!exists){
                _selectedDropItem.vehicleBrandId = services.vehicleBrandNameList[0].id.toString();
              }
            }
          }


          if(requestType == "Add New Brand"){
            rawUtilityId = "1";
            parentId = "0";
            vehicleTypeForModelId = _selectedDropItem.vehicleTypeId;
            isVisible = false;
          }else{
            rawUtilityId = "2";
            parentId = _selectedDropItem.vehicleBrandId;
            vehicleTypeForModelId = "";
            isVisible = true;
          }

          return Column(
            children:[
              DropDownBorderItem(
                textTitle: "Vehicle Type:",
                list: services.vehicleTypeComList,
                requestType: "vehicleType",selectedItem: _selectedDropItem.vehicleTypeId,),
             SizedBox(height: 10),
              Visibility(
                child: DropDownBorderItem(
                  textTitle: "Brand Name:",
                  list: services.vehicleBrandNameList,
                  requestType: "BrandName", selectedItem: _selectedDropItem.vehicleBrandId,),
                visible: isVisible,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _textFieldController,
                decoration: commonInputDecoration("Name", "Type name"),
              )] ,
          );
        }),
        actions: <Widget>[
          TextButton(
            child: Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Add'),
            onPressed: () {

              VehicleInfoProvider vehicleInfoAdd = Provider.of<VehicleInfoProvider>(context, listen: false);

              final Future<dynamic> successfulMessage = vehicleInfoAdd.addVehicleBrandModel("",rawUtilityId, _textFieldController.text, parentId, vehicleTypeForModelId, "${AppConstant.userId}");

              AddBrandModel brandDetails;
              successfulMessage.then((value) => {
                print(value),
                // if (value.result == "success"){
                brandDetails = value['details'] as AddBrandModel,
                print("brandDetails   $requestType    ${brandDetails.result?.id.toString()}"),
                if(requestType == "Add New Brand"){
                  Provider.of<ServiceProvider>(context, listen: false).getVehicleGeneralInfo(
                      "1", "", _selectedDropItem.vehicleTypeId, "${AppConstant.userId}"),
                  _selectedDropItem.vehicleBrandId =
                  "${brandDetails.result?.id.toString()}",
                }else{
                  Provider.of<ServiceProvider>(context, listen: false).getVehicleGeneralInfo("2", _selectedDropItem.vehicleBrandId, "", "${AppConstant.userId}"),

              _selectedDropItem.vehicleModelId =
                  "${brandDetails.result?.id.toString()}",
                },
                Navigator.pop(context),

                Flushbar(
                  message: " $requestType successfully",
                  duration: Duration(seconds: 5),
                ).show(context),
              });
              // print(successfulMessage.toString());
              // Navigator.pop(context);

            },
          ),
        ],
      );
    },
  );
}
