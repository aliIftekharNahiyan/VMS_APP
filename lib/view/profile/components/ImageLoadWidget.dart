import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/widgets/ImageFullScreen.dart';
import 'package:flutter/material.dart';

class ImageLoadWidget extends StatelessWidget {
  final String requestType;
  ImageLoadWidget({required this.requestType});

  @override
  Widget build(BuildContext context) {
    var imageFullScreen = (String imageUrl) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ImageFullScreen(imageURL: imageUrl)));
    };
    if (requestType == "expenseImage") {
      return InkWell(
        onTap: () {
          imageFullScreen(AppConstant.NidURL);
        },
        child: AppConstant.expenseImageURL == "" || AppConstant.expenseImageURL == "null"
            ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
            : Image.network(
                AppConstant.expenseImageURL,
                fit: BoxFit.cover,
                height: 50,
                width: 50,
              ),
      );
    } else if (requestType == "nid") {
      return InkWell(
        onTap: () {
          imageFullScreen(AppConstant.NidURL);
        },
        child: AppConstant.NidURL == "" ||  AppConstant.NidURL == "null"
            ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
            : Image.network(
                AppConstant.NidURL,
                fit: BoxFit.cover,
                height: 50,
                width: 50,
              ),
      );
    } else if (requestType == "bc1") {
      return InkWell(
        onTap: () {
          imageFullScreen(AppConstant.BC_URL1);
        },
        child: AppConstant.BC_URL1 == "" || AppConstant.BC_URL1 == "null"
            ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
            : Image.network(
                AppConstant.BC_URL1,
                fit: BoxFit.cover,
                height: 50,
                width: 50,
              ),
      );
    } else if (requestType == "bc2") {
      return InkWell(
        onTap: () {
          imageFullScreen(AppConstant.BC_URL2);
        },
        child: AppConstant.BC_URL2 == "" || AppConstant.BC_URL2 == "null"
            ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
            : Image.network(
                AppConstant.BC_URL2,
                fit: BoxFit.cover,
                height: 50,
                width: 50,
              ),
      );
    } else if (requestType == "cc1") {
      return InkWell(
        onTap: () {
          imageFullScreen(AppConstant.CC_URL1);
        },
        child: AppConstant.CC_URL1 == "" || AppConstant.CC_URL1 == "null"
            ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
            : Image.network(
                AppConstant.CC_URL1,
                fit: BoxFit.cover,
                height: 50,
                width: 50,
              ),
      );
    } else if (requestType == "cc2") {
      return InkWell(
        onTap: () {
          imageFullScreen(AppConstant.CC_URL2);
        },
        child: AppConstant.CC_URL2 == "" || AppConstant.CC_URL2 == "null"
            ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
            : Image.network(
                AppConstant.CC_URL2,
                fit: BoxFit.cover,
                height: 50,
                width: 50,
              ),
      );
    } else if (requestType == "driverImage") {
      return InkWell(
        onTap: () {
          imageFullScreen(AppConstant.DP_URL);
        },
        child: AppConstant.DP_URL == "" || AppConstant.DP_URL == "null"
            ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
            : Image.network(
                AppConstant.DP_URL,
                fit: BoxFit.cover,
                height: 50,
                width: 50,
              ),
      );
    } else if (requestType == "bioData") {
      return InkWell(
        onTap: () {
          imageFullScreen(AppConstant.BD_URL2);
        },
        child: AppConstant.BD_URL2 == "" || AppConstant.BD_URL2 == "null"
            ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
            : Image.network(
                AppConstant.BD_URL2,
                fit: BoxFit.cover,
                height: 50,
                width: 50,
              ),
      );
    } else if (requestType == "drivingLicense") {
      return InkWell(
        onTap: () {
          imageFullScreen(AppConstant.drivingLicenseURL);
        },
        child: AppConstant.drivingLicenseURL == "" || AppConstant.drivingLicenseURL == "null"
            ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
            : Image.network(
                AppConstant.drivingLicenseURL,
                fit: BoxFit.cover,
                height: 50,
                width: 50,
              ),
      );
    } else if (requestType == "VehicleImage") {
      return InkWell(
        onTap: () {
          imageFullScreen(AppConstant.vehicleImageURL);
        },
        child: AppConstant.vehicleImageURL == "" || AppConstant.vehicleImageURL == "null"
            ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
            : Image.network(
                AppConstant.vehicleImageURL,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
      );
    } else if (requestType == AppConstant.expenseSlip) {
      return InkWell(
        onTap: () {
          imageFullScreen(AppConstant.expenseSlipURL);
        },
        child: AppConstant.expenseSlipURL == "" || AppConstant.expenseSlipURL == "null"
            ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
            : Image.network(
                AppConstant.expenseSlipURL,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
      );
    } else if (requestType == AppConstant.partsImage) {
      return InkWell(
        onTap: () {
          imageFullScreen(AppConstant.partsImageURL);
        },
        child: AppConstant.partsImageURL == "" || AppConstant.partsImageURL == "null"
            ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
            : Image.network(
                AppConstant.partsImageURL,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
      );
    } else if (requestType == AppConstant.accidentImage) {
      return InkWell(
        onTap: () {
          imageFullScreen(AppConstant.accidentImageURL);
        },
        child: AppConstant.accidentImageURL == "" || AppConstant.accidentImageURL == "null"
            ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
            : Image.network(
                AppConstant.accidentImageURL,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
      );
    } else if (requestType == AppConstant.fuelSlipImg) {
      return InkWell(
        onTap: () {
          imageFullScreen(AppConstant.fuelSlipImgURL);
        },
        child: AppConstant.fuelSlipImgURL == "" || AppConstant.fuelSlipImgURL == "null"
            ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
            : Image.network(
                AppConstant.fuelSlipImgURL,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
      );
    } else if (requestType == AppConstant.docRegistrationImg) {
      return InkWell(
        onTap: () {
          imageFullScreen(AppConstant.docRegistrationImgURL);
        },
        child: AppConstant.docRegistrationImgURL == "" || AppConstant.docRegistrationImgURL == "null"
            ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
            : Image.network(
                AppConstant.docRegistrationImgURL,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
      );
    } else if (requestType == AppConstant.docFitnessImg) {
      return InkWell(
        onTap: () {
          imageFullScreen(AppConstant.docFitnessImgURL);
        },
        child: AppConstant.docFitnessImgURL == "" ||  AppConstant.docFitnessImgURL == "null"
            ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
            : Image.network(
                AppConstant.docFitnessImgURL,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
      );
    } else if (requestType == AppConstant.docInsuranceImg) {
      return InkWell(
        onTap: () {
          imageFullScreen(AppConstant.docInsuranceImgURL);
        },
        child: AppConstant.docInsuranceImgURL == "" ||  AppConstant.docInsuranceImgURL == "null"
            ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
            : Image.network(
                AppConstant.docInsuranceImgURL,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
      );
    } else if (requestType == AppConstant.docTaxTokenImg) {
      return InkWell(
        onTap: () {
          imageFullScreen(AppConstant.docTaxTokenImgURL);
        },
        child: AppConstant.docTaxTokenImgURL == "" || AppConstant.docTaxTokenImgURL == "null"
            ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
            : Image.network(
                AppConstant.docTaxTokenImgURL,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
      );
    } else if (requestType == AppConstant.docRoadPermitImg) {
      return InkWell(
        onTap: () {
          imageFullScreen(AppConstant.docRoadPermitImgURL);
        },
        child: AppConstant.docRoadPermitImgURL == "" || AppConstant.docRoadPermitImgURL == "null"
            ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
            : Image.network(
                AppConstant.docRoadPermitImgURL,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
      );
    } else if (requestType == AppConstant.policeCaseImageImg) {
      return InkWell(
        onTap: () {
          imageFullScreen(AppConstant.policeCaseImageImgURL);
        },
        child: AppConstant.policeCaseImageImgURL == "" ||  AppConstant.policeCaseImageImgURL == "null"
            ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
            : Image.network(
                AppConstant.policeCaseImageImgURL,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
      );
    } else {
      return AppConstant.vehicleImageURL == "" ||  AppConstant.vehicleImageURL == "null"
          ? ImageIcon(AssetImage("assets/icons/edit_image.png"))
          : Image.network(
              AppConstant.vehicleImageURL,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            );
    }
  }
}
