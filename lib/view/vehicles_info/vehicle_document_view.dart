import 'package:amargari/model/vehicle_doc_details.dart';
import 'package:amargari/model/vehicleinfo/vehicle_info_model.dart';
import 'package:amargari/providers/VehicleDocumentInfoProvider.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/utility.dart';
import 'package:amargari/view/common_view/edit_List_Item.dart';
import 'package:amargari/view/common_view/image_upload_view_item.dart';
import 'package:amargari/view/vehicles_info/vehicle_list_item.dart';
import 'package:amargari/widgets/ImageFullScreen.dart';
import 'package:amargari/widgets/TextEditingControllerWithEndCursor.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/user_model.dart';
import '../../uril/shared_preference.dart';

class VehicleDocumentView extends StatefulWidget {
  VehicleDocumentView(
      {required this.requestType,
      required this.vehicleId,
      required this.vcDataModel,
      required this.vcDocDetailsModel});

  final String requestType;
  final String vehicleId;
  final VehicleInfoDataModel vcDataModel;
  final VehicleDocDetailsModel vcDocDetailsModel;

  @override
  _VehicleDocumentViewState createState() => _VehicleDocumentViewState();
}

class _VehicleDocumentViewState extends State<VehicleDocumentView> {
  var regDate = new TextEditingControllerWithEndCursor(text: '');
  var expiryDate = new TextEditingControllerWithEndCursor(text: '');
  var regNumber = new TextEditingControllerWithEndCursor(text: '');
  var feesAmount = new TextEditingControllerWithEndCursor(text: '');
  var otherExpense = new TextEditingControllerWithEndCursor(text: '');
  var uploadImage = new TextEditingControllerWithEndCursor(text: '');
  Future<dynamic>? policeCaseList;
  String driverId = "";
  Future<dynamic>? vehicleDoc;
  Future<List<VehicleDocDetailsModel>>? vehicleList;
  var isVisible = true;

  @override
  void initState() {
    super.initState();
    uploadImage.text = widget.requestType;
    AppConstant.docRegistrationImgURL = "";
    AppConstant.docFitnessImgURL = "";
    AppConstant.docInsuranceImgURL = "";
    AppConstant.docTaxTokenImgURL = "";
    AppConstant.docRoadPermitImgURL = "";

    if (widget.vcDocDetailsModel.id != null) {
      regDate.text = convertDate2(widget.vcDocDetailsModel.regdate.toString());
      regNumber.text = widget.vcDocDetailsModel.registrationNumber.toString();
      expiryDate.text =
          convertDate2(widget.vcDocDetailsModel.expiryDate.toString());
      feesAmount.text = widget.vcDocDetailsModel.feesAmount.toString();
      otherExpense.text = widget.vcDocDetailsModel.otherExpense.toString();
      uploadImage.text = widget.vcDocDetailsModel.insuranceImg.toString();
      if (widget.requestType == AppConstant.docRegistrationImg) {
        AppConstant.docRegistrationImgURL =
            widget.vcDocDetailsModel.insuranceImg.toString();
      } else if (widget.requestType == AppConstant.docFitnessImg) {
        AppConstant.docFitnessImgURL =
            widget.vcDocDetailsModel.insuranceImg.toString();
      } else if (widget.requestType == AppConstant.docInsuranceImg) {
        AppConstant.docInsuranceImgURL =
            widget.vcDocDetailsModel.insuranceImg.toString();
      } else if (widget.requestType == AppConstant.docTaxTokenImg) {
        AppConstant.docTaxTokenImgURL =
            widget.vcDocDetailsModel.insuranceImg.toString();
      } else if (widget.requestType == AppConstant.docRoadPermitImg) {
        AppConstant.docRoadPermitImgURL =
            widget.vcDocDetailsModel.insuranceImg.toString();
      }
    }

    new Future.delayed(new Duration(seconds: 3), () {
      setState(() {
        isVisible = false;
      });
    });
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) => {
      if(widget.requestType == AppConstant.docRegistrationImg) {
        vehicleList =
            VehicleDocumentInfoProvider().fetchDocumentHistory(widget.vehicleId, "4","")
      }else if(widget.requestType == AppConstant.docFitnessImg) {
        vehicleList =
            VehicleDocumentInfoProvider().fetchDocumentHistory(widget.vehicleId, "3","")
      }else if(widget.requestType == AppConstant.docInsuranceImg) {
        vehicleList =
            VehicleDocumentInfoProvider().fetchDocumentHistory(widget.vehicleId, "1","")
      }else if(widget.requestType == AppConstant.docTaxTokenImg) {
        vehicleList =
            VehicleDocumentInfoProvider().fetchDocumentHistory(widget.vehicleId, "2","")
      }else if(widget.requestType == AppConstant.docRoadPermitImg) {
        vehicleList =
            VehicleDocumentInfoProvider().fetchDocumentHistory(widget.vehicleId, "5","")
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    var viewVehicleInfo = (VehicleDocDetailsModel vehicleInfoDataModel) {

    };
    VehicleDocumentInfoProvider vehicleDocumentInfoProvider =
        Provider.of<VehicleDocumentInfoProvider>(context);
    doUpdate() {
      print(
          "document ${widget.requestType}  ${AppConstant.docRegistrationImg} ${feesAmount.text}  ${expiryDate.text}   ${regDate.text}");

      if (widget.vehicleId != "" &&
          feesAmount.text != "" &&
          regDate.text != "") {
        if (widget.vcDocDetailsModel.id != null) {
          if (widget.requestType == AppConstant.docRegistrationImg) {
            vehicleDoc = vehicleDocumentInfoProvider.vehicleDocumentUpdate(
                widget.vcDocDetailsModel.id.toString(),
                widget.vehicleId,
                feesAmount.text,
                AppConstant.docRegistrationImgURL,
                "4",
                expiryDate.text,
                regDate.text,  otherExpense.text,
                feesAmount.text,
                 regNumber.text);
            widget.vcDataModel.registrationDate = convertDate4(regDate.text);
            widget.vcDataModel.registrationExpireDate =
                convertDate4(expiryDate.text);
          } else if (widget.requestType == AppConstant.docFitnessImg) {
            vehicleDoc = vehicleDocumentInfoProvider.vehicleDocumentUpdate(
                widget.vcDocDetailsModel.id.toString(),
                widget.vehicleId,
                feesAmount.text,
                AppConstant.docFitnessImgURL,
                "3",
                expiryDate.text,
                regDate.text,
                otherExpense.text,
                feesAmount.text,
                regNumber.text);
            widget.vcDataModel.fitnessExpireDate =
                convertDate4(expiryDate.text);
          } else if (widget.requestType == AppConstant.docInsuranceImg) {
            vehicleDoc = vehicleDocumentInfoProvider.vehicleDocumentUpdate(
                widget.vcDocDetailsModel.id.toString(),
                widget.vehicleId,
                feesAmount.text,
                AppConstant.docInsuranceImgURL,
                "1",
                expiryDate.text,
                regDate.text,
                otherExpense.text,
                feesAmount.text,
                regNumber.text);
            widget.vcDataModel.insuranceExpireDate =
                convertDate4(expiryDate.text);
          } else if (widget.requestType == AppConstant.docTaxTokenImg) {
            vehicleDoc = vehicleDocumentInfoProvider.vehicleDocumentUpdate(
                widget.vcDocDetailsModel.id.toString(),
                widget.vehicleId,
                feesAmount.text,
                AppConstant.docTaxTokenImgURL,
                "2",
                expiryDate.text,
                regDate.text,
                otherExpense.text,
                feesAmount.text,
                regNumber.text);
            widget.vcDataModel.taxTokenExpireDate =
                convertDate4(expiryDate.text);
          } else if (widget.requestType == AppConstant.docRoadPermitImg) {
            vehicleDoc = vehicleDocumentInfoProvider.vehicleDocumentUpdate(
                widget.vcDocDetailsModel.id.toString(),
                widget.vehicleId,
                feesAmount.text,
                AppConstant.docRoadPermitImgURL,
                "5",
                expiryDate.text,
                regDate.text,
                otherExpense.text,
                feesAmount.text,
                regNumber.text);
            widget.vcDataModel.routePermitExpireDate =
                convertDate4(expiryDate.text);
          }
          ;

          vehicleDoc?.whenComplete(() => {
                setState(() { }),
                snackBar(context, "Document save successfully"),

          regDate.text = "",
              regNumber.text = "",
          expiryDate.text = '',
          feesAmount.text = '',
          otherExpense.text = '',
          uploadImage.text = '',

               /* Navigator.pop(context),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VehicleDocumentDetailsView(
                            requestType: widget.requestType,
                            vehicleId: widget.vcDataModel.id.toString(),
                            vcDataModel: widget.vcDataModel)))*/
              });
        } else {
          if (widget.requestType == AppConstant.docRegistrationImg) {
            vehicleDoc = vehicleDocumentInfoProvider.vehicleDocumentUpdate(
                "",
                widget.vehicleId,
                feesAmount.text,
                AppConstant.docRegistrationImgURL,
                "4",
                expiryDate.text,
                regDate.text,
                otherExpense.text,
                feesAmount.text,
                regNumber.text);
            widget.vcDataModel.registrationDate = convertDate3(regDate.text);
            widget.vcDataModel.registrationExpireDate =
                convertDate3(expiryDate.text);
          } else if (widget.requestType == AppConstant.docFitnessImg) {
            vehicleDoc = vehicleDocumentInfoProvider.vehicleDocumentUpdate(
                "",
                widget.vehicleId,
                feesAmount.text,
                AppConstant.docFitnessImgURL,
                "3",
                expiryDate.text,
                regDate.text,
                otherExpense.text,
                feesAmount.text,
                regNumber.text);
            widget.vcDataModel.fitnessExpireDate =
                convertDate3(expiryDate.text);
          } else if (widget.requestType == AppConstant.docInsuranceImg) {
            vehicleDoc = vehicleDocumentInfoProvider.vehicleDocumentUpdate(
                "",
                widget.vehicleId,
                feesAmount.text,
                AppConstant.docInsuranceImgURL,
                "1",
                expiryDate.text,
                regDate.text,
                otherExpense.text,
                feesAmount.text,
                regNumber.text);
            widget.vcDataModel.insuranceExpireDate =
                convertDate3(expiryDate.text);
          } else if (widget.requestType == AppConstant.docTaxTokenImg) {
            vehicleDoc = vehicleDocumentInfoProvider.vehicleDocumentUpdate(
                "",
                widget.vehicleId,
                feesAmount.text,
                AppConstant.docTaxTokenImgURL,
                "2",
                expiryDate.text,
                regDate.text,
                otherExpense.text,
                feesAmount.text,
                regNumber.text);
            widget.vcDataModel.taxTokenExpireDate =
                convertDate3(expiryDate.text);
          } else if (widget.requestType == AppConstant.docRoadPermitImg) {
            vehicleDoc = vehicleDocumentInfoProvider.vehicleDocumentUpdate(
                "",
                widget.vehicleId,
                feesAmount.text,
                AppConstant.docRoadPermitImgURL,
                "5",
                expiryDate.text,
                regDate.text,
                otherExpense.text,
                feesAmount.text,
                regNumber.text);
            widget.vcDataModel.routePermitExpireDate =
                convertDate3(expiryDate.text);
          }
          ;

          vehicleDoc?.whenComplete(() => {
            setState(() { }),
            snackBar(context, "Document save successfully"),

            regDate.text = "",
            regNumber.text = "",
            expiryDate.text = '',
            feesAmount.text = '',
            otherExpense.text = '',
            uploadImage.text = '',


        // Navigator.pop(context),
        /*  Navigator.push(
                context,
                MaterialPageRoute(Fees Amount
                    builder: (context) => VehicleDocumentDetailsView(
                        requestType: widget.requestType,
                        vehicleId: widget.vcDataModel.id.toString(),
                        vcDataModel: widget.vcDataModel)))*/

          });
        }
      } else {
        print("calling");
        snackBar2(context, "Please select mandatory filed ");
      }
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.requestType),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Consumer<ServiceProvider>(builder: (context, services, child) {
          return Column(
            children: [
              SizedBox(height: 20),
              EditListItem(
                text: 'Reg Date',
                nameController: regDate,
                isDate: true,
                isRequired: true,
                hintText: 'Click to select date',
              ),
              SizedBox(height: 10),

              EditListItem(
                text: 'Registration number',
                nameController: regNumber,
                isNumber: true,
                isRequired: true,
                hintText: 'Type registration number',
              ),
              SizedBox(height: 10),
          if (widget.requestType != AppConstant.docRegistrationImg) ...[
             EditListItem(
                  text: 'Expiry Date',
                  nameController: expiryDate,
                  isDate: true,
                  isFutureDate: true,
                  isRequired: true,
                  hintText: 'Click to select date'),
              ],
              SizedBox(height: 10),
              EditListItem(
                  text: 'Fees Amount',
                  nameController: feesAmount,
                  isNumber: true,
                  isRequired: true,
                  hintText: 'Type amount'),
              SizedBox(height: 10),

              EditListItem(
                  text: 'Other Expense',
                  nameController: otherExpense,
                  isNumber: true,
                  isRequired: true,
                  hintText: 'Type other expense'),
              SizedBox(height: 10),

              ImageUploadViewItem(
                  text: 'Upload Image',
                  nameController: uploadImage,
                  isVisible: true,
                  images: widget.requestType),
              //ImageUploadViewItem(text: 'Upload Image:', nameController: uploadImage, isVisible: true, images: uploadImage.text),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     
                      SizedBox(width: 20),
                      MaterialButton(
                        onPressed: () {
                          doUpdate();
                        },
                        child: Text(
                          "SAVE",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.orange,
                      )
                    ]),
              ),

              FutureBuilder<List<VehicleDocDetailsModel>>(
                future: vehicleList,
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.done) {

                    return snapshot.data!.isEmpty
                        ? Center(child: Text('Not found any information '))
                        : Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          VehicleDocDetailsModel vehicleInfoDataModel =
                          snapshot.data![index];

                          int totalCost = int.parse(vehicleInfoDataModel.feesAmount ?? "0") + int.parse(vehicleInfoDataModel.otherExpense ?? "0");
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                            child: Card(
                              child: new InkResponse(
                                onTap: () {
                                  print(index);
                                  viewVehicleInfo(vehicleInfoDataModel);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children:[
                                      Expanded(
                                          flex: 3,
                                          child: InkWell(
                                            onTap: (){
                                              
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ImageFullScreen(imageURL: vehicleInfoDataModel.insuranceImg ?? "",)));

                                            },
                                            child: vehicleInfoDataModel.insuranceImg == "" ? 
                                              Image.asset("assets/icons/edit_image.png", color: Colors.black,) :
                                             CachedNetworkImage(
                                              imageUrl: vehicleInfoDataModel.insuranceImg ?? "",
                                              placeholder: (context, url) => CircularProgressIndicator(),
                                              errorWidget: (context, url, error) =>  ImageIcon(AssetImage("assets/icons/edit_image.png")),
                                              height: 100,
                                            ),
                                          )
                                      ),
                                      Expanded(
                                          flex: 7,
                                          child:InkWell(
                                            onTap: (){
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          VehicleDocumentView(
                                                              requestType: widget.requestType,
                                                              vehicleId: widget
                                                                  .vcDataModel.id
                                                                  .toString(),
                                                              vcDataModel:
                                                              widget.vcDataModel,
                                                              vcDocDetailsModel: vehicleInfoDataModel
                                                          )));
                                            },
                                            child: Column(children: <Widget>[
                                              VehicleListItem(
                                                  textTitle: 'Reg date:',
                                                  text: convertDate2(vehicleInfoDataModel.regdate ?? "")),
                                              VehicleListItem(
                                                  textTitle: 'Reg Number:',
                                                  text: vehicleInfoDataModel.registrationNumber ?? ""),
                                              VehicleListItem(
                                                  textTitle: 'Fees Amount:',
                                                  text: vehicleInfoDataModel.feesAmount ?? ""),
                                              VehicleListItem(
                                                  textTitle: 'Others Expense:',
                                                  text: vehicleInfoDataModel.otherExpense ?? ""),
                                              VehicleListItem(
                                                  textTitle: 'Total Cost:',
                                                  text: totalCost.toString())
                                            ]),
                                          )
                                      ),


                                      /*Column(children: <Widget>[
                                      VehicleListItem(
                                          textTitle: 'Brand Name:',
                                          text: vehicleInfoDataModel.brandName),
                                      VehicleListItem(
                                          textTitle: 'Model Name:',
                                          text: vehicleInfoDataModel.modelName),
                                    ]),*/
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }

                  // By default, show a loading spinner.
                },
              ),
            ],
          );
        }),
      ),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
