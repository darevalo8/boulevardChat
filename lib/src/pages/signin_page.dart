import 'package:boulevard/src/themes/theme.dart';
import 'package:boulevard/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
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
    return Stack(
      children: [
        Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [_BottomPage()],
          ),
        ),
        _BackgroundImage(),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.13),
              CurvedBorder(size: 70, corner: Corner.TopLeft),
              _Content(),
            ],
          ),
        ),
      ],
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image(
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
      image: AssetImage('assets/images/woman-smiling-mod.jpg'),
    );
  }
}

class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: _SignInForm(),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(60),
          bottomLeft: Radius.circular(60),
          bottomRight: Radius.circular(60),
        ),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final _formKey = GlobalKey<FormState>();
  _SignInModel model = _SignInModel();
  final _emailValidator = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  void signIn() {
    if (_formKey.currentState.validate()) {
      print('Iniciando sesión...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 30),
          Text('¿Y vos qué?', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26)),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Ingresa tu correo electrónico y contraseña',
              style: TextStyle(color: Color(0xff505050)),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: InputFormFieldType1(
              labelText: 'Correo electrónico',
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              prefixIcon: Icon(Icons.mail_outline),
              validator: (String value) {
                if (value.trim().length == 0) return 'Ingresa tu correo electrónico';
                if (!_emailValidator.hasMatch(value.trim())) return 'Ingresa un correo válido';
                _formKey.currentState.save();
                return null;
              },
              onSaved: (String value) => this.model.email = value.trim(),
              onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: InputFormFieldType1(
              labelText: 'Contraseña',
              textInputType: TextInputType.text,
              obscureText: true,
              prefixIcon: Icon(Icons.lock_outline),
              validator: (String value) {
                if (value.trim().length == 0) return 'Ingresa tu contraseña';
                _formKey.currentState.save();
                return null;
              },
              onSaved: (String value) => this.model.password = value.trim(),
              onFieldSubmitted: (_) => signIn(),
            ),
          ),
          SizedBox(height: 25),
          Text(
            'Olvidé mi contraseña',
            style: TextStyle(color: teal, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: ButtonType1(
              backgroundColor: Colors.black,
              text: 'Ingresar',
              textColor: Colors.white,
              onPressed: signIn,
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _BottomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonSocialNetworks(
                socialNetwork: SocialNetworks.Facebook,
                onPressed: () {},
              ),
              ButtonSocialNetworks(
                socialNetwork: SocialNetworks.Google,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '¿No tienes una cuenta?',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 5),
              Text(
                'Ingresa aquí',
                style: TextStyle(color: teal, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SignInModel {
  String email;
  String password;
}
