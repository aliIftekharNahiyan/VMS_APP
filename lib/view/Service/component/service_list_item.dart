import 'package:flutter/material.dart';
class ServiceItem extends StatefulWidget {
  ServiceItem({

    required this.textTitle,
    required this.text,
  }) ;

  final String textTitle, text;
  @override
  _ServiceItemState createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(widget.textTitle, style: TextStyle(fontSize: 15)),
          ),
          SizedBox(width: 1),
          Expanded(
            child: Text(widget.text , style: TextStyle(fontSize: 14)),
          ),
          SizedBox(width: 1),
        ],
      ),
    );
  }
}
//
