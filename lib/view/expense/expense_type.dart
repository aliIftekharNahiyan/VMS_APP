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

  var _controller = new ScrollController();

  var id = new TextEditingControllerWithEndCursor(text: '');
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
    int gg = int.parse(_selectedDropItem.expenseStatusId);
    getUserData().then((value) => {
          if (expanceTypeText.text == "")
            {
              snackBar(context, "Expense Type Required", success: false),
            }
          else
            {
              expenseType = ExpenseProvider().addUpdateExpenseType(
                  new ExpenseTypeReq(
                      id: id.text == "" ? null : int.parse(id.text),
                      name: expanceTypeText.text,
                      status: gg,
                      userId: value.id)),
              expenseType?.whenComplete(() => {
                    snackBar(context,
                        "Successfully ${id.text == "" ? "saved" : "updated"}",
                        success: true),
                    _clear(),
                    _fetchList()
                  })
            }
        });
  }

  _clear() {
    setState(() {
      expanceTypeText.clear();
      id.clear();
      _selectedDropItem.expenseStatusId = "";
      status.clear();
    });
  }

  Future<bool> _willPopCallback() async {
    _selectedDropItem.expenseStatusId = "1";
    return true; // return true if the route to be popped
  }

  _onEdit(ExpenseTypeDTO expenseDTO) {
    setState(() {
      _selectedDropItem.expenseStatusId = expenseDTO.status.toString();
      expanceTypeText.text = expenseDTO.name ?? "";
      id.text = expenseDTO.id.toString();

      _controller.animateTo(_controller.position.minScrollExtent,
          curve: Curves.easeOut, duration: const Duration(milliseconds: 500));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("Expense Type"),
        ),
        body: WillPopScope(
          onWillPop: _willPopCallback,
          child: Container(
            child: SingleChildScrollView(
              controller: _controller,
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
                            id.text != "" ? "UPDATE" : "SAVE",
                            // "SAVE",
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
                                              8, 0, 4, 0),
                                          child: Card(
                                            child: new InkResponse(
                                              onTap: () {
                                                _onEdit(expense);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
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
                                                                  'Status: ',
                                                              text: expense
                                                                          .status ==
                                                                      1
                                                                  ? "Active"
                                                                  : "Inactive"),
                                                        ])),
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
