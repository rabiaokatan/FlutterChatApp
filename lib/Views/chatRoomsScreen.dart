import 'package:chat_app/Helper/authentication.dart';
import 'package:chat_app/Helper/constants.dart';
import 'package:chat_app/Helper/sharedprefencefunctions.dart';
import 'package:chat_app/Services/auth.dart';
import 'package:chat_app/Services/database.dart';
import 'package:chat_app/Views/conversationScreen.dart';
import 'package:chat_app/Views/search.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

AuthMethods authMethods = new AuthMethods();
DatabaseMethods databaseMethods = new DatabaseMethods();

//i used .snapshot() from database.dart side so i should use stream here
Stream streamChatRooms;

Widget chatRoomList(){
return StreamBuilder(stream: streamChatRooms,
    builder:(context , snapshot){
      return snapshot.hasData ? ListView.builder(
        itemCount: snapshot.data.docs.length,
        itemBuilder: (context, index) {
                  return ChatRoomsListView(
                      snapshot.data.docs[index].data()["chatroomId"]
                      .toString().replaceAll("_", "").replaceAll(Constants.myName, ""),
                      snapshot.data.docs[index].data()["chatroomId"]
                      );
                }) : Container();
    });
}

@override
  void initState() {
   getUserInfo();
    super.initState();
  }

  getUserInfo() async{
    Constants.myName= await SharedPreferenceFunctions.getUserNameSharedPreference();
    databaseMethods.getChatRoom(Constants.myName).then((value){
     setState(() {
       streamChatRooms =value;
     });
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatApp'),
        actions: [
          GestureDetector(
            onTap: (){
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context)=>Authentication()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          ),
        ],
      ),
      body: chatRoomList(),
      backgroundColor: Color(0xffF3EFEE),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.search),
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => SearchScreen()));
      },
    ),
    );
  }
}
