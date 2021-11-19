// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:todoapp/pages/Home.dart';
import 'package:todoapp/pages/signup.dart';
import 'package:todoapp/pages/AddTodo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  firebase_auth.FirebaseAuth firebaseauth = firebase_auth.FirebaseAuth.instance;
  TextEditingController emailController =
      TextEditingController(); ////For get email and pasword from text input
  TextEditingController passwordController = TextEditingController();
  bool circular = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: prefer_const_constructors
              Text(
                "Welcome Back !",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 30),
              ButtonIteam("assets/google.svg", "Continue with Google", 25),
              SizedBox(height: 15),
              ButtonIteam("assets/phone.svg", "Continue with Phone", 30),
              SizedBox(height: 15),
              Text("OR", style: TextStyle(color: Colors.grey, fontSize: 18)),
              SizedBox(height: 15),
              textIteam("Email", emailController, false),
              SizedBox(height: 15),
              textIteam("Password", passwordController, true),

              SizedBox(height: 15),
              Text(
                "Forgot password !",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              colorButton(),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text("Don't have an account ? ",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  InkWell(
                    onTap: () {
                        Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => SignUpPage()),
              (route) => false);
                    },
                    child: Text("Create Account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ButtonIteam(String imgPath, String btnName, double size) {
    return InkWell(
      onTap:(){
            
           final snackbar = SnackBar(content: Text("Feature Not Available -- Subham Mishra"));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);

      },
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(width: 1, color: Colors.grey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imgPath,
                height: size,
                width: size,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                btnName,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textIteam(String lable,TextEditingController controller, bool obsecureText) {
    return Container(
        width: MediaQuery.of(context).size.width - 70,
        height: 55,
        child: TextFormField(
           controller: controller,
          obscureText: obsecureText,
           style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              labelText: lable,
              labelStyle: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
                  focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    width: 1.5,
                    color: Colors.amber,
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 1, color: Colors.grey))),
        ));
  }

  Widget colorButton() {
    return InkWell(
      onTap: ()async{
         setState(() {
          circular = true;
        });
        try {
          firebase_auth.UserCredential usercredential =
              await firebaseauth.signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => HomePage()),
              (route) => false);
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });
        }
             

         
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 170,
        height: 55,
        decoration: BoxDecoration(
          // ignore: prefer_const_literals_to_create_immutables
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: [
            Color(0xfffd746c),
            Color(0xffff9068),
            Color(0xfffd746c),
          ]),
        ),
        
        child: Center(
          child:circular
              ? CircularProgressIndicator()
              : Text("Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              )),
        ),
      ),
    );
  }
}
