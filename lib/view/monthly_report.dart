import 'package:amargari/get_state/selected_dropdown.dart';
import 'package:amargari/model/expense_report_model.dart';
import 'package:amargari/model/user_model.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/uril/utility.dart';
import 'package:amargari/widgets/drop_down_list_item.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MonthlyReportView extends StatefulWidget {
  @override
  _MonthlyReportViewState createState() => _MonthlyReportViewState();
}

class _MonthlyReportViewState extends State<MonthlyReportView> {
  Future<dynamic>? accidentAddUpdate;

  String vehicleId = "";
  bool insuranceCover = true;
  bool _switchValue = false;
  // List<CommonDropDownModel> serviceTypeList = [];
  SelectedDropDown _selectedDropItem = Get.find();

  void _pickDateDialog(String requestType) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(1950),
            //what will be the previous supported year in picker
            lastDate: DateTime
                .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
        //for rebuilding the u
        if (requestType == "StartDate") {
          AppConstant.startDate = formattedDate;
        } else {
          AppConstant.endDate = formattedDate;
        }
        //  _selectedDate = pickedDate;
      });
    });
  }

  @override
  void initState() {
    _selectedDropItem.vehicleId = "";
    final now = new DateTime.now();
    AppConstant.startDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    print("${AppConstant.startDate}");
    AppConstant.startDate = AppConstant.startDate.replaceRange(0, 2, "01");
    AppConstant.endDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    print("${AppConstant.startDate}    ${AppConstant.endDate}");
    // serviceTypeList
    //     .add(new CommonDropDownModel(id: "0", name: "All", title: ""));
    // serviceTypeList
    //     .add(new CommonDropDownModel(id: "1", name: "Police Case", title: ""));
    // serviceTypeList
    //     .add(new CommonDropDownModel(id: "2", name: "Accident", title: ""));
    // serviceTypeList
    //     .add(new CommonDropDownModel(id: "3", name: "Fuel", title: ""));
    // serviceTypeList
    //     .add(new CommonDropDownModel(id: "4", name: "Service", title: ""));

    _fetchServiceDropdownList(context);

    super.initState();
  }

  void _fetchServiceDropdownList(BuildContext context) async {
    Provider.of<ServiceProvider>(context, listen: false)
        .getReportServiceDropdownList();
  }

  void _loadData(BuildContext context) async {
    Future<UserInfoModel> getUserData() => UserPreferences().getUser();
    getUserData().then((value) => {
          Provider.of<ServiceProvider>(context, listen: false)
              .fetchVehicleDetails(value.id.toString(), "report"),
          if (_selectedDropItem.vehicleId == "0")
            {
              Provider.of<ServiceProvider>(context, listen: false)
                  .getMonthlyReport(
                      AppConstant.startDate,
                      AppConstant.endDate,
                      _selectedDropItem.vehicleId,
                      _selectedDropItem.serviceType,
                      value.id.toString())
            }
          else
            {
              Provider.of<ServiceProvider>(context, listen: false)
                  .getMonthlyReport(
                      AppConstant.startDate,
                      AppConstant.endDate,
                      _selectedDropItem.vehicleId,
                      _selectedDropItem.serviceType,
                      "0")
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    _loadData(context);
    double totalCost(List<ExpenseReportModel> expenseReportModel) {
      double totalCost = 0;
      for (int i = 0; i < expenseReportModel.length; i++) {
        print(expenseReportModel[i].cost ?? "0");
        var myDouble;
        if (expenseReportModel[i].cost == "") {
          myDouble = double.parse("0");
        } else {
          myDouble = double.parse(expenseReportModel[i].cost ?? "0.0");
        }
        print(myDouble);
        totalCost = totalCost + myDouble;
      }
      return totalCost;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Expense report"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Consumer<ServiceProvider>(
          builder: (context, services, child) {
            if (_selectedDropItem.vehicleId == "") {
              if (services.vehicleShortList.isNotEmpty) {
                _selectedDropItem.vehicleId =
                    services.vehicleShortList[0].id.toString();
                print(
                    "vechileId 2  ${services.vehicleShortList[0].id.toString()}");
              }
            } else {
              if (services.vehicleShortList.isNotEmpty) {
                bool exists = services.vehicleShortList
                    .any((file) => file.id == _selectedDropItem.vehicleId);

                if (!exists) {
                  _selectedDropItem.vehicleId =
                      services.vehicleShortList[0].id.toString();
                }
              }
            }
            if (_selectedDropItem.serviceType == "") {
              if (services.reportServiceList.isNotEmpty) {
                _selectedDropItem.serviceType =
                   services.reportServiceList[0].id.toString();
              }
            }

            return Column(
              children: [
                SizedBox(height: 5),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(flex: 1, child: label("Start Date:")),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  _pickDateDialog("StartDate");
                                },
                                child: Text(AppConstant.startDate))),
                        Container(width: 1, height: 40, color: Colors.grey),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(flex: 1, child: label("End Date:")),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  _pickDateDialog("endDate");
                                },
                                child: Text(AppConstant.endDate))),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: DropDownListItem(
                      textTitle: "Vehicle:",
                      list: services.vehicleShortList,
                      requestType: "reportVehicleList",
                      selectedItem: _selectedDropItem.vehicleId),
                ),
                Card(
                  child: DropDownListItem(
                      textTitle: "Service Type:",
                      list: services.reportServiceList,
                      requestType: "serviceType",
                      selectedItem: _selectedDropItem.serviceType),
                ),
                SizedBox(height: 5),
                SizedBox(height: 5),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (services.expenseReportModel.isNotEmpty) ...[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "Total cost: ${totalCost(services.expenseReportModel)} TK",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ] else ...[
                            Text(""),
                          ],
                          Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    " Type",
                                    style: TextStyle(fontSize: 12),
                                  )),
                              Container(
                                  width: 1, height: 40, color: Colors.grey),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    " Date",
                                    style: TextStyle(fontSize: 12),
                                  )),
                              Container(
                                  width: 1, height: 40, color: Colors.grey),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    " Servicing",
                                    style: TextStyle(fontSize: 12),
                                  )),
                              Container(
                                  width: 1, height: 40, color: Colors.grey),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    " Cost",
                                    style: TextStyle(fontSize: 12),
                                  )),
                              Container(
                                  width: 1, height: 40, color: Colors.grey),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    " Vehicle",
                                    style: TextStyle(fontSize: 12),
                                  )),
                            ],
                          ),
                          Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: services.expenseReportModel.length,
                              itemBuilder: (context, index) {
                                return services.expenseReportModel.isNotEmpty
                                    ? Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                services
                                                        .expenseReportModel[
                                                            index]
                                                        .type ??
                                                    "",
                                                style: TextStyle(fontSize: 12),
                                              )),
                                          Container(
                                              width: 1,
                                              height: 40,
                                              color: Colors.grey),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                convertDate2(services
                                                        .expenseReportModel[
                                                            index]
                                                        .date ??
                                                    ""),
                                                style: TextStyle(fontSize: 12),
                                              )),
                                          Container(
                                              width: 1,
                                              height: 40,
                                              color: Colors.grey),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                services
                                                        .expenseReportModel[
                                                            index]
                                                        .eventName ??
                                                    "",
                                                style: TextStyle(fontSize: 12),
                                              )),
                                          Container(
                                              width: 1,
                                              height: 40,
                                              color: Colors.grey),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                services
                                                        .expenseReportModel[
                                                            index]
                                                        .cost ??
                                                    "",
                                                style: TextStyle(fontSize: 12),
                                              )),
                                          Container(
                                              width: 1,
                                              height: 40,
                                              color: Colors.grey),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                services
                                                        .expenseReportModel[
                                                            index]
                                                        .brandName ??
                                                    "",
                                                style: TextStyle(fontSize: 12),
                                              )),
                                        ],
                                      )
                                    : Center(child: Text("No value found"));
                              })
                        ]),
                  ),
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
