import 'package:chat_app/Helper/authentication.dart';
import 'package:chat_app/Helper/sharedprefencefunctions.dart';
import 'package:chat_app/Views/chatRoomsScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userIsLoggedIn=false;

@override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState()async{
    await SharedPreferenceFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
         textTheme: TextTheme(
            headline1: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white),
            headline2: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black),
            headline3: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
      ),
      ),
      home:  userIsLoggedIn ? ChatRoom() : Authentication(),
    );
  }
}



