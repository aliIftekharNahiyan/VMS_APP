import 'package:amargari/providers/trip_list%20_provider.dart';
import 'package:amargari/view/common_view/all_drop_down_Item.dart';
import 'package:amargari/view/common_view/edit_List_Item.dart';
import 'package:amargari/view/common_view/edit_List_Item_without_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:provider/provider.dart';
import 'package:amargari/get_state/selected_dropdown.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/widgets/TextEditingControllerWithEndCursor.dart';
import 'package:amargari/widgets/widgets.dart';

class AddUpdateTrip extends StatefulWidget {
  AddUpdateTrip();


  @override
  _AddUpdateTripState createState() =>
      _AddUpdateTripState();
}

class _AddUpdateTripState extends State<AddUpdateTrip> {
  var startPoint = new TextEditingControllerWithEndCursor(text: '');
  var endPoint = new TextEditingControllerWithEndCursor(text: '');

  var startPointLat = new TextEditingControllerWithEndCursor(text: '');
  var endPointLong = new TextEditingControllerWithEndCursor(text: '');
  var mapImg = new TextEditingControllerWithEndCursor(text: '');
  var tripStatus = new TextEditingControllerWithEndCursor(text: '-1');
  var tripStartDate = new TextEditingControllerWithEndCursor(text: '');
  var tripStartTime = new TextEditingControllerWithEndCursor(text: '');

  Future<dynamic>? accidentAddUpdate;
  String driverId = "";
  String vehicleId = "";
  bool insuranceCover = true;
  bool _switchValue = false;
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);
  // PickResult? selectedPlace;
  SelectedDropDown _selectedDropItem = Get.find();
  String dateTime = "";
  @override
  void initState() {
    _selectedDropItem.vehicleId = "";
    _selectedDropItem.driverId = "";
    super.initState();
  }

  void _loadData(BuildContext context) async {
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) => {
      Provider.of<ServiceProvider>(context, listen: false)
          .fetchVehicleDetails(value.id.toString(),""),
      Provider.of<ServiceProvider>(context, listen: false)
          .fetchDriverList(value.id.toString()),
      Provider.of<ServiceProvider>(context, listen: false)
          .getVehicleEnergyType()
    });
  }

  locationPicker(String requestType){
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) {
    //           return PlacePicker(
    //             apiKey: AppConstant.ApiKey,
    //             initialPosition: kInitialPosition,
    //             useCurrentLocation: true,
    //             selectInitialPosition: true,

    //             //usePlaceDetailSearch: true,
    //             onPlacePicked: (result) {
    //               selectedPlace = result;
    //               if (requestType == "StartPoint"){
    //                 startPoint.text = "${selectedPlace?.formattedAddress}";
    //                 startPointLat.text = "${selectedPlace?.geometry?.location.lat}, ${selectedPlace?.geometry?.location.lng}";
    //               }else{
    //                 endPoint.text = "${selectedPlace?.formattedAddress}";
    //                 endPointLong.text = "${selectedPlace?.geometry?.location.lat}, ${selectedPlace?.geometry?.location.lng}";
    //               }
    //               //endPoint.text = selectedPlace?.geometry?.location.lat as String;
    //               print( "Location select ${selectedPlace?.geometry?.location.lat}");
    //               Navigator.of(context).pop();
    //               setState(() {});
    //             },
    //           );
    //         }
    //     ));
  }
  @override
  Widget build(BuildContext context) {
    _loadData(context);
    var doUpdate = () {

      if(isRedundantClick(DateTime.now())){
        print('hold on, processing');
        return;
      }
      print('run process');
      //isEditAble = true;
      Future<UserInfoModel> getUserData() => UserPreferences().getUser();

      getUserData().then((value) => {
        // if (widget.vcDataModel == null)
        //   {
        //     accidentAddUpdate = addUpdateFuelList(
        //         "",
        //         _selectedDropItem.vehicleId,
        //         _selectedDropItem.driverId,
        //         _selectedDropItem.vehicleEnergyTypeId,
        //         stationName.text,
        //         amount.text,
        //         AppConstant.fuelSlipImgURL,
        //         haveFuelAlert.text,
        //         fuelTime.text),
        //     accidentAddUpdate.whenComplete(() => {
        //       Navigator.pop(context),
        //       Navigator.pop(context),
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => FuelManagementView(
        //                   title: "Fuel Analysis",
        //                   vehicleId: _selectedDropItem.vehicleId)))
        //
        //     })
        //   }
        // else
        //   {


        if (_selectedDropItem.vehicleId != "" && _selectedDropItem.driverId != "" && startPointLat.text != "" && endPointLong.text != ""){
          dateTime  = tripStartDate.text +" " + tripStartTime.text,
          accidentAddUpdate = TripListProvider().addUpdateTrip(
              "",
              _selectedDropItem.vehicleId,
              _selectedDropItem.driverId,
              startPointLat.text,
              endPointLong.text,
              mapImg.text,
              "-1",
            startPoint.text,
            endPoint.text,
            dateTime
          ),
          accidentAddUpdate?.whenComplete(() => {
            Navigator.pop(context)
          })
        }else{
          snackBar(context,"Please select all field")
        }


      });
    };
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Trip"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Consumer<ServiceProvider>(
          builder: (context, services, child) {
            if(_selectedDropItem.vehicleId == ""){
              if (services.vehicleShortList.isNotEmpty){
                _selectedDropItem.vehicleId = services.vehicleShortList[0].id.toString();
                print("vechileId 2  ${services.vehicleShortList[0].id.toString()}");
              }
            }else{
              if (services.vehicleShortList.isNotEmpty) {
                bool exists = services.vehicleShortList.any((file) => file.id == _selectedDropItem.vehicleId);
                if (!exists){
                  _selectedDropItem.vehicleId = services.vehicleShortList[0].id.toString();
                }
              }
            }
            print("vechileId 3  ${_selectedDropItem.vehicleId}");

            if(_selectedDropItem.driverId == ""){
              if (services.driverCommonList.isNotEmpty) {
                _selectedDropItem.driverId = services.driverCommonList[0].id.toString();
              }
            }else{
              if (services.driverCommonList.isNotEmpty) {
                bool exists = services.driverCommonList.any((file) => file.id == _selectedDropItem.driverId);
                if (!exists){
                  _selectedDropItem.driverId = services.driverCommonList[0].id.toString();
                }
              }
            }
            return Column(
              children: [
                SizedBox(height: 20),
                AllDropDownItem(
                    textTitle: "Vehicle",
                    list: services.vehicleShortList,
                    requestType: "vehicleList", selectedItem: _selectedDropItem.vehicleId,),
                SizedBox(height: 15),
                AllDropDownItem(
                    textTitle: "Driver",
                    list: services.driverCommonList,
                    requestType: "driverCommonList", selectedItem: _selectedDropItem.driverId),

                SizedBox(height: 10),

                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [ Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: EditListItem(text: 'Start Point', nameController: startPoint, isEditAble: false, hintText: 'Click in map')
                ), IconButton(
                  icon: Image.asset('assets/icons/googlemap.png'),
                  iconSize: 40,
                  onPressed: () {
                    locationPicker("StartPoint");
                  },
                )]),
                SizedBox(height: 5),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [ Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: EditListItem(text: 'End Point', nameController: endPoint,  isEditAble: false, hintText: 'Click in map')
                ), IconButton(
                  icon: Image.asset('assets/icons/googlemap.png'),
                  iconSize: 40,
                  onPressed: () {
                    locationPicker("endPoint");
                  },
                )]),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [ Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: EditListItemWithOutPadding(
                          text: 'Trip Start Date',
                          nameController: tripStartDate,
                          isDate: true,
                          isFutureDate: true,
                          hintText: 'Click to select date'),
                  ),  Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: EditListItemWithOutPadding(
                        text: 'Time',
                        nameController: tripStartTime,
                        isTime: true,
                        hintText: 'Time'),
                  ),
                  ]),
                ),

               // AccountItem(text: 'Trip Status:', nameController: tripStatus),
              //  SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: longButtons("Add Trip", doUpdate),
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
