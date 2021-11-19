// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color iconColor;
  final String time;
  final bool check;
  final Color iconBgColor;
  const TaskCard({
    Key? key,
    required this.title,
    required this.iconData,
    required this.iconColor,
    required this.time,
    required this.check,
    required this.iconBgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Theme(
            child: Transform.scale(
              scale: 1.5,
              child: Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // ignore: prefer_const_constructors
                  activeColor: Color(0xff6cf8a9),
                  checkColor: Color(0xff0e3e26),
                  value: check,
                  onChanged: (bool? value) {}),
            ),
            data: ThemeData(
                primarySwatch: Colors.blue,
                // ignore: prefer_const_constructors
                unselectedWidgetColor: Color(0xff5e6161)),
          ),
          Expanded(
            // ignore: sized_box_for_whitespace
            child: Container(
                height: 75,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    // ignore: prefer_const_constructors
                    color: Color(0xff2a2e3d),
                    child: Row(children: [
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 33,
                        width: 36,
                        decoration: BoxDecoration(
                          color: iconBgColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(iconData, color: iconColor),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(title,maxLines:1,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ]))),
          )
        ],
      ),
    );
  }
}
