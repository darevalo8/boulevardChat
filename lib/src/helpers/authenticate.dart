import 'package:boulevard/src/pages/signin.dart';
import 'package:boulevard/src/pages/signup.dart';
import 'package:flutter/material.dart';

class AuthenticateHelper extends StatefulWidget {
  AuthenticateHelper({Key key}) : super(key: key);

  @override
  _AuthenticateHelperState createState() => _AuthenticateHelperState();
}

class _AuthenticateHelperState extends State<AuthenticateHelper> {
  bool showSignIn = true;
  void togleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(
        toggle: togleView,
      );
    } else {
      return SignUp(
        toggle: togleView,
      );
    }
  }
}
