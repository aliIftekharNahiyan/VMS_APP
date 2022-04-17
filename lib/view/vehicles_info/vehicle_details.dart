import 'package:amargari/model/accident_list_model.dart';
import 'package:amargari/model/fuel_list_model.dart';
import 'package:amargari/model/police_case_model.dart';
import 'package:amargari/model/service/service_model.dart';
import 'package:amargari/model/vehicle_doc_details.dart';
import 'package:amargari/model/vehicleinfo/vehicle_info_model.dart';
import 'package:amargari/providers/common_provider.dart';
import 'package:amargari/providers/vehicle_details_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/uril/utility.dart';
import 'package:amargari/view/Service/add_service.dart';
import 'package:amargari/view/accident_management/add_update_accident.dart';
import 'package:amargari/view/fuel_management/add_update_fuel_management.dart';
import 'package:amargari/view/police_case/add_update_police_case_details_view.dart';
import 'package:amargari/view/police_case/police_case_list.dart';
import 'package:amargari/view/vehicles_info/vehicle_add_edit_details.dart';
import 'package:amargari/view/vehicles_info/vehicle_document_view.dart';
import 'package:amargari/widgets/image_picker_gallery_camera.dart';
import 'package:amargari/widgets/themes.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class VehicleDetailsScreen extends StatefulWidget {
  final VehicleInfoDataModel vcDataModel;

  const VehicleDetailsScreen({required this.vcDataModel});

  @override
  _VehicleDetailsScreenState createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  bool _showMoreAbout = false;
  var _image;
  bool imageUploadRequest = true;
  Future<dynamic>? vehicleList;

  Future getImage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
        imageQuality: 10,
        enableCloseButton: true,
        closeIcon: Icon(
          Icons.close,
          color: Colors.red,
          size: 12,
        ),
        context: context,
        source: source,
        barrierDismissible: true,
        cameraIcon: Icon(
          Icons.camera_alt,
          color: Colors.red,
        ),
        //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
        cameraText: Text(
          "From Camera",
          style: TextStyle(color: Colors.red),
        ),
        galleryText: Text(
          "From Gallery",
          style: TextStyle(color: Colors.blue),
        ));
    setState(() {
      _image = image;
    });
  }

  imageUpload(BuildContext context, String imagePath) {
    CommonProvider commonProvider = Provider.of<CommonProvider>(context);
    var getUserData = UserPreferences().getUser();

    //snackBar(context,"Start to upload image, please wait");
    getUserData.then((user) => setState(() {
          print("path:  " + imagePath);
          final Future<String> url = commonProvider.uploadImage(
              user.name ?? "", user.mobileNo ?? "", imagePath);
          url.then((value) {
            print("Response output " + value);
            //   snackBar(context,"Successfully upload user Image");
            AppConstant.vehicleImageURL = value;
            print("vehicleImageURL:  " + AppConstant.vehicleImageURL);

            //  print("userId " + value.id.toString()),
            vehicleList = VehicleInfoProvider().vehicleDetailsUpdate(
                widget.vcDataModel.id.toString(),
                widget.vcDataModel.vechileTypeId.toString(),
                user.id.toString(),
                AppConstant.vehicleImageURL,
                widget.vcDataModel.vechileNumber.toString(),
                widget.vcDataModel.engineNumber.toString(),
                widget.vcDataModel.chasisNumber.toString(),
                widget.vcDataModel.modelName.toString(),
                widget.vcDataModel.brandName.toString(),
                widget.vcDataModel.vechileTierSize.toString(),
                widget.vcDataModel.registrationDate.toString(),
                widget.vcDataModel.registrationExpireDate.toString(),
                widget.vcDataModel.vechileRentId.toString(),
                widget.vcDataModel.cc.toString(),
                widget.vcDataModel.tierNumber.toString(),
                widget.vcDataModel.milage.toString(),
                widget.vcDataModel.vechileEnergySourceId.toString(),
                widget.vcDataModel.status.toString(),
                widget.vcDataModel.colorName.toString(),
                widget.vcDataModel.modelYear.toString());

            vehicleList?.whenComplete(() => {
                  widget.vcDataModel.vechileImage = AppConstant.vehicleImageURL,
                  setState(() {}),
                });
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    var editVehicle = () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VehicleAddEditView(vcDataModel: widget.vcDataModel)));
    };

    if (_image != null) {
      if (imageUploadRequest) {
        imageUploadRequest = false;
        imageUpload(context, _image.path);
      }
    }
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, _) => Stack(children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Stack(children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              widget.vcDataModel.vechileImage.toString()),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.5),
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5.0,
                      bottom: 15.0,
                      child: FloatingActionButton(
                        onPressed: () {
                          //addVehicleInfo(new VehicleInfoDataModel());
                          getImage(ImgSource.Both);
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 29,
                        ),
                        backgroundColor: Colors.orange,
                        tooltip: 'Image',
                        elevation: 5,
                        splashColor: Colors.grey,
                      ),
                    )
                  ]),
                ),
                Positioned.fill(
                  child: DraggableScrollableSheet(
                    initialChildSize: 2 / 3,
                    minChildSize: 2 / 3,
                    maxChildSize: 1,
                    builder: (context, scrollController) => Container(
                      padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.0),
                          topLeft: Radius.circular(15.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.1),
                            offset: Offset(0, -3),
                            blurRadius: 5.0,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          /*Expanded(
                            flex: 8,
                            child: ListView(
                              controller: scrollController,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(height: 10),
                                          Text(
                                            "Vehicle Name: ${widget.vcDataModel.brandName.toString()}-${widget.vcDataModel.modelName.toString()}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Brand Name: ${widget.vcDataModel.brandName.toString()}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Vehicle Number: ${widget.vcDataModel.vechileNumber.toString()}",
                                            maxLines: _showMoreAbout ? null : 1,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Manufacturing Year: ${widget.vcDataModel.modelYear.toString()}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Registration Date: ${convertDate2(widget.vcDataModel.registrationDate.toString())}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Reg Expire Date: ${convertDate2(widget.vcDataModel.registrationExpireDate.toString())}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Fitness Expire Date: ${convertDate2(widget.vcDataModel.fitnessExpireDate.toString())}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Insurance Expire Date: ${convertDate2(widget.vcDataModel.insuranceExpireDate.toString())}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "TaxToken Expire Date: ${convertDate2(widget.vcDataModel.taxTokenExpireDate.toString())}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Route Permit Expire Date: ${convertDate2(widget.vcDataModel.routePermitExpireDate.toString())}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                longButtons("Edit Vehicle".tr(), editVehicle),
                              ],
                            ),
                          ),*/

                          /*  Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MaterialButton(
                                height: 90.0,
                                minWidth: 110.0,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VehicleDocumentView(
                                                requestType: AppConstant
                                                    .docRegistrationImg,
                                                vehicleId: widget
                                                    .vcDataModel.id
                                                    .toString(),
                                                vcDataModel:
                                                    widget.vcDataModel,
                                                  vcDocDetailsModel: VehicleDocDetailsModel()
                                              )));
                                },
                                color: MyTheme.buttonColor,
                                textColor: Colors.white,
                                child: Text("REG",
                                    style: TextStyle(fontSize: 15)),
                                padding: EdgeInsets.all(5),
                                shape: CircleBorder(),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              MaterialButton(
                                height: 90.0,
                                minWidth: 110.0,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VehicleDocumentView(
                                                requestType: AppConstant
                                                    .docFitnessImg,
                                                vehicleId: widget
                                                    .vcDataModel.id
                                                    .toString(),
                                                vcDataModel:
                                                    widget.vcDataModel,
                                                  vcDocDetailsModel: VehicleDocDetailsModel()
                                              )));
                                },
                                color: MyTheme.buttonColor,
                                textColor: Colors.white,
                                child: Text("Fitness",
                                    style: TextStyle(fontSize: 15)),
                                padding: EdgeInsets.all(5),
                                shape: CircleBorder(),
                              ),
                              SizedBox(height: 5),
                              MaterialButton(
                                height: 90.0,
                                minWidth: 110.0,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VehicleDocumentView(
                                                requestType: AppConstant
                                                    .docInsuranceImg,
                                                vehicleId: widget
                                                    .vcDataModel.id
                                                    .toString(),
                                                vcDataModel:
                                                    widget.vcDataModel,
                                                  vcDocDetailsModel: VehicleDocDetailsModel()
                                              )));
                                },
                                color: MyTheme.buttonColor,
                                textColor: Colors.white,
                                child: Text(
                                  "Insurance",
                                  style: TextStyle(fontSize: 15),
                                ),
                                padding: EdgeInsets.all(5),
                                shape: CircleBorder(),
                              ),

                            ],
                          ),*/
                          SizedBox(
                            height: 10,
                          ),
                          /*    Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MaterialButton(
                                height: 90.0,
                                minWidth: 110.0,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VehicleDocumentView(
                                                  requestType: AppConstant
                                                      .docTaxTokenImg,
                                                  vehicleId: widget
                                                      .vcDataModel.id
                                                      .toString(),
                                                  vcDataModel:
                                                  widget.vcDataModel,
                                                  vcDocDetailsModel: VehicleDocDetailsModel()
                                              )));
                                },
                                color: MyTheme.buttonColor,
                                textColor: Colors.white,
                                child: Text("Tax Token",
                                    style: TextStyle(fontSize: 15)),
                                padding: EdgeInsets.all(5),
                                shape: CircleBorder(),
                              ),
                              SizedBox(height: 5),
                              MaterialButton(
                                height: 90.0,
                                minWidth: 110.0,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VehicleDocumentView(
                                                  requestType: AppConstant
                                                      .docRoadPermitImg,
                                                  vehicleId: widget
                                                      .vcDataModel.id
                                                      .toString(),
                                                  vcDataModel:
                                                  widget.vcDataModel,
                                                  vcDocDetailsModel: VehicleDocDetailsModel()
                                              )));
                                },
                                color: MyTheme.buttonColor,
                                textColor: Colors.white,
                                child: Text("Road Permit",
                                    style: TextStyle(fontSize: 12)),
                                padding: EdgeInsets.all(5),
                                shape: CircleBorder(),
                              )
                            ],
                          ),*/
                          longButtons("Edit Vehicle".tr(), editVehicle),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VehicleDocumentView(
                                                    requestType: AppConstant
                                                        .docRegistrationImg,
                                                    vehicleId: widget
                                                        .vcDataModel.id
                                                        .toString(),
                                                    vcDataModel:
                                                        widget.vcDataModel,
                                                    vcDocDetailsModel:
                                                        VehicleDocDetailsModel())));
                                  },
                                  child: Card(
                                    semanticContainer: true,
                                    child: Container(
                                      color: MyTheme.buttonColor,
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: Text('REG',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VehicleDocumentView(
                                                    requestType: AppConstant
                                                        .docFitnessImg,
                                                    vehicleId: widget
                                                        .vcDataModel.id
                                                        .toString(),
                                                    vcDataModel:
                                                        widget.vcDataModel,
                                                    vcDocDetailsModel:
                                                        VehicleDocDetailsModel())));
                                  },
                                  child: Card(
                                    semanticContainer: true,
                                    child: Container(
                                      height: 50,
                                      color: MyTheme.buttonColor,
                                      alignment: Alignment.center,
                                      child: Text('Fitness',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VehicleDocumentView(
                                                    requestType: AppConstant
                                                        .docTaxTokenImg,
                                                    vehicleId: widget
                                                        .vcDataModel.id
                                                        .toString(),
                                                    vcDataModel:
                                                        widget.vcDataModel,
                                                    vcDocDetailsModel:
                                                        VehicleDocDetailsModel())));
                                  },
                                  child: Card(
                                    semanticContainer: true,
                                    child: Container(
                                      color: MyTheme.buttonColor,
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: Text('Tax Token',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VehicleDocumentView(
                                                    requestType: AppConstant
                                                        .docRoadPermitImg,
                                                    vehicleId: widget
                                                        .vcDataModel.id
                                                        .toString(),
                                                    vcDataModel:
                                                        widget.vcDataModel,
                                                    vcDocDetailsModel:
                                                        VehicleDocDetailsModel())));
                                  },
                                  child: Card(
                                    semanticContainer: true,
                                    child: Container(
                                      height: 50,
                                      color: MyTheme.buttonColor,
                                      alignment: Alignment.center,
                                      child: Text('Road Permit',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PoliceCaseView(
                                                    title:
                                                        "Police case Clearance",
                                                    vehicleId: "")));
                                  },
                                  child: Card(
                                    semanticContainer: true,
                                    child: Container(
                                      color: MyTheme.buttonColor,
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: Text('Police case Clearance',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VehicleDocumentView(
                                                    requestType: AppConstant
                                                        .docInsuranceImg,
                                                    vehicleId: widget
                                                        .vcDataModel.id
                                                        .toString(),
                                                    vcDataModel:
                                                        widget.vcDataModel,
                                                    vcDocDetailsModel:
                                                        VehicleDocDetailsModel())));
                                  },
                                  child: Card(
                                    semanticContainer: true,
                                    child: Container(
                                      height: 50,
                                      color: MyTheme.buttonColor,
                                      alignment: Alignment.center,
                                      child: Text('Insurance',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddUpdateFuelManagement(
                                                    vcDataModel:
                                                        new FuelListModel(),
                                                    vehicleId: widget
                                                        .vcDataModel.id
                                                        .toString())));
                                  },
                                  child: Card(
                                    semanticContainer: true,
                                    child: Container(
                                      color: MyTheme.buttonColor,
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: Text('Fuel Load',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PoliceCaseDetailsView(
                                                    vcDataModel:
                                                        new PoliceCaseModel(),
                                                    vehicleId: widget
                                                        .vcDataModel.id
                                                        .toString())));
                                  },
                                  child: Card(
                                    semanticContainer: true,
                                    child: Container(
                                      height: 50,
                                      color: MyTheme.buttonColor,
                                      alignment: Alignment.center,
                                      child: Text('Police case',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddServiceView(
                                                  serviceDataModel:
                                                      new ServiceDataModel(),
                                                  vehicleId: widget
                                                      .vcDataModel.id
                                                      .toString(),
                                                )));
                                  },
                                  child: Card(
                                    semanticContainer: true,
                                    child: Container(
                                      color: MyTheme.buttonColor,
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: Text('Vehicle Servicing',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddUpdateAccidentView(
                                                    vcDataModel:
                                                        new AccidentListModel(),
                                                    vehicleId: widget
                                                        .vcDataModel.id
                                                        .toString())));
                                  },
                                  child: Card(
                                    semanticContainer: true,
                                    child: Container(
                                      height: 50,
                                      color: MyTheme.buttonColor,
                                      alignment: Alignment.center,
                                      child: Text('Accident Management',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            /*  Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddUpdateFuelManagement(
                                              vcDataModel: new FuelListModel(),
                                              vehicleId: widget.vcDataModel.id
                                                  .toString())));
                            },
                            child: Card(
                              semanticContainer: true,
                              child: Container(
                                color: MyTheme.buttonColor,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text('Fuel Load',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PoliceCaseDetailsView(
                                              vcDataModel:
                                                  new PoliceCaseModel(),
                                              vehicleId: widget.vcDataModel.id
                                                  .toString())));
                            },
                            child: Card(
                              semanticContainer: true,
                              child: Container(
                                height: 50,
                                color: MyTheme.buttonColor,
                                alignment: Alignment.center,
                                child: Text('Police case',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddServiceView(
                                        serviceDataModel:
                                        new ServiceDataModel(),
                                        vehicleId: widget.vcDataModel.id
                                            .toString(),
                                      )));
                            },
                            child: Card(
                              semanticContainer: true,
                              child: Container(
                                color: MyTheme.buttonColor,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text('Police case Clearance',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddUpdateAccidentView(
                                              vcDataModel:
                                              new AccidentListModel(),
                                              vehicleId: widget.vcDataModel.id
                                                  .toString())));
                            },
                            child: Card(
                              semanticContainer: true,
                              child: Container(
                                height: 50,
                                color: MyTheme.buttonColor,
                                alignment: Alignment.center,
                                child: Text('Another Option',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddServiceView(
                                            serviceDataModel:
                                                new ServiceDataModel(),
                                            vehicleId: widget.vcDataModel.id
                                                .toString(),
                                          )));
                            },
                            child: Card(
                              semanticContainer: true,
                              child: Container(
                                color: MyTheme.buttonColor,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text('Vehicle Servicing',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddUpdateAccidentView(
                                              vcDataModel:
                                                  new AccidentListModel(),
                                              vehicleId: widget.vcDataModel.id
                                                  .toString())));
                            },
                            child: Card(
                              semanticContainer: true,
                              child: Container(
                                height: 50,
                                color: MyTheme.buttonColor,
                                alignment: Alignment.center,
                                child: Text('Accident Management',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )*/
          ]),
        ),
      ),
    );
  }
}
