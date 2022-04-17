import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:amargari/get_state/selected_dropdown.dart';
import 'package:amargari/model/insurancePolicy.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/insurance_policy_provider.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/profile/components/details_body_item.dart';
import 'package:amargari/widgets/TextEditingControllerWithEndCursor.dart';
import 'package:amargari/widgets/drop_down_list_item.dart';
import 'package:amargari/widgets/widgets.dart';

class AddUpdateInsurancePolicy extends StatefulWidget {
  AddUpdateInsurancePolicy({ required this.vcDataModel});
  final InsurancePolicyModel vcDataModel;

  @override
  _AddUpdateInsurancePolicyState createState() =>
      _AddUpdateInsurancePolicyState();
}

class _AddUpdateInsurancePolicyState extends State<AddUpdateInsurancePolicy> {
  var coverageDetails = new TextEditingControllerWithEndCursor(text: '');
  var insuranceImgURL = new TextEditingControllerWithEndCursor(text: '');
  var expiryDate = new TextEditingControllerWithEndCursor(text: '');

  late Future<dynamic> accidentAddUpdate;
  String driverId = "";
  String vehicleId = "";
  bool insuranceCover = true;

  @override
  void initState() {
    if (widget.vcDataModel.id != null) {
      coverageDetails = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.coverageDetails.toString());
      insuranceImgURL = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.insuranceImg.toString());
      expiryDate = new TextEditingControllerWithEndCursor(
          text: widget.vcDataModel.expiryDate.toString());

      AppConstant.insuranceImgURL = widget.vcDataModel.insuranceImg.toString();
    }
    super.initState();
  }

  void _loadData(BuildContext context) async {
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) => {
          Provider.of<ServiceProvider>(context, listen: false)
              .fetchVehicleDetails(value.id.toString(),""),
        });
  }

  @override
  Widget build(BuildContext context) {
    _loadData(context);
    SelectedDropDown _selectedDropItem = Get.find();
    var doUpdate = () {
      //isEditAble = true;
      if(isRedundantClick(DateTime.now())){
        print('hold on, processing');
        return;
      }
      print('run process');
      Future<UserInfoModel> getUserData() => UserPreferences().getUser();
      getUserData().then((value) => {
            if (widget.vcDataModel.id == null)
              {
                accidentAddUpdate = addUpdateInsurancePolicy(
                    "",
                    _selectedDropItem.vehicleId,
                    coverageDetails.text,
                    AppConstant.insuranceImgURL,
                    expiryDate.text)
              }
            else
              {
                accidentAddUpdate = addUpdateInsurancePolicy(
                    widget.vcDataModel.id.toString(),
                    _selectedDropItem.vehicleId,
                    coverageDetails.text,
                    AppConstant.insuranceImgURL,
                    expiryDate.text)
              }
          });
    };
    return Scaffold(
      appBar: AppBar(
        title: Text("Insurance Policy"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Consumer<ServiceProvider>(
          builder: (context, services, child) {
            return Column(
              children: [
                SizedBox(height: 20),
                DropDownListItem(
                    textTitle: "Vehicle:",
                    list: services.vehicleShortList,
                    requestType: "vehicleShortList"),
                SizedBox(height: 5),
                AccountItem(
                    text: 'Insurance Image:',
                    isVisible: true,
                    nameController: insuranceImgURL,
                    images: AppConstant.insuranceImg),
                AccountItem(
                    text: 'Coverage Details:', nameController: coverageDetails),
                SizedBox(height: 5),
                AccountItem(
                  text: 'Expiry Date:',
                  nameController: expiryDate,
                  isDate: true,
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: longButtons("SAVE", doUpdate),
                ),
              ],
            );
          },
        ),
      ),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
