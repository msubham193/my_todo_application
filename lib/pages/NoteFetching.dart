// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/Widget/NoteCard.dart';
import 'package:todoapp/pages/viewData.dart';

import 'AddTodo.dart';

class NoteFetching extends StatefulWidget {
  const NoteFetching({Key? key}) : super(key: key);

  @override
  _NoteFetchingState createState() => _NoteFetchingState();
}

class _NoteFetchingState extends State<NoteFetching> {
  String docs = "";
static var currentUser = FirebaseAuth.instance.currentUser!.email;
    final Stream<QuerySnapshot> stream = FirebaseFirestore.instance
      .collection("Data")
      .doc(currentUser)
      .collection("NOTE")
      .snapshots();
 
      CollectionReference users = FirebaseFirestore.instance.collection('Data');
  Future<void> deleteData(String docs) {
    return users
        .doc(currentUser)
        .collection('NOTE')
        .doc(docs)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body:StreamBuilder<QuerySnapshot>(
          stream:stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
              if (snapshot.data!.docs.length == 0) {
              return Center(child: Lottie.asset('assets/Lottie/empty2.json'));
            }
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> document = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;
                    print(document["Title"]);
                    return InkWell(
                      onTap: (){

                         Navigator.push(context, MaterialPageRoute(builder: (builder)=>viewData(document: document,id:snapshot.data!.docs[index].id)));

                      },
                           onLongPress: () {
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.confirm,
                            text: 'Do you want to Remove',
                            confirmBtnText: 'Yes',
                            cancelBtnText: 'No',
                            confirmBtnColor: Colors.red,
                            cancelBtnTextStyle:TextStyle(color: Colors.black),
                            onConfirmBtnTap: () {
                              setState(() {
                                docs = snapshot.data!.docs[index].id;
                              });
                              deleteData(docs);
                              Navigator.pop(context);
                            },
                            onCancelBtnTap: () {
                              Navigator.pop(context);
                            },
                            
                            
                            );
                      },
                      child: NoteCard(
                        title: document["Title"],
                        description : document["Description"],
                      //   dateTime: document["DateTime"],
                         type : document["Type"],
                        
                      ),
                    );
                  }),
            );
          }
          
          
          
          
          
          ),

 floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => AddTodo()));
        },
        label: const Text('Create'),
        icon: const Icon(Icons.edit),
        backgroundColor: Color(0xff2a2e3d),
      ),





    );
  }
}
