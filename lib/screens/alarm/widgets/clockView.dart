import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as Vector;

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  @override void initState(){
    Timer.periodic(Duration(seconds: 1), (timer){
      setState((){
    });
  });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Transform.rotate(
          angle: -pi/2,
          child: CustomPaint(
            painter: ClockPainter(),
          ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width/2, size.height/2);
    var paint1 = Paint();
    var paint2 = Paint();
    var minute = Paint();
    var hour = Paint();
    paint1.color = Colors.white70;
    paint2.color = Colors.indigo;
    minute.color = Colors.green;
    hour.color = Colors.red;
    canvas.drawCircle(center, (size.width/3), paint1);
    canvas.drawCircle(center, (size.width/3-5 ), paint2);


    DateTime timeNow = DateTime.now();

    //hours
    var p1Hour = center;
    var xHour = (size.width/2) + ((size.width/3)-40)* cos(Vector.radians(360/12 * (timeNow.hour -12)));
    var yHour = (size.height/2) + ((size.height/3)-40)* sin(Vector.radians(360/12 * (timeNow.hour -12)));
    var p2Hour = Offset(xHour, yHour);
    var paintHour = Paint();
    paintHour.strokeWidth = 5;
    paintHour.color= Colors.purpleAccent;

    canvas.drawLine(p1Hour, p2Hour, paintHour);

    //minutes
    var p1Min = center;
    var xMin = (size.width/2) + ((size.width/3)-20)* cos(Vector.radians(360/60 * timeNow.minute));
    var yMin = (size.height/2) + ((size.height/3)-20)* sin(Vector.radians(360/60 * timeNow.minute));
    var p2Min = Offset(xMin, yMin);
    var paintMin = Paint();
    paintMin.strokeWidth = 5;
    paintMin.color= Colors.orange;

    canvas.drawLine(p1Min, p2Min, paintMin);
    //seconds
    var p1Sec = center;
    var xSec = (size.width/2) + ((size.width/3)-40)* cos(Vector.radians(360/60 * timeNow.second));
    var ySec = (size.height/2) + ((size.height/3)-40)* sin(Vector.radians(360/60 * timeNow.second));
    var p2Sec = Offset(xSec, ySec);
    var paintSec = Paint();
    paintSec.strokeWidth = 5;
    paintSec.color= Colors.green;

    canvas.drawLine(p1Sec, p2Sec, paintSec);

    //the little circle in the middle
    canvas.drawCircle(center, 14, paint1);

    var paint_around = Paint();
    var dis =0;
    ////
    for (int i=0; i<60; i++){
      var min= 360/60 * i;
      if ( i%5 == 0){
        paint_around.color = Colors.indigo;
        paint_around.strokeWidth = 4;
        dis = 6;
      }
      else{
        paint_around.color = Colors.indigoAccent;
        paint_around.strokeWidth = 1;
        dis = 20;
      }

      var x1= (size.width/2)+(size.width/3 + dis)* cos(Vector.radians(min));
      var y1= (size.height/2)+(size.height/3 + dis)* sin(Vector.radians(min));

      var x2= (size.width/2)+(size.width/3 + 40)* cos(Vector.radians(min));
      var y2= (size.height/2)+(size.height/3 + 40)* sin(Vector.radians(min));

      var p1 = Offset(x1, y1);
      var p2 = Offset(x2, y2);
      canvas.drawLine(p1, p2, paint_around);


    }


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}