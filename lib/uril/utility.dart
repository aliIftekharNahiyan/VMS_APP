import 'package:intl/intl.dart';

String convertDate(String dateTime) {
  DateTime parseDate =
      new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(dateTime);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('yyyy-MM-dd');
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
  // setState(() {});
}

String convertDate2(String? dateTime) {

  print("dateTime 2  $dateTime");

  var outputDate = "";

  if (dateTime != null && dateTime != "") {
    if (dateTime != "null") {
      DateTime parseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(dateTime);
      var inputDate = DateTime.parse(parseDate.toString());

      var outputFormat = DateFormat('yyyy-MM-dd');
      outputDate = outputFormat.format(inputDate);
    }
  }
  return outputDate;
}

String convertDateWithRemaning(String? dateTime) {
  var outputDate = "";
  var status = "";
  if (dateTime != null && dateTime != "") {
    if (dateTime != "null") {
      DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(dateTime);
      var inputDate = DateTime.parse(parseDate.toString());
      var dif = inputDate.difference(DateTime.now()).inDays;
      status = dif == 0 ? "Today Last Day" : dif > 0 ? "$dif day's remaining" : "Expired";
      var outputFormat = DateFormat('yyyy-MM-dd');
      outputDate = outputFormat.format(inputDate);
    }
  }

  return "$outputDate  $status";
}

String convertDateTime(String? dateTime) {

  print("dateTime   $dateTime");

  var outputDate = "";
  if (dateTime != "null" && dateTime != "") {
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(dateTime!);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    outputDate = outputFormat.format(inputDate);
  }

  return outputDate;
}

String convertDate3(String? dateTime) {
  print("dateTime   $dateTime");
  var outputDate = "";
  if (dateTime != "null" && dateTime != "") {
    DateTime parseDate = new DateFormat("dd-MMM-yyyy").parse(dateTime!);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    outputDate = outputFormat.format(inputDate);
  }

  return outputDate;
  // setState(() {});
}

String convertDate4(String? dateTime) {
  print("dateTime   $dateTime");
  var outputDate = "";
  if (dateTime != "null" && dateTime != "") {
    DateTime parseDate = new DateFormat("dd-MM-yyyy").parse(dateTime!);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    outputDate = outputFormat.format(inputDate);
  }

  return outputDate;
  // setState(() {});
}
