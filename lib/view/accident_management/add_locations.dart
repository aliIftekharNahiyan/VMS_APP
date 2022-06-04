import 'package:amargari/providers/service_provider.dart';
import 'package:amargari/view/common_view/all_drop_down_Item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({Key? key}) : super(key: key);

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    _loadData(context);
    super.initState();
  }

  void _loadData(BuildContext context) async {
    Provider.of<ServiceProvider>(context, listen: false).getLocationType();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("Add Map Location"),
        ),
        body: Container(child: Text("data")),
      ),
    );
  }
}
