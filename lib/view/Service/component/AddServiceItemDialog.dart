import 'package:amargari/get_state/selected_dropdown.dart';
import 'package:amargari/model/RequestModel/request_service_model.dart';
import 'package:amargari/model/ServiceNameModel.dart';
import 'package:amargari/model/service/service_model.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/app_url.dart';
import 'package:amargari/view/Service/add_service.dart';
import 'package:amargari/view/Service/component/create_new_service.dart';
import 'package:amargari/view/common_view/all_drop_down_Item_withOut_padding.dart';
import 'package:amargari/view/common_view/edit_List_Item_without_padding.dart';
import 'package:amargari/widgets/TextEditingControllerWithEndCursor.dart';
import 'package:amargari/widgets/themes.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> AddServiceItemDialog(
    BuildContext context,
    ServiceDataModel serviceModel,
    String userId,
    int position,
    bool initial) async {
  Provider.of<ServiceProvider>(context, listen: false)
      .getServiceListDropDown(userId);
  SelectedDropDown _selectedDropItem = Get.find();

  TextEditingControllerWithEndCursor serviceDetails =
      TextEditingControllerWithEndCursor(text: '');
  TextEditingControllerWithEndCursor serviceCost =
      TextEditingControllerWithEndCursor(text: '');

  if (position != -1) {
    serviceDetails.text = AppConstant.requestList[position].details.toString();
    serviceCost.text = AppConstant.requestList[position].Amount.toString();
    _selectedDropItem.serviceNameListId =
        serviceModel.serviceCost![position].id.toString();
    _selectedDropItem.serviceNameListName =
        serviceModel.serviceCost![position].serviceName.toString();
  }

  return showDialog(
    context: context,
    builder: (context) {
      return Consumer<ServiceProvider>(builder: (context, services, child) {
        return AlertDialog(
          title: Text('Service Name'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 10,
                  child: AllDropDownItemWithOutPadding(
                      textTitle: "Service Name",
                      list: services.serviceNameList,
                      requestType: AppConstant.serviceNameList,
                      selectedItem: _selectedDropItem.serviceNameListName),
                ),
                Expanded(
                    flex: 3,
                    child: MaterialButton(
                      height: 30.0,
                      minWidth: 30.0,
                      color: MyTheme.buttonColor,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                        CreateNewServiceDialog(context, serviceModel,
                            "${AppConstant.userId}", -1, initial);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 2.0, 0.0, 2.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      shape: CircleBorder(),
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            EditListItemWithOutPadding(
                text: 'Service Details',
                nameController: serviceDetails,
                hintText: 'Service Details'),
            SizedBox(
              height: 10,
            ),
            EditListItemWithOutPadding(
              text: 'Service Cost',
              nameController: serviceCost,
              hintText: 'Service Cost',
              isNumber: true,
            ),
          ]),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                if (_selectedDropItem.serviceNameListName != "") {
                  if (position != -1) {
                    AppConstant.requestList[position].ServiceName =
                        _selectedDropItem.serviceNameListName.toString();
                    AppConstant.requestList[position].Amount =
                        serviceCost.text.toString();
                    AppConstant.requestList[position].details =
                        serviceDetails.text.toString();
                  } else {
                    RequestServiceModel requestServiceModel =
                        new RequestServiceModel();
                    requestServiceModel.Id = "";
                    requestServiceModel.ServiceName =
                        _selectedDropItem.serviceNameListName.toString();
                    requestServiceModel.Amount = serviceCost.text.toString();
                    requestServiceModel.details =
                        serviceDetails.text.toString();
                    AppConstant.requestList.add(requestServiceModel);
                  }

                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddServiceView(
                              serviceDataModel: serviceModel,
                              vehicleId: "",
                              initial:
                                  initial))); //  confirmRequest(context, services.sendRequestRes);
                } else {
                  snackBar(context, "Please select vehicle");
                }
              },
            ),
          ],
        );
      });
    },
  );
}

Widget _customDropDownExample(BuildContext context, ServiceNameModel? item) {
  if (item == null) {
    return Container();
  }

  return Container(
    child: (item.serviceName == null)
        ? ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: CircleAvatar(),
            title: Text("No item selected"),
          )
        : ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: CircleAvatar(
                // this does not work - throws 404 error
                // backgroundImage: NetworkImage(item.avatar ?? ''),
                ),
            title: Text(item.serviceName ?? ""),
          ),
  );
}

Widget _customPopupItemBuilderExample2(
    BuildContext context, ServiceNameModel? item, bool isSelected) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8),
    decoration: !isSelected
        ? null
        : BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
    child: ListTile(
      selected: isSelected,
      title: Text(item?.serviceName ?? ''),
      //subtitle: Text(item?.createdAt?.toString() ?? ''),
      leading: CircleAvatar(
          // this does not work - throws 404 error
          // backgroundImage: NetworkImage(item.avatar ?? ''),
          ),
    ),
  );
}

/*Future<List<CommonDropDownModel>> getData(filter) async {
  var response = await Dio().get(
    "https://5d85ccfb1e61af001471bf60.mockapi.io/user",
    queryParameters: {"filter": filter},
  );

  final data = response.data;
  if (data != null) {
    return CommonDropDownModel.fromJsonList(data);
  }

  return [];
}*/
Future<List<ServiceNameModel>> getServiceListDropDown(String userId) async {
  final responseData = await http.get(
      Uri.parse(AppUrl.getServiceListDropDown.replaceAll("_userId", userId)));
  var result;

  print("fetchGarageList  " +
      responseData.toString() +
      "  " +
      AppUrl.getServiceListDropDown.replaceAll("_userId", userId));
  if (responseData.statusCode == 200) {
    // Iterable l = json.decode(responseData.body)['data'];
    // List<AccidentListModel> policeCaseModel = List<AccidentListModel>.from(l.map((model)=> AccidentListModel.fromJson(model)));

    final List parsedList = json.decode(responseData.body)['data'];

    List<ServiceNameModel> serviceNameList =
        parsedList.map((val) => ServiceNameModel.fromJson(val)).toList();

    //result = {'status': true, 'message': 'Successful', 'data': garageModel};
    print("fetchGarageList  " + serviceNameList.length.toString());
    // VehicleInfoModel vi = ;
    return serviceNameList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
