import 'package:cloud_firestore/cloud_firestore.dart';


//for set users to cloudfirestore...
class DatabaseMethods{

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
}