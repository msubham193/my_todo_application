// ignore_for_file: prefer_const_constructors, duplicate_ignore, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/pages/Login.dart';
import 'package:todoapp/pages/Spalsh.dart';
import 'package:todoapp/service.dart/auth_service.dart';
import 'pages/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      home: Spalsh(),
      debugShowCheckedModeBanner: false,
    );
  }
}
