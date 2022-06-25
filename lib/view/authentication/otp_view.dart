import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amargari/model/registration_model.dart';
import 'package:amargari/providers/auth.dart';
import 'package:amargari/uril/routes.dart';
import 'package:amargari/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';

class OtpView extends StatefulWidget {

  @override
  _OtpViewState createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final formKey = new GlobalKey<FormState>();
  String otp = "";
  late String number;

  late RegistrationModel registrationModel;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    registrationModel = ModalRoute.of(context)!.settings.arguments as RegistrationModel;
  }
  @override
  Widget build(BuildContext context) {

    AuthProvider auth = Provider.of<AuthProvider>(context);


    // final pinCode =  PinFieldAutoFill(
    //   decoration:  const UnderlineDecoration(colorBuilder: FixedColorBuilder(Colors.black54), textStyle: TextStyle(color: Colors.black87)),
    //     currentCode: otp,// prefill with a code
    //  //   onCodeSubmitted: //code submitted callback
    //   //  onCodeChanged: //code changed callback
    //     codeLength:4,//code length, default 6
    // );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text("Otp Verify ... Please wait")
      ],
    );


    var verifyOtp = () {
      if(otp.isEmpty){
        Flushbar(
          title: "OTP Should not empty",
          duration: Duration(seconds: 10),
        ).show(context);
      }else{
        if (registrationModel.otp ==  otp){

          final Future<Map<String, dynamic>> successfulMessage =
          auth.otpVerify(registrationModel.result ?? "");
          print(successfulMessage);

          Flushbar(
            title: "You are successfully registered",
            duration: Duration(seconds: 10),
          ).show(context);

          Navigator.pushReplacementNamed(context, MyRoutes.dashboardRoute);

        }else{
          Flushbar(
            title: "OTP don't match",
            duration: Duration(seconds: 10),
          ).show(context);
        }

      }

    };
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(40.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.0),
                label("OTP Coder".tr()),
                SizedBox(height: 5.0),
                SizedBox(height: 20.0),
                longButtons("Verify OTP".tr(), verifyOtp),
                SizedBox(height: 5.0),
                //  forgotLabel
              ],
            ),
          ),
        ),
      ),
    );
  }


}
