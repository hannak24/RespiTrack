


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../icons/custom_icons_icons.dart';

class acuteHomePageCard extends StatefulWidget {
  const acuteHomePageCard({Key? key}) : super(key: key);

  @override
  State<acuteHomePageCard> createState() => _acuteHomePageCardState();
}

class _acuteHomePageCardState extends State<acuteHomePageCard> {
  @override
  bool isSameDate(DateTime date1, DateTime date2) {
    if (date1.year == date2.year && date1.month == date2.month &&
        date1.day == date2.day) {
      return true;
    }
    return false;
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder<void>(
            stream: FirebaseFirestore.instance.collection('Acute').orderBy(
                'dateTime').snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot1) {
                    return StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Settings').snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot3) {
                    List<DateTime> pushes = [];
                    Widget widget = SizedBox();

                    var nameOfMedicine = "Ventolin";
                    var perscription = "2 doses when needed";

                    if(snapshot3.hasData){
                      DocumentSnapshot documentSnapshot = snapshot3.data?.docs[2];
                      nameOfMedicine = documentSnapshot["Medicine name"];
                      perscription = documentSnapshot["Prescripted Dose"];
                      }


                    if (snapshot1.hasData) {
                      for (int index = 0; index < snapshot1.data?.docs.length; index++) {
                            DocumentSnapshot documentSnapshot = snapshot1.data
                                ?.docs[index];
                            var initialTime = documentSnapshot["dateTime"]
                                .replaceAll(
                            ".", "-");
                            var temp = initialTime.split(" ");
                            var temp2 = temp[1].split("-");
                            var fixedDate = temp2[2] + "-" + temp2[1] + "-" +
                            temp2[0];
                            var fixedTime = fixedDate + " " + temp[0] + "Z";
                            DateTime pushTime = DateTime.parse(fixedTime);
                            pushes.add(pushTime);
                            }
                        pushes.sort((a, b) {
                          return a.compareTo(b);
                        });


                        var lastPush = pushes.last;
                        var today = DateTime.now();
                        var difference = daysBetween(lastPush, today);
                        var lastTaken = "  Last taken " + difference.toString() + " days ago";
                        if(difference == 0){
                          lastTaken = "  Last taken today";
                        }
                      if(difference < 0){
                        lastTaken = "  Last taken in the future";
                      }



                        widget = Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 5,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(top: 5.0, left: 5.0),
                                    child: Row(
                                        children: [
                                          Icon(CustomIcons.inhalator__1_, color: Colors.indigo, size: 15.0),
                                          Padding(
                                              padding: EdgeInsets.only(top: 5.0, left: 11.0),
                                              child: Text(nameOfMedicine, style: TextStyle(fontSize: 19, color: Colors.black),)
                                          )
                                        ]
                                    )
                                ),
                                SizedBox(
                                  height: 13,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 9.0),
                                  child: Row(
                                      children:[
                                        Text(perscription, style: TextStyle(fontSize: 13, color: Colors.black),),
                                      ]
                                  ),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 30.0,right: 30.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 41.0,
                                        width: 174.0,
                                        decoration: BoxDecoration(
                                            color: Colors.cyan.withOpacity(0.3),
                                            border: Border.all(
                                              color: Colors.cyan.withOpacity(0.3),
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(14))
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Row(
                                              children: [
                                                Icon(Icons.alarm, color: Color(0xFF006400), size:20.0),
                                                Text(lastTaken, style: TextStyle(
                                                    fontSize: 12, color: Color(0xFF006400), fontWeight: FontWeight.bold),)
                                              ]
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                        );
                    }
                    return widget;
                  }
              );
            }

     )
    );
  }
}
