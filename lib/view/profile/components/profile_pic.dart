import 'dart:io';

import 'package:amargari/providers/common_provider.dart';
import 'package:amargari/uril/app_constant.dart';
import 'package:amargari/uril/shared_preference.dart';
import 'package:amargari/widgets/imageUpload.dart';
import 'package:amargari/widgets/image_picker_gallery_camera.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfilePic extends StatefulWidget {
  var requestType;
  ProfilePic(this.requestType);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  var _image;
  var getUserData  = UserPreferences().getUser();
  bool imageUploadRequest = true;

  @override
  void initState() {
    super.initState();
    getUserData.then((user) => setState(()
    {
      AppConstant.profileImageUrl = user.profilePicture ?? "";
      print(AppConstant.profileImageUrl);
    }
    ));
    // This will print "initState() ---> MainPage"
  }
  Future getImage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
        imageQuality: 10,
        enableCloseButton: true,
        closeIcon: Icon(
          Icons.close,
          color: Colors.red,
          size: 12,
        ),
        context: context,
        source: source,
        barrierDismissible: true,
        cameraIcon: Icon(
          Icons.camera_alt,
          color: Colors.red,
        ),
        //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
        cameraText: Text(
          "From Camera",
          style: TextStyle(color: Colors.red),
        ),
        galleryText: Text(
          "From Gallery",
          style: TextStyle(color: Colors.blue),
        ));
    setState(() {
      _image = image;

    });


  }

  imageUpload(BuildContext context, String imagePath){

    CommonProvider commonProvider = Provider.of<CommonProvider>(context);
    var getUserData  = UserPreferences().getUser();

    //snackBar(context,"Start to upload image, please wait");
    getUserData.then((user) => setState(() {
      print("path:  " + imagePath);
      final Future<String> url = commonProvider.uploadImage(
          user.name ?? "", user.mobileNo ?? "",  imagePath);
      url.then((value){
        print("Response output " + value);
        //   snackBar(context,"Successfully upload user Image");
        print("profileUrl:  "+AppConstant.fuelSlipImgURL);
        AppConstant.profileImageUrl = value;
      }
      );
    }
    ));

  }

  @override
  Widget build(BuildContext context) {


    if (_image != null){
      if (imageUploadRequest) {
        imageUploadRequest = false;
        imageUpload(context, _image.path);
      }
    }

    return SizedBox(
      height: 120,
      width: 120,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
              radius: (60),
              backgroundColor: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: _image != null
                    ? Image.file(
                    File(_image.path),
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover
                )
                    : AppConstant.profileImageUrl == "" || AppConstant.profileImageUrl == "null"  ? Image.asset("assets/images/profile.png") : Image.network(AppConstant.profileImageUrl, height: 120,
                    width: 120, fit: BoxFit.cover),
              )),
          if(widget.requestType == "details" )
            Positioned(
              right: -16,
              bottom: 0,
              child: SizedBox(
                height: 46,
                width: 46,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  color: Color(0xFFF5F6F9),
                  onPressed: () {
                    getImage(ImgSource.Both);
                  },
                  child: Icon(Icons.edit_rounded),

                ),
              ),
            )
        ],
      ),
    );
  }
}
