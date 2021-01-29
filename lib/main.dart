import 'package:chat_app/Helper/authentication.dart';
import 'package:chat_app/Views/chatRoomsScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

User firebaseUser = FirebaseAuth.instance.currentUser;
Widget firstWidget;
void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
if (firebaseUser != null) {
    firstWidget = ChatRoom();
  } else {
    firstWidget = Authentication();
  }
runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home:Splash(), 
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      backgroundColor: Colors.deepPurple,
      image: Image.asset('assets/images/splash.png'),
      photoSize: 150.0,
      loaderColor: Colors.white,
      navigateAfterSeconds: firstWidget,
    );
  }
}


