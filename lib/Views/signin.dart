import 'package:chat_app/Helper/sharedprefencefunctions.dart';
import 'package:chat_app/Services/auth.dart';
import 'package:chat_app/Services/database.dart';
import 'package:chat_app/Views/chatRoomsScreen.dart';
import 'package:chat_app/Widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final formKey =GlobalKey<FormState>();
  TextEditingController eMailTextEditingController =new TextEditingController();
  TextEditingController passwordTextEditingController =new TextEditingController();
  AuthMethods authMethods= new AuthMethods();
  DatabaseMethods databaseMethods =new DatabaseMethods();

  bool isLoading=false;
  QuerySnapshot snapshotUserInfo;

  signIn(){
    if(formKey.currentState.validate()){

      SharedPreferenceFunctions.saveUserEmailSharedPreference(eMailTextEditingController.text.trim());

      databaseMethods.getUserByUserEmail(eMailTextEditingController.text)
      .then((val){
        snapshotUserInfo=val;
        SharedPreferenceFunctions
        .saveUserNameSharedPreference(snapshotUserInfo.docs[0].data()["name"]);
      });

      setState(() {
        isLoading=true;
      });

      authMethods.signInWithEmailAndPassword(eMailTextEditingController.text.trim(), 
      passwordTextEditingController.text).then((val){
      if(val !=null){
        SharedPreferenceFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ChatRoom()));
      }
      
      });
      
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form( //if we want to use TextFormField then we should use Form
              key:formKey,
                child: Column(
                  children: [
                    TextFormField( //if it is not TextFormField then we can not use validator
                       validator: (val){
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                          null : "Enter correct email";
                    },
                      controller: eMailTextEditingController,
                      decoration: InputDecoration(
                        hintText: "E-mail",
                        hintStyle: TextStyle(color: Colors.black54),
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      validator:  (val){
                      return val.length < 6 ? "Enter Password 6+ characters" : null;
                    },
                      controller: passwordTextEditingController,
                      decoration: InputDecoration(hintText: "Password"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  child: Text("Forget Password?",
                      style: Theme.of(context).textTheme.headline3),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: (){
                  signIn();
                },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    const Color(0xff9575cd),
                    const Color(0xff2a75bc)
                  ]),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    )
                  ],
                ),
                child: Text("Sign In",
                    style: Theme.of(context).textTheme.headline1),
              ),
          ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    )
                  ],
                ),
                child: Text("Sign In with Google",
                    style: Theme.of(context).textTheme.headline2),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.toggle();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Register now",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
