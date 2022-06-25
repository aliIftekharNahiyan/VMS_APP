import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:amargari/view/file_picker/file_picker_demo.dart';

class CommonNumberItem extends StatefulWidget {
  CommonNumberItem(
      {
      required this.text,
      this.images = '',
      this.isVisible = false,
      this.isEditAble = false,
      this.isDate = false,
      required this.nameController});

  final String text, images;
  final bool isVisible;
  final bool isEditAble;
  final bool isDate;
  TextEditingController nameController;

  // final VoidCallback press;

  @override
  _CommonNumberItemState createState() => _CommonNumberItemState();
}

class _CommonNumberItemState extends State<CommonNumberItem> {
  @override
  Widget build(BuildContext context) {
    //  DateTime _selectedDate;

    //Method for showing the date picker
    void _pickDateDialog() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              //which date will display when user open the picker
              firstDate: DateTime(1950),
              //what will be the previous supported year in picker
              lastDate: DateTime(2050)) //what will be the up to supported date in picker
          .then((pickedDate) {
        //then usually do the future job
        if (pickedDate == null) {
          //if user tap cancel then this function will stop
          return;
        }
        setState(() {
          String formattedDate = DateFormat('dd-MMM-yyyy').format(pickedDate);
          //for rebuilding the ui
          widget.nameController.text =
              formattedDate; //  _selectedDate = pickedDate;
        });
      });
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(widget.text, style: TextStyle(fontSize: 17)),
          ),
          SizedBox(width: 1),
          Visibility(
            child: Expanded(
              child: TextField(
                controller: widget.nameController,
                enabled: true,
                keyboardType: TextInputType.number,
                onTap: () {
                  print('Editing stated $widget');

                  if (widget.isDate) {
                    _pickDateDialog();
                  }
                },
                // onSaved: (value) => AccountItem.username = value,
                style: TextStyle(color: Colors.black54),
                onChanged: (value) {
                  print("change " + widget.nameController.text);
                  setState(() {
                    widget.nameController.text = value;
                  });
                },
              ),
              // ),
            ),
            visible: !widget.isVisible,
          ),
          Visibility(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FilePickerDemo(requestFileType: widget.images, imageURL: widget.nameController.text)));
              },
              child: Image.network(
                widget.nameController.text,
                height: 100,
                width: 100,
              ),
            ),
            visible: widget.isVisible,
          ),
        ],
      ),
    );
  }
}
//
