import 'package:amargari/uril/utility.dart';
import 'package:amargari/view/common_view/image_upload_view_item.dart';
import 'package:amargari/view/common_view/edit_List_Item.dart';
import 'package:amargari/view/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amargari/providers/auth.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/profile/components/profile_pic.dart';
import 'package:amargari/widgets/TextEditingControllerWithEndCursor.dart';
import 'package:amargari/widgets/widgets.dart';

class DetailsBody extends StatefulWidget {
  @override
  _DetailsBodyState createState() => _DetailsBodyState();
}

class _DetailsBodyState extends State<DetailsBody> {
  var getUserData = UserPreferences().getUser();
  var nameController = new TextEditingControllerWithEndCursor(text: '');
  var mobileNumber = new TextEditingControllerWithEndCursor(text: '');

  var birthDayCirtificate1 = new TextEditingControllerWithEndCursor(text: '');
  var birthDayCirtificate2 = new TextEditingControllerWithEndCursor(text: '');

  var chairmanCirtificate1 = new TextEditingControllerWithEndCursor(text: '');
  var chairmanCirtificate2 = new TextEditingControllerWithEndCursor(text: '');

  var driverImage = new TextEditingControllerWithEndCursor(text: '');
  var bioData = new TextEditingControllerWithEndCursor(text: '');

  var fatherMobileNo = new TextEditingControllerWithEndCursor(text: '');
  var spouseMobileNo = new TextEditingControllerWithEndCursor(text: '');

  var joiningDate = new TextEditingControllerWithEndCursor(text: '');

  var nID = new TextEditingControllerWithEndCursor(text: '');
  var occupation = new TextEditingControllerWithEndCursor(text: '');
  var address = new TextEditingControllerWithEndCursor(text: '');
  var gender = new TextEditingControllerWithEndCursor(text: '');
  var drivingLicense = new TextEditingControllerWithEndCursor(text: '');
  var licenseExpiryDate = new TextEditingControllerWithEndCursor(text: '');
  var salary = new TextEditingControllerWithEndCursor(text: '');
  var bouns = new TextEditingControllerWithEndCursor(text: '');
  var tradeLicense = new TextEditingControllerWithEndCursor(text: '');
  var tinBin = new TextEditingControllerWithEndCursor(text: '');

  // static String username = "Md. Tariqul Islam";
  static bool isEditAble = true;
  var userTypeId = "";

  @override
  void initState() {
    getUserData.then((value) => setState(() {
          userTypeId = value.userTypeId.toString();
          nameController =
              new TextEditingControllerWithEndCursor(text: value.name ?? "");
          mobileNumber = new TextEditingControllerWithEndCursor(
              text: value.mobileNo ?? "");
          nID = new TextEditingControllerWithEndCursor(text: value.nid ?? "");
          AppConstant.NidURL = value.nid ?? "";

          birthDayCirtificate1 =
              new TextEditingControllerWithEndCursor(text: value.bc1 ?? "");
          AppConstant.BC_URL1 = value.bc1 ?? "";

          birthDayCirtificate2 =
              new TextEditingControllerWithEndCursor(text: value.bc2 ?? "");
          AppConstant.BC_URL2 = value.bc2 ?? "";

          chairmanCirtificate1 =
              new TextEditingControllerWithEndCursor(text: value.cc1 ?? "");
          AppConstant.CC_URL1 = value.cc1 ?? "";

          chairmanCirtificate2 =
              new TextEditingControllerWithEndCursor(text: value.cc2 ?? "");
          AppConstant.CC_URL2 = value.cc2 ?? "";

          driverImage = new TextEditingControllerWithEndCursor(
              text: value.driverImg1 ?? "");
          AppConstant.DP_URL = value.driverImg1 ?? "";

          bioData =
              new TextEditingControllerWithEndCursor(text: value.bioData ?? "");
          AppConstant.BD_URL2 = value.bioData ?? "";

          joiningDate = new TextEditingControllerWithEndCursor(
              text: value.joiningDate ?? "");

          fatherMobileNo = new TextEditingControllerWithEndCursor(
              text: value.fatherMobile ?? "");
          spouseMobileNo = new TextEditingControllerWithEndCursor(
              text: value.spouseMobile ?? "");

          occupation = new TextEditingControllerWithEndCursor(
              text: value.occupation ?? "");
          address =
              new TextEditingControllerWithEndCursor(text: value.address ?? "");
          gender =
              new TextEditingControllerWithEndCursor(text: value.gender ?? "");
          drivingLicense = new TextEditingControllerWithEndCursor(
              text: value.drivingLicense ?? "");
          AppConstant.drivingLicenseURL = value.drivingLicense ?? "";
          licenseExpiryDate = new TextEditingControllerWithEndCursor(
              text: "${convertDate2(value.licenseExpiryDate ?? "")}");
          salary = new TextEditingControllerWithEndCursor(
              text: value.salary.toString());
          bouns = new TextEditingControllerWithEndCursor(
              text: value.bouns.toString());
          tradeLicense = new TextEditingControllerWithEndCursor(
              text: value.tradeLicense.toString());
          AppConstant.tradeLicenseURL = value.tradeLicense ?? "";
          tinBin =
              new TextEditingControllerWithEndCursor(text: value.tinBin ?? "");
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    var doUpdate = () {
      //isEditAble = true;
      auth
          .profileUpdate(
              userTypeId,
              nameController.text,
              mobileNumber.text,
              AppConstant.NidURL,
              occupation.text,
              address.text,
              gender.text,
              AppConstant.drivingLicenseURL,
              licenseExpiryDate.text,
              salary.text,
              bouns.text,
              AppConstant.tradeLicenseURL,
              tinBin.text,
              AppConstant.profileImageUrl,
              joiningDate.text,
              AppConstant.BC_URL1,
              AppConstant.BC_URL2,
              AppConstant.CC_URL1,
              AppConstant.CC_URL2,
              AppConstant.DP_URL,
              AppConstant.BD_URL2,
              fatherMobileNo.text,
              spouseMobileNo.text)
          .then((response) {
        //print("profileupdate "+response );
        snackBar(context, "Successfully updated");

        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      });
    };

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          ProfilePic("details"),
          SizedBox(height: 20),
          EditListItem(
            text: 'Full Name',
            nameController: nameController,
            isEditAble: isEditAble,
            hintText: "Type your name",
          ),
          SizedBox(height: 5),
          EditListItem(
              text: 'Mobile No',
              nameController: mobileNumber,
              isEditAble: false,
              hintText: 'Type your mobile number'),
          SizedBox(height: 5),
          if (AppConstant.userTypeId != 3) ...[
            ImageUploadViewItem(
                text: 'Birth certificate 1',
                nameController: birthDayCirtificate1,
                isVisible: true,
                images: "bc1"),
            SizedBox(height: 5),
            ImageUploadViewItem(
                text: 'Birth certificate 2',
                nameController: birthDayCirtificate2,
                isVisible: true,
                images: "bc2"),
            SizedBox(height: 5),
            ImageUploadViewItem(
                text: 'NID',
                nameController: nID,
                isVisible: true,
                images: "nid"),
            SizedBox(height: 5),
            ImageUploadViewItem(
                text: 'Chairman Certificate 1',
                nameController: chairmanCirtificate1,
                isVisible: true,
                images: "cc1"),
            SizedBox(height: 5),
            ImageUploadViewItem(
                text: 'Chairman Certificate 2',
                nameController: chairmanCirtificate2,
                isVisible: true,
                images: "cc2"),
            SizedBox(height: 5),
            ImageUploadViewItem(
                text: 'Driver Image',
                nameController: driverImage,
                isVisible: true,
                images: "driverImage"),
            SizedBox(height: 5),
            ImageUploadViewItem(
                text: 'Bio Data',
                nameController: bioData,
                isVisible: true,
                images: "bioData"),
            SizedBox(height: 5),
            EditListItem(
              text: 'Address',
              nameController: address,
              hintText: "Type your address",
            ),
            SizedBox(height: 5),
            EditListItem(
              text: 'Gender',
              nameController: gender,
              hintText: "Type your gender",
            ),
            SizedBox(height: 5),
            EditListItem(
                text: 'Father mobile No',
                nameController: fatherMobileNo,
                isEditAble: isEditAble,
                hintText: 'Type your father mobile number'),
            SizedBox(height: 5),
            EditListItem(
                text: 'Spouse mobile No',
                nameController: spouseMobileNo,
                isEditAble: isEditAble,
                hintText: 'Type your spouse mobile number'),
            SizedBox(height: 5),
            ImageUploadViewItem(
                text: 'Driving License',
                nameController: drivingLicense,
                isVisible: true,
                images: "drivingLicense"),
            SizedBox(height: 5),
            EditListItem(
                text: 'Joining date',
                nameController: joiningDate,
                isDate: true,
                isFutureDate: true,
                hintText: "Click to select date"),
            SizedBox(height: 5),
            EditListItem(
                text: 'License expiry date',
                nameController: licenseExpiryDate,
                isDate: true,
                isFutureDate: true,
                hintText: "Click to select date"),
          ],
          SizedBox(height: 5),
          if (AppConstant.userTypeId == 2) ...[
            EditListItem(
                text: 'Salary',
                nameController: salary,
                hintText: "Type your salary"),
            SizedBox(height: 5),
            EditListItem(
                text: 'Bonus',
                nameController: bouns,
                hintText: "Type your bonus"),
            SizedBox(height: 5),
          ],
          if (AppConstant.userTypeId == 3) ...[
            ImageUploadViewItem(
                text: 'Trade License',
                nameController: tradeLicense,
                isVisible: true,
                images: "TradeLicense"),
            SizedBox(height: 5),
            EditListItem(
                text: 'Tin Bin:',
                nameController: tinBin,
                hintText: "Type your tin bin"),
            SizedBox(height: 5),
          ],
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: longButtons("SAVE", doUpdate),
          ),
        ],
      ),
    );
  }
}
