import 'package:flutter/material.dart';
class VehicleListItem extends StatefulWidget {
    VehicleListItem({
    required this.textTitle,
    required this.text,
  });

  final String textTitle, text;
  @override
  _VehicleListItemState createState() => _VehicleListItemState();
}

class _VehicleListItemState extends State<VehicleListItem> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(widget.textTitle, style: TextStyle(fontSize: 12)),
          ),
          SizedBox(width: 1),
          Expanded(
            child: Text(widget.text, style: TextStyle(fontSize: 11)),
          ),
          SizedBox(width: 1),
        ],
      ),
    );
  }
}