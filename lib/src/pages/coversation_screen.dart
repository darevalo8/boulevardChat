import 'package:boulevard/src/helpers/constants.dart';
import 'package:boulevard/src/services/database.dart';
import 'package:boulevard/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ConversationPage extends StatefulWidget {
  final String chatRoomId;
  ConversationPage({Key key, this.chatRoomId}) : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  DatabaseService databaseService = DatabaseService();
  TextEditingController messageTextEditController = TextEditingController();
  Stream chatMessageList;

  Widget chatMessagesList() {
    return StreamBuilder(
      stream: chatMessageList,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return MessageTile(
                userName: snapshot.data.docs[index].data()["sendBy"],
                message: snapshot.data.docs[index].data()["message"],
                isSendByMe: snapshot.data.docs[index].data()["sendBy"] ==
                    Constants.myUserName,
              );
            });
      },
    );
  }

  sendMessage() {
    if (messageTextEditController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageData = {
        "message": messageTextEditController.text,
        "sendBy": Constants.myUserName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      databaseService.addMessage(widget.chatRoomId, chatMessageData);
      messageTextEditController.text = "";
    }
  }

  @override
  void initState() {
    databaseService.getChats(widget.chatRoomId).then((value) {
      setState(() {
        chatMessageList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Expanded(child: chatMessagesList()),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0x54FFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: messageTextEditController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: "Mensaje...",
                        hintStyle: TextStyle(
                          color: Colors.white54,
                        ),
                        border: InputBorder.none,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                const Color(0x36FFFFFF),
                                const Color(0x0FFFFFFF)
                              ]),
                              borderRadius: BorderRadius.circular(40)),
                          child: Image.asset('assets/images/send.png')),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final String userName;
  final bool isSendByMe;
  const MessageTile({Key key, this.message, this.userName, this.isSendByMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: isSendByMe ? 0 : 24, right: isSendByMe ? 24 : 0),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: isSendByMe
                    ? [
                        const Color(0xff007EF4),
                        const Color(0xff2A75BC),
                      ]
                    : [
                        const Color(0x1AFFFFFF),
                        const Color(0x1AFFFFFF),
                      ]),
            borderRadius: isSendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23),
                  )),
        child: Text(
          "$message - $userName",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}
