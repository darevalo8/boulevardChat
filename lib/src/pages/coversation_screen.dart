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

  @override
  void initState() {
    databaseService.getChats(widget.chatRoomId).then((value) {
      setState(() => chatMessageList = value);
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
            inputMessage(),
          ],
        ),
      ),
    );
  }

  Widget chatMessagesList() {
    return StreamBuilder(
      stream: chatMessageList,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            return MessageTile(
              userName: snapshot.data.docs[index].data()["sendBy"],
              message: snapshot.data.docs[index].data()["message"],
              isSendByMe: snapshot.data.docs[index].data()["sendBy"] == Constants.myUserName,
            );
          },
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
              // color: Color(0x54FFFFFF),
              // border: Border.all(width: 1, color: Colors.black54),
              boxShadow: <BoxShadow>[
                BoxShadow(blurRadius: 10, spreadRadius: -4, color: Colors.black26)
              ]
            ),
            child: TextField(
              controller: messageTextEditController,
              // style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Mensaje...",
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
            // height: 40,
            // width: 40,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(80),
              boxShadow: <BoxShadow>[
                BoxShadow(blurRadius: 10, spreadRadius: -4, color: Colors.black26)
              ]
            ),
            child: Icon(Icons.send, color:  Color(0xff00b9b0)),
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
      databaseService.addMessage(widget.chatRoomId, chatMessageData);
      messageTextEditController.text = "";
    }
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
      // padding: EdgeInsets.symmetric(horizontal: 14),
      padding: EdgeInsets.only(left: isSendByMe ? 35 : 14, right: isSendByMe ? 14 : 35),
      // width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSendByMe?  Color(0xff00b9b0):Colors.white,
          // gradient: LinearGradient(
          //   colors: isSendByMe
          //       ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
          //       : [const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)],
          // ),
          border: Border.all(
            width: 1,
            color:  Color(0xff00b9b0)
          ),
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
