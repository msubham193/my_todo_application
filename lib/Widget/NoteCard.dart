// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
   
     final String title;
     final String description;
    //  final String dateTime;
     final String type;
  const NoteCard({
    Key? key,
    required this.title,
    required this.description,
    // required this.dateTime,
    required this.type,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,

      child: Card(
      
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          color: Color(0xff2a2e3d),
          child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
            children: [
             SizedBox(
                height: 10,
              ),
              Text(title,maxLines:1,
                  style: TextStyle(letterSpacing:1,
                      color: Colors.white, fontWeight: FontWeight.w400,fontSize:16)),
              SizedBox(
                height: 20,
              ),
              Expanded(
                        
                child: Text(
                    description,maxLines:2,textAlign:TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing:1,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    )),
              ),
              SizedBox(height: 15),
              Text(
                "Tue,23Nov",textAlign:TextAlign.start,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height:10),
            ],
          )),
    );
  }
}
