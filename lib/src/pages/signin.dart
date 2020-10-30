import 'package:boulevard/src/helpers/helper_functions.dart';
import 'package:boulevard/src/services/auth.dart';
import 'package:boulevard/src/services/database.dart';
import 'package:boulevard/src/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn({Key key, this.toggle}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  AuthService authService = AuthService();
  DatabaseService databaseService = DatabaseService();
  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;
  signIn() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authService
          .signInWithEmailAndPassword(
              emailTextController.text, passwordTextController.text)
          .then((value) {
        if (value != null) {
          // Se consulta la info del usuario para colocar el email
          // y el username en los sharedPreference
          databaseService
              .getUserByEmail(emailTextController.text)
              .then((value) {
            snapshotUserInfo = value;
            HelperFunctions.saveUserEmailSharedPreference(
                snapshotUserInfo.docs[0].data()["email"]);
            HelperFunctions.saveUserNameSharedPreference(
                snapshotUserInfo.docs[0].data()["username"]);
          });

          HelperFunctions.saveUserLoggedInSharedPreference(true);

          Navigator.pushReplacementNamed(context, 'chatrooms');
        }
      }).catchError((e) {
        print(e.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
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
                      SizedBox(height: 20),
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
                      SizedBox(height: 10),
                      TextFormField(
                          obscureText: true,
                          validator: (val) {
                            return val.length < 6
                                ? "Digita una Password de 6 o más caracteres"
                                : null;
                          },
                          controller: passwordTextController,
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration("password")),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "Olvidó su contraseña?",
                      style: simpleTextStyle(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                // Bottom Sign in
                GestureDetector(
                  onTap: () {
                    signIn();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black,
                        // gradient: LinearGradient(colors: [
                        //   const Color(0xff007EF4),
                        //   const Color(0xff2A75BC)
                        // ]),
                        ),
                    child: Text(
                      "Iniciar Sesión",
                      // style: mediumTextStyle(),
                      style: TextStyle(color: Colors.white, fontSize: 16),
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
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.black)),
                  child: Text(
                    "Inicia con Google",
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No tienes cuenta?',
                      style: mediumTextStyle(),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        widget.toggle();
                        // Navigator.pushNamed(context, 'signup');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Registrate Ahora',
                          style: TextStyle(
                              color: Color(0xff00b9b0),
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
