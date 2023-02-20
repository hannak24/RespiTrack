


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_icons_icons.dart';

class routineHomePageCard extends StatefulWidget {
  const routineHomePageCard({Key? key}) : super(key: key);

  @override
  State<routineHomePageCard> createState() => _routineHomePageCardState();
}

class _routineHomePageCardState extends State<routineHomePageCard> {
  @override
  bool isSameDate(DateTime date1, DateTime date2) {
    if (date1.year == date2.year && date1.month == date2.month &&
        date1.day == date2.day) {
      return true;
    }
    return false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder<void>(
            stream: FirebaseFirestore.instance.collection('Routine').orderBy(
                'dateTime').snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot1) {
              return StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('alarms')
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot2) {
                    return StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Settings').snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot3) {

                    var firstAlarm = "10:00:00";
                    var secondAlarm = "18:00:00";

                    List<DateTime> pushes = [];
                    if (snapshot2.hasData) {
                      DocumentSnapshot documentSnapshot = snapshot2.data
                          ?.docs[0];
                      firstAlarm = snapshot2.data?.docs[0]["time"];
                      secondAlarm = snapshot2.data?.docs[1]["time"];
                    }


                    Widget widget = SizedBox();

                    var nameOfMedicine = "Symbicort";
                    var perscription = "2 doses per AM & PM";

                    if(snapshot3.hasData){
                      DocumentSnapshot documentSnapshot = snapshot3.data?.docs[1];
                      nameOfMedicine = documentSnapshot["medicine name"];
                      perscription = documentSnapshot["Prescripted Dose"];
                      }


                    if (snapshot1.hasData) {
                      DateTime lastAlarm = DateTime.parse(
                          '2022-11-03 18:00:04Z');
                      DateTime firstClosestAlarm = DateTime.parse(
                          '2022-11-03 18:00:04Z');
                      DateTime firstFarAlarm = DateTime.parse(
                          '2022-11-03 18:00:04Z');
                      var lastPushDate = DateTime.parse('1000-11-03 18:00:04Z');
                      var firstPushDate = DateTime.parse(
                          '2222-11-03 18:00:04Z');
                      DateTime alarm1Time = DateTime.now();
                      DateTime alarm2Time = DateTime.now();
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
                            var fixedAlarm1 = fixedDate + " " + firstAlarm + "Z";
                            var fixedAlarm2 = fixedDate + " " + secondAlarm + "Z";
                            alarm1Time = DateTime.parse(fixedAlarm1);
                            alarm2Time = DateTime.parse(fixedAlarm2);
                            pushes.add(pushTime);
                            }


                        var morningAlarm = alarm1Time.isAfter(alarm2Time)
                            ? alarm2Time
                            : alarm1Time;

                        var eveningAlarm = alarm2Time.isAfter(alarm1Time)
                            ? alarm2Time
                            : alarm1Time;

                        pushes.sort((a, b) {
                          return a.compareTo(b);
                        });


                        DateTime current_date = DateTime.now();
                        var todayMorningAlarm = DateTime(
                            current_date.year, current_date.month,
                            current_date.day,
                            morningAlarm.hour, morningAlarm.minute);
                        var todayEveningAlarm = DateTime(
                            current_date.year, current_date.month,
                            current_date.day,
                            eveningAlarm.hour, eveningAlarm.minute);

                        String isMoriningMedicineTaken = "future";
                        String isEveningMedicineTaken = "future";
                        var previousPush = pushes.last;
                        if(pushes.length > 1) {
                          previousPush = pushes[pushes.length - 2];
                        }



                        if (isSameDate(pushes.last, todayEveningAlarm)) {
                          if ((pushes.last).isAfter(todayEveningAlarm) ||
                              (pushes.last).isAtSameMomentAs(
                                  todayEveningAlarm)) {
                            isEveningMedicineTaken = "taken";
                            if (previousPush.isBefore(todayEveningAlarm) &&
                                ((previousPush.isAfter(todayMorningAlarm)) ||
                                    (previousPush.isAtSameMomentAs(
                                        todayMorningAlarm)))) {
                              isMoriningMedicineTaken = "taken";
                            }
                            if (!isSameDate(previousPush, todayMorningAlarm)) {
                              isMoriningMedicineTaken = "missed";
                            }
                          }
                          if (pushes.last.isBefore(todayEveningAlarm) &&
                              ((pushes.last.isAfter(todayMorningAlarm)) ||
                                  (pushes.last.isAtSameMomentAs(
                                      todayMorningAlarm)))) {
                            isMoriningMedicineTaken = "taken";
                          }
                        }

                        var colorMorning = Colors.cyan.withOpacity(0.3); //future clock color
                        var colorEvening = Colors.cyan.withOpacity(0.3); //future clock color

                        if(isMoriningMedicineTaken == "taken"){
                          colorMorning = Colors.lightGreen.withOpacity(0.3);
                        }
                        else if(isMoriningMedicineTaken == "missed"){
                          colorMorning = Colors.redAccent.withOpacity(0.7);
                        }

                        if(isEveningMedicineTaken == "taken"){
                          colorEvening = Colors.lightGreen.withOpacity(0.3);
                        }

                        var morningAlarmHour = morningAlarm.hour.toString() + ":" + morningAlarm.minute.toString();
                        var morningText = "  AM dose " + morningAlarmHour;
                        if(isMoriningMedicineTaken == "missed"){
                          morningText = "  AM dose missed";
                        }
                        if(isMoriningMedicineTaken == "taken"){
                          morningText = "  AM dose taken";
                        }

                        var eveningAlarmHour = eveningAlarm.hour.toString() + ":" + eveningAlarm.minute.toString();
                        var eveningText = "  PM dose " + eveningAlarmHour;
                        if(isEveningMedicineTaken == "taken"){
                          eveningText = "  PM dose taken";
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
                                    padding: EdgeInsets.only(
                                        top: 5.0, left: 5.0),
                                    child: Row(
                                        children: [
                                          Icon(CustomIcons.inhalator__1_,
                                              color: Colors.orange, size: 15.0),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 5.0, left: 11.0),
                                              child: Text(nameOfMedicine,
                                                style: TextStyle(fontSize: 19,
                                                    color: Colors.black),)
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
                                      children: [
                                        Text(perscription,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black),),
                                      ]
                                  ),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 30.0, right: 30.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 41.0,
                                        width: 150.0,
                                        decoration: BoxDecoration(
                                            color:  colorMorning,
                                            border: Border.all(
                                              color: colorMorning,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(14))
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Row(
                                              children: [
                                                Icon(Icons.alarm,
                                                    color: Color(0xFF006400),
                                                    size: 20.0),
                                                Text(morningText,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0xFF006400),
                                                      fontWeight: FontWeight
                                                          .bold),)
                                              ]
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Container(
                                        height: 41.0,
                                        width: 150.0,
                                        decoration: BoxDecoration(
                                            color: colorEvening,
                                            border: Border.all(
                                              color: colorEvening,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(14))
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Row(
                                              children: [
                                                Icon(Icons.alarm,
                                                    color: Color(0xFF006400),
                                                    size: 20.0),
                                                Text(eveningText,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0xFF006400),
                                                      fontWeight: FontWeight
                                                          .bold),)
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
        );
      }
     )
    );
  }
}
