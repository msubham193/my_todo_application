// ignore_for_file: prefer_const_constructors_in_immutables, file_names, prefer_const_constructors

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/service.dart/auth_service.dart';

import 'Home.dart';
import 'Login.dart';

class Spalsh extends StatefulWidget {
  Spalsh({Key? key}) : super(key: key);

  @override
  _SpalshState createState() => _SpalshState();
}

class _SpalshState extends State<Spalsh> {
 var currentUser = FirebaseAuth.instance.currentUser;

  Widget currentPage = LoginPage();
  Auth auth = Auth();

  void checkLogin() async {
    if (currentUser != null) {
       setState(() {
        currentPage = HomePage();
      
      });
      
    }
 
  }
 
  @override
  void initState() {
    super.initState();
        checkLogin();
    Timer(
        Duration(seconds: 4),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => currentPage)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment(0.0,0.8),children:[ Lottie.asset('assets/Lottie/spalshi.json'),
      
      Text("Developed by Subham Mishra",style:TextStyle(color:Colors.white,fontSize:15,fontWeight:FontWeight.w400),textAlign:TextAlign.center,),


      ]
      
      
      
      ),
   
  
          
    );
  }
}
