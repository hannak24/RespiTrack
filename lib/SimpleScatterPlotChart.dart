import 'package:charts_flutter/flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleScatterPlotChart extends StatelessWidget {

  final List<charts.Series<medicineIntake, int>> seriesList;
  //final bool animate;
  SimpleScatterPlotChart(this.seriesList,); //this.animate);
  factory SimpleScatterPlotChart.withSampleData() {
    return SimpleScatterPlotChart(
      createSampleData(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return new charts.ScatterPlotChart(
      seriesList,
      animate: true,
      primaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec:
          new charts.BasicNumericTickProviderSpec(zeroBound: false, desiredMaxTickCount: 24)),
      secondaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec:
          new charts.BasicNumericTickProviderSpec(zeroBound: false, desiredMaxTickCount: 24)),
      behaviors: [
        new charts.ChartTitle('Routine inhaler use time',
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
            innerPadding: 18),
        new charts.SeriesLegend(position: charts.BehaviorPosition.bottom, entryTextStyle:  charts.TextStyleSpec(
            color: charts.Color(r: 127, g: 63, b: 191),
            fontFamily: 'Georgia',
            fontSize: 11),),
      ],);

  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<medicineIntake, int>> createSampleData() {
    final onTime = [
      medicineIntake(DateTime.parse('2022-11-01 10:00:04Z'),"onTime"),
      medicineIntake(DateTime.parse('2022-11-02 20:09:04Z'),"onTime"),
      medicineIntake(DateTime.parse('2022-11-03 20:00:04Z'),"onTime"),
      medicineIntake(DateTime.parse('2022-11-04 20:00:04Z'),"onTime"),
      medicineIntake(DateTime.parse('2022-11-05 10:00:04Z'),"onTime"),
      medicineIntake(DateTime.parse('2022-11-05 20:00:04Z'),"onTime"),
      medicineIntake(DateTime.parse('2022-11-06 10:00:04Z'),"onTime"),
    ];

    final late = [
      medicineIntake(DateTime.parse('2022-11-01 22:00:04Z'),"late"),
      medicineIntake(DateTime.parse('2022-11-02 11:00:04Z'),"late"),
    ];

    final veryLate = [
      medicineIntake(DateTime.parse('2022-11-03 18:00:04Z'),"veryLate"),
    ];

    final missed = [
      medicineIntake(DateTime.parse('2022-11-04 10:00:04Z'),"missing"),
      medicineIntake(DateTime.parse('2022-11-06 20:00:04Z'),"missing"),
    ];


    return [
      new charts.Series<medicineIntake, int>(
        id: 'In time',
        // Providing a color function is optional.
        colorFn: (medicineIntake medicineTime, _) {
          return charts.MaterialPalette.blue.shadeDefault;
        },
        domainFn: (medicineIntake times, _) => times.dateTime.day,
        measureFn: (medicineIntake times, _) => times.dateTime.hour,
        // // Providing a radius function is optional.
        data: onTime,
      ),
      new charts.Series<medicineIntake, int>(
        id: 'Late',
        // Providing a color function is optional.
        colorFn: (medicineIntake medicineTime, _) {
          return charts.MaterialPalette.lime.shadeDefault;
        },
        domainFn: (medicineIntake times, _) => times.dateTime.day,
        measureFn: (medicineIntake times, _) => times.dateTime.hour,
        // // Providing a radius function is optional.
        data: late,
      ),
      new charts.Series<medicineIntake, int>(
        id: 'Very late',
        // Providing a color function is optional.
        colorFn: (medicineIntake medicineTime, _) {
          return charts.MaterialPalette.red.shadeDefault;
        },
        domainFn: (medicineIntake times, _) => times.dateTime.day,
        measureFn: (medicineIntake times, _) => times.dateTime.hour,
        // // Providing a radius function is optional.
        data: veryLate,
      ),
      new charts.Series<medicineIntake, int>(
        id: 'Missed',
        // Providing a color function is optional.
        colorFn: (medicineIntake medicineTime, _) {
          return charts.MaterialPalette.black;
        },
        domainFn: (medicineIntake times, _) => times.dateTime.day,
        measureFn: (medicineIntake times, _) => times.dateTime.hour,
        // // Providing a radius function is optional.
        data: missed,
      ),
    ];
  }
}

class medicineIntake {
  final DateTime dateTime;
  final String status;
  medicineIntake(this.dateTime,this.status);

  String getDate() {
    var day = dateTime.day;
    var month = dateTime.month;
    var date = "$day/$month";
    return date;
  }

  String getTime() {
    var hour = dateTime.hour;
    var minute = dateTime.minute;
    var time = "$hour:$minute";
    return time;
  }

}

class SimpleScatterPlotChartDB extends StatefulWidget {
  const SimpleScatterPlotChartDB({Key? key}) : super(key: key);

  @override
  State<SimpleScatterPlotChartDB> createState() => _SimpleScatterPlotChartDBState();
}

class _SimpleScatterPlotChartDBState extends State<SimpleScatterPlotChartDB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<void>(
          stream: FirebaseFirestore.instance.collection('Routine').orderBy('dateTime').snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot1) {
            return StreamBuilder(
              stream: FirebaseFirestore.instance.collection('alarms').snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot2) {
                var firstAlarm = "10:00:00";
                var secondAlarm = "18:00:00";
                var status = "missed";
                List<DateTime> pushes = [];
                if(snapshot2.hasData){
                  DocumentSnapshot documentSnapshot = snapshot2.data?.docs[0];
                  firstAlarm =  snapshot2.data?.docs[0]["time"];
                  secondAlarm = snapshot2.data?.docs[1]["time"];
                }
                Widget widget = Container();
                List<charts.Series<medicineIntake, int>> chartData = <charts.Series<medicineIntake, int>>[];
                if (snapshot1.hasData) {
                  List<medicineIntake> onTime = <medicineIntake>[];
                  List<medicineIntake> late = <medicineIntake>[];
                  List<medicineIntake> veryLate = <medicineIntake>[];
                  List<medicineIntake> missed = <medicineIntake>[];
                  DateTime lastAlarm = DateTime.parse('2022-11-03 18:00:04Z');
                  DateTime firstClosestAlarm = DateTime.parse('2022-11-03 18:00:04Z');
                  DateTime firstFarAlarm = DateTime.parse('2022-11-03 18:00:04Z');
                  var lastPushDate = DateTime.parse('1000-11-03 18:00:04Z');
                  var morning = 1;
                  var firstPushDate = DateTime.parse('2222-11-03 18:00:04Z');
                  for (int index = 0; index < snapshot1.data?.docs.length; index++) {
                    DocumentSnapshot documentSnapshot = snapshot1.data?.docs[index];
                    var initialTime = documentSnapshot["dateTime"].replaceAll(".","-");
                    var temp = initialTime.split(" ");
                    var temp2 = temp[1].split("-");
                    var fixedDate = temp2[2] + "-" + temp2[1] + "-" + temp2[0];
                    var fixedTime = fixedDate +" "+ temp[0]+"Z";
                    DateTime pushTime = DateTime.parse(fixedTime);


                    var fixedAlarm1 = fixedDate +" "+ firstAlarm+"Z";
                    var fixedAlarm2 = fixedDate +" "+ secondAlarm+"Z";
                    DateTime alarm1Time = DateTime.parse(fixedAlarm1);
                    DateTime alarm2Time = DateTime.parse(fixedAlarm2);
                    var closestAlarm =
                    (pushTime.isAfter(alarm1Time) || pushTime.isAtSameMomentAs(alarm1Time)) && pushTime.isBefore(alarm2Time)?
                    alarm1Time: alarm2Time;

                    var farAlarm =
                    (pushTime.isAfter(alarm1Time) || pushTime.isAtSameMomentAs(alarm1Time)) && pushTime.isBefore(alarm2Time)?
                    alarm2Time: alarm1Time;




                    if(index == 0){
                      lastAlarm = closestAlarm;
                    }
                    else{
                      // if(closestAlarm.hour == lastAlarm.hour){
                      //   var missedAlarm = farAlarm;
                      //   if(closestAlarm.hour < 14) {
                      //     missedAlarm = farAlarm.subtract(const Duration(days: 1));
                      //   }
                      //
                      //   status = "missed";
                      //   medicineIntake intakeTime = medicineIntake(missedAlarm,status);
                      //   missed.add(intakeTime);
                      // }
                      // if(closestAlarm.hour > lastAlarm.hour && lastAlarm.day != closestAlarm.day){
                      //
                      //   status = "missed";
                      //   medicineIntake intakeTime = medicineIntake(farAlarm,status);
                      //   missed.add(intakeTime);
                      // }
                      lastAlarm = closestAlarm;
                    }




                    var missedAlarm1 = closestAlarm.subtract(const Duration(days: 1));
                    var missedAlarm2 = farAlarm.subtract(const Duration(days: 1));
                    // print("lastPushed");
                    // print(lastPushDate);
                    // print("missedAlarm1");
                    // print(missedAlarm1);
                    // print("missedAlarm2");
                    // print(missedAlarm2);
                    // while(lastPushDate.isBefore(missedAlarm1)){
                    //   print("putting missed1");
                    //   status = "missed";
                    //   medicineIntake intakeTime = medicineIntake(missedAlarm1,status);
                    //   missed.add(intakeTime);
                    //   missedAlarm1 = missedAlarm1.subtract(const Duration(days: 1));
                    // }
                    //
                    // while(lastPushDate.isBefore(missedAlarm2)){
                    //   print("putting missed2");
                    //   status = "missed";
                    //   medicineIntake intakeTime = medicineIntake(missedAlarm2,status);
                    //   missed.add(intakeTime);
                    //   missedAlarm2 = missedAlarm2.subtract(const Duration(days: 1));
                    // }




                    //checking status

                    if((pushTime.hour == closestAlarm.hour && pushTime.minute - alarm1Time.minute > 11)
                        || pushTime.hour - closestAlarm.hour < 3){
                      status = "late";
                      medicineIntake intakeTime = medicineIntake(pushTime,status);
                      late.add(intakeTime);
                      pushes.add(pushTime);
                      if(lastPushDate.isBefore(pushTime)){
                        lastPushDate = pushTime;
                      }
                      if(firstPushDate.isAfter(pushTime)){
                        firstPushDate = pushTime;
                        firstClosestAlarm = closestAlarm;
                        firstFarAlarm = farAlarm;
                      }
                      lastPushDate = pushTime;
                      if(closestAlarm.hour < 14){
                        morning = 1;
                      }
                      else{
                        morning = 0;
                      }
                    }

                    if((pushTime.hour == closestAlarm.hour) && (pushTime.minute - closestAlarm.minute < 11)){
                        status = "onTime";
                        medicineIntake intakeTime = medicineIntake(pushTime,status);
                        onTime.add(intakeTime);
                        //pushes.add(pushTime);
                        if(lastPushDate.isBefore(pushTime)){
                          lastPushDate = pushTime;
                        }
                        if(firstPushDate.isAfter(pushTime)){
                          firstPushDate = pushTime;
                          firstClosestAlarm = closestAlarm;
                          firstFarAlarm = farAlarm;
                        }
                        if(closestAlarm.hour < 14){
                          morning = 1;
                        }
                        else{
                          morning = 0;
                        }
                    }

                    if(pushTime.hour - closestAlarm.hour > 3 && pushTime.isBefore(farAlarm)){
                      status = "veryLate";
                      medicineIntake intakeTime = medicineIntake(pushTime,status);
                      veryLate.add(intakeTime);
                      pushes.add(pushTime);
                      if(lastPushDate.isBefore(pushTime)){
                        lastPushDate = pushTime;
                      }
                      if(firstPushDate.isAfter(pushTime)){
                        firstPushDate = pushTime;
                        firstClosestAlarm = closestAlarm;
                        firstFarAlarm = farAlarm;
                      }
                      if(closestAlarm.hour < 14){
                        morning = 1;
                      }
                      else{
                        morning = 0;
                      }
                    }
                    // print("lastPushDate");
                    // print(lastPushDate);

                  }

                  var dateToCheck = firstPushDate;
                  pushes.sort((a,b) {
                    return a.compareTo(b);
                  });
                  print(pushes);

                  var initialFirstAlarm = firstClosestAlarm;
                  var initialSecondAlarm = firstFarAlarm;

                  // for(var i=1;i<pushes.length;i++) {
                  //     while (pushes[i].difference(firstClosestAlarm).inHours > 24) {
                  //       if (morning == 0) {
                  //         firstFarAlarm.add(const Duration(days: 1));
                  //       }
                  //       status = "missed";
                  //       medicineIntake intakeTime = medicineIntake(
                  //           firstFarAlarm, status);
                  //       missed.add(intakeTime);
                  //       if (morning == 1) {
                  //         firstFarAlarm = firstFarAlarm.add(const Duration(days: 1));
                  //       }
                  //       firstClosestAlarm = firstClosestAlarm.add(const Duration(days: 1));
                  //     }
                  //   firstClosestAlarm = pushes[i].add(const Duration(days: 1));
                  //   firstFarAlarm = pushes[i].add(const Duration(days: 1));
                  // }

                  // for(var i=1;i<pushes.length;i++) {
                  //   while (pushes[i].difference(firstClosestAlarm).inHours > 24) {
                  //
                  //     status = "missed";
                  //     medicineIntake intakeTime = medicineIntake(
                  //         firstFarAlarm, status);
                  //     missed.add(intakeTime);
                  //
                  //     //firstClosestAlarm = firstClosestAlarm.add(const Duration(days: 1));
                  //   }
                  //   if(pushes[i].difference(firstClosestAlarm).inHours > 0) {
                  //     firstFarAlarm = pushes[i].add(const Duration(days: 1));
                  //     firstClosestAlarm =
                  //         pushes[i].add(const Duration(days: 1));
                  //   }
                  // }

                  firstClosestAlarm = initialFirstAlarm;
                  firstFarAlarm = initialSecondAlarm;

                  // for(var i=1;i<pushes.length;i++) {
                  //   while (pushes[i].difference(firstFarAlarm).inHours > 24) {
                  //     if (morning == 1) {
                  //       firstClosestAlarm.add(const Duration(days: 1));
                  //     }
                  //     status = "missed";
                  //     medicineIntake intakeTime = medicineIntake(
                  //         firstClosestAlarm, status);
                  //     missed.add(intakeTime);
                  //     if (morning == 1) {
                  //       firstClosestAlarm = firstClosestAlarm.add(const Duration(days: 1));
                  //     }
                  //     firstFarAlarm = firstFarAlarm.add(const Duration(days: 1));
                  //   }
                  //   firstFarAlarm = pushes[i].add(const Duration(days: 1));
                  //   firstClosestAlarm = pushes[i].add(const Duration(days: 1));
                  // }









                  chartData = [

                new charts.Series<medicineIntake, int>(
                      id: 'Late',
                      // Providing a color function is optional.
                      colorFn: (medicineIntake medicineTime, _) {
                        return charts.MaterialPalette.lime.shadeDefault;
                      },
                      domainFn: (medicineIntake times, _) => times.dateTime.day,
                      measureFn: (medicineIntake times, _) => times.dateTime.hour,
                      // // Providing a radius function is optional.
                      data: late,
                    ),
                new charts.Series<medicineIntake, int>(
                id: 'In time',
                // Providing a color function is optional.
                colorFn: (medicineIntake medicineTime, _) {
                return charts.MaterialPalette.blue.shadeDefault;
                },
                domainFn: (medicineIntake times, _) => times.dateTime.day,
                measureFn: (medicineIntake times, _) => times.dateTime.hour,
                // // Providing a radius function is optional.
                data: onTime,
                ),
                new charts.Series<medicineIntake, int>(
                id: 'Very late',
                // Providing a color function is optional.
                colorFn: (medicineIntake medicineTime, _) {
                return charts.MaterialPalette.red.shadeDefault;
                },
                domainFn: (medicineIntake times, _) => times.dateTime.day,
                measureFn: (medicineIntake times, _) => times.dateTime.hour,
                // // Providing a radius function is optional.
                data: veryLate,
                ),
                charts.Series<medicineIntake, int>(
                id: 'Missed',
                // Providing a color function is optional.
                colorFn: (medicineIntake medicineTime, _) {
                return charts.MaterialPalette.black;
                },

                domainFn: (medicineIntake times, _) => times.dateTime.day,
                measureFn: (medicineIntake times, _) => times.dateTime.hour,
                // // Providing a radius function is optional.
                data: missed,

                )];
                  widget = new charts.ScatterPlotChart(
                    chartData,
                    // customSeriesRenderers: [PointRendererConfig(radiusPx: 20
                    // ),PointRendererConfig(radiusPx: 20
                    // ),PointRendererConfig(radiusPx: 20
                    // ),PointRendererConfig(radiusPx: 20
                    // )],
                    animate: true,
                    primaryMeasureAxis: new charts.NumericAxisSpec(
                        tickProviderSpec:
                        new charts.BasicNumericTickProviderSpec(zeroBound: false, desiredMaxTickCount: 24)),
                    secondaryMeasureAxis: new charts.NumericAxisSpec(
                        tickProviderSpec:
                        new charts.BasicNumericTickProviderSpec(zeroBound: false, desiredMaxTickCount: 24)),
                    behaviors: [
                      new charts.ChartTitle('Routine inhaler use time',
                          behaviorPosition: charts.BehaviorPosition.top,
                          titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                          innerPadding: 18),
                      new charts.SeriesLegend(position: charts.BehaviorPosition.bottom, entryTextStyle:  charts.TextStyleSpec(
                          color: charts.Color(r: 127, g: 63, b: 191),
                          fontFamily: 'Georgia',
                          fontSize: 11),),
                    ],);
                }
                return widget;
              });
          }
        ));
  }
}



// Widget build(BuildContext context) {
//   return Scaffold(
//       body: StreamBuilder<void>(
//         stream: FirebaseFirestore.instance.collection('Routine').snapshots(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           Widget widget = Container();
//           List<charts.Series<medicineIntake, int>> chartData = <charts.Series<medicineIntake, int>>[];
//           if (snapshot.hasData) {
//             List<medicineIntake> onTime = <medicineIntake>[];
//             for (int index = 0; index < snapshot.data.documents.length; index++) {
//               DocumentSnapshot documentSnapshot = snapshot.data.documents[index];
//               // here we are storing the data into a list which is used for chart’s data source
//               //chartData.add(medicineIntake.fromMap(documentSnapshot.data as Map<String, dynamic>) );
//               DateTime pushTime = DateTime.parse(documentSnapshot as String);
//               medicineIntake intakeTime = medicineIntake(pushTime,"onTime");
//               onTime.add(intakeTime);
//             }
//             chartData = [new charts.Series<medicineIntake, int>(
//               id: 'In time',
//               // Providing a color function is optional.
//               colorFn: (medicineIntake medicineTime, _) {
//                 return charts.MaterialPalette.blue.shadeDefault;
//               },
//               domainFn: (medicineIntake times, _) => times.dateTime.day,
//               measureFn: (medicineIntake times, _) => times.dateTime.hour,
//               // // Providing a radius function is optional.
//               data: onTime,
//             )];
//             widget = new charts.ScatterPlotChart(
//               chartData,
//               animate: true,
//               primaryMeasureAxis: new charts.NumericAxisSpec(
//                   tickProviderSpec:
//                   new charts.BasicNumericTickProviderSpec(zeroBound: false, desiredMaxTickCount: 24)),
//               secondaryMeasureAxis: new charts.NumericAxisSpec(
//                   tickProviderSpec:
//                   new charts.BasicNumericTickProviderSpec(zeroBound: false, desiredMaxTickCount: 24)),
//               behaviors: [
//                 new charts.ChartTitle('Routine inhaler use time',
//                     behaviorPosition: charts.BehaviorPosition.top,
//                     titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
//                     innerPadding: 18),
//                 new charts.SeriesLegend(position: charts.BehaviorPosition.bottom, entryTextStyle:  charts.TextStyleSpec(
//                     color: charts.Color(r: 127, g: 63, b: 191),
//                     fontFamily: 'Georgia',
//                     fontSize: 11),),
//               ],);
//           }
//           return widget;
//         },
//       ));
// }



