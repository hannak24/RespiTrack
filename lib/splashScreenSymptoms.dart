import 'dart:async';

import 'package:flutter/material.dart';
import 'setSymptoms.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 2);
  }

  initScreen(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.red,],
            )
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
               child: Image.asset("images/icons8-right-handed-65.png"),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "Thank you",
              style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Hope your child feels better!",
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white
              ),
            ),
            SizedBox(height: 50),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 5,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}