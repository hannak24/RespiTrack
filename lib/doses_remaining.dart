import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class dosesRemaining extends StatefulWidget {
  //const dosesRemaining({Key? key}) : super(key: key);
  final double width;
  const dosesRemaining(this.width);

  @override
  State<dosesRemaining> createState() => _dosesRemainingState();
}

class _dosesRemainingState extends State<dosesRemaining> {
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
                                      fontSize: 15,
                                      color: Colors.white),),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 50.0, right: 50.0),
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
                                                    .white),),
                                          Text("146",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors
                                                    .white,
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
                                                    .white),),
                                          Text(routineDosesRemaining,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors
                                                    .white,
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
                );
              }
          )
      ),
    );


  }
}
