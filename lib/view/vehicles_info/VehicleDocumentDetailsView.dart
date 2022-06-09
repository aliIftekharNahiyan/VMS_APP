import 'dart:core';

import 'package:amargari/model/user_model.dart';
import 'package:amargari/model/vehicle_doc_details.dart';
import 'package:amargari/model/vehicleinfo/vehicle_info_model.dart';
import 'package:amargari/providers/VehicleDocumentInfoProvider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/uril/utility.dart';
import 'package:amargari/view/vehicles_info/vehicle_document_view.dart';
import 'package:amargari/view/vehicles_info/vehicle_list_item.dart';
import 'package:amargari/widgets/ImageFullScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VehicleDocumentDetailsView extends StatefulWidget {
  final String vehicleId;
  final String requestType;
  final VehicleInfoDataModel vcDataModel;
  // In the constructor, require a Todo.
  VehicleDocumentDetailsView(
      {required this.vehicleId,
      required this.requestType,
      required this.vcDataModel});

  @override
  _VehicleDocumentDetailsViewState createState() =>
      _VehicleDocumentDetailsViewState();
}

class _VehicleDocumentDetailsViewState
    extends State<VehicleDocumentDetailsView> {
  Future<List<VehicleDocDetailsModel>>? vehicleList;
  var isVisible = true;

  @override
  void initState() {
    super.initState();

    new Future.delayed(new Duration(seconds: 3), () {
      setState(() {
        isVisible = false;
      });
    });
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) => {
          if (widget.requestType == AppConstant.docRegistrationImg)
            {
              vehicleList = VehicleDocumentInfoProvider()
                  .fetchDocumentHistory(widget.vehicleId, "4", "")
            }
          else if (widget.requestType == AppConstant.docFitnessImg)
            {
              vehicleList = VehicleDocumentInfoProvider()
                  .fetchDocumentHistory(widget.vehicleId, "3", "")
            }
          else if (widget.requestType == AppConstant.docInsuranceImg)
            {
              vehicleList = VehicleDocumentInfoProvider()
                  .fetchDocumentHistory(widget.vehicleId, "1", "")
            }
          else if (widget.requestType == AppConstant.docTaxTokenImg)
            {
              vehicleList = VehicleDocumentInfoProvider()
                  .fetchDocumentHistory(widget.vehicleId, "2", "")
            }
          else if (widget.requestType == AppConstant.docRoadPermitImg)
            {
              vehicleList = VehicleDocumentInfoProvider()
                  .fetchDocumentHistory(widget.vehicleId, "5", "")
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    var viewVehicleInfo = (VehicleDocDetailsModel vehicleInfoDataModel) {};

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(widget.requestType),
      ),
      body: FutureBuilder<List<VehicleDocDetailsModel>>(
        future: vehicleList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data!.isEmpty
                ? Center(child: Text('Empty'))
                : Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        VehicleDocDetailsModel vehicleInfoDataModel =
                            snapshot.data![index];
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
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: InkWell(
                                          onTap: () {
                                            // Navigator.push(context, MaterialPageRoute(builder: (_) {
                                            //   return ImageFullScreen(imageURL: vehicleInfoDataModel.insuranceImg ?? "",);
                                            // }));
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ImageFullScreen(
                                                          imageURL:
                                                              vehicleInfoDataModel
                                                                      .insuranceImg ??
                                                                  "",
                                                        )));
                                          },
                                          child: CachedNetworkImage(
                                            imageUrl: vehicleInfoDataModel
                                                    .insuranceImg ??
                                                "",
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget: (context, url,
                                                    error) =>
                                                ImageIcon(AssetImage(
                                                    "assets/icons/edit_image.png")),
                                            height: 100,
                                          ),
                                        )),
                                    // networkCachedImageLoad(
                                    //     vehicleInfoDataModel.vechileImage ?? ""),

                                    Expanded(
                                        flex: 7,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        VehicleDocumentView(
                                                            requestType: widget
                                                                .requestType,
                                                            vehicleId: widget
                                                                .vcDataModel.id
                                                                .toString(),
                                                            vcDataModel: widget
                                                                .vcDataModel,
                                                            vcDocDetailsModel:
                                                                vehicleInfoDataModel)));
                                          },
                                          child: Column(children: <Widget>[
                                            VehicleListItem(
                                                textTitle: 'Document Name:',
                                                text: vehicleInfoDataModel
                                                        .documentName ??
                                                    ""),
                                            VehicleListItem(
                                                textTitle: 'Expire Date:',
                                                text: convertDate2(
                                                    vehicleInfoDataModel
                                                            .expiryDate ??
                                                        "")),
                                            VehicleListItem(
                                                textTitle: 'Amount:',
                                                text: vehicleInfoDataModel
                                                        .coverageDetails ??
                                                    "")
                                          ]),
                                        )),

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
    );
  }
}
