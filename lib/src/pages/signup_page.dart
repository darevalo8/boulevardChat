import 'package:boulevard/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
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
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CurvedBorder(size: 70, corner: Corner.TopRight),
                _Content(),
                SizedBox(height: 110),
              ],
            ),
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
      image: AssetImage('assets/images/12-mod.jpg'),
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
          topLeft: Radius.circular(60),
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
  _SignUpModel model = _SignUpModel();
  final _emailValidator = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  void signUp() {
    if (_formKey.currentState.validate()) {
      print('Iniciando sesión...');
      Navigator.pushNamed(context, 'navigation_bar');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 26),
          Text('Pegate al parche', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26)),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              '¿Te estabas demorando, no?',
              style: TextStyle(color: Color(0xff505050)),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 26),
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
          SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: InputFormFieldType1(
              labelText: 'Contraseña',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              obscureText: true,
              prefixIcon: Icon(Icons.lock_outline),
              validator: (String value) {
                if (value.trim().length == 0) return 'Ingresa tu contraseña';
                _formKey.currentState.save();
                return null;
              },
              onSaved: (String value) => this.model.password = value.trim(),
              onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            ),
          ),
          SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: InputFormFieldType1(
              labelText: 'Confirma tu contraseña',
              textInputType: TextInputType.text,
              obscureText: true,
              prefixIcon: Icon(Icons.lock_outline),
              validator: (String value) {
                if (value.trim().length == 0) return 'Ingresa de nuevo tu contraseña';
                if (model.password != value.trim()) return 'Las contraseñas no coinciden';
                _formKey.currentState.save();
                return null;
              },
              onSaved: (String value) => this.model.retryPassword = value.trim(),
              onFieldSubmitted: (_) => signUp(),
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: ButtonType1(
              backgroundColor: Colors.black,
              text: 'Ingresar',
              textColor: Colors.white,
              onPressed: signUp,
            ),
          ),
          SizedBox(height: 25),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Ingresa con tu cuenta de Google o Facebook',
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _SignUpModel {
  String email;
  String password;
  String retryPassword;
}
