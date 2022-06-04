import 'package:flutter/material.dart';
import 'package:amargari/model/insurancePolicy.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/accident_provider.dart';
import 'package:amargari/providers/insurance_policy_provider.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/Service/component/service_list_item.dart';
import 'package:amargari/view/accident_management/add_update_accident.dart';
import 'package:amargari/view/insurance_policy/add_update_insurance_policy.dart';

class InsurancePolicyView extends StatefulWidget {
  final String title;
  final String vehicleId;

  // In the constructor, require a Todo.
  InsurancePolicyView({required this.title, required this.vehicleId});

  @override
  _InsurancePolicyViewState createState() => _InsurancePolicyViewState();
}

class _InsurancePolicyViewState extends State<InsurancePolicyView> {
  Future<List<InsurancePolicyModel>>? insurancePolicy;
  var isVisible = true;

  @override
  void initState() {
    super.initState();
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();

    getUserData().then((value) =>
        {insurancePolicy = getInsurancePolicyList(value.id.toString())});
    new Future.delayed(new Duration(seconds: 3), () {
      setState(() {
        isVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var addInsurancePolicyInfo = (InsurancePolicyModel insurancePolicyModel) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AddUpdateInsurancePolicy(vcDataModel: insurancePolicyModel)));
    };
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<InsurancePolicyModel>>(
        future: insurancePolicy,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data!.isEmpty
                ? Center(child: Text('Empty'))
                : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      InsurancePolicyModel insurancePolicyModel =
                          snapshot.data![index];
                      return Card(
                        child: new InkResponse(
                            onTap: () {
                              print(index);
                              addInsurancePolicyInfo(insurancePolicyModel);
                            },
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 5),
                                ServiceItem(
                                    textTitle: 'Coverage Details',
                                    text: insurancePolicyModel.coverageDetails
                                        .toString()),
                                ServiceItem(
                                    textTitle: 'Expiry Date',
                                    text: insurancePolicyModel.expiryDate
                                        .toString()),
                                SizedBox(height: 5),
                              ],
                            )),
                      );
                    },
                  );
          } else {
            return Center(child: CircularProgressIndicator());
          }
          // By default, show a loading spinner.
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: () {
            addInsurancePolicyInfo(new InsurancePolicyModel());
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 29,
          ),
          backgroundColor: Colors.orange,
          tooltip: 'Add More',
          elevation: 5,
          splashColor: Colors.grey,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
