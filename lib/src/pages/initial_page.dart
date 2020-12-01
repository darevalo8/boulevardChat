import 'package:boulevard/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatelessWidget {
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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        _BackgroundImage(),
        Positioned(
          bottom: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CurvedBorder(size: 60, corner: Corner.TopRight),
              _Content(),
            ],
          ),
        ),
        Positioned(right: 0, bottom: 60, child: _Plant1()),
        Positioned(left: 0, bottom: 60, child: _Plant2()),
      ],
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('assets/images/woman.jpg'),
    );
  }
}

class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(60)),
      ),
      child: Column(
        children: [
          SizedBox(height: 30),
          Text('¿Qué más ve?', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26)),
          SizedBox(height: 30),
          Text(
            'Es momento de crear nuevos amigos mientras exploras tu ciudad',
            style: TextStyle(color: Color(0xff505050)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          ButtonType1(
            backgroundColor: Colors.black,
            textColor: Colors.white,
            text: 'Registrarse',
            onPressed: () => Navigator.pushNamed(context, 'signup'),
          ),
          SizedBox(height: 14),
          ButtonType1(
            backgroundColor: Colors.grey[200],
            textColor: Colors.black,
            text: 'Iniciar sesión',
            onPressed: () => Navigator.pushNamed(context, 'signin'),
          ),
          SizedBox(height: 25),
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
          SizedBox(height: 25),
        ],
      ),
    );
  }
}

class _Plant1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      child: Image(
        image: AssetImage('assets/images/plant-01-mod.png'),
      ),
    );
  }
}

class _Plant2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      child: Image(
        image: AssetImage('assets/images/plant-02-mod.png'),
      ),
    );
  }
}
