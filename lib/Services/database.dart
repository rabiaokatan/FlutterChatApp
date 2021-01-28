import 'package:cloud_firestore/cloud_firestore.dart';



class DatabaseMethods{
//for get users to cloudfirestore...
  getUserByUsername(String username) async{
    return await FirebaseFirestore.instance.collection("users")
      .where("name", isEqualTo: username)
      .get();
  }

getUserByUserEmail(String email) async{
    return await FirebaseFirestore.instance.collection("users")
      .where("email", isEqualTo: email)
      .get();
  }

//set users
  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection("users")
    .add(userMap).catchError((e){
      print(e.toString());
    });
  }

  createChatRoom(String chatroomId, chatRoomMap){
    FirebaseFirestore.instance.collection("ChatRoom")
    .doc(chatroomId).set(chatRoomMap).catchError((e){
      print(e.toString());
  });
  }

//for messages
addConversation(String chatRoomId, messageMap){
FirebaseFirestore.instance.collection("ChatRoom")
.doc(chatRoomId)
.collection("chats").add(messageMap).catchError((e){
  print(e.toString());
  });
}

getConversation(String chatRoomId) async{
return await FirebaseFirestore.instance.collection("ChatRoom")
.doc(chatRoomId)
.collection("chats").orderBy("time").snapshots();
}

getChatRoom(String userName) async{
return await FirebaseFirestore.instance.collection("ChatRoom")
.where("users", arrayContains:userName)
.snapshots();
}

}