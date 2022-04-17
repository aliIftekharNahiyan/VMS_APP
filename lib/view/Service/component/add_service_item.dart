import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:amargari/view/file_picker/file_picker_demo.dart';

class AddServiceItem extends StatefulWidget {
  AddServiceItem({

    required this.serviceName,
    required this.serviceNameController,
    required this.serviceCost,
    required this.serviceCostController,
  }) ;

  final String serviceName;
  TextEditingController serviceNameController;
  final String serviceCost;
  TextEditingController serviceCostController;

  @override
  _AddServiceItemState createState() => _AddServiceItemState();
}

class _AddServiceItemState extends State<AddServiceItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(widget.serviceName, style: TextStyle(fontSize: 17)),
              ),
              SizedBox(width: 1),
              Expanded(
                child:TextField(
                  controller: widget.serviceNameController,
                  enabled: true,
                  textInputAction: TextInputAction.next,
                  // onSaved: (value) => AccountItem.username = value,
                //  style: TextStyle(color: Colors.black54),
                  onChanged: (value) {
                    print("change " + widget.serviceNameController.text);
                    setState(() {
                      widget.serviceNameController.text = value;
                    });
                  },
                ),
              ),
              SizedBox(width: 1),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(widget.serviceCost, style: TextStyle(fontSize: 17)),
              ),
              SizedBox(width: 1),
              Expanded(
                child:TextField(
                  controller: widget.serviceCostController,
                  enabled: true,
                  textInputAction: TextInputAction.next,
                  // onSaved: (value) => AccountItem.username = value,
                 // style: TextStyle(color: Colors.black54),
                  onChanged: (value) {
                    print("change " + widget.serviceCostController.text);
                    setState(() {
                      widget.serviceCostController.text = value;
                    });
                  },
                ),
              ),
              SizedBox(width: 1),
            ],
          ),
        ]
      ),

    );
  }
}
//
