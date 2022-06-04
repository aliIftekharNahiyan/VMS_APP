import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:amargari/providers/common_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/widgets/widgets.dart';

class FilePickerDemo extends StatefulWidget {
  //FilePickerDemo(var images);

  FilePickerDemo({required this.requestFileType, required this.imageURL});
  final String requestFileType;
  final String imageURL;

  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _fileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();

  _FilePickerDemoState();
  var isVisible = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      print(_paths!.first.extension);
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    });
  }

/*  void _clearCachedFiles() {
    FilePicker.platform.clearTemporaryFiles().then((result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: result ? Colors.green : Colors.red,
          content: Text((result
              ? 'Temporary files removed with success.'
              : 'Failed to clean temporary files')),
        ),
      );
    });
  }*/

  void _selectFolder() {
    FilePicker.platform.getDirectoryPath().then((value) {
      setState(() => _directoryPath = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    CommonProvider commonProvider = Provider.of<CommonProvider>(context);
    var getUserData = UserPreferences().getUser();
    var doUploadFile = (String path) {
      snackBar(context, "Start to upload image, please wait");

      getUserData.then((user) => setState(() {
            print("path:  " + path);
            final Future<String> url = commonProvider.uploadImage(
                user.name ?? "", user.mobileNo ?? "", path);
            url.then((value) {
              print("Response output " + value);

              if (widget.requestFileType == "nid") {
                AppConstant.NidURL = value;
              } else if (widget.requestFileType == "drivingLicense") {
                AppConstant.drivingLicenseURL = value;
              } else if (widget.requestFileType == "VehicleImage") {
                AppConstant.vehicleImageURL = value;
              } else if (widget.requestFileType == "AccidentImage") {
                AppConstant.accidentImageURL = value;
              } else if (widget.requestFileType == "InsuranceImgURL") {
                AppConstant.insuranceImgURL = value;
              } else if (widget.requestFileType == "FuelSlipImage") {
                AppConstant.fuelSlipImgURL = value;
              }

              snackBar(context, "Successfully upload user Image");
              print("fuelSlipImgURL:  " + AppConstant.fuelSlipImgURL);
            });
          }));
    };
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("File Picker"),
      ),
      key: _scaffoldKey,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Your Image",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Image.network(
                      widget.imageURL,
                      height: 200,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _openFileExplorer(),
                      child: const Text("Select file or Image"),
                    ),

                    /* ElevatedButton(
                            onPressed: () => _selectFolder(),
                            child: const Text("Pick folder"),
                          ),
                          ElevatedButton(
                            onPressed: () => _clearCachedFiles(),
                            child: const Text("Clear temporary files"),
                          ),*/
                  ],
                ),
              ),
              Builder(
                builder: (BuildContext context) => _loadingPath
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: const CircularProgressIndicator(),
                      )
                    : _directoryPath != null
                        ? ListTile(
                            title: const Text('Directory path'),
                            subtitle: Text(_directoryPath!),
                          )
                        : _paths != null
                            ? Container(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                height:
                                    MediaQuery.of(context).size.height * 0.50,
                                child: Scrollbar(
                                    child: ListView.separated(
                                  itemCount:
                                      _paths != null && _paths!.isNotEmpty
                                          ? _paths!.length
                                          : 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final bool isMultiPath =
                                        _paths != null && _paths!.isNotEmpty;
                                    final String name = 'File $index: ' +
                                        (isMultiPath
                                            ? _paths!
                                                .map((e) => e.name)
                                                .toList()[index]
                                            : _fileName ?? '...');
                                    final path = _paths!
                                        .map((e) => e.path)
                                        .toList()[index]
                                        .toString();

                                    return Column(
                                      children: [
                                        /* ListTile(
                                      title: Text(
                                        name,
                                      ),
                                      subtitle: Text("File Path: "+path),

                                    ),*/
                                        //Image.file(new File(path), height: 200),
                                        Text(
                                          "do you want to upload new Image?",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(height: 5),

                                        Image.network(
                                          widget.imageURL,
                                          height: 200,
                                        ),

                                        SizedBox(height: 10.0),
                                        //longButtons("Upload", doUploadFile(path))
                                        ElevatedButton(
                                          onPressed: () => doUploadFile(path),
                                          child: const Text("Upload"),
                                        ),
                                      ],
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(),
                                )),
                              )
                            : const SizedBox(),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
