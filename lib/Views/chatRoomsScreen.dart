import 'package:chat_app/Helper/authentication.dart';
import 'package:chat_app/Helper/constants.dart';
import 'package:chat_app/Helper/sharedprefencefunctions.dart';
import 'package:chat_app/Services/auth.dart';
import 'package:chat_app/Views/search.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}



class _ChatRoomState extends State<ChatRoom> {

AuthMethods authMethods = new AuthMethods();

@override
  void initState() {
   getUserInfo();
    super.initState();
  }

  getUserInfo() async{
    Constants.myName= await SharedPreferenceFunctions.getUserNameSharedPreference();
    setState(() {
      
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
