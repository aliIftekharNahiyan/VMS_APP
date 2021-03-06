import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:amargari/providers/common_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/profile/components/ImageLoadWidget.dart';
import 'package:amargari/widgets/ImageFullScreen.dart';
import 'package:amargari/widgets/image_picker_gallery_camera.dart';
import 'package:amargari/widgets/themes.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';

class ImageUploadViewItem extends StatefulWidget {
  ImageUploadViewItem(
      {required this.text,
      this.images = '',
      this.isVisible = false,
      this.isRequired = false,
      this.isDownloadAble = false,
      this.hintText = '',
      required this.nameController,
      this.isEditable = true});

  final String text, images;
  final bool isVisible;
  final bool isRequired;
  final bool isDownloadAble;
  final String hintText;
  final isEditable;
  TextEditingController nameController;

  // final VoidCallback press;

  @override
  _ImageUploadViewItemState createState() => _ImageUploadViewItemState();
}

class _ImageUploadViewItemState extends State<ImageUploadViewItem> {
  var getUserData = UserPreferences().getUser();
  bool imageUploadRequest = true;

  var _image;

  Future getImage(ImgSource source, String requestType) async {
    var image = await ImagePickerGC.pickImage(
        enableCloseButton: true,
        imageQuality: 5,
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

  Future downloadImage(String img) async {
    // print("Download Image::::::: ${imagePath}");
    var rng = Random();
    String imagePath = "";
    if (img == "nid") {
      imagePath = AppConstant.NidURL;
    } else if (img == "bc1") {
      imagePath = AppConstant.BC_URL1;
    } else if (img == "bc2") {
      imagePath = AppConstant.BC_URL2;
    } else if (img == "cc1") {
      imagePath = AppConstant.CC_URL1;
    } else if (img == "cc2") {
      imagePath = AppConstant.CC_URL2;
    } else if (img == "driverImage") {
      imagePath = AppConstant.DP_URL;
    } else if (img == "bioData") {
      imagePath = AppConstant.BD_URL2;
    } else if (img == "drivingLicense") {
      imagePath = AppConstant.drivingLicenseURL;
    }
    try {
      if (imagePath == "") {
        snackBar2(context, "Image Not Found", success: false);
        return;
      }
      var response = await Dio()
          .get(imagePath, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 100,
          name: "image ${rng.nextInt(9999999)}");
      print(result);
      if (result['isSuccess']) {
        snackBar2(context, "Successfully Saved", success: true);
      } else {
        snackBar2(context, "Check Your Internet Connection & Try Again",
            success: false);
      }
    } catch (ex) {
      snackBar2(context, "Check Your Internet Connection & Try Again",
          success: false);
    }
  }

  imageUpload(BuildContext context, String imagePath) {
    CommonProvider commonProvider = Provider.of<CommonProvider>(context);
    var getUserData = UserPreferences().getUser();

    //  snackBar(context,"Start to upload image, please wait");
    getUserData.then((user) => setState(() {
          print("path:  " + imagePath);
          final Future<String> url = commonProvider.uploadImage(
              user.name ?? "", user.mobileNo ?? "", imagePath);
          url.then((value) {
            print("Response output " + value);
            //   snackBar(context,"Successfully upload user Image");
            print("imageURL:  " + AppConstant.fuelSlipImgURL);
            print("images ${widget.images}");

            if (widget.images == "expenseImage") {
              AppConstant.expenseImageURL = value;
            } else if (widget.images == "nid") {
              AppConstant.NidURL = value;
            } else if (widget.images == "bc1") {
              AppConstant.BC_URL1 = value;
            } else if (widget.images == "bc2") {
              AppConstant.BC_URL2 = value;
            } else if (widget.images == "cc1") {
              AppConstant.CC_URL1 = value;
            } else if (widget.images == "cc2") {
              AppConstant.CC_URL2 = value;
            } else if (widget.images == "driverImage") {
              AppConstant.DP_URL = value;
            } else if (widget.images == "bioData") {
              AppConstant.BD_URL2 = value;
            } else if (widget.images == "drivingLicense") {
              AppConstant.drivingLicenseURL = value;
            } else if (widget.images == "VehicleImage") {
              AppConstant.vehicleImageURL = value;
            } else if (widget.images == AppConstant.accidentImage) {
              AppConstant.accidentImageURL = value;
            } else if (widget.images == "InsuranceImgURL") {
              AppConstant.insuranceImgURL = value;
            } else if (widget.images == AppConstant.fuelSlipImg) {
              AppConstant.fuelSlipImgURL = value;
            } else if (widget.images == AppConstant.docInsuranceImg) {
              AppConstant.docInsuranceImgURL = value;
            } else if (widget.images == AppConstant.docTaxTokenImg) {
              AppConstant.docTaxTokenImgURL = value;
            } else if (widget.images == AppConstant.docFitnessImg) {
              AppConstant.docFitnessImgURL = value;
            } else if (widget.images == AppConstant.docRegistrationImg) {
              AppConstant.docRegistrationImgURL = value;
            } else if (widget.images == AppConstant.docRoadPermitImg) {
              AppConstant.docRoadPermitImgURL = value;
            } else if (widget.images == AppConstant.policeCaseImageImg) {
              AppConstant.policeCaseImageImgURL = value;
            } else if (widget.images == AppConstant.expenseSlip) {
              AppConstant.expenseSlipURL = value;
            } else if (widget.images == AppConstant.partsImage) {
              AppConstant.partsImageURL = value;
            }
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (_image != null) {
      if (imageUploadRequest) {
        imageUploadRequest = false;
        imageUpload(context, _image.path);
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(children: [
              Visibility(
                child: Icon(Icons.star, color: Colors.red, size: 10),
                visible: widget.isRequired,
              ),
              Visibility(
                  child: SizedBox(
                    width: 10,
                  ),
                  visible: !widget.isRequired),
            ]),
          ),
          Expanded(
            child: InputDecorator(
              decoration: InputDecoration(
                  labelText: widget.text,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  labelStyle: TextStyle(color: MyTheme.titleHintColor),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              child: Row(children: [
                Expanded(
                  flex: 3,
                  child: _image != null
                      ? InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImageFullScreen(
                                        imageURL: _image.path)));
                          },
                          child: Image.file(
                            File(_image.path),
                            height: 50,
                            width: 50,
                          ),
                        )
                      : ImageLoadWidget(requestType: widget.images),
                ),
                Expanded(
                  flex: 7,
                  child: InkWell(
                    onTap: () {
                      if (widget.isDownloadAble) {
                        downloadImage(widget.images);
                      }
                      if (widget.isEditable) {
                        imageUploadRequest = true;
                        getImage(ImgSource.Both, widget.images);
                      }
                    },
                    child: Column(children: [
                      !widget.isDownloadAble
                          ? ImageIcon(
                              AssetImage("assets/icons/upload_cloud.png"))
                          : ImageIcon(
                              AssetImage("assets/icons/computing-cloud.png")),
                      !widget.isDownloadAble
                          ? label("Upload Image")
                          : label("Download Image")
                    ]),
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
//
