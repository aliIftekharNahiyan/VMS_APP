import 'package:flutter/material.dart';
import 'package:amargari/model/common_dropdown_model.dart';
import 'package:amargari/widgets/dropdown.dart';
import 'package:amargari/widgets/widgets.dart';

class DropDownListItem extends StatefulWidget {
  DropDownListItem({
    required this.textTitle,
    required this.requestType,
    required this.list,
    this.isRequired = false,
    this.selectedItem = ""
  });

  final String textTitle, requestType;
  final bool isRequired;
  List<CommonDropDownModel> list;
   String selectedItem;
  @override
  _DropDownListItemState createState() => _DropDownListItemState();
}

class _DropDownListItemState extends State<DropDownListItem> {
  @override
  Widget build(BuildContext context) {

    print(" selectedItem dropdown ${widget.requestType}  ${widget.selectedItem}    ");
    return widget.list.isNotEmpty
        ? Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(children: [

        Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(children: [Visibility(child: Icon(Icons.star, color: Colors.red, size: 10), visible: widget.isRequired,),
              Visibility(child: SizedBox(width: 10,),visible: !widget.isRequired),]),
          ),

       //  Expanded(
       // // flex: 1,
       //  child: ,
       //  ),
        label(widget.textTitle),
        SizedBox(width: 5),
        Expanded(
         // flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: DropDown(
              widget.list,
              isExpanded: true,
              requestType: widget.requestType,
              selectedItem: widget.selectedItem
            ),
          ),
        ),
      ]),
    )
        : Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(children: [Visibility(child: Icon(Icons.star, color: Colors.red, size: 10), visible: widget.isRequired,),
            Visibility(child: SizedBox(width: 10,),visible: !widget.isRequired),]),
        ),
        label(widget.textTitle),
        Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text("No value, please add fast", style: TextStyle(fontSize: 14),)))
      ]),
    );
  }
}
//
