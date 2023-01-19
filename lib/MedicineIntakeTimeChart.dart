import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_chart/time_chart.dart';
import 'package:flutter/material.dart';

class MedicineIntakeTimeChart extends StatelessWidget {

  // Data must be sorted.
  final data = [
    DateTimeRange(
      start: DateTime(2021,2,24,18,0),
      end: DateTime(2021,2,24,23,59),
    ),
    DateTimeRange(
      start: DateTime(2021,2,24,10,0),
      end: DateTime(2021,2,24,10,10),
    ),
    DateTimeRange(
      start: DateTime(2021,2,23,18,0),
      end: DateTime(2021,2,23,18,10),
    ),
    DateTimeRange(
      start: DateTime(2021,2,23,10,0),
      end: DateTime(2021,2,23,10,10),
    ),
    DateTimeRange(
      start: DateTime(2021,2,22,18,00),
      end: DateTime(2021,2,22,18,10),
    ),
    DateTimeRange(
      start: DateTime(2021,2,22,10,0),
      end: DateTime(2021,2,22,18,0),
    ),
    DateTimeRange(
      start: DateTime(2021,2,21,18,0),
      end: DateTime(2021,2,21,18,10),
    ),
    DateTimeRange(
      start: DateTime(2021,2,21,10,0),
      end: DateTime(2021,2,21,16,10),
    ),
    DateTimeRange(
      start: DateTime(2021,2,20,18,0),
      end: DateTime(2021,2,20,18,10),
    ),
    DateTimeRange(
      start: DateTime(2021,2,20,10,0),
      end: DateTime(2021,2,20,10,30),
    ),
    DateTimeRange(
      start: DateTime(2021,2,19,18,0),
      end: DateTime(2021,2,19,19,0),
    ),
    DateTimeRange(
      start: DateTime(2021,2,19,10,0),
      end: DateTime(2021,2,19,10,10),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final sizedBox = const SizedBox(height: 16);

    return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Weekly routine inhaler use time'),
              SizedBox(height: 10),
              TimeChart(
                data: data,
                viewMode: ViewMode.weekly,
              ),]
    ));
      // Scaffold(
      //   body: SingleChildScrollView(
      //     child: Padding(
      //       padding: const EdgeInsets.all(16.0),
      //       child: Column(
      //         children: [
      //           const Text('Weekly time chart'),
      //           TimeChart(
      //             data: data,
      //             viewMode: ViewMode.weekly,
      //           ),
      //           // sizedBox,
      //           // const Text('Monthly time chart'),
      //           // TimeChart(
      //           //   data: data,
      //           //   viewMode: ViewMode.monthly,
      //           //),
      //         ],
      //       ),
      //     ),
      //   ),
      // );
  }
}

class MedicineIntakeTimeChartDB extends StatefulWidget {
  const MedicineIntakeTimeChartDB({Key? key}) : super(key: key);

  @override
  State<MedicineIntakeTimeChartDB> createState() => _MedicineIntakeTimeChartDBState();
}

class _MedicineIntakeTimeChartDBState extends State<MedicineIntakeTimeChartDB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<void>(
            stream: FirebaseFirestore.instance.collection('Routine').orderBy(
                'dateTime').snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot1) {
              return StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('alarms')
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot2) {
                    var firstAlarm = "10:00:00";
                    var secondAlarm = "18:00:00";
                    var status = "missed";
                    List<DateTime> pushes = [];
                    List<DateTimeRange>? data = [];
                    List<DateTimeRange>? finalData = [];
                    if (snapshot2.hasData) {
                      DocumentSnapshot documentSnapshot = snapshot2.data
                          ?.docs[0];
                      firstAlarm = snapshot2.data?.docs[0]["time"];
                      secondAlarm = snapshot2.data?.docs[1]["time"];
                    }
                    Widget widget = Container();
                    if (snapshot1.hasData) {
                      DateTime lastAlarm = DateTime.parse(
                          '2022-11-03 18:00:04Z');
                      DateTime firstClosestAlarm = DateTime.parse(
                          '2022-11-03 18:00:04Z');
                      DateTime firstFarAlarm = DateTime.parse(
                          '2022-11-03 18:00:04Z');
                      var lastPushDate = DateTime.parse('1000-11-03 18:00:04Z');
                      var morning = 1;
                      var firstPushDate = DateTime.parse(
                          '2222-11-03 18:00:04Z');
                      for (int index = 0; index < snapshot1.data?.docs.length; index++) {
                        DocumentSnapshot documentSnapshot = snapshot1.data
                            ?.docs[index];
                        var initialTime = documentSnapshot["dateTime"]
                            .replaceAll(".", "-");
                        var temp = initialTime.split(" ");
                        var temp2 = temp[1].split("-");
                        var fixedDate = temp2[2] + "-" + temp2[1] + "-" +
                            temp2[0];
                        var fixedTime = fixedDate + " " + temp[0] + "Z";

                        DateTime pushTime = DateTime.parse(fixedTime);

                        var fixedAlarm1 = fixedDate +" "+ firstAlarm+"Z";
                        var fixedAlarm2 = fixedDate +" "+ secondAlarm+"Z";
                        firstClosestAlarm = DateTime.parse(fixedAlarm1);
                        firstFarAlarm = DateTime.parse(fixedAlarm2);

                        pushes.add(pushTime);
                      }
                      pushes.sort((a, b) {
                        return a.compareTo(b);
                      });


                      firstClosestAlarm = DateTime(pushes[0].year,pushes[0].month,pushes[0].day,firstClosestAlarm.hour, firstClosestAlarm.minute);
                      firstFarAlarm = DateTime(pushes[0].year,pushes[0].month,pushes[0].day,firstFarAlarm.hour, firstFarAlarm.minute);
                      print("firstClosestAlarm");
                      print(firstClosestAlarm);
                      print("firstFarAlarm");
                      print(firstFarAlarm);

                      var morningAlarm = firstClosestAlarm;
                      var eveningAlarm = firstFarAlarm;

                      if (morningAlarm.hour > 15) {
                        var temp = morningAlarm;
                        morningAlarm = eveningAlarm;
                        eveningAlarm = temp;
                      }
                      var eveningMorningDiff = eveningAlarm.hour -
                          morningAlarm.hour;
                      var morningEveningDiff = (morningAlarm.hour + 24 -
                          eveningAlarm.hour);

                      var i = 0;
                      var status = "missed";
                      for (; i < (pushes.length);) {
                        while (pushes[i].difference(morningAlarm).inHours < 0) {
                          i++;
                        }
                        print("pushes[i]");
                        print(pushes[i]);
                        print("morningAlarm");
                        print(morningAlarm);
                        if (pushes[i].difference(morningAlarm).inHours >= eveningMorningDiff) {
                          data.add(DateTimeRange(
                            start: DateTime(morningAlarm.year, morningAlarm.month, morningAlarm.day, morningAlarm.hour, morningAlarm.minute),
                            end: DateTime(eveningAlarm.year, eveningAlarm.month, eveningAlarm.day, eveningAlarm.hour, eveningAlarm.minute),
                          ));
                        }
                        else {
                          print("I'm here");
                          data.add(DateTimeRange(
                            start: DateTime(
                                morningAlarm.year, morningAlarm.month,
                                morningAlarm.day, morningAlarm.hour,
                                morningAlarm.minute),
                            end: DateTime(
                                pushes[i].year, pushes[i].month, pushes[i].day,
                                pushes[i].hour, pushes[i].minute),
                          ));
                          i++;
                        }

                        if (i >= pushes.length){
                          break;
                        }



                        while (i < pushes.length && pushes[i].difference(eveningAlarm).inHours < 0) {
                          i++;
                        }

                        if (i < pushes.length && pushes[i]
                            .difference(eveningAlarm)
                            .inHours >= morningEveningDiff) {
                          data.add(DateTimeRange(
                            start: DateTime(
                                eveningAlarm.year, eveningAlarm.month,
                                eveningAlarm.day, eveningAlarm.hour,
                                eveningAlarm.minute),
                            end: DateTime(eveningAlarm.year, eveningAlarm.month,
                                eveningAlarm.day, 23, 59),
                          ));
                        }
                        else {
                          data.add(DateTimeRange(
                            start: DateTime(
                                eveningAlarm.year, eveningAlarm.month,
                                eveningAlarm.day, eveningAlarm.hour,
                                eveningAlarm.minute),
                            end: DateTime(
                                pushes[i].year, pushes[i].month, pushes[i].day,
                                pushes[i].hour, pushes[i].minute),
                          ));
                          i++;
                        }

                        //i++;

                        morningAlarm =
                            morningAlarm.add(const Duration(days: 1));
                        eveningAlarm =
                            eveningAlarm.add(const Duration(days: 1));
                      }

                      for(int j = pushes.length - 1; j > -1; j--){
                        finalData.add(data[j]);
                      }
                      print(finalData);
                    }
                    return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            children: [
                              const Text('Weekly routine inhaler use time'),
                              SizedBox(height: 10),
                              TimeChart(
                                //width: 400,
                                data: finalData,
                                viewMode: ViewMode.weekly,
                              ),]
                        ));
                  }
              );
            }
        )
    );
  }
}

