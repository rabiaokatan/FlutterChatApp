import 'package:chat_app/Services/auth.dart';
import 'package:chat_app/Widgets/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final formKey= GlobalKey<FormState>();
  bool isLoading = false;

  TextEditingController userNameTextEditingController =new TextEditingController();
  TextEditingController eMailTextEditingController =new TextEditingController();
  TextEditingController passwordTextEditingController =new TextEditingController();

  AuthMethods authMethods =new AuthMethods();

  signMeUp(){
    if(formKey.currentState.validate()){
      setState(() {

          isLoading = true;
      });
      
      authMethods.signUpWithEmailAndPassword(eMailTextEditingController.text, 
      passwordTextEditingController.text).then((val){
        print("$val");
      });
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading ? Container(
        child: Center( child: CircularProgressIndicator())
      ) : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24, vertical:20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (val){
                      return val.isEmpty || val.length < 3 ? "Enter Username 3+ characters" : null;
                    },
                controller: userNameTextEditingController,
                decoration: InputDecoration(
                  hintText: "Username",
                  hintStyle: TextStyle(color: Colors.black54),
                ),
              ),
              TextFormField(
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
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.black54),
                  ),
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
                signMeUp();
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
                child: Text("Sign Up",
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
                child: Text("Sign Up with Google",
                    style: Theme.of(context).textTheme.headline2),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    "Sign In now",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
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
