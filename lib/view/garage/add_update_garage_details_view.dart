import 'package:amargari/model/garage/GarageModel.dart';
import 'package:amargari/model/service/service_model.dart';
import 'package:amargari/view/Service/add_service.dart';
import 'package:amargari/view/common_view/edit_List_Item.dart';
import 'package:amargari/view/garage/garage_list_view.dart';
import 'package:flutter/material.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/garage_provider.dart';
import 'package:amargari/providers/vehicle_details_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/profile/components/details_body_item.dart';
import 'package:amargari/widgets/TextEditingControllerWithEndCursor.dart';
import 'package:amargari/widgets/widgets.dart';

class GarageDetailsView extends StatefulWidget {
  GarageDetailsView({ required this.vcDataModel, required this.requestType,required this.serviceDataModel, required this.vehicleId,});
  final GarageModel vcDataModel;
  final String requestType;
  final ServiceDataModel serviceDataModel;
  final String vehicleId;

  @override
  _GarageDetailsViewState createState() => _GarageDetailsViewState();
}

class _GarageDetailsViewState extends State<GarageDetailsView> {
  var GargeName = new TextEditingControllerWithEndCursor(text: '');
  var GargeNameLocation = new TextEditingControllerWithEndCursor(text: '');
  var GargeOwnerName = new TextEditingControllerWithEndCursor(text: '');
  var ContactPersonName1  = new TextEditingControllerWithEndCursor(text: '');
  var ContactPersonNumber1  = new TextEditingControllerWithEndCursor(text: '');
  var ContactPersonName2  = new TextEditingControllerWithEndCursor(text: '');
  var ContactPersonNumber2  = new TextEditingControllerWithEndCursor(text: '');
  late Future<dynamic> garageList;

  @override
  void initState() {
    if (widget.vcDataModel.id != null) {
      GargeName = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.gargeName.toString());
      GargeNameLocation = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.gargeNameLocation.toString());
      GargeOwnerName = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.ownerName.toString());
      ContactPersonName1 = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.contactPerson1Name.toString());
      ContactPersonNumber1 = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.contactPerson1Mobile.toString());
      ContactPersonName2 = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.contactPerson2Name.toString());
      ContactPersonNumber2 = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.contactPerson2Mobile.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var doUpdate = () {
      //isEditAble = true;
      if(isRedundantClick(DateTime.now())){
        print('hold on, processing');
        return;
      }
      print('run process');
      if (GargeName.text != "" && GargeNameLocation.text != "") {
        Future<UserInfoModel> getUserData() => UserPreferences().getUser();
        getUserData().then((value) =>
        {
          if (widget.vcDataModel.id == null)
            {
              garageList = GarageProvider().garageDetailsUpdate(
                  "",
                  GargeName.text,
                  GargeNameLocation.text,
                  "1",
                  value.id.toString(),
                  value.ownerId.toString(),
                GargeOwnerName.text.toString(),
                ContactPersonName1.text.toString(),
                ContactPersonNumber1.text.toString(),
                ContactPersonName2.text.toString(),
                ContactPersonNumber2.text.toString(),
              ),

            } else
            {

              garageList = GarageProvider().garageDetailsUpdate(
                  widget.vcDataModel.id.toString(),
                  GargeName.text,
                  GargeNameLocation.text,
                  "1",
                  value.id.toString(),
                  value.ownerId.toString(),
                GargeOwnerName.text.toString(),
                ContactPersonName1.text.toString(),
                ContactPersonNumber1.text.toString(),
                ContactPersonName2.text.toString(),
                ContactPersonNumber2.text.toString(),),
            },

          garageList.whenComplete(() =>
          {
            //snackBar(context, "Successfully save you police case"),
            Navigator.pop(context),
            Navigator.pop(context),
            if (widget.requestType == "addFromService"){

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddServiceView(
                              serviceDataModel: widget.serviceDataModel, vehicleId: widget.vehicleId)))

            }else{
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          GarageInfoView(
                              title: "Workshop Expense")))
            }
          })
          // garageList.then((value) =>
          // {
          //   print("garageList  " + value.toString()),
          //   GargeName.text = "",
          //   GargeNameLocation.text = "",
          //   snackBar(context, "Successfully save garage")
          // })
        });
      }else{
        snackBar(context, "Required field should not empty");
      }
    };
    return Scaffold(
      appBar: AppBar(
        title: Text("Garage Details"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            SizedBox(height: 20),
            EditListItem(
                text: 'Garage Name', nameController: GargeName, isRequired: true, hintText: 'Type garage name',),
            SizedBox(height: 5),
            EditListItem(text: 'Garage Location', nameController: GargeNameLocation, isRequired: true, hintText: 'Type garage location'),
            SizedBox(height: 5),
            EditListItem(text: 'Garage Owner Name', nameController: GargeOwnerName,  hintText: 'Type garage owner name'),
            SizedBox(height: 5),
            EditListItem(text: 'Contact person name 1', nameController: ContactPersonName1,  hintText: 'Type contact person name 1'),
            SizedBox(height: 5),
            EditListItem(text: 'Contact person number 1', nameController: ContactPersonNumber1, hintText: 'Type contact person number 1'),
            SizedBox(height: 5),
            EditListItem(text: 'Contact person name 2', nameController: ContactPersonName2,  hintText: 'Type contact person name 2'),
            SizedBox(height: 5),
            EditListItem(text: 'Contact person number 2', nameController: ContactPersonNumber2, hintText: 'Type contact person number 2'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: longButtons("SAVE", doUpdate),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
