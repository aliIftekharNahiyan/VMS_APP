import 'package:amargari/get_state/selected_dropdown.dart';
import 'package:amargari/model/Expense/ExpenseResponse.dart';
import 'package:amargari/model/Expense/ExpenseTypeResponse.dart';
import 'package:amargari/model/Expense/ExpenseTypeReq.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/expense_provider.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/common_view/all_drop_down_Item.dart';
import 'package:amargari/view/common_view/edit_List_Item.dart';
import 'package:amargari/view/vehicles_info/vehicle_list_item.dart';
import 'package:amargari/widgets/TextEditingControllerWithEndCursor.dart';
import 'package:amargari/widgets/themes.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ExpenseType extends StatefulWidget {
  const ExpenseType({Key? key}) : super(key: key);

  @override
  State<ExpenseType> createState() => _ExpenseTypeState();
}

class _ExpenseTypeState extends State<ExpenseType> {
  SelectedDropDown _selectedDropItem = Get.find();

  Future<dynamic>? expenseType;

  var expanceTypeText = new TextEditingControllerWithEndCursor(text: '');
  var status = new TextEditingControllerWithEndCursor(text: '');

  Future<List<ExpenseTypeDTO>>? expenseTypeDTOList;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: MyTheme.statusBarColor));
    _loadData(context);
    _fetchList();
    super.initState();
  }

  void _loadData(BuildContext context) async {
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) => {
          Provider.of<ServiceProvider>(context, listen: false)
              .getExpenseTypeStatus()
        });
  }

  void _fetchList() {
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) => {
          expenseTypeDTOList =
              ExpenseProvider().getExpenseTypeList(value.id.toString())
        });
  }

  doUpdate() {
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) => {
          expenseType = ExpenseProvider().addUpdateExpenseType(
              new ExpenseTypeReq(
                  name: expanceTypeText.text,
                  status: int.parse(_selectedDropItem.expenseStatusId),
                  userId: value.id)),
          expenseType?.whenComplete(
              () => {snackBar(context, "Successfully save"), _clear()})
        });
  }

  _clear() {
    expanceTypeText.clear();
    status.clear();
  }

  Future<bool> _willPopCallback() async {
    _selectedDropItem.expenseStatusId = "1";
    return true; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Expense Type"),
        ),
        body: WillPopScope(
          onWillPop: _willPopCallback,
          child: Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Consumer<ServiceProvider>(
                builder: (context, services, child) {
                  return Column(
                    children: [
                      SizedBox(height: 20),
                      EditListItem(
                        text: 'Expense Type',
                        nameController: expanceTypeText,
                        hintText: "Enter expense type",
                        isRequired: true,
                      ),
                      SizedBox(height: 20),
                      AllDropDownItem(
                          textTitle: "Status",
                          list: services.expenseTypeStatusList,
                          requestType: "expenseTypeStatus",
                          isRequired: true,
                          selectedItem: _selectedDropItem.expenseStatusId),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: longButtons(
                            //widget.vcDataModel.id != null ? "UPDATE" : "SAVE",
                            "SAVE",
                            doUpdate),
                      ),
                      FutureBuilder<List<ExpenseTypeDTO>>(
                        future: expenseTypeDTOList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return snapshot.data!.isEmpty
                                ? Center(
                                    child: Text('Not found any information '))
                                : Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 16, 0, 0),
                                    child: ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        ExpenseTypeDTO expense =
                                            snapshot.data![index];
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 4, 8, 4),
                                          child: Card(
                                            child: new InkResponse(
                                              onTap: () {},
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: InkWell(
                                                      onTap: () {},
                                                      child: Column(
                                                          children: <Widget>[
                                                            VehicleListItem(
                                                                textTitle:
                                                                    'ExpenseType: ',
                                                                text: expense
                                                                        .name ??
                                                                    ""),
                                                            VehicleListItem(
                                                                textTitle:
                                                                    'Description: ',
                                                                text: expense
                                                                            .status ==
                                                                        1
                                                                    ? "Active"
                                                                    : "Inactive"),
                                                          ]),
                                                    )),
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
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
