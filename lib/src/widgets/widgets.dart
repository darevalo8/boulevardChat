import 'package:boulevard/src/models/parcero.dart';
import 'package:boulevard/src/themes/theme.dart';
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

// Nuevos widgets:

class ButtonType1 extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Function onPressed;

  const ButtonType1({
    this.backgroundColor = Colors.black,
    this.text = '',
    this.textColor = Colors.white,
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: backgroundColor,
      shape: StadiumBorder(),
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        height: 50,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}

class ButtonSocialNetworks extends StatelessWidget {
  final SocialNetworks socialNetwork;
  final Function onPressed;

  const ButtonSocialNetworks({
    @required this.socialNetwork,
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.grey[200],
      padding: EdgeInsets.all(10),
      shape: CircleBorder(),
      onPressed: onPressed,
      child: Container(
        height: 26,
        child: Image(
          image: AssetImage(socialNetwork == SocialNetworks.Facebook
              ? 'assets/images/facebook-icon.png'
              : 'assets/images/google-icon.png'),
        ),
      ),
    );
  }
}

enum SocialNetworks { Facebook, Google }

class InputFormFieldType1 extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType textInputType;
  final Icon prefixIcon;
  final bool obscureText;
  final Function validator;
  final Function onSaved;
  final TextInputAction textInputAction;
  final Function onFieldSubmitted;

  const InputFormFieldType1({
    @required this.labelText,
    this.textInputType = TextInputType.text,
    this.prefixIcon = const Icon(Icons.edit),
    this.hintText = '',
    this.obscureText = false,
    this.textInputAction = TextInputAction.done,
    @required this.validator,
    @required this.onSaved,
    @required this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: textInputType,
      validator: validator,
      onSaved: onSaved,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: teal),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: gray),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}

class ContactAvatar extends StatelessWidget {
  final Parcero parcero;
  final bool online;

  const ContactAvatar({
    this.parcero,
    this.online = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        backgroundColor: Colors.transparent,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25))),
        context: context,
        builder: (context) => ProfileModalBottomSheet(parcero: parcero),
      ),
      child: Container(
        height: 60,
        width: 60,
        child: Stack(
          children: [
            ClipOval(
              child: Image(
                fit: BoxFit.cover,
                image: parcero.imageUrl == ''
                    ? AssetImage('assets/fake-images/no_image.png')
                    : AssetImage(parcero.imageUrl),
                // : NetworkImage(urlImage), // Descomentar para usar imagenes web
              ),
            ),
            if (online)
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class ProfileModalBottomSheet extends StatelessWidget {
  final Parcero parcero;

  const ProfileModalBottomSheet({this.parcero});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 0,
            child: Image(
              height: 260,
              image: AssetImage('assets/images/plant-04-mod.png'),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Container(
                  height: 120,
                  width: 120,
                  child: Image(
                    fit: BoxFit.cover,
                    image: parcero.imageUrl == ''
                        ? AssetImage('assets/fake-images/no_image.png')
                        : AssetImage(parcero.imageUrl),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  parcero.name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  parcero.location,
                  style: TextStyle(color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  parcero.description,
                  style: TextStyle(color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ButtonType1(
                  text: 'Ver perfil',
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  'Enviar mensaje privado',
                  style: TextStyle(color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CurvedBorder extends StatelessWidget {
  final double size;
  final Corner corner;

  const CurvedBorder({@required this.size, this.corner = Corner.TopLeft});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: CustomPaint(
        painter: _CurvedBorderPainter(corner),
      ),
    );
  }
}

class _CurvedBorderPainter extends CustomPainter {
  final Corner corner;

  _CurvedBorderPainter(this.corner);

  @override
  void paint(Canvas canvas, Size size) {
    // Creamos el lapiz
    final paint = new Paint();

    // Propiedades para el lapiz
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill; // Rellena la figura
    paint.strokeWidth = 2; // Que tan grueso es el lapiz

    final path = new Path();

    switch (corner) {
      case Corner.TopLeft:
        path.lineTo(0, size.height);
        path.lineTo(size.width, size.height);
        path.quadraticBezierTo(0, size.height, 0, 0);
        break;
      case Corner.TopRight:
        path.moveTo(0, size.height);
        path.lineTo(size.width, size.height);
        path.lineTo(size.width, 0);
        path.quadraticBezierTo(size.width, size.height, 0, size.height);
        break;
      case Corner.BottomLeft:
        break;
      case Corner.BottomRight:
        break;
      default:
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

enum Corner { TopLeft, TopRight, BottomLeft, BottomRight }
