import 'package:chat_app/Helper/constants.dart';
import 'package:chat_app/Services/database.dart';
import 'package:chat_app/Views/conversationScreen.dart';
import 'package:chat_app/Widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController =
      new TextEditingController();

  QuerySnapshot searchSnapshot;

  initiateSearch() {
    databaseMethods
        .getUserByUsername(searchTextEditingController.text)
        .then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }


  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return searchTile(
                userName: searchSnapshot.docs[index].data()["name"],
                userEmail: searchSnapshot.docs[index].data()["email"],
              );
            })
        : Container();
  }

createChatRoomAndStartConversation({String userName}){

//print("${Constants.myName}");
if(userName != Constants.myName){
 
   String _chatRoomId=getChatRoomId(userName,Constants.myName  );
    List<String> users = [userName, Constants.myName];

  Map<String, dynamic> chatRoomMap ={
    "users" : users,
    "chatroomId": _chatRoomId
  };

  DatabaseMethods().createChatRoom(_chatRoomId, chatRoomMap);

  Navigator.push(context, MaterialPageRoute(
    builder: (context) => ConversationScreen(_chatRoomId, userName) ),);
}else{
  print("You can't send message to yourself.");
}
  
}

Widget searchTile({String userName, String userEmail}){
return Container(
      padding: EdgeInsets.symmetric(horizontal:24, vertical:16),
      decoration: BoxDecoration(
      border: Border(
      bottom: BorderSide(width: 1.0, color: Colors.black26,),
      top:BorderSide(width: 1.0, color: Colors.black26,),),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: Theme.of(context).textTheme.headline3),
              Text(userEmail, style: Theme.of(context).textTheme.headline3),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
           createChatRoomAndStartConversation(
             userName: userName
           );
            },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(24)),
            child: Text(
              "Message",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
      ),
        ],
      ),
    );
}
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:8),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xFFB39DDB),  
                ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextEditingController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: "Search username...",
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0x36FFFFFF),
                                  const Color(0x0FFFFFFF)
                                ],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight),
                            borderRadius: BorderRadius.circular(40)),
                        padding: EdgeInsets.all(12),
                        child: Image.asset(
                          "assets/images/search_white.png",
                          height: 25,
                          width: 25,
                        )),
                  ),
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
    if /*(a.compareTo(b)>0)*/ (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)){
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
