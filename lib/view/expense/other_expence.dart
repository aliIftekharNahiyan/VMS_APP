import 'package:amargari/get_state/selected_dropdown.dart';
import 'package:amargari/model/Expense/ExpenseResponse.dart';
import 'package:amargari/model/common_dropdown_model.dart';
import 'package:amargari/model/Expense/expense_model.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/expense_provider.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/view/common_view/all_drop_down_Item.dart';
import 'package:amargari/view/common_view/edit_List_Item.dart';
import 'package:amargari/view/common_view/image_upload_view_item.dart';
import 'package:amargari/view/expense/expense_type.dart';
import 'package:amargari/view/vehicles_info/vehicle_list_item.dart';
import 'package:amargari/widgets/TextEditingControllerWithEndCursor.dart';
import 'package:amargari/widgets/themes.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OtherExpense extends StatefulWidget {
  const OtherExpense({Key? key, required this.vehicleId}) : super(key: key);
  final String vehicleId;

  @override
  State<OtherExpense> createState() => _OtherExpenseState();
}

class _OtherExpenseState extends State<OtherExpense> {
  var id = new TextEditingControllerWithEndCursor(text: '');
  var date = new TextEditingControllerWithEndCursor(text: '');
  var expenseType = new TextEditingControllerWithEndCursor(text: '');
  var expenseAmount = new TextEditingControllerWithEndCursor(text: '');
  var description = new TextEditingControllerWithEndCursor(text: '');
  var image = new TextEditingControllerWithEndCursor(text: '');
  var status = new TextEditingControllerWithEndCursor(text: '');
  SelectedDropDown _selectedDropItem = Get.find();
  List<CommonDropDownModel> expenseList = [];
  Future<List<ExpenseDTO>>? expenseDTOList;
  Future<dynamic>? expense;

  var _controller = new ScrollController();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: MyTheme.statusBarColor));

    _selectedDropItem.expenseId = "";
    _loadData(context);
    _fetchList();
    super.initState();
  }

  void _loadData(BuildContext context) async {
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) => {
          Provider.of<ServiceProvider>(context, listen: false)
              .getExpenseType(value.id.toString())
        });
  }

  void _fetchList() {
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) => {
          expenseDTOList = ExpenseProvider().getExpenseList(value.id.toString())
        });
  }

  doUpdate() {
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) => {
          expense = ExpenseProvider().addUpdateExpense(new Expense(
              id: id.text == "" ? null : int.parse(id.text),
              serviceTypeId: int.parse(_selectedDropItem.expenseId),
              date: date.text,
              description: description.text,
              image: AppConstant.expenseImageURL,
              expenseAmount: expenseAmount.text,
              userId: value.id,
              status: 1)),
          expense?.whenComplete(() => {
                snackBar(context,
                    "Successfully ${id.text == "" ? "saved" : "updated"}"),
                _onClear(),
                _fetchList()
              })
        });
  }

  _onClear() {
    setState(() {
      date.text = "";
      _selectedDropItem.expenseId = "";
      expenseAmount.text = "";
      description.text = "";
      id.text = "";
      AppConstant.expenseImageURL = "";
    });
  }

  _onEdit(ExpenseDTO expenseDTO) {
    setState(() {
      try {
        var dateTime = DateTime.parse(expenseDTO.date ?? "");
        date.text = DateFormat('dd-MMM-yyyy').format(dateTime);
      } catch (ex) {
        print(ex);
      }
      _selectedDropItem.expenseId = expenseDTO.serviceTypeId.toString();
      expenseAmount.text = expenseDTO.expenseAmount ?? "";
      AppConstant.expenseImageURL = expenseDTO.image ?? "";
      description.text = expenseDTO.description ?? "";
      id.text = expenseDTO.id.toString();

      _controller.animateTo(_controller.position.minScrollExtent,
          curve: Curves.easeOut, duration: const Duration(milliseconds: 500));
    });
  }

   Future<bool> _willPopCallback() async {
    _onClear();
    return true; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Other Expense"),
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
                          text: 'Date',
                          nameController: date,
                          hintText: "Select Date",
                          isDate: true,
                          isFutureDate: true,
                          isRequired: true),
                      SizedBox(height: 10),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 10,
                              child: AllDropDownItem(
                                  textTitle: "Expense Type",
                                  list: services.expenseTypeList,
                                  requestType: "expenseTypeList",
                                  isRequired: true,
                                  selectedItem: _selectedDropItem.expenseId),
                            ),
                            Expanded(
                                flex: 2,
                                child: MaterialButton(
                                  height: 30.0,
                                  minWidth: 30.0,
                                  color: MyTheme.buttonColor,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ExpenseType()));
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             GarageDetailsView(
                                    //               vcDataModel: GarageModel(),
                                    //               requestType: "addFromService",
                                    //               serviceDataModel:
                                    //                   widget.serviceDataModel,
                                    //               vehicleId: widget.vehicleId,
                                    //             )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 2.0, 0.0, 2.0),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                  shape: CircleBorder(),
                                ))
                          ]),
                      SizedBox(height: 10),
                      EditListItem(
                        text: 'Expense Amount',
                        nameController: expenseAmount,
                        hintText: "Enter expense amount",
                        isNumber: true,
                        isRequired: true,
                      ),
                      ImageUploadViewItem(
                          text: 'Expense Image',
                          nameController: image,
                          isVisible: true,
                          images: "expenseImage"),
                      SizedBox(height: 10),
                      EditListItem(
                        text: 'Description',
                        nameController: description,
                        hintText: "Enter description",
                        multiLine: true,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: longButtons(
                            id.text != "" ? "UPDATE" : "SAVE",
                            // "SAVE",
                            doUpdate),
                      ),
                      FutureBuilder<List<ExpenseDTO>>(
                        future: expenseDTOList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
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
                                        ExpenseDTO expense =
                                            snapshot.data![index];
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 4, 8, 4),
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
                                                        flex: 3,
                                                        child: expense.image == ""
                                                            ? Image.asset(
                                                                "assets/icons/edit_image.png",
                                                                color:
                                                                    Colors.black,
                                                              )
                                                            : CachedNetworkImage(
                                                                imageUrl: expense
                                                                        .image ??
                                                                    "",
                                                                placeholder: (context,
                                                                        url) =>
                                                                    CircularProgressIndicator(),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    ImageIcon(
                                                                        AssetImage(
                                                                            "assets/icons/edit_image.png")),
                                                                height: 100,
                                                              )),
                                                    Expanded(
                                                        flex: 7,
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
                                                                          .description ??
                                                                      ""),
                                                              VehicleListItem(
                                                                  textTitle:
                                                                      'Expense Amount: ',
                                                                  text: expense
                                                                          .expenseAmount ??
                                                                      ""),
                                                              VehicleListItem(
                                                                  textTitle:
                                                                      'Date: ',
                                                                  text: expense
                                                                          .date ??
                                                                      "")
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
