import 'package:flutter/material.dart';

const Color amber = Color(0xffF7B500);
const Color teal  = Color(0xff2CB9B0);
const Color gray  = Color(0xff6D7278);
const Color black = Color(0xff000000);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'SFPro',
  accentColor: teal,
  primaryColor: teal,
  dividerColor: gray,
  primaryColorDark: black,
  canvasColor: Colors.transparent,
  appBarTheme: AppBarTheme(
    color: Colors.white.withOpacity(0.95),
    elevation: 2,
    iconTheme: IconThemeData(color: black),
  ),
  textTheme: TextTheme(
    headline4: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w500,
      color: black,
    ),
    headline5: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: black,
    ),
    headline6: TextStyle(
      color: black,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    subtitle1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: black,
    ),
    // bodyText1: TextStyle(
    //   color: darkGrey,
    //   fontSize: 16,
    //   fontWeight: FontWeight.w400,
    // ),
    // bodyText2: TextStyle(color: darkGrey, fontSize: 14),
  ),
  // chipTheme: ChipThemeData(
  //   backgroundColor: Colors.transparent,
  //   disabledColor: grey,
  //   selectedColor: purple,
  //   secondarySelectedColor: purple,
  //   labelPadding: EdgeInsets.all(0),
  //   padding: EdgeInsets.symmetric(horizontal: 10),
  //   shape: StadiumBorder(side: BorderSide(color: purple, width: 1.0)),
  //   labelStyle: TextStyle(fontSize: 14, color: purple),
  //   secondaryLabelStyle: TextStyle(fontSize: 14, color: Colors.white),
  //   brightness: Brightness.light,
  //   pressElevation: 4,
  // ),
);