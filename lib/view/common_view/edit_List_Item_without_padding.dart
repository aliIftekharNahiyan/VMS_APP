
import 'package:amargari/providers/common_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/widgets/image_picker_gallery_camera.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditListItemWithOutPadding extends StatefulWidget {
  EditListItemWithOutPadding(
      {
        required this.text,
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
  TextEditingController nameController;



  // final VoidCallback press;

  @override
  _EditListItemWithOutPaddingState createState() => _EditListItemWithOutPaddingState();
}

class _EditListItemWithOutPaddingState extends State<EditListItemWithOutPadding> {
  var getUserData  = UserPreferences().getUser();
  bool imageUploadRequest = true;

  var _image;
  Future getImage(ImgSource source, String requestType ) async {
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
  imageUpload(BuildContext context, String imagePath){

    CommonProvider commonProvider = Provider.of<CommonProvider>(context);
    var getUserData  = UserPreferences().getUser();

    //  snackBar(context,"Start to upload image, please wait");
    getUserData.then((user) => setState(() {
      print("path:  " + imagePath);
      final Future<String> url = commonProvider.uploadImage(
          user.name ?? "", user.mobileNo ?? "",  imagePath);
      url.then((value){
        print("Response output " + value);
        //   snackBar(context,"Successfully upload user Image");
        print("imageURL:  "+AppConstant.fuelSlipImgURL);
        print("images ${widget.images}");

        if (widget.images == "nid") {
          AppConstant.NidURL = value;
        }else if (widget.images == "drivingLicense") {
          AppConstant.drivingLicenseURL = value;
        }else if (widget.images == "VehicleImage") {
          AppConstant.vehicleImageURL = value;
        }else if (widget.images == AppConstant.accidentImage) {
          AppConstant.accidentImageURL = value;
        }
        else if (widget.images == "InsuranceImgURL") {
          AppConstant.insuranceImgURL = value;
        }  else if (widget.images == AppConstant.fuelSlipImg) {
          AppConstant.fuelSlipImgURL = value;
        }
        else if (widget.images == AppConstant.docInsuranceImg) {
          AppConstant.docInsuranceImgURL = value;
        }else if (widget.images == AppConstant.docTaxTokenImg) {
          AppConstant.docTaxTokenImgURL = value;
        }else if (widget.images == AppConstant.docFitnessImg) {
          AppConstant.docFitnessImgURL = value;
        }else if (widget.images == AppConstant.docRegistrationImg) {
          AppConstant.docRegistrationImgURL = value;
        }else if (widget.images == AppConstant.docRoadPermitImg) {
          AppConstant.docRoadPermitImgURL = value;
        }
        else if (widget.images == AppConstant.policeCaseImageImg) {
          AppConstant.policeCaseImageImgURL = value;
        } else if (widget.images == AppConstant.expenseSlip) {
          AppConstant.expenseSlipURL = value;
        } else if (widget.images == AppConstant.partsImage) {
          AppConstant.partsImageURL = value;
        }
      }
      );
    }
    ));


  }
  @override
  Widget build(BuildContext context) {



    if (_image != null){
      if (imageUploadRequest) {
        imageUploadRequest = false;
        imageUpload(context, _image.path);
      }
    }

    //  DateTime _selectedDate;
    // getUserData.then((user) => setState(()
    // {
    //   uploadFile(_image, widget.images, user.name, user.mobileNo, context);
    // }
    // ));
    // print("fuelSlipImgURL:  "+AppConstant.fuelSlipImgURL);
    //Method for showing the date picker
    void _pickDateDialog() {
      showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          //which date will display when user open the picker
          firstDate: widget.isFutureDate ?   DateTime.now(): DateTime(1950) ,
          //what will be the previous supported year in picker
          lastDate: widget.isFutureDate ?  DateTime(2050): DateTime.now() )

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
      final TimeOfDay? pickedS = await showTimePicker(
          context: context,
          initialTime: selectedTime);

      if (pickedS != null && pickedS != selectedTime )
        setState(() {
          selectedTime = pickedS;
          widget.nameController.text = selectedTime.format(context);
        });
    }
    // Future<void> _pickTimeDialog() async {
    //
    //   final TimeOfDay? _timePicked = await showTimePicker(
    //     context: context,
    //     initialTime: TimeOfDay.now(),
    //   );
    //   if (_timePicked != null) {
    //     // _dt = DateTime(
    //     //   _selectedDate.year,
    //     //   _selectedDate.month,
    //     //   _selectedDate.day,
    //       _timePicked.hour,
    //       _timePicked.minute,
    //     );
    //     setState(() {
    //       eventStartTimeController.text = DateFormat('h:mm a')
    //           .format(_timePicked.hour: _t); //_timePicked.format(context);
    //       eventProvider.changeeventstarttime(_dt);
    //     });
    //   }
    //   // final TimeOfDay _timePicked = showTimePicker(
    //   //     context: context,
    //   //     initialTime: TimeOfDay.now(),
    //   //     //which date will display when user open the picker
    //   //     )
    //   //
    //   // //what will be the up to supported date in picker
    //   //     .then((pickedTime) {
    //   //   //then usually do the future job
    //   //   if (pickedTime == null) {
    //   //     //if user tap cancel then this function will stop
    //   //     return;
    //   //   }
    //   //   setState(() {
    //   //     //String formattedDate = DateFormat('dd-MMM-yyyy').format(pickedTime);
    //   //     //for rebuilding the u
    //   //     widget.nameController.text =
    //   //         DateFormat('h:mm a')
    //   //             .format(pickedTime ? ""); //  _selectedDate = pickedDate;
    //   //   });
    //   // });
    // }
    void _pickYearDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Year"),
            content: Container( // Need to use container to add size constraint.
              width: 300,
              height: 300,
              child: YearPicker(
                firstDate: DateTime(DateTime
                    .now()
                    .year - 100, 1),
                lastDate: DateTime(DateTime
                    .now()
                    .year + 100, 1),
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
                  widget.nameController.text =
                      formattedDate;
                  // Do something with the dateTime selected.
                  // Remember that you need to use dateTime.year to get the year
                },
              ),
            ),
          );
        },
      );
    }
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(children: [Visibility(child: Icon(Icons.star, color: Colors.red, size: 10), visible: widget.isRequired,),
            Visibility(child: SizedBox(width: 10,),visible: !widget.isRequired),]),
        ),
        // Expanded(
        //   flex: 1,
        //   child: Text(widget.text, style: TextStyle(fontSize: 17)),
        // ),
        // SizedBox(width: 1),
        Visibility(
          child: Expanded(
            flex: 1,
            child: widget.isNumber ? TextField(
              controller: widget.nameController,
              enabled: true,
              textInputAction: TextInputAction.next,
              decoration: commonInputDecoration(widget.text, widget.hintText),
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
              // onSaved: (value) => AccountItem.username = value,
              // style: TextStyle(color: Colors.black54),
              onChanged: (value) {
                print("change " + widget.nameController.text);
                setState(() {
                  widget.nameController.text = value;
                });
              },
            ) : TextField(
              controller: widget.nameController,
              enabled: widget.isEditAble,

              textInputAction: TextInputAction.next,
              decoration: commonInputDecoration(widget.text, widget.hintText),
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
              // onSaved: (value) => AccountItem.username = value,
              //  style: TextStyle(color: Colors.black54),
              onChanged: (value) {
                print("change " + widget.nameController.text);
                setState(() {
                  widget.nameController.text = value;
                });
              },
            ),
            // ),
          ),
          visible: !widget.isVisible,
        ),
      ],
    );
  }
}
//
