import 'package:amargari/model/common_dropdown_model.dart';
import 'package:amargari/model/police_doc_request_model.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/utility.dart';
import 'package:amargari/view/common_view/all_drop_down_Item.dart';
import 'package:amargari/view/common_view/edit_List_Item.dart';
import 'package:amargari/view/common_view/image_upload_view_item.dart';
import 'package:amargari/view/police_case/police_case_list.dart';
import 'package:amargari/view/profile/components/common_item_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:amargari/get_state/selected_dropdown.dart';
import 'package:amargari/model/police_case_model.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/police_case_provider.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/profile/components/details_body_item.dart';
import 'package:amargari/widgets/TextEditingControllerWithEndCursor.dart';
import 'package:amargari/widgets/drop_down_list_item.dart';
import 'package:amargari/widgets/widgets.dart';

class PoliceCaseDetailsView extends StatefulWidget {
  PoliceCaseDetailsView({required this.vcDataModel, required this.vehicleId});

  final PoliceCaseModel vcDataModel;
  final String vehicleId;

  @override
  _PoliceCaseDetailsViewState createState() => _PoliceCaseDetailsViewState();
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
            .getPoliceFreezingList(value.id.toString(), value.id.toString())
      });
}

class _PoliceCaseDetailsViewState extends State<PoliceCaseDetailsView> {
  var caseName = new TextEditingControllerWithEndCursor(text: '');
  var caseAmount = new TextEditingControllerWithEndCursor(text: '');
  var caseDate = new TextEditingControllerWithEndCursor(text: '');
  var caseDetails = new TextEditingControllerWithEndCursor(text: '');
  var policeStation = new TextEditingControllerWithEndCursor(text: '');
  var location = new TextEditingControllerWithEndCursor(text: '');
  var fineSubmitLastDate = new TextEditingControllerWithEndCursor(text: '');
  var image = new TextEditingControllerWithEndCursor(text: '');
  var paperHandoverAlert = new TextEditingControllerWithEndCursor(text: 'YES');
  var policeCaseClear = new TextEditingControllerWithEndCursor(text: '0');
  List<CommonDropDownModel> policeCaseStatus = [];
  List<CommonDropDownModel?> policeFreezingSelectList = [];
  List<PoliceDocRequestModel> policeDocRequestModel = [];
  Future<dynamic>? policeCaseList;
  bool _switchValue = false;
  bool _switchPoliceCaseValue = false;
  bool policeCaseLoad = true;
  //String driverId = "";
  //String vehicleId = "";
  SelectedDropDown _selectedDropItem = Get.find();

  @override
  void initState() {
    _selectedDropItem.vehicleId = "";
    _selectedDropItem.driverId = "";
    policeCaseStatus
        .add(new CommonDropDownModel(id: "1", name: "Active", title: ""));
    policeCaseStatus
        .add(new CommonDropDownModel(id: "-1", name: "InActive", title: ""));

    if (widget.vcDataModel.policeCaseList?.id != null) {
      caseName = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.policeCaseList?.caseName ?? "");
      caseAmount = new TextEditingControllerWithEndCursor(
          text: "${widget.vcDataModel.policeCaseList?.caseAmount.toString()}");
      caseDate = new TextEditingControllerWithEndCursor(
          text:
              "${convertDate2(widget.vcDataModel.policeCaseList?.caseDate.toString())}");
      caseDetails = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.policeCaseList?.caseDetails ?? "");
      policeStation = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.policeCaseList?.policeStation ?? "");
      location = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.policeCaseList?.location ?? "");
      // if (widget.vcDataModel.toString() == "1") {
      //   _switchValue = true;
      // }
      fineSubmitLastDate = new TextEditingControllerWithEndCursor(
          text: convertDate2(widget
              .vcDataModel.policeCaseList?.submissionLastDate
              .toString()));
      paperHandoverAlert = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.policeCaseList?.paperHandOver ?? "");
      policeCaseClear = new TextEditingControllerWithEndCursor(
          text: "${widget.vcDataModel.policeCaseList?.isClear ?? " "}");

      if (widget.vcDataModel.policeCaseList?.paperHandOver.toString() ==
          "YES") {
        _switchValue = true;
      }
      if (widget.vcDataModel.policeCaseList?.isClear.toString() == "1") {
        _switchPoliceCaseValue = true;
      }
      _selectedDropItem.vehicleId =
          "${widget.vcDataModel.policeCaseList?.vechileId ?? ""}";
      _selectedDropItem.driverId =
          "${widget.vcDataModel.policeCaseList?.driverId ?? ""}";
      AppConstant.policeCaseImageImgURL =
          "${widget.vcDataModel.policeCaseList?.img ?? ""}";

      //  image.text = widget.vcDataModel.img.toString();
    } else {
      _selectedDropItem.vehicleId = widget.vehicleId;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _loadData(context);
    var doUpdate = () {
      //isEditAble = true;
      if (isRedundantClick(DateTime.now())) {
        print('hold on, processing');
        return;
      }

      print('run process');
      if (_selectedDropItem.driverId != "" &&
          _selectedDropItem.vehicleId != "") {
        Future<UserInfoModel> getUserData() => UserPreferences().getUser();
        getUserData().then((value) => {
              if (widget.vcDataModel.policeCaseList?.id == null)
                {
                  policeCaseList = updatePoliceCaseUpdate(
                      "",
                      caseName.text,
                      caseAmount.text,
                      _selectedDropItem.driverId,
                      _selectedDropItem.vehicleId,
                      caseDate.text,
                      "1",
                      AppConstant.policeCaseImageImgURL,
                      AppConstant.policeCaseImageImgURL,
                      caseDetails.text,
                      policeStation.text,
                      location.text,
                      paperHandoverAlert.text,
                      policeDocRequestModel,
                      policeCaseClear.text,
                      fineSubmitLastDate.text),
                }
              else
                {
                  policeCaseList = updatePoliceCaseUpdate(
                      "${widget.vcDataModel.policeCaseList?.id ?? 0}",
                      caseName.text,
                      caseAmount.text,
                      _selectedDropItem.driverId,
                      _selectedDropItem.vehicleId,
                      caseDate.text,
                      "1",
                      AppConstant.policeCaseImageImgURL,
                      AppConstant.policeCaseImageImgURL,
                      caseDetails.text,
                      policeStation.text,
                      location.text,
                      paperHandoverAlert.text,
                      policeDocRequestModel,
                      policeCaseClear.text,
                      fineSubmitLastDate.text),
                },
              policeCaseList?.whenComplete(() => {
                    //snackBar(context, "Successfully save you police case"),
                    Navigator.pop(context),
                    Navigator.pop(context),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PoliceCaseView(
                                  title: "Police Case",
                                  vehicleId: '',
                                )))
                  })
            });
      } else {
        snackBar(context, "Required field should not empty");
      }
    };
    return Scaffold(
      appBar: AppBar(
        title: Text("Police Case Details"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Consumer<ServiceProvider>(builder: (context, services, child) {
          // for(int i = 0, i <  , i++)
          if(policeCaseLoad) {
            if (widget.vcDataModel.documentFreezeingMapList != null &&
                services.policeFreezingList.isNotEmpty) {
              for (int i = 0;
              i < widget.vcDataModel.documentFreezeingMapList!.length;
              i++) {
                final index = services.policeFreezingList.indexWhere((
                    element) =>
                    identical(element.id,
                        "${widget.vcDataModel.documentFreezeingMapList?[i]
                            .policeFreeZingDocumentId}"));
                print(
                    "index  $index  ${widget.vcDataModel
                        .documentFreezeingMapList?.length} "
                        "  ${widget.vcDataModel
                        .documentFreezeingMapList}   ${widget.vcDataModel
                        .documentFreezeingMapList?[i]
                        .policeFreeZingDocumentId}  ");

                if (index != -1) {
                  policeFreezingSelectList
                      .add(services.policeFreezingList[index]);

                }
                policeCaseLoad = false;
                //  print("policeFreezingSelectList   ${policeFreezingSelectList.length}");
              }
            }
          }
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
          if (_selectedDropItem.policeFreezingDoc == "") {
            if (services.policeFreezingList.isNotEmpty) {
              _selectedDropItem.policeFreezingDoc =
                  services.policeFreezingList[0].id.toString();
            }
          } else {
            if (services.policeFreezingList.isNotEmpty) {
              bool exists = services.policeFreezingList.any(
                  (file) => file.id == _selectedDropItem.policeFreezingDoc);
              if (!exists) {
                _selectedDropItem.policeFreezingDoc =
                    services.policeFreezingList[0].id.toString();
              }
            }
          }
          return Column(
            children: [
              SizedBox(height: 20),

              EditListItem(
                text: 'Case Date',
                nameController: caseDate,
                isDate: true,
                hintText: 'Type case date',
              ),
              SizedBox(height: 10),
              EditListItem(
                text: 'Case Name & Details',
                nameController: caseName,
                hintText: 'Type case name & details',
              ),
              SizedBox(height: 10),
              // EditListItem(text: 'Case Details', nameController: caseDetails, hintText: 'Type case details',),
              // SizedBox(height: 10),
              EditListItem(
                text: 'Case Fine Amount',
                nameController: caseAmount,
                isNumber: true,
                hintText: 'Type case fine amount',
              ),
              SizedBox(height: 10),
              EditListItem(
                text: 'Police Station',
                nameController: policeStation,
                hintText: 'Type case police station',
              ),
              SizedBox(height: 10),
              EditListItem(
                text: 'Location',
                nameController: location,
                hintText: 'Type case location',
              ),
              SizedBox(height: 10),
              EditListItem(
                text: 'Fine Submit Last Date',
                nameController: fineSubmitLastDate,
                hintText: 'Click to select Fine Submit Last Date',
                isDate: true,
                isFutureDate: true,
              ),
              SizedBox(height: 10),

              /*  AllDropDownItem(
                  textTitle: "Police Freezing documents",
                  list: services.policeFreezingList,
                  requestType: "policeFreezingList",
                  isRequired: true,
                  selectedItem: _selectedDropItem.policeFreezingDoc),*/

              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                child: MultiSelectDialogField(
                  items: services.policeFreezingList
                      .map((e) => MultiSelectItem<CommonDropDownModel?>(
                          e, e.name ?? ""))
                      .toList(),
                  initialValue: policeFreezingSelectList,
                  searchable: true,
                  buttonText: Text("Police Freezing documents"),
                  listType: MultiSelectListType.LIST,
                  onConfirm: (values) {
                    print("values  ${values}");
                    policeFreezingSelectList =
                        values as List<CommonDropDownModel?>;
                    print("values  ${policeFreezingSelectList.first?.id}");

                    for (int i = 0; i < policeFreezingSelectList.length; i++) {
                      policeDocRequestModel.add(PoliceDocRequestModel(
                          FreeZingId: "${policeFreezingSelectList[i]?.id}"));
                    }

                    //_selectedDropItem.policeFreezingDoc = values as String;
                  },
                ),
              ),
/*
              MultiSelectDialogField(
                items: _animals.map((e) => MultiSelectItem(e, e.name)).toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (values) {
                  _selectedAnimals = values;
                },
              ),*/
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                child: Row(children: [
                  Expanded(
                    child:
                        Text("Paper Handover", style: TextStyle(fontSize: 17)),
                  ),
                  SizedBox(width: 1),
                  CupertinoSwitch(
                    value: _switchValue,
                    onChanged: (value) {
                      setState(() {
                        _switchValue = value;
                        if (_switchValue) {
                          paperHandoverAlert.text = "YES";
                        } else {
                          paperHandoverAlert.text = "NO";
                        }
                      });
                    },
                  ),
                ]),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                child: Row(children: [
                  Expanded(
                    child: Text("Is Police Case Clear",
                        style: TextStyle(fontSize: 17)),
                  ),
                  SizedBox(width: 1),
                  CupertinoSwitch(
                    value: _switchPoliceCaseValue,
                    onChanged: (value) {
                      setState(() {
                        _switchPoliceCaseValue = value;
                        if (_switchPoliceCaseValue) {
                          policeCaseClear.text = "1";
                        } else {
                          policeCaseClear.text = "0";
                        }
                      });
                    },
                  ),
                ]),
              ),
              SizedBox(height: 10),
              ImageUploadViewItem(
                  text: AppConstant.policeCaseImageImg,
                  nameController: image,
                  isVisible: true,
                  images: AppConstant.policeCaseImageImg),
              SizedBox(height: 15),
              AllDropDownItem(
                  textTitle: "Driver",
                  list: services.driverCommonList,
                  requestType: "driverCommonList",
                  isRequired: true,
                  selectedItem: _selectedDropItem.driverId),
              SizedBox(height: 15),
              AllDropDownItem(
                textTitle: "Vehicle",
                list: _selectedDropItem.vehicleId == "" ? services.vehicleShortList : services.vehicleShortList.where((e)=> e.id == _selectedDropItem.vehicleId).toList(),
                requestType: "vehicleList",
                isRequired: true,
                selectedItem: _selectedDropItem.vehicleId,
              ),

              SizedBox(height: 10),

              // DropDownListItem(
              //     textTitle: "Status:",
              //     list: policeCaseStatus,
              //     requestType: "vehicleStatus", selectedItem:  _selectedDropItem.vehicleStatusId,),
              // SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: longButtons(
                    widget.vcDataModel.policeCaseList?.id != null
                        ? "UPDATE"
                        : "SAVE",
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
