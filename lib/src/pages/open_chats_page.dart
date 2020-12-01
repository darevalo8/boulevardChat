import 'package:boulevard/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class OpenChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: Image(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/boulevard-mod.jpg'),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 1),
            Text('(Logo)'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ButtonType1(
                text: 'Dale, entrá, no seas tímido',
                backgroundColor: Colors.black,
                textColor: Colors.white,
                // onPressed: () => Navigator.pushNamed(context, 'search_screen'),
                onPressed: () => Navigator.pushNamed(context, 'public_chat_page'),
              ),
            ),
            Column(
              children: [
                Text('¡Qué hubo ve!', style: TextStyle(color: Colors.black45, fontSize: 22)),
                SizedBox(height: 6),
                Container(width: 100, height: 3, color: Colors.black38,)
              ],
            ),
            SizedBox(height: 1),
          ],
        ),
      ],
    );
  }
}
