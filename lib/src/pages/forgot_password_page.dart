import 'package:boulevard/src/themes/theme.dart';
import 'package:boulevard/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _BackgroundImage(),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: _Title(),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: _Subtitle(),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: _PasswordForm(),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: _Options(),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image(
      height: 120,
      image: AssetImage('assets/images/plant-03-mod.png'),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'No jodás ¿En serio se te olvidó la contraseña?',
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
      textAlign: TextAlign.center,
    );
  }
}

class _Subtitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Ingresa tu correo electrónico para restablecerla',
      style: TextStyle(color: Color(0xff505050)),
      textAlign: TextAlign.center,
    );
  }
}

class _PasswordForm extends StatefulWidget {
  @override
  __PasswordFormState createState() => __PasswordFormState();
}

class __PasswordFormState extends State<_PasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailValidator = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  String password;

  void resetPassword() {
    if (_formKey.currentState.validate()) {
      print('Restableciendo contraseña...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          InputFormFieldType1(
            prefixIcon: Icon(Icons.mail_outline),
            labelText: 'Correo electrónico',
            textInputType: TextInputType.emailAddress,
            validator: (String value) {
              if (value.trim().length == 0) return 'Ingresa tu correo electrónico';
              if (!_emailValidator.hasMatch(value.trim())) return 'Ingresa un correo válido';
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) => password = value.trim(),
            onFieldSubmitted: (_) => resetPassword(),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ButtonType1(
              backgroundColor: Colors.black,
              textColor: Colors.white,
              text: 'Restablecer',
              onPressed: resetPassword,
            ),
          ),
        ],
      ),
    );
  }
}

class _Options extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('No funciona'),
        SizedBox(width: 5),
        Text(
          'Intenta de otra forma',
          style: TextStyle(color: teal, fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
