import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
    //  primarySwatch: Colors.deepPurple,
      fontFamily: "The_Girl_Next_Door",
      cardColor: Colors.white,
      canvasColor: appColor,
      buttonColor: buttonColor,
      primaryColor: buttonColor,
      accentColor: darkBluishColor,
      hintColor: hintColor,
      // buttonTheme:  ButtonThemeData(
      //     buttonColor: buttonColor,
      //     shape: RoundedRectangleBorder(),
      //     ),
      textTheme: Theme.of(context).textTheme.apply(
        bodyColor: titleColor,
        displayColor: titleColor,),
      appBarTheme: AppBarTheme(
        color: buttonColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
       // textTheme: Theme.of(context).textTheme,
      ));

  static ThemeData darkTheme(BuildContext context) => ThemeData(
      brightness: Brightness.dark,
      cardColor: Colors.black,
      canvasColor: titleColor,
      buttonColor: lightBluishColor,
      accentColor: Colors.white,
      primaryColor: buttonColor,
      fontFamily: "The_Girl_Next_Door",
      appBarTheme: AppBarTheme(
        color: Colors.black,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        // textTheme: Theme.of(context).textTheme.copyWith(
        //   headline6:
        //   context.textTheme.headline6.copyWith(color: Colors.white),
        // ),
      ));

  //Colors
  static Color appColor = Color(0xfff6fafb);
  static Color hintColor = Color(0xffc1c8c7);
  static Color titleColor = Color(0xff252b31);
  static Color buttonColor = Color(0xffF1A44F);
  static Color statusBarColor = Color(0xffD89347);
  static Color titleHintColor = Color(0xff616161);


  static Color darkHintColor = Color(0xffc1c8c7);
  static Color darkBluishColor = Color(0xff403b58);
  static Color lightBluishColor = Color(0xffb8b8b8);
}
