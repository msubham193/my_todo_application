// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/service.dart/auth_service.dart';

import 'Home.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  String type = "";
  String category = "";

   var currentUser = FirebaseAuth.instance.currentUser!.email;
  Auth auth = Auth();
  CollectionReference users = FirebaseFirestore.instance.collection('Data');
  Future<void> addTodo() {
    return users
        .doc(currentUser)
        .collection("TO-DO")
        .add({
          'Title': titleController.text,
          'Type': type,
          'Category': category,
          'Description': descController.text,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addNote() {
    return users
        .doc(currentUser)
        .collection("NOTE")
        .add({
          'Title': titleController.text,
          'Type': type,
          'Description': descController.text,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            // ignore: prefer_const_literals_to_create_immutables
            gradient: LinearGradient(colors: [
          Color(0xff1d1e26),
          Color(0xff252041),
        ])),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text("Create",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 4)),
                    SizedBox(
                      height: 8,
                    ),
                    Text("New Task",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2)),
                    SizedBox(height: 25),
                    lable("Task Title"),
                    SizedBox(height: 12),
                    title(),
                    SizedBox(height: 30),
                    lable("Task Type"),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        taskSelect("TO-DO", 0xff2664fa),
                        SizedBox(width: 20),
                        taskSelect("NOTE", 0xff2bc8d9),
                      ],
                    ),
                    SizedBox(height: 25),
                    lable("Description"),
                    SizedBox(height: 16),
                    Description(),
                    SizedBox(height: 25),
                    type == "NOTE" ? Container() : lable("Category"),
                    SizedBox(height: 16),
                    Wrap(
                      children: [
                        categorySelect("Shopping", 0xffff6d6e),
                        SizedBox(width: 20),
                        categorySelect("Sports", 0xfff29732),
                        SizedBox(width: 20),
                        categorySelect("Entertainment", 0xff6557ff),
                        SizedBox(width: 20),
                        categorySelect("Study", 0xff234ebd),
                        SizedBox(width: 20),
                        categorySelect("Workout", 0xff78290f),
                        SizedBox(width: 20),
                        categorySelect("Other", 0xff669bbc),
                      ],
                    ),
                    SizedBox(height: 50),
                    Button(),
                    SizedBox(height: 30),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names..
  Widget Button() {
    return InkWell(
      onTap: () {
        type == 'TO-DO' ? addTodo() : addNote();

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => HomePage()),
            (route) => false);
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xff2a2e3d),
          borderRadius: BorderRadius.circular(20),
          gradient:
              LinearGradient(colors: [Color(0xff8a32f1), Color(0xffad32f9)]),
        ),
        child: Center(
            child: Text("Create",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18))),
      ),
    );
  }

  Widget Description() {
    return Container(
      height: 170,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
          controller: descController,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          maxLines: null,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter Description",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
            contentPadding: EdgeInsets.only(left: 20, right: 20),
          )),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
          controller: titleController,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter title",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
            contentPadding: EdgeInsets.only(left: 20, right: 20),
          )),
    );
  }

  Widget lable(String lable) {
    return Text(lable,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16.5,
            letterSpacing: 0.2));
  }

  Widget taskSelect(String lable, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          type = lable;
        });
      },
      child: Chip(
        backgroundColor: type == lable ? Colors.black : Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(lable, style: TextStyle(color: Colors.white, fontSize: 17)),
        labelPadding: EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.8,
        ),
      ),
    );
  }

  Widget categorySelect(String lable, int color) {
    return type == "NOTE"
        ? Container()
        : InkWell(
            onTap: () {
              setState(() {
                category = lable;
              });
            },
            child: Chip(
              backgroundColor: category == lable ? Colors.black : Color(color),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              label: Text(lable,
                  style: TextStyle(color: Colors.white, fontSize: 17)),
              labelPadding: EdgeInsets.symmetric(
                horizontal: 17,
                vertical: 3.8,
              ),
            ),
          );
  }
}
