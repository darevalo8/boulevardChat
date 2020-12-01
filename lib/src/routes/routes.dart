import 'package:boulevard/src/helpers/authenticate.dart';
import 'package:boulevard/src/pages/chat_rooms_screen.dart';
import 'package:boulevard/src/pages/coversation_screen.dart';
import 'package:boulevard/src/pages/forgot_password_page.dart';
import 'package:boulevard/src/pages/initial_page.dart';
import 'package:boulevard/src/pages/navigation_bar.dart';
import 'package:boulevard/src/pages/public_chat_page.dart';
import 'package:boulevard/src/pages/search.dart';
import 'package:boulevard/src/pages/signin_page.dart';
import 'package:boulevard/src/pages/signup_page.dart';
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

    'initial': (BuildContext context) => InitialPage(),
    'signin': (BuildContext context) => SignInPage(),
    'signup': (BuildContext context) => SignUpPage(),
    'forgot_password': (BuildContext context) => ForgotPasswordPage(),
    'navigation_bar': (BuildContext context) => NavigationBar(),
    'public_chat_page': (BuildContext context) => PublicChatPage(),
  };
}
