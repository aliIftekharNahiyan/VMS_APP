import 'package:amargari/get_state/selected_dropdown.dart';
import 'package:amargari/model/AddDriver/search_driver_model.dart';
import 'package:amargari/model/AddDriver/send_request_res.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/common_view/all_drop_down_Item.dart';
import 'package:amargari/view/common_view/all_drop_down_Item_withOut_padding.dart';
import 'package:amargari/view/profile/adddriver/search_driver.dart';
import 'package:amargari/widgets/drop_down_list_item.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DriverAddRemoveWidget extends StatelessWidget {

  SearchDriverModel searchDriverModel;
  DriverAddRemoveWidget({required this.searchDriverModel});

  @override
  Widget build(BuildContext context) {

    if (searchDriverModel.ownerId == AppConstant.userId && searchDriverModel.isDriverAllocated != null){
      return  MaterialButton(
        onPressed:  () {
          removeDriver(context, searchDriverModel);


        },
        child: Text("Remove Driver"),
        color: Colors.orange,
      );
    }else{
      return MaterialButton(
        onPressed:  () {
          addDriver(context, searchDriverModel);
        },
        child: Text("Add Driver"),
        color: Colors.orange,
      );
    }
  }
  removeDriver(BuildContext context, SearchDriverModel searchDriverModel ) {

    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) =>
    {
    Provider.of<ServiceProvider>(context, listen: false)
        .removeDriverFromAllocation(value.id.toString(), searchDriverModel.id.toString()),
    snackBar(context, "Successfully remove driver from you account"),
    Navigator.pop(context),
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SearchDriver()))
    });
  }

  addDriver(BuildContext context, SearchDriverModel searchDriverModel ) {

    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) =>
    {
      displayVehicle(context, searchDriverModel, value.id.toString())
    });
  }
}



Future<void> displayVehicle(BuildContext context, SearchDriverModel searchDriverModel, String userId) async {
  Provider.of<ServiceProvider>(context, listen: false)
      .fetchVehicleDetails(userId,"");
  String otpCode  = "" ;
  SelectedDropDown _selectedDropItem = Get.find();
  return showDialog(
    context: context,
    builder: (context) {
      return Consumer<ServiceProvider>(builder: (context, services, child) {


          if (services.vehicleShortList.isNotEmpty) {
            bool exists = services.vehicleShortList.any((file) => file.id == _selectedDropItem.vehicleId);
            if (!exists){
              _selectedDropItem.vehicleId = services.vehicleShortList[0].id.toString();
            }
          }

        return AlertDialog(
          title: Text('Add Driver!!'),
          content:
          // DropDownListItem(
          //     textTitle: "Vehicle :",
          //     list: services.vehicleShortList,
          //     requestType: "vehicleList"),
          AllDropDownItemWithOutPadding(
              textTitle: "Vehicle",
              list: services.vehicleShortList,
              requestType: "vehicleType", selectedItem: _selectedDropItem.vehicleId),

          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {

                if(_selectedDropItem.vehicleId != "") {
                  Provider.of<ServiceProvider>(context, listen: false)
                      .sendDriverAllocateRequest(
                      searchDriverModel.id.toString(), userId,
                      _selectedDropItem.vehicleId);

                  Navigator.pop(context);

                  confirmRequest(context, services.sendRequestRes);
                }else{
                  snackBar(context, "Please select vehicle");
                }
              },
            ),
          ],
        );
      }
      );
    },
  );
}

TextEditingController _textFieldController = TextEditingController();

Future<void> confirmRequest(BuildContext context, SendRequestRes sendRequestRes) async {
  _textFieldController.text = "";
  String otpCode  = "" ;
  return showDialog(
    context: context,
    builder: (context) {
      return Consumer<ServiceProvider>(builder: (context, services, child) {
        return AlertDialog(
          title: Text('OTP validation. OPT send to driver number, Please collect OTP from your driver!!', style: TextStyle(fontSize: 12),),
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

                if(_textFieldController.text != "") {

                  print(services.sendRequestRes.otp);
                  print(_textFieldController.text);
               if(services.sendRequestRes.otp == _textFieldController.text){

                   Provider.of<ServiceProvider>(context, listen: false)
                       .confirmDriverAllocateRequest(services.sendRequestRes.data!.id.toString());
                   Navigator.pop(context);
                   Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => SearchDriver()));
                   snackBar(context, "Success fully added");

                 }else{
                   snackBar(context, "Please type input correct otp");
                 }
                 // Navigator.pop(context);
                }else{
                  snackBar(context, "Please input otp");
                }
              },
            ),
          ],
        );
      }
      );
    },
  );
}