import 'package:amargari/providers/common_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void uploadFile(String path, String requestFileType, String? name, String? mobileNo, BuildContext context) {
  var getUserData = UserPreferences().getUser();
  CommonProvider commonProvider = Provider.of<CommonProvider>(context);
  snackBar(context, "Start to upload image, please wait");
  print("path:  " + path);
  final Future<String> url = commonProvider.uploadImage(
      name ?? "", mobileNo ?? "", path);
  url.then((value) {
    print("Response output " + value);

    if (requestFileType == "nid") {
      AppConstant.NidURL = value;
    } else if (requestFileType == "drivingLicense") {
      AppConstant.drivingLicenseURL = value;
    } else if (requestFileType == "VehicleImage") {
      AppConstant.vehicleImageURL = value;
    } else if (requestFileType == "AccidentImage") {
      AppConstant.accidentImageURL = value;
    } else if (requestFileType == "InsuranceImgURL") {
      AppConstant.insuranceImgURL = value;
    } else if (requestFileType == "FuelSlipImage") {
      AppConstant.fuelSlipImgURL = value;
    } else if (requestFileType ==  AppConstant.profileImage) {
      AppConstant.profileImage = value;
    }


    snackBar(context, "Successfully upload user Image");
    print("fuelSlipImgURL:  " + AppConstant.fuelSlipImgURL);
  });
}