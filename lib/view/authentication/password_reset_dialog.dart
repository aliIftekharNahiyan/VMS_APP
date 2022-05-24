
import 'package:amargari/model/o_t_p_confirm.dart';
import 'package:amargari/providers/auth.dart';
import 'package:amargari/uril/routes.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

TextEditingController _textFieldController = TextEditingController();
TextEditingController _otpFieldController = TextEditingController();
Future<void> passwordResetDialog(BuildContext context, String mobileNumber, String? otp, {type: String}) async {

  return showDialog(

    context: context,
    builder: (context) {

      void confirmPassword(){
        AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
        final Future<OTPConfirm> successfulMessage =
        auth.updatePassword(mobileNumber, _textFieldController.text, _otpFieldController.text);
        successfulMessage.then((value) => {

          print(value.result),
          if( value.result == "success" ){
            Flushbar(
              title: "Forget password!!",
              message: "Your password has been changed",
              duration: Duration(seconds: 5),
            ).show(context),
            // Navigator.pop(context),
            // Navigator.pop(context),
            // Navigator.pop(context),
             Navigator.pushReplacementNamed(context, MyRoutes.loginRoute)
            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: builder), (route) => false)

          }else{
            Flushbar(
                title: "Forget password!!",
                message: value.reason,
                duration: Duration(seconds: 5)),
              snackBar(context, "Password or otp should not empty")
          }
        });
        print(successfulMessage.toString());
       // Navigator.pop(context);
      //  Navigator.pop(context);
      }

      return AlertDialog(
        title: Text('Reset Password!!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children:[ TextField(
            controller: _textFieldController,
            decoration: commonInputDecoration("New Password", "Type new password"),
          ),
            SizedBox(height: 15,),
            TextField(
            controller: _otpFieldController,
            decoration: commonInputDecoration("OTP", "Type otp"),
          )] ,
        ),
        actions: <Widget>[
          TextButton(
            child: Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('OK'),
            onPressed: () {

              if(_textFieldController.text.isNotEmpty && _otpFieldController.text.isNotEmpty)
                {
                   confirmPassword();

                  // }{
                  //   snackBar(context, "OTP not matched, please try correct on.");
                  // }
                }else{
                // Flushbar(
                //     title: "Forget password!!",
                //     message: "Password or otp should not empty",
                //     duration: Duration(seconds: 5));
                   snackBar(context, "Password or otp should not empty");
              }

            },
          ),
        ],
      );
    },
  );
}