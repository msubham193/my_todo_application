// ignore_for_file: file_names, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';


class Suffle extends StatefulWidget {
  const Suffle({ Key? key }) : super(key: key);

  @override
  _SuffleState createState() => _SuffleState();
}

class _SuffleState extends State<Suffle> {
  @override
  Widget build(BuildContext context) {
   return SafeArea(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          // ignore: prefer_const_literals_to_create_immutables
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            "TO-DO",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      child: Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          // ignore: prefer_const_literals_to_create_immutables
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        // ignore: prefer_const_constructors
                        child: Center(
                          child: Text(
                            "NOTE",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                
              ),
              
            ),
            
          );
    
  }
}