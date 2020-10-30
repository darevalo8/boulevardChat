import 'package:boulevard/src/helpers/constants.dart';
import 'package:boulevard/src/helpers/helper_functions.dart';
import 'package:boulevard/src/pages/coversation_screen.dart';
import 'package:boulevard/src/services/auth.dart';
import 'package:boulevard/src/services/database.dart';
import 'package:boulevard/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChatRooms extends StatefulWidget {
  ChatRooms({Key key}) : super(key: key);

  @override
  _ChatRoomsState createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  AuthService authService = AuthService();
  DatabaseService databaseService = DatabaseService();
  Stream chatRoomsStream;
  @override
  void initState() {
    getUserInfo();

    super.initState();
  }

  getUserInfo() async {
    Constants.myUserName = await HelperFunctions.getUserNameSharedPreference();

    databaseService.getUserChats(Constants.myUserName).then((value) {
      setState(() => chatRoomsStream = value);
    });
  }

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            print("chatttt ${snapshot.data.docs[index].data()["chatroomId"]}");
            return ChatRoomTile(
              userName: snapshot.data.docs[index]
                  .data()["chatroomId"]
                  .replaceAll("_", "")
                  .replaceAll(Constants.myUserName, ""),
              chatRoomId: snapshot.data.docs[index].data()["chatroomId"],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BoulevardChat"),
          actions: [
            GestureDetector(
              onTap: () {
                authService.signOut();
                HelperFunctions.saveUserLoggedInSharedPreference(false);
                Navigator.pushReplacementNamed(context, 'auth');
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff00b9b0),
          child: Icon(Icons.search),
          onPressed: () {
            Navigator.pushNamed(context, 'search_screen');
          },
        ),
        body: chatRoomList());
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  const ChatRoomTile({Key key, this.userName, this.chatRoomId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConversationPage(chatRoomId: this.chatRoomId)),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // color: Colors.blue,
                color: Color(0xff00b9b0),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                "${this.userName.substring(0, 1).toUpperCase()}",
                // style: mediumTextStyle(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 8),
            Text(this.userName, style: mediumTextStyle())
          ],
        ),
      ),
    );
  }
}
