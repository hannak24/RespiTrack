import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class AvgNumOfPushes extends StatefulWidget {
  final double width;
  const AvgNumOfPushes(this.width);

  @override
  State<AvgNumOfPushes> createState() => _AvgNumOfPushesState();
}

class _AvgNumOfPushesState extends State<AvgNumOfPushes> {
  var routineAvgPushesNum = "1.1";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 87.0,
      width: widget.width,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Routine').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot1) {
          List<DateTime> pushes = <DateTime>[];
          List<int> pushesCount = [];
          if (snapshot1.hasData) {
              for (int index = 0; index < snapshot1.data?.docs.length; index++) {
                DocumentSnapshot documentSnapshot = snapshot1.data?.docs[index];
                var initialTime = documentSnapshot["dateTime"].replaceAll(
                    ".", "-");
                var temp = initialTime.split(" ");
                var temp2 = temp[1].split("-");
                var fixedDate = temp2[2] + "-" + temp2[1] + "-" + temp2[0];
                var fixedTime = fixedDate + " " + temp[0] + "Z";
                DateTime pushTime = DateTime.parse(fixedTime);
                pushes.add(pushTime);
              }

              pushes.sort((a,b) {return a.compareTo(b);});
              for(int i=0; i< pushes.length - 1; i++){
                var count = 1;
                var inTheLoop = 0;
                while((pushes[i+1].difference(pushes[i]).inMinutes < 10) && i < pushes.length - 1){
                  inTheLoop = 1;
                  count++;
                  i++;
                }
                if(inTheLoop == 1){
                  i = i-1;
                }
                pushesCount.add(count);
              }
              var routineAvgPushesNumInt = pushesCount.average;
              routineAvgPushesNum = routineAvgPushesNumInt.toStringAsFixed(2);
          }

          return Card(
              elevation: 3.5,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 5.0),
                    child: Text(
                      "Average number of pushes per usage: ",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors
                              .black),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 70.0,
                        right: 70.0,
                        top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween,
                      mainAxisSize: MainAxisSize
                          .max,
                      children: [
                        Column(
                            children: [
                              Text(
                                "acute inhaler: ",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors
                                        .black),),
                              Text("1.4",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors
                                        .black,
                                    fontWeight: FontWeight
                                        .bold),)
                            ]
                        ),
                        Column(
                            children: [
                              Text(
                                "Routine inhaler: ",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors
                                        .black),),
                              Text(routineAvgPushesNum,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors
                                        .black,
                                    fontWeight: FontWeight
                                        .bold),)
                            ]
                        )
                      ],
                    ),
                  )
                ],
              )
          );
        }
      ),
    );
  }
}


class AvgNumOfPushesRoutine extends StatefulWidget {
  final double width;
  const AvgNumOfPushesRoutine(this.width);

  @override
  State<AvgNumOfPushesRoutine> createState() => _AvgNumOfPushesRoutineState();
}

class _AvgNumOfPushesRoutineState extends State<AvgNumOfPushesRoutine> {
  var routineAvgPushesNum = "1.1";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 87.0,
      width: widget.width,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Routine').snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot1) {
            List<DateTime> pushes = <DateTime>[];
            List<int> pushesCount = [];
            if (snapshot1.hasData) {
              for (int index = 0; index < snapshot1.data?.docs.length; index++) {
                DocumentSnapshot documentSnapshot = snapshot1.data?.docs[index];
                var initialTime = documentSnapshot["dateTime"].replaceAll(
                    ".", "-");
                var temp = initialTime.split(" ");
                var temp2 = temp[1].split("-");
                var fixedDate = temp2[2] + "-" + temp2[1] + "-" + temp2[0];
                var fixedTime = fixedDate + " " + temp[0] + "Z";
                DateTime pushTime = DateTime.parse(fixedTime);
                pushes.add(pushTime);
              }

              pushes.sort((a,b) {return a.compareTo(b);});
              for(int i=0; i< pushes.length - 1; i++){
                var count = 1;
                var inTheLoop = 0;
                while((pushes[i+1].difference(pushes[i]).inMinutes < 10) && i < pushes.length - 1){
                  inTheLoop = 1;
                  count++;
                  i++;
                }
                if(inTheLoop == 1){
                  i = i-1;
                }
                pushesCount.add(count);
              }
              var routineAvgPushesNumInt = pushesCount.average;
              routineAvgPushesNum = routineAvgPushesNumInt.toStringAsFixed(2);
            }

            return Card(
                elevation: 3.5,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 5.0),
                      child: Text(
                        "Average number of pushes per usage: ",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors
                                .black),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 70.0,
                          right: 70.0,
                          top: 10),
                      child: Text(routineAvgPushesNum,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors
                                .black,
                            fontWeight: FontWeight
                                .bold),),
                    )
                  ],
                )
            );
          }
      ),
    );
  }
}

