import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  // Future<int> waitForIntakeNum(String inhalerType) async {
  //   var snaps = await FirebaseFirestore.instance.collection(widget.inhalerType).get();
  //   var numOfIntakes =  snaps.docs.length;
  //   return numOfIntakes;
  // }

  // Future<String> waitForNumOfDoses() async {
  //   var snaps = await FirebaseFirestore.instance.collection('Settings').get();
  //   DocumentSnapshot documentSnapshot = snaps.docs.elementAt(1);
  //   if (widget.inhalerType == "acute") {
  //     documentSnapshot = snaps.docs.elementAt(2);
  //   }
  //   var numOfDoses = documentSnapshot["Num of doses in bottle"];
  //   numOfDoses = int.parse(numOfDoses);
  //   int numOfIntakes = await waitForIntakeNum(widget.inhalerType);
  //   String dosesRemaining = (numOfDoses - numOfIntakes).toString();
  //   return dosesRemaining;
  // }
  //
  // Future<String> remainingDoses() async {
  //   String dosesRemaining = await waitForNumOfDoses();
  //   return dosesRemaining;
  // }

  Widget build(BuildContext context) {
    var dosesRemaining = "200";


    return Container(
      //height: 70.0,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: StreamBuilder<void>(
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

                      Widget returnedWidget = Container();

                      if (snapshot1.hasData && snapshot2.hasData ) {
                        print("here45");
                        if (int.parse(dosesRemaining) <= 15) {
                          print("here1");
                          if (widget.inhalerType == "routine") {
                            heightRemainingDosesAlertRoutine = 60.0;
                          }
                          else {
                            heightRemainingDosesAlertAcute = 60.0;
                          }
                          returnedWidget = Card(
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
                          );
                        }
                        else {
                          if (widget.inhalerType == "routine" ) {
                            heightRemainingDosesAlertRoutine = 0.0;
                          }
                          else {
                            heightRemainingDosesAlertAcute = 0.0;
                          }
                          returnedWidget = CircularProgressIndicator();
                        }
                      }
                      else {
                        print("here7");
                        returnedWidget = CircularProgressIndicator();
                        print(heightRemainingDosesAlertRoutine);
                        print(heightRemainingDosesAlertAcute);
                      }
                      return returnedWidget;
                    }
                );
              }
          )
      ),
    );
  }
}



class dosesRemainingRoutine extends StatefulWidget {
  final double width;
  const dosesRemainingRoutine(this.width);

  @override
  State<dosesRemainingRoutine> createState() => _dosesRemainingRoutineState();
}

class _dosesRemainingRoutineState extends State<dosesRemainingRoutine> {
  @override
  Widget build(BuildContext context) {
    var routineDosesRemaining = "25";
    return SizedBox(
      height: 70.0,
      width: widget.width,
      child: Scaffold(
          body: StreamBuilder<void>(
              stream: FirebaseFirestore.instance.collection('Routine').orderBy('dateTime').snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot1) {
                var numOfIntakes =  snapshot1.data?.docs.length;
                return StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Settings').snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot2) {
                      if(snapshot2.hasData){
                        DocumentSnapshot documentSnapshot = snapshot2.data?.docs[1];
                        var numOfDoses =  documentSnapshot["Num of doses in bottle"];
                        numOfDoses = int.parse(numOfDoses);
                        routineDosesRemaining = (numOfDoses-numOfIntakes).toString();

                      }
                      return Container(
                          height: 70.0,
                          width: widget.width,
                          //color: Color(0xFF010280),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF010280),
                                  const Color(0xFF135CC5),
                                  const Color(0xFF010280),
                                ],
                                begin: const FractionalOffset(
                                    0.0, 0.0),
                                end: const FractionalOffset(
                                    1.0, 0.0),
                                stops: [0.0, 0.5, 0.8],
                                tileMode: TileMode.mirror),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0),
                                child: Text(
                                  "Doses remaining ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white),),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 50.0, right: 50.0, top: 4.0),
                                child: Text(routineDosesRemaining,
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors
                                          .white,
                                      fontWeight: FontWeight
                                          .bold),),
                              )
                            ],
                          )
                      );
                    }
                );
              }
          )
      ),
    );
  }
}

class dosesRemainingAcute extends StatefulWidget {
  final double width;
  const dosesRemainingAcute(this.width);

  @override
  State<dosesRemainingAcute> createState() => _dosesRemainingAcuteState();
}

class _dosesRemainingAcuteState extends State<dosesRemainingAcute> {
  @override
  Widget build(BuildContext context) {
    var routineDosesRemaining = "25";
    return SizedBox(
      height: 70.0,
      width: widget.width,
      child: Scaffold(
          body: StreamBuilder<void>(
              stream: FirebaseFirestore.instance.collection('Acute').orderBy('dateTime').snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot1) {
                var numOfIntakes =  snapshot1.data?.docs.length;
                return StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Settings').snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot2) {
                      if(snapshot2.hasData){
                        DocumentSnapshot documentSnapshot = snapshot2.data?.docs[2];
                        var numOfDoses =  documentSnapshot["Num of doses in bottle"];
                        numOfDoses = int.parse(numOfDoses);
                        routineDosesRemaining = (numOfDoses-numOfIntakes).toString();

                      }
                      return Container(
                          height: 70.0,
                          width: widget.width,
                          //color: Color(0xFF010280),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF010280),
                                  const Color(0xFF135CC5),
                                  const Color(0xFF010280),
                                ],
                                begin: const FractionalOffset(
                                    0.0, 0.0),
                                end: const FractionalOffset(
                                    1.0, 0.0),
                                stops: [0.0, 0.5, 0.8],
                                tileMode: TileMode.mirror),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0),
                                child: Text(
                                  "Doses remaining ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white),),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 50.0, right: 50.0, top: 4.0),
                                child: Text(routineDosesRemaining,
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors
                                          .white,
                                      fontWeight: FontWeight
                                          .bold),),
                              )
                            ],
                          )
                      );
                    }
                );
              }
          )
      ),
    );
  }
}

