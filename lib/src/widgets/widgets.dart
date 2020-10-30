import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(title: Text("BoulevardChat"));
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    // hintStyle: TextStyle(color: Colors.white54),
    hintStyle: TextStyle(color: Colors.black45),
    // focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Color(0xff00b9b0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Color(0xff00b9b0)),
    ),
  );
}

TextStyle simpleTextStyle() {
  // return TextStyle(color: Colors.white, fontSize: 16);
  return TextStyle(color: Colors.black87, fontSize: 16);
}

TextStyle mediumTextStyle() {
  // return TextStyle(color: Colors.white, fontSize: 17);
  return TextStyle(color: Colors.black87, fontSize: 17);
}
