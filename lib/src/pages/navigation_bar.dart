import 'package:boulevard/src/pages/chat_rooms_screen.dart';
import 'package:boulevard/src/pages/coversation_screen.dart';
import 'package:boulevard/src/pages/open_chats_page.dart';
import 'package:boulevard/src/pages/public_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationBar extends StatelessWidget {
  final _pages = [
    Container(color: Colors.green),
    Container(color: Colors.blue),
    // PublicChatPage(),
    // ChatRooms(),
    // ConversationPage(),
    OpenChatsPage(),
    // Container(color: Colors.red),
    Container(color: Colors.yellow),
    Container(color: Colors.purple),
    // Center(child: Text('Parches')),
    // Center(child: Text('Retos')),
    // Center(child: Text('Mensajes')),
    // Center(child: Text('Parceros')),
    // Center(child: Text('Perfil')),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavigationState(),
      child: Builder(
        builder: (context) {
          final navigationState = Provider.of<_NavigationState>(context);
          return Scaffold(
            body: _pages[navigationState.currentPage],
            bottomNavigationBar: _Navigation(),
          );
        },
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationState = Provider.of<_NavigationState>(context);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: navigationState.currentPage,
      onTap: (i) => navigationState.currentPage = i,
      // showSelectedLabels: false,
      // showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.audiotrack,
            color: navigationState.currentPage == 0
                ? Theme.of(context).accentColor
                : Colors.grey[700],
          ),
          title: Text('Parches'),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.offline_bolt,
            color: navigationState.currentPage == 1
                ? Theme.of(context).accentColor
                : Colors.grey[700],
          ),
          title: Text('Retos'),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.message,
            color: navigationState.currentPage == 2
                ? Theme.of(context).accentColor
                : Colors.grey[700],
          ),
          title: Text('Mensajes'),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.people,
            color: navigationState.currentPage == 3
                ? Theme.of(context).accentColor
                : Colors.grey[700],
          ),
          title: Text('Parceros'),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: navigationState.currentPage == 4
                ? Theme.of(context).accentColor
                : Colors.grey[700],
          ),
          title: Text('Perfil'),
        ),
      ],
    );
  }
}

class _NavigationState with ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => this._currentPage;

  set currentPage(int page) {
    this._currentPage = page;
    notifyListeners();
  }
}
