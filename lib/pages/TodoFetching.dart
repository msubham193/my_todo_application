// ignore_for_file: file_names, prefer_const_constructors, unused_import, prefer_is_empty

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:todoapp/Widget/TaskCard.dart';
import 'package:todoapp/pages/AddTodo.dart';
import 'package:todoapp/pages/viewData.dart';

class DataFetching extends StatefulWidget {
  const DataFetching({
    Key? key,
  }) : super(key: key);

  @override
  _DataFetchingState createState() => _DataFetchingState();
}

class _DataFetchingState extends State<DataFetching> {
  static var currentUser = FirebaseAuth.instance.currentUser!.email;

  String docs = "";

  final Stream<QuerySnapshot> stream = FirebaseFirestore.instance
      .collection("Data")
      .doc(currentUser)
      .collection("TO-DO")
      .snapshots();

  CollectionReference users = FirebaseFirestore.instance.collection('Data');
  Future<void> deleteData(String docs) {
    return users
        .doc(currentUser)
        .collection('TO-DO')
        .doc(docs)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.length == 0) {
              return Center(child: Lottie.asset('assets/Lottie/empty.json'));
            }
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    IconData icondata = Icons.run_circle_outlined;
                    Color iconColor = Colors.red;

                    Map<String, dynamic> document = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;
                    print(document["Title"]);
                    switch (document["Category"]) {
                      case ("Workout"):
                        icondata = Icons.run_circle_outlined;
                        iconColor = Colors.white;
                        break;

                      case ("Sports"):
                        icondata = Icons.run_circle_outlined;
                        iconColor = Colors.red;

                        break;

                      case ("Shopping"):
                        icondata = Icons.add_shopping_cart_outlined;
                        iconColor = Colors.amber;
                        break;

                      case ("Study"):
                        icondata = Icons.auto_stories_outlined;
                        iconColor = Colors.cyan;
                        break;

                      case ("Entertainment"):
                        icondata = Icons.bike_scooter_outlined;
                        iconColor = Colors.green;
                        break;

                      case ("Other"):
                        icondata = Icons.code_outlined;
                        iconColor = Colors.yellow;
                    }
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => viewData(
                                    document: document,
                                    id: snapshot.data!.docs[index].id)));
                      },
                      onLongPress: () {
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.confirm,
                          text: 'Do you want to Remove',
                          confirmBtnText: 'Yes',
                          cancelBtnText: 'No',
                          confirmBtnColor: Colors.red,
                          cancelBtnTextStyle: TextStyle(color: Colors.black),
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
                      child: TaskCard(
                        title: document["Title"],
                        check: true,
                        iconBgColor: Colors.white,
                        iconColor: iconColor,
                        iconData: icondata,
                        time: "7.30 AM",
                      ),
                    );
                  }),
            );
          }),
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
