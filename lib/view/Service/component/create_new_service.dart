import 'package:amargari/get_state/selected_dropdown.dart';
import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/app_url.dart';
import 'package:amargari/view/common_view/edit_List_Item_without_padding.dart';
import 'package:amargari/widgets/TextEditingControllerWithEndCursor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../model/service/service_model.dart';
import 'AddServiceItemDialog.dart';

Future<void> CreateNewServiceDialog(
    BuildContext context,  ServiceDataModel serviceModel, String userId, int position, bool initial) async {
  Provider.of<ServiceProvider>(context, listen: false)
      .getServiceListDropDown(userId);
  SelectedDropDown _selectedDropItem = Get.find();

  TextEditingControllerWithEndCursor serviceName =
      TextEditingControllerWithEndCursor(text: '');

  return showDialog(
    context: context,
    builder: (context) {
      return Consumer<ServiceProvider>(builder: (context, services, child) {
        return AlertDialog(
          title: Text('Create New Service'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            EditListItemWithOutPadding(
                text: 'Service Name',
                nameController: serviceName,
                hintText: 'Enter Service Name'),
            SizedBox(
              height: 10,
            )
          ]),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('SAVE'),
              onPressed: () {
                print(serviceName.text);
                createServiceName(userId, serviceName.text).then((value) {
                  if (value) {
                    Navigator.pop(context);
                    AddServiceItemDialog(
                        context, serviceModel, "${AppConstant.userId}", position, initial);
                  }
                });
              },
            ),
          ],
        );
      });
    },
  );
}

Future<bool> createServiceName(String userId, String serviceName) async {
  final Map<String, dynamic> registrationData = {
    "UserId": userId,
    "ServiceName": serviceName
  };

  final responseData = await http.post(Uri.parse(AppUrl.createServiceName),
      body: json.encode(registrationData),
      headers: {'Content-Type': 'application/json'});

  if (responseData.statusCode == 200) {
    return true;
  } else {
    // throw Exception('Failed to load album');
    return false;
  }
}
