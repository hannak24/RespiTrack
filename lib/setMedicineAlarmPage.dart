import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'clockView.dart';

class AlarmPage extends StatefulWidget{
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage>{
  @override
  Widget build(BuildContext context) {
    var timeNow =DateTime.now();
    var time = DateFormat('HH:mm').format(timeNow);
    var date = DateFormat('EEEE, d MMM').format(timeNow);
    return Scaffold(
      body: Container(

        color: Colors.indigo.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
              child: Row(
                children: [
                 TextButton (
                   onPressed: () {},
                   child: Column(
                     children: [
                       Image.asset('images/icons8-clock-45.png'),
                       Text('Clock', style: TextStyle(fontFamily:'avenir' ,fontSize: 20, color: Colors.indigo),),
                     ],
                   ),
                  ),
                  TextButton (
                    onPressed: () {},
                    child: Column(
                      children: [
                        Image.asset('images/icons8-alarm-45.png'),
                        Text('Alarm', style: TextStyle(fontSize: 20, color: Colors.indigo),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 0,
              thickness: 5,
              indent: 0,
              endIndent: 0,
              color: Colors.black45,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(40),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(time, style: TextStyle(fontSize: 60, color: Colors.black45),),
                    SizedBox(height: 15),
                    Text(date, style: TextStyle(fontSize: 35, color: Colors.black45),),
                    SizedBox(height: 50),
                    Clock()],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

class FlatButton {
}