import 'package:flutter/material.dart';
import 'package:amargari/model/common_dropdown_model.dart';
import 'package:amargari/widgets/dropdown.dart';
import 'package:amargari/widgets/widgets.dart';

class DropDownBorderItem extends StatefulWidget {
  DropDownBorderItem({
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
  _DropDownBorderItemState createState() => _DropDownBorderItemState();
}

class _DropDownBorderItemState extends State<DropDownBorderItem> {
  @override
  Widget build(BuildContext context) {

    print(" selectedItem dropdown ${widget.requestType}  ${widget.selectedItem}    ");
    return widget.list.isNotEmpty
        ? InputDecorator(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      child: Row(children: [
        Expanded(
          // flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            child: DropDown(
                widget.list,
                isExpanded: true,
                requestType: widget.requestType,
                selectedItem: widget.selectedItem,
                isUnderline: false,
                onCallback: (){},
            ),
          ),
        ),
      ]),
    )
        : InputDecorator(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      child: Row(children: [
      /*  Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Row(children: [Visibility(child: Icon(Icons.star, color: Colors.red, size: 10), visible: widget.isRequired,),
            Visibility(child: SizedBox(width: 10,),visible: widget.isRequired),]),
        ),
        label(widget.textTitle),*/
        Expanded(
          child: hintLabelLeft("No value found"),

        )
      ]),
    );
  }
}
//
