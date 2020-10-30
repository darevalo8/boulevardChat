import 'package:boulevard/src/helpers/constants.dart';
import 'package:boulevard/src/pages/coversation_screen.dart';
import 'package:boulevard/src/services/database.dart';
import 'package:boulevard/src/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextEditController = TextEditingController();
  DatabaseService databaseService = DatabaseService();
  QuerySnapshot searchSnapshot;
  initiateSearch() {
    databaseService.getUserByUsername(searchTextEditController.text).then((val) {
      setState(() => searchSnapshot = val);
    });
  }

  /// creaate chatroom, send user to coversation screen,

  createChatroomAndStartCoversation({String userName}) {
    if (userName != Constants.myUserName) {
      String chatRoomId = getChatRoomId(userName, Constants.myUserName);
      List<String> users = [userName, Constants.myUserName];
      Map<String, dynamic> chatRoomMap = {'users': users, 'chatroomId': chatRoomId};
      DatabaseService().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ConversationPage(chatRoomId: chatRoomId)),
      );
    } else {
      print("no existe");
    }
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return searchTile(
                email: searchSnapshot.docs[index].data()["email"],
                userName: searchSnapshot.docs[index].data()["username"],
              );
            },
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              // color: Color(0x54FFFFFF),
              color: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                      color: Colors.white,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: TextField(
                        controller: searchTextEditController,
                        style: TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          hintText: "Digita un nombre de usuario...",
                          hintStyle: TextStyle(color: Colors.black45),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: initiateSearch,
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Color(0xff00b9b0),
                        // gradient: LinearGradient(
                        //   colors: [const Color(0x36FFFFFF), const Color(0x0FFFFFFF)],
                        // ),
                      ),
                      child: Image.asset('assets/images/search_white.png'),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 9),
            searchList(),
          ],
        ),
      ),
    );
  }

  Widget searchTile({String userName, String email}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: simpleTextStyle()),
              Text(email, style: simpleTextStyle())
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatroomAndStartCoversation(userName: userName);
              print("object");
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff00b9b0),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              // child: Text('Mensaje', style: simpleTextStyle()),
              child: Text('Mensaje', style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

// class SearchTile extends StatelessWidget {
//   final String userName;
//   final String email;
//   const SearchTile({Key key, this.email, this.userName}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//       child: Row(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 this.userName,
//                 style: simpleTextStyle(),
//               ),
//               Text(
//                 this.email,
//                 style: simpleTextStyle(),
//               )
//             ],
//           ),
//           Spacer(),
//           GestureDetector(
//             onTap: () {
//               createChatroomAndStartCoversation(context, this.userName);
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Colors.blue, borderRadius: BorderRadius.circular(30)),
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//               child: Text(
//                 'Mensaje',
//                 style: simpleTextStyle(),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
