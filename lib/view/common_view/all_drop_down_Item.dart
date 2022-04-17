import 'package:amargari/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:amargari/model/common_dropdown_model.dart';
import 'package:amargari/widgets/dropdown.dart';
import 'package:amargari/widgets/widgets.dart';

class AllDropDownItem extends StatefulWidget {
  AllDropDownItem(
      {required this.textTitle,
      required this.requestType,
      required this.list,
      this.isRequired = false,
      this.selectedItem = ""});

  final String textTitle, requestType;
  final bool isRequired;
  List<CommonDropDownModel> list;
  String selectedItem;

  @override
  _AllDropDownItemState createState() => _AllDropDownItemState();
}

class _AllDropDownItemState extends State<AllDropDownItem> {
  @override
  Widget build(BuildContext context) {
    print(
        " selectedItem dropdown ${widget.requestType}  ${widget.selectedItem}    ");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children:[
          Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(children: [Visibility(child: Icon(Icons.star, color: Colors.red, size: 10), visible: widget.isRequired,),
            Visibility(child: SizedBox(width: 10,),visible: !widget.isRequired),]),
        ),
          Expanded(
            child: widget.list.isNotEmpty
                ? InputDecorator(
              decoration: InputDecoration(
                  labelText: widget.textTitle,
                  labelStyle: TextStyle(color: MyTheme.titleHintColor),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              child: Row(children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0.0),
                    child: DropDown(
                      widget.list,
                      isExpanded: true,
                      requestType: widget.requestType,
                      selectedItem: widget.selectedItem,
                      isUnderline: false,
                    ),
                  ),
                ),
              ]),
            )
                : InputDecorator(
              decoration: InputDecoration(
                  labelText: widget.textTitle,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  labelStyle: TextStyle(color: MyTheme.titleHintColor),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              child: Row(children: [
                Expanded(
                  child: hintLabelLeft("No value found"),
                )
              ]),
            ),
          ),
        ]
      ),
    );
  }
}
//
