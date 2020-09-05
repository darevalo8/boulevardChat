import 'package:boulevard/src/helpers/authenticate.dart';
import 'package:boulevard/src/pages/chat_rooms_screen.dart';
import 'package:boulevard/src/pages/coversation_screen.dart';
import 'package:boulevard/src/pages/search.dart';
// import 'package:boulevard/src/pages/signin.dart';
// import 'package:boulevard/src/pages/signup.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> applicationRoutes() {
  return {
    // 'signin': (BuildContext contex) => SignIn(),
    // 'signup': (BuildContext contex) => SignUp(),
    'auth': (BuildContext context) => AuthenticateHelper(),
    'chatrooms': (BuildContext context) => ChatRooms(),
    'search_screen': (BuildContext context) => SearchScreen(),
    'conversation': (BuildContext context) => ConversationPage(),
  };
}
