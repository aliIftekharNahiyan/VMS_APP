import 'package:amargari/model/forget_password_model.dart';
import 'package:amargari/view/authentication/password_reset_dialog.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:amargari/providers/auth.dart';
import 'package:amargari/widgets/themes.dart';
// import 'package:fluttertoast/fluttertoast.dart';


MaterialButton longButtons(String title, VoidCallback fun,
    {Color textColor: Colors.white}) {
  return MaterialButton(
    onPressed: fun,
    textColor: textColor,
    color: MyTheme.buttonColor,
    child: SizedBox(
      width: double.infinity,
      child: Text(title, style: TextStyle(fontSize: 16, fontFamily: GoogleFonts.montserrat().fontFamily, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
    ),
    height: 45,
    minWidth: 600,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}
MaterialButton clickButtons(String title, VoidCallback fun,
    {Color textColor: Colors.white}) {
  return MaterialButton(
    onPressed: fun,
    textColor: textColor,
    color: MyTheme.buttonColor,
    child: SizedBox(
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    ),
    height: 45,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}

label(String title) => Text(title, style: TextStyle(fontSize: 16, fontFamily: GoogleFonts.montserrat().fontFamily), textAlign: TextAlign.left);
hintLabelLeft(String title) => Text(title, style: TextStyle(fontSize: 16, fontFamily: GoogleFonts.montserrat().fontFamily, color: Colors.black12), textAlign: TextAlign.left);

titleLabel(String title) => Text(title,
    style:
    TextStyle(fontSize: 20, fontFamily: GoogleFonts.mateSc().fontFamily));


drawerLabel(String title, IconData iconData) => ListTile(
    leading: Icon(
      iconData,
    ),
    title: Text(
      title,
      textScaleFactor: 1.2,
      style:TextStyle( fontFamily: GoogleFonts.poppins().fontFamily) ,
    ));

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon),
    hintText: hintText,
    hintStyle: TextStyle(fontSize: 14.0, fontFamily: GoogleFonts.montserrat().fontFamily),
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}

InputDecoration commonInputDecoration(String labelText, String hintText) {
  return InputDecoration(
    hintStyle: TextStyle(fontSize: 14.0, fontFamily: GoogleFonts.montserrat().fontFamily),
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    labelText: labelText,
    hintText: hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
    labelStyle: TextStyle(color: MyTheme.titleHintColor),
  );
}
BoxDecoration linearGradientDecoration() {
  return BoxDecoration(
      gradient: new LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xffFEFEFE), Color(0xffC1C1C1)],
      ));
}


TextEditingController _textFieldController = TextEditingController();

Future<void> displayTextInputDialog(BuildContext context) async {
  String otpCode  = "" ;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: label('Reset Password!!'),
        content: TextField(
          controller: _textFieldController,
          keyboardType: TextInputType.number,
          decoration: commonInputDecoration("Mobile Number", "Type your mobile number"),
        ),
        actions: <Widget>[
          TextButton(
            child: label('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: label('OK'),
            onPressed: () {

              AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
              final Future<ForgetPasswordModel> successfulMessage =
              auth.resetPassword(_textFieldController.text);
              successfulMessage.then((value) => {
                print(value),
                if (value.result == "success"){
                  Flushbar(
                    title: "Forget password!!",
                    message: "Message has been send to your register number, please check in mobile sms",
                    duration: Duration(seconds: 5),
                  ).show(context),

                  passwordResetDialog(context, _textFieldController.text, value.otp),

                  //Navigator.pop(context),

                }else{
                  Flushbar(
                    title: "Forget password!!",
                    message: "Some thing went wrong, please try again",
                    duration: Duration(seconds: 5),
                  ).show(context)

                }

              });
              print(successfulMessage.toString());
              // Navigator.pop(context);


            },
          ),
        ],
      );
    },
  );
}

snackBar2(BuildContext context,String message, {bool success = false}) {
  // return ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //     content: Text(message),
  //     duration: Duration(seconds: 2),
  //   ),
  // );
  Fluttertoast.showToast(
        msg: "$message",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: success ? Color.fromARGB(255, 87, 204, 91): Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
}

snackBar(BuildContext context,String message, {bool success = false}) {
  // return ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
  //   content: Text(message),
  //   behavior: SnackBarBehavior.floating,
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.circular(24),
  //   ),
  //   margin: EdgeInsets.only(
  //       bottom: MediaQuery.of(context).size.height - 10,
  //       right: 20,
  //       left: 20),
  // ));
  Fluttertoast.showToast(
        msg: "$message",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: success ? Color.fromARGB(255, 87, 204, 91): Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
}
onError(error) {
  print("the error is $error.detail");
  return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true;
}

networkCachedImageLoad2(String imageURL){
  print("load imageURL   " + imageURL.replaceAll(" ", "%20"));
  return CachedNetworkImage(
    imageUrl: "https://vms.griho.app/Assests/01913481199_tariqul%20islam_20210929111358.jpg",
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter:
            ColorFilter.mode(Colors.orangeAccent, BlendMode.colorBurn)),
      ),
    ),
    placeholder: (context, url) => Image.asset(
        "assets/images/default_image.jpg",
        fit: BoxFit.fitWidth,
        height: 100
    ),
    errorWidget: (context, url, error) => Image.asset(
        "assets/images/default_image.jpg",
        fit: BoxFit.fitWidth,
        height: 100
    ),
    height: 100,
  );
}
networkCachedImageLoad(String imageURL) {
  print("imageURL  $imageURL");
  CachedNetworkImage(
    imageUrl: imageURL,
    placeholder: (context, url) => CircularProgressIndicator(),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );

}

RegExp _numeric = RegExp(r'^-?[0-9]+$');

/// check if the string contains only numbers
bool isNumeric(String str) {
  return _numeric.hasMatch(str);
}


DateTime? loginClickTime;
bool isRedundantClick(DateTime currentTime){

  if(loginClickTime==null){
    loginClickTime = currentTime;
    print("first click");
    return false;
  }
  print('diff is ${currentTime.difference(loginClickTime!).inSeconds}');
  if(currentTime.difference(loginClickTime!).inSeconds<1){//set this difference time in seconds
    return true;
  }

  loginClickTime = currentTime;
  return false;

}




