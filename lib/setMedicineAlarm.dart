import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'clockView.dart';
import 'data.dart';

//import 'package:respi_track/constants/theme_data.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    var timeNow =DateTime.now();
    var time = DateFormat('HH:mm').format(timeNow);
    var date = DateFormat('EEEE, d MMM').format(timeNow);
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('SET MEDICINE ALARM'),
        ),
        body: Column(
          children: [
            /*TabBar(tabs:[
              Tab(icon: Icon(Icons.access_time_outlined, color: Colors.indigoAccent)),
              Tab(icon: Icon(Icons.notifications_on_outlined, color: Colors.indigoAccent)),
            ],
            ),*/
            Expanded(
              child: TabBarView(children: [
               /* Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(40),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(time, style: TextStyle(fontSize: 60, color: Colors.black45),),
                      SizedBox(height: 15),
                      Text(date, style: TextStyle(fontSize: 35, color: Colors.black45),),
                      SizedBox(height: 50),
                      Clock()],
                  ),), */
                Container(
                  color: Colors.grey.shade300,
                  padding: EdgeInsets.symmetric(horizontal:5 ,vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                          children: alarms.map((alarm){
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              margin:EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                gradient: LinearGradient(
                                  colors: [Colors.blueGrey, Colors.grey],
                                  begin: Alignment.centerLeft, end: Alignment.centerRight),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,spreadRadius: 5, blurRadius: 2, offset: Offset(3,3)
                                  )
                                ]
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(width:10),
                                          Icon(Icons.label_important, color: Colors.grey.shade700),
                                          SizedBox(width:10),
                                          Text('first dose', style: TextStyle(color: Colors.white,fontSize: 20),
                                          ),
                                        ],
                                        ),
                                          Switch(activeColor: Colors.white,value: true, onChanged: (bool value) {},
                                          )
                                    ],
                                  ),
                                  Text(' 07:00AM', style: TextStyle(color: Colors.white,fontSize: 30, fontWeight: FontWeight.w600)),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('  Sun - Sat', style: TextStyle(color: Colors.white,fontSize: 20)),
                                      IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {},
                                          color: Colors.white)
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).followedBy([
                            Container(
                              color: Colors.grey.shade300,
                              height: 100,
                              child: TextButton(
                                onPressed: () {},
                                child: Column(
                                  children: [

                                    Image.asset('images/icons8-plus-65.png', ),
                                    Text('Add Alarm', style: TextStyle(color: Colors.black45, fontSize: 15, fontWeight: FontWeight.w600)),

                                  ],
                                ),
                              ),
                            )
                          ]).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            )
         ],
        ),
      ),
    );
  }
}
