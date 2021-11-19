// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Widget/Suffle.dart';
import 'package:todoapp/Widget/TaskCard.dart';
import 'package:todoapp/pages/NoteFetching.dart';
import 'package:todoapp/service.dart/auth_service.dart';

import 'AddTodo.dart';
import 'Login.dart';
import 'TodoFetching.dart';
import 'viewData.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection("Task").snapshots();
  Auth auth = Auth();
  late TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TabController(length: 2, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                auth.logout();
                 Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (builder) => LoginPage()),
                          (route) => false);


              })
        ],
        title: controller.index + 1 == 2 ? Text("NOTE") : Text("TO-DO"),
        centerTitle: true,
        backgroundColor: Colors.black87,
        bottom: TabBar(
          controller: controller,
          tabs: [
            Tab(text: "Todo"),
            Tab(text: "Note"),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [DataFetching(), NoteFetching()],
      ),
    );
  }
}
