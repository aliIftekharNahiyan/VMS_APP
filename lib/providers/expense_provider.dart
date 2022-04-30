import 'dart:async';
import 'dart:convert';
import 'package:amargari/model/Expense/ExpenseResponse.dart';
import 'package:amargari/model/Expense/ExpenseTypeReq.dart';
import 'package:amargari/model/Expense/ExpenseTypeResponse.dart';
import 'package:amargari/model/Expense/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:amargari/uril/app_url.dart';
import 'package:amargari/widgets/widgets.dart';

class ExpenseProvider with ChangeNotifier {
  Future<List<ExpenseDTO>> getExpenseList(String userId) async {
    final responseData = await http
        .get(Uri.parse(AppUrl.getExpenseList.replaceAll("_userId", userId)));
    if (responseData.statusCode == 200) {
      return ExpenseResponse.fromJson(json.decode(responseData.body)).data ??
          [];
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<ExpenseTypeDTO>> getExpenseTypeList(String userId) async {
    final responseData = await http
        .get(Uri.parse(AppUrl.getExpenseTypeList.replaceAll("_userId", userId)));
    if (responseData.statusCode == 200) {
      return ExpenseTypeResponse.fromJson(json.decode(responseData.body)).data ??
          [];
    } else {
      throw Exception('Failed to load album');
    }
  }

//vehicle details update
  Future<dynamic> addUpdateExpense(Expense expense) async {
    var encodebody = json.encode(expense.toJson());
    return await post(Uri.parse(AppUrl.updateExpense),
            body: encodebody, headers: {'Content-Type': 'application/json'})
        .then(onExpense)
        .catchError(onError);
  }

  //vehicle details update
  Future<dynamic> addUpdateExpenseType(ExpenseTypeReq expense) async {
    var encodebody = json.encode(expense.toJson());
    return await post(Uri.parse(AppUrl.updateExpenseType),
            body: encodebody, headers: {'Content-Type': 'application/json'})
        .then(onExpense)
        .catchError(onError);
  }

  Future<FutureOr> onExpense(Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    if (responseData["result"] == "updated") {
      result = {'status': true, 'message': 'Successful', 'user': responseData};
    } else if (responseData["result"] == "success") {
      result = {'status': true, 'message': 'Successful', 'user': responseData};
    } else {
      result = {'status': false, 'message': "fail to update profile"};
    }
    return result;
  }
}
