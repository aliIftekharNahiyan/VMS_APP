import 'dart:io';

import 'package:amargari/providers/common_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/profile/components/ImageLoadWidget.dart';
import 'package:amargari/widgets/image_picker_gallery_camera.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditListItem extends StatefulWidget {
  EditListItem(
      {required this.text,
      this.images = '',
      this.isVisible = false,
      this.isEditAble = true,
      this.isDate = false,
      this.isTime = false,
      this.isFutureDate = false,
      this.isYear = false,
      this.isNumber = false,
      this.isRequired = false,
      this.hintText = '',
      this.multiLine = false,
      this.obscureText = false,
      required this.nameController});

  final String text, images;
  final bool isVisible;
  final bool isEditAble;
  final bool isDate;
  final bool isTime;
  final bool isFutureDate;
  final bool isYear;
  final bool isNumber;
  final bool isRequired;
  final String hintText;
  final bool multiLine;
  final bool obscureText;
  TextEditingController nameController;

  @override
  _EditListItemState createState() => _EditListItemState();
}

class _EditListItemState extends State<EditListItem> {
  var getUserData = UserPreferences().getUser();
  bool imageUploadRequest = true;

  var _image;
  Future getImage(ImgSource source, String requestType) async {
    var image = await ImagePickerGC.pickImage(
        enableCloseButton: true,
        imageQuality: 10,
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
        ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
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

            if (widget.images == "nid") {
              AppConstant.NidURL = value;
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
  void initState() {
    if (widget.nameController.text == "null") {
      widget.nameController.text = "";
    }
    if (widget.isDate) {
      if (widget.nameController.text == "") {
        widget.nameController.text =
            DateFormat('dd-MMM-yyyy').format(DateTime.now());
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.nameController.text == "null") {
      widget.nameController.text = "";
    }
    if (_image != null) {
      if (imageUploadRequest) {
        imageUploadRequest = false;
        imageUpload(context, _image.path);
      }
    }
    void _pickDateDialog() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              //which date will display when user open the picker
              // firstDate: widget.isFutureDate ?   DateTime.now(): DateTime(1950) ,
              firstDate: DateTime(1950),
              //what will be the previous supported year in picker
              lastDate: widget.isFutureDate ? DateTime(2050) : DateTime.now())

          //what will be the up to supported date in picker
          .then((pickedDate) {
        //then usually do the future job
        if (pickedDate == null) {
          //if user tap cancel then this function will stop
          return;
        }
        setState(() {
          String formattedDate = DateFormat('dd-MMM-yyyy').format(pickedDate);
          //for rebuilding the u
          widget.nameController.text =
              formattedDate; //  _selectedDate = pickedDate;
        });
      });
    }

    TimeOfDay selectedTime = TimeOfDay.now();

    Future<void> _pickTimeDialog(BuildContext context) async {
      final TimeOfDay? picked_s =
          await showTimePicker(context: context, initialTime: selectedTime);

      if (picked_s != null && picked_s != selectedTime)
        setState(() {
          selectedTime = picked_s;
          widget.nameController.text = selectedTime.format(context);
        });
    }

    void _pickYearDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Year"),
            content: Container(
              // Need to use container to add size constraint.
              width: 300,
              height: 300,
              child: YearPicker(
                firstDate: DateTime(DateTime.now().year - 100, 1),
                lastDate: DateTime(DateTime.now().year + 100, 1),
                initialDate: DateTime.now(),
                // save the selected date to _selectedDate DateTime variable.
                // It's used to set the previous selected date when
                // re-showing the dialog.
                selectedDate: DateTime.now(),
                onChanged: (DateTime dateTime) {
                  // close the dialog when year is selected.
                  Navigator.pop(context);
                  String formattedDate = DateFormat('yyyy').format(dateTime);
                  //for rebuilding the u
                  widget.nameController.text = formattedDate;
                  // Do something with the dateTime selected.
                  // Remember that you need to use dateTime.year to get the year
                },
              ),
            ),
          );
        },
      );
    }

    ;
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
          Visibility(
            child: Expanded(
              flex: 1,
              child: widget.isNumber
                  ? TextField(
                      controller: widget.nameController,
                      enabled: true,
                      obscureText: widget.obscureText,
                      textInputAction: TextInputAction.next,
                      decoration:
                          commonInputDecoration(widget.text, widget.hintText),
                      keyboardType: TextInputType.number,
                      onTap: () {
                        print('Editing stated $widget');

                        if (widget.isDate) {
                          _pickDateDialog();
                        }
                        if (widget.isYear) {
                          _pickYearDialog();
                        }
                        if (widget.isTime) {
                          _pickTimeDialog(context);
                        }
                      },
                      onChanged: (value) {
                        print("change " + widget.nameController.text);
                        setState(() {
                          widget.nameController.text = value;
                        });
                      },
                    )
                  : TextField(
                      controller: widget.nameController,
                      enabled: widget.isEditAble,
                      textInputAction: TextInputAction.next,
                      maxLines: widget.multiLine ? 5 : 1,
                      minLines: widget.multiLine ? 2 : 1,
                      obscureText: widget.obscureText,
                      decoration:
                          commonInputDecoration(widget.text, widget.hintText),
                      onTap: () {
                        if (widget.isDate) {
                          _pickDateDialog();
                        }
                        if (widget.isYear) {
                          _pickYearDialog();
                        }
                        if (widget.isTime) {
                          _pickTimeDialog(context);
                        }
                      },
                      onChanged: (value) {
                        print("change " + widget.nameController.text);
                        setState(() {
                          widget.nameController.text = value;
                        });
                      },
                    ),
            ),
            visible: !widget.isVisible,
          ),
          Visibility(
            child: InkWell(
                onTap: () {
                  imageUploadRequest = true;
                  getImage(ImgSource.Both, widget.images);
                },
                child: _image != null
                    ? Image.file(
                        File(_image.path),
                        height: 100,
                        width: 100,
                      )
                    : ImageLoadWidget(requestType: widget.images)),
            visible: widget.isVisible,
          ),
        ],
      ),
    );
  }
}
//
