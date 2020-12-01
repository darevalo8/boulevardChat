import 'package:boulevard/src/helpers/constants.dart';
import 'package:boulevard/src/models/parcero.dart';
import 'package:boulevard/src/services/database.dart';
import 'package:boulevard/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PublicChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Boulevard Chat',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  TextEditingController messageTextEditController = TextEditingController();
  // Convertir a StateFul cuando se usen datos reales

  final List fakeData = [
    {'sendBy': 'Lila', 'message': '¡Hola!'},
    {'sendBy': 'Lila', 'message': 'Soy nueva en este chat, quisiera saber de que trata??'},
    {'sendBy': 'Ana P.', 'message': 'Wow! estas bien??'},
    {'sendBy': 'Lila', 'message': 'hahahaha'},
    {'sendBy': 'Ana P.', 'message': 'Claro, yo puedo decirte'},
    {'sendBy': 'Ana P.', 'message': 'La idea es conocer gente nueva mientras exploras'},
    {'sendBy': 'José Guerra', 'message': 'Si, y también hay retos'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SearchBar(),
        _Contacts(context: context),
        Expanded(child: chatMessagesList()),
        inputMessage(),
      ],
    );
  }

  Widget chatMessagesList() {
    return ListView.builder(
      itemCount: fakeData.length,
      itemBuilder: (context, index) {
        return MessageTile(
          userName: fakeData[index]["sendBy"],
          message: fakeData[index]["message"],
          isSendByMe: fakeData[index]["sendBy"] == 'Ana P.',
        );
      },
    );
  }

  Widget inputMessage() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(blurRadius: 10, spreadRadius: -4, color: Colors.black26)
              ],
            ),
            child: TextField(
              controller: messageTextEditController,
              decoration: InputDecoration(
                hintText: '¿Qué tienes por decir?',
                hintStyle: TextStyle(color: Colors.black45),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: sendMessage,
          child: Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(80),
              boxShadow: <BoxShadow>[
                BoxShadow(blurRadius: 10, spreadRadius: -4, color: Colors.black26)
              ],
            ),
            child: Icon(Icons.send, color: Color(0xff00b9b0)),
          ),
        )
      ],
    );
  }

  sendMessage() {
    if (messageTextEditController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageData = {
        "message": messageTextEditController.text,
        "sendBy": Constants.myUserName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      // databaseService.addMessage(widget.chatRoomId, chatMessageData);
      messageTextEditController.text = "";
    }
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                // controller: searchTextEditController,
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  hintText: 'Buscar en el chat',
                  hintStyle: TextStyle(color: Colors.black45),
                  border: InputBorder.none,
                ),
              ),
            ),
            GestureDetector(
              child: Icon(Icons.search, color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }
}

class _Contacts extends StatelessWidget {
  final BuildContext context;

  _Contacts({Key key, this.context}) : super(key: key);

  final List fakeContacts = [
    ContactAvatar(parcero: Parcero(name: 'Ana Laura', location: 'Cali, Colombia', description: 'Soy una persona completamente des-complicada, me encanta conocer nuevas personas', imageUrl: 'assets/fake-images/artista-1.jpg'), online: true),
    ContactAvatar(parcero: Parcero(imageUrl: 'assets/fake-images/artista-2.jpg'), online: true),
    ContactAvatar(parcero: Parcero(imageUrl: 'assets/fake-images/artista-3.jpg'), online: false),
    ContactAvatar(parcero: Parcero(imageUrl: 'assets/fake-images/artista-4.jpg'), online: true),
    ContactAvatar(parcero: Parcero(imageUrl: 'assets/fake-images/artista-5.jpg'), online: true),
    ContactAvatar(parcero: Parcero(imageUrl: 'assets/fake-images/artista-6.jpg'), online: true),
    ContactAvatar(parcero: Parcero(imageUrl: 'assets/fake-images/artista-7.jpg'), online: false),
    ContactAvatar(parcero: Parcero(imageUrl: 'assets/fake-images/artista-8.jpg'), online: true),
    ContactAvatar(parcero: Parcero(imageUrl: 'assets/fake-images/artista-9.jpg'), online: false),
    ContactAvatar(parcero: Parcero(imageUrl: 'assets/fake-images/artista-10.jpg'), online: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        scrollDirection: Axis.horizontal,
        itemCount: fakeContacts.length,
        itemBuilder: (context, i) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: fakeContacts[i],
          );
        },
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final String userName;
  final bool isSendByMe;
  const MessageTile({Key key, this.message, this.userName, this.isSendByMe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSendByMe ? 35 : 14, right: isSendByMe ? 14 : 35),
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSendByMe ? Color(0xff00b9b0) : Colors.white,
          border: Border.all(width: 1, color: Color(0xff00b9b0)),
          borderRadius: isSendByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                )
              : BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
        ),
        child: Text(
          "$message - $userName",
          style: TextStyle(color: isSendByMe ? Colors.white : Colors.black87, fontSize: 14),
        ),
      ),
    );
  }
}
