import 'package:boulevard/src/helpers/helper_functions.dart';
import 'package:boulevard/src/services/auth.dart';
import 'package:boulevard/src/services/database.dart';
import 'package:boulevard/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp({Key key, @required this.toggle}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  AuthService _authService = AuthService();
  DatabaseService databaseService = DatabaseService();
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  signUp(BuildContext context) {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      _authService
          .signUpWithEmailAndPassword(
              emailTextController.text, passwordTextController.text)
          .then((value) {
        if (value != null) {
          Map<String, dynamic> userInfoMap = {
            'username': userNameTextController.text,
            'email': emailTextController.text
          };
          databaseService.uploadUserInfo(userInfoMap);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userNameTextController.text);
          HelperFunctions.saveUserEmailSharedPreference(
              emailTextController.text);
          Navigator.pushReplacementNamed(context, 'chatrooms');
        }
        // print("$value")
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                // height: MediaQuery.of(context).size.height - 150,
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                String message;
                                if (value.isEmpty || value.length < 4) {
                                  message = "Es obligatorio el username";
                                }
                                return message;
                              },
                              controller: userNameTextController,
                              style: simpleTextStyle(),
                              decoration: textFieldInputDecoration("username"),
                            ),
                            TextFormField(
                              validator: (value) {
                                String message;
                                if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  message = 'Digita un correo valido';
                                }
                                return message;
                              },
                              controller: emailTextController,
                              style: simpleTextStyle(),
                              decoration: textFieldInputDecoration("Email"),
                            ),
                            TextFormField(
                                validator: (val) {
                                  return val.length < 6
                                      ? "Enter Password 6+ characters"
                                      : null;
                                },
                                obscureText: true,
                                controller: passwordTextController,
                                style: simpleTextStyle(),
                                decoration:
                                    textFieldInputDecoration("password")),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      // Container(
                      //   alignment: Alignment.centerRight,
                      //   child: Container(
                      //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      //     child: Text(
                      //       "Olvidó su contraseña?",
                      //       style: simpleTextStyle(),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 8,
                      ),
                      // Bottom Sign in
                      GestureDetector(
                        onTap: () {
                          signUp(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(colors: [
                                const Color(0xff007EF4),
                                const Color(0xff2A75BC)
                              ])),
                          child: Text(
                            "Registrarse",
                            style: mediumTextStyle(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      // Bottom google
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white),
                        child: Text(
                          "Registrarse con Google",
                          style: TextStyle(color: Colors.black87, fontSize: 17),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Tienes cuenta?',
                            style: mediumTextStyle(),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toggle();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                'Inicia sesión Ahora',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
