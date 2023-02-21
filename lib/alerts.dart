import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'custom_icons_icons.dart';
import 'globals.dart';

class dosesRemainingAlert extends StatefulWidget {
  //const dosesRemaining({Key? key}) : super(key: key);
  final String inhalerType;
  const dosesRemainingAlert( this.inhalerType);

  @override
  State<dosesRemainingAlert> createState() => _dosesRemainingAlertState();
}

class _dosesRemainingAlertState extends State<dosesRemainingAlert> {
  @override

  Widget build(BuildContext context) {
    var dosesRemaining = "200";
    return Container(
          color: Colors.transparent,
          child: StreamBuilder<void>(
              stream: widget.inhalerType == "routine" ?  FirebaseFirestore.instance.collection('Routine').orderBy('dateTime').snapshots() : FirebaseFirestore.instance.collection('Acute').orderBy('dateTime').snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot1) {
                var numOfIntakes =  snapshot1.data?.docs.length;
                return StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Settings').snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot2) {
                      if (snapshot2.hasData) {
                        DocumentSnapshot documentSnapshot = snapshot2.data?.docs[1];
                        if (widget.inhalerType == "acute") {
                          documentSnapshot = snapshot2.data?.docs[2];
                        }
                        var numOfDoses = documentSnapshot["Num of doses in bottle"];
                        numOfDoses = int.parse(numOfDoses);
                        dosesRemaining = (numOfDoses - numOfIntakes).toString();
                      }

                      var alertText = "Only " + dosesRemaining.toString() +
                          " doses left in " + widget.inhalerType.toString() +
                          " inhaler!";
                      var inhalerColor = Colors.indigo;
                      if (widget.inhalerType == "routine") {
                        inhalerColor = Colors.orange;
                      }

                      Widget returnedWidget = Container(height: widget.inhalerType == "routine"? heightRemainingDosesAlertRoutine: heightRemainingDosesAlertAcute,);

                      if (snapshot1.hasData && snapshot2.hasData ) {
                        if (int.parse(dosesRemaining) <= 15) {
                          if (widget.inhalerType == "routine") {
                            heightRemainingDosesAlertRoutine = 60.0;
                          }
                          else {
                            heightRemainingDosesAlertAcute = 60.0;
                          }
                          returnedWidget = Container(
                            height: widget.inhalerType == "routine"? heightRemainingDosesAlertRoutine: heightRemainingDosesAlertAcute,
                            child: Card(
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
                                                  color: inhalerColor,
                                                  size: 15.0),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 5.0, left: 11.0),
                                                  child: Text(alertText,
                                                    style: TextStyle(fontSize: 19,
                                                        color: Colors.black),)
                                              )
                                            ]
                                        )
                                    ),
                                    SizedBox(
                                      height: 13,
                                    ),
                                  ],
                                )
                            ),
                          );
                        }
                        else {
                          if (widget.inhalerType == "routine" ) {
                            heightRemainingDosesAlertRoutine = 0.0;
                          }
                          else {
                            heightRemainingDosesAlertAcute = 0.0;
                          }
                          returnedWidget = Container(height: widget.inhalerType == "routine"? heightRemainingDosesAlertRoutine: heightRemainingDosesAlertAcute,);
                        }
                      }
                      else {
                        returnedWidget = CircularProgressIndicator();
                      }
                      return returnedWidget;
                    }
                );
              }
          )
      );
  }
}


class expireAlert extends StatefulWidget {
  //const dosesRemaining({Key? key}) : super(key: key);
  final String inhalerType;
  const expireAlert( this.inhalerType);

  @override
  State<expireAlert> createState() => _expireAlertState();
}

class _expireAlertState extends State<expireAlert> {
  @override

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  Widget build(BuildContext context) {
    var expirationDate = DateTime.parse('2026-02-03 18:00:04Z');
    var daysToExpiration = 200;
    return Container(
        color: Colors.transparent,
        child: StreamBuilder<void>(
                  stream: FirebaseFirestore.instance.collection('Settings').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot2) {
                    if (snapshot2.hasData) {
                      DocumentSnapshot documentSnapshot = snapshot2.data?.docs[1];
                      if (widget.inhalerType == "acute") {
                        documentSnapshot = snapshot2.data?.docs[2];
                      }
                      var expirationDateInitial = documentSnapshot["Expiration Date"];
                      expirationDateInitial = expirationDateInitial.toString();
                      var expirationDateParts = expirationDateInitial.split("/");
                      for (int i = 0; i < 2; i++){
                        if(expirationDateParts[i].length > 1 && expirationDateParts[i][0] == "0"){
                          expirationDateParts[i] = expirationDateParts[i][expirationDateParts[i].length - 1];
                        }
                      }
                      if(expirationDateParts[2].length == 2){
                        expirationDateParts[2] = "20" + expirationDateParts[2];
                      }
                      var now = DateTime.now();
                      expirationDate = DateTime(int.parse(expirationDateParts[2]),int.parse(expirationDateParts[1]), int.parse(expirationDateParts[0]),now.hour, now.minute);
                      daysToExpiration = daysBetween(now, expirationDate);
                    }

                    var alertText = widget.inhalerType + " inhaler expires in " + daysToExpiration.toString() + " days!";
                    var inhalerColor = Colors.indigo;
                    if (widget.inhalerType == "routine") {
                      inhalerColor = Colors.orange;
                    }

                    Widget returnedWidget = Container(height: widget.inhalerType == "routine"? heightRemainingDosesAlertRoutine: heightRemainingDosesAlertAcute,);

                    if (snapshot2.hasData ) {

                      if (daysToExpiration <= 14) {
                        if(daysToExpiration <= 0){
                          alertText = widget.inhalerType + " inhaler expired!";
                        }
                        if (widget.inhalerType == "routine") {
                          heightExpiringAlertRoutine = 60.0;
                        }
                        else {
                          heightExpiringAlertAcute = 60.0;
                        }
                        returnedWidget = Container(
                          height: widget.inhalerType == "routine"? heightExpiringAlertRoutine: heightExpiringAlertAcute,
                          child: Card(
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
                                                color: inhalerColor,
                                                size: 15.0),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 5.0, left: 11.0),
                                                child: Text(alertText,
                                                  style: TextStyle(fontSize: 19,
                                                      color: Colors.black),)
                                            )
                                          ]
                                      )
                                  ),
                                  SizedBox(
                                    height: 13,
                                  ),
                                ],
                              )
                          ),
                        );
                      }
                      else {
                        if (widget.inhalerType == "routine" ) {
                          heightExpiringAlertRoutine = 0.0;
                        }
                        else {
                          heightExpiringAlertAcute = 0.0;
                        }
                        returnedWidget = Container(height: widget.inhalerType == "routine"? heightExpiringAlertRoutine: heightExpiringAlertAcute);
                      }
                    }
                    else {
                      returnedWidget = CircularProgressIndicator();
                    }
                    return returnedWidget;
                  }
        )
    );
  }
}


class averageUseTimeAlert extends StatefulWidget {
  //const dosesRemaining({Key? key}) : super(key: key);
  const averageUseTimeAlert();

  @override
  _averageUseTimeAlertState createState() => _averageUseTimeAlertState();
}

class _averageUseTimeAlertState extends State<averageUseTimeAlert> {


  bool isSameDate(DateTime date1, DateTime date2) {
    if (date1.year == date2.year && date1.month == date2.month &&
        date1.day == date2.day) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> illnessDates = [];
    Widget returnedWidget = Container(height: averageUseTimeAlertAcute);
    return Container(
        color: Colors.transparent,
        child: StreamBuilder<void>(
            stream: FirebaseFirestore.instance.collection('Acute').orderBy('dateTime').snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot1) {
              List<DateTime> pushes = [];
              DateTime prevPush = DateTime.now();
              if(snapshot1.hasData){

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

                for(int i = 0; i < pushes.length - 1; i++){
                    var difference = (pushes[i+1].difference(pushes[i])).inHours;
                    if(difference < 4){
                      illnessDates.add(pushes[i]);
                    }
                }

                var finalDates = [];

                for (int i = 0; i < illnessDates.length - 1; i++){

                  if(!isSameDate(illnessDates[i],illnessDates[i+1])) {
                    finalDates.add(DateFormat.yMd().format(illnessDates[i]));
                  }
                }

                if(illnessDates.length>0){
                    finalDates.add(DateFormat.yMd().format(illnessDates[illnessDates.length-1]));
                  }

                print(finalDates);

                int middleIndex = (finalDates.length / 2).round();


                for(int i = 1; i < finalDates.length; i++){
                  if(finalDates[i] == finalDates[0]){
                    middleIndex = i;
                    break;
                  }
                }

                if(middleIndex != finalDates.length - 1) {
                  finalDates = finalDates.sublist(0, middleIndex);
                }

                returnedWidget =  Container(
                    height: 110 + 27.0 * finalDates.length);

                if(finalDates.length > 0) {
                        averageUseTimeAlertAcute = 113 + 28.0 * finalDates.length;
                        returnedWidget = Container(
                          height:averageUseTimeAlertAcute,
                          child: Card(
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
                                            Padding(
                                                padding: EdgeInsets.only(top: 5.0),
                                                child: Column(
                                                    children:[
                                                      Row(
                                                          children:[
                                                            Icon(CustomIcons.inhalator__1_, color: Colors.indigo, size: 15.0),
                                                            SizedBox(
                                                              width: 11,
                                                            ),
                                                            Text("The average time between the uses ", style: TextStyle(fontSize: 19, color: Colors.black),),
                                                          ]
                                                      ),
                                                      Text("of the acute inhaler is less than ", style: TextStyle(fontSize: 19, color: Colors.black),),
                                                      Text("4 hours. at", style: TextStyle(fontSize: 19, color: Colors.black),),
                                                      Column(
                                                        children: finalDates.map((e) => Text(e, style: TextStyle(fontSize: 19, color: Colors.black),)).toList(),
                                                      ),
                                                      Text("Better get checked!", style: TextStyle(fontSize: 19, color: Colors.black),)
                                                    ]
                                                )

                                            )
                                          ]
                                      ),
                                  ),
                                  SizedBox(
                                    height: 13,
                                  ),
                                ],
                              )
                          ),
                        );
                      }
                else{
                    returnedWidget = Container(height: averageUseTimeAlertAcute);
                }
              }
              else {
                  returnedWidget = CircularProgressIndicator();
              }
              return returnedWidget;
            }
       )

    );
  }
}



