import 'package:chat_app/Helper/constants.dart';
import 'package:chat_app/Services/database.dart';
import 'package:chat_app/Widgets/widget.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageTextEditingController =
      new TextEditingController();
  Stream streamChatMessages;

  Widget chatMessageList() {
    return StreamBuilder(
      stream: streamChatMessages,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageShape(
                      snapshot.data.docs[index].data()["message"],
                      snapshot.data.docs[index].data()["sendBy"] ==
                          Constants.myName);
                })
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageTextEditingController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageTextEditingController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversation(widget.chatRoomId, messageMap);
      messageTextEditingController.text = "";
    }
  }

  @override
  void initState() {
    databaseMethods.getConversation(widget.chatRoomId).then((value) {
      setState(() {
        streamChatMessages = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        color: Color(0xffF3EFEE),
        child: Stack(
          children: [
            chatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xFFB39DDB),  
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageTextEditingController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: "Send message...",
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
                        sendMessage();
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
                            "assets/images/send.png",
                            height: 25,
                            width: 25,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageShape extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageShape(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSendByMe ? 0:12, right: isSendByMe ? 12:0),
      margin: EdgeInsets.symmetric(vertical:6),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
     // child: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:20, vertical:12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSendByMe ? [
              const Color(0xFFD1C4E9),
              const Color(0xFFD1C4E9)
            ]
            : [
              const Color(0xFFFFFFFF),
              const Color(0xFFFFFFFF)
            ]
          ),
          borderRadius: isSendByMe ?
          BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
            bottomLeft: Radius.circular(23),
          ) :
          BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
            bottomRight: Radius.circular(23),
          ) 
         
        ),
        child: Text(message,
            style: TextStyle(fontSize: 16, 
            color: Colors.black54)
            ),
      ),
     // ),
    );
  }
}
