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
  final DateTime start;
  final DateTime end;

  const SimpleScatterPlotChartDB(this.start, this.end);

  @override
  State<SimpleScatterPlotChartDB> createState() => _SimpleScatterPlotChartDBState();
}

class _SimpleScatterPlotChartDBState extends State<SimpleScatterPlotChartDB> {


  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2022, 11, 5),
    end: DateTime(2022, 12, 24),
  );

  @override
  Widget build(BuildContext context) {
    var _start = widget.start;

    var _end = widget.end.add(const Duration(days: 1));
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
                    DocumentSnapshot documentSnapshot = snapshot1.data
                        ?.docs[index];
                    var initialTime = documentSnapshot["dateTime"].replaceAll(
                        ".", "-");
                    var temp = initialTime.split(" ");
                    var temp2 = temp[1].split("-");
                    var fixedDate = temp2[2] + "-" + temp2[1] + "-" + temp2[0];
                    var fixedTime = fixedDate + " " + temp[0] + "Z";
                    DateTime pushTime = DateTime.parse(fixedTime);



                    if (!(pushTime.isAfter(_start) && pushTime.isBefore(_end))){
                      continue;
                    }


                    var fixedAlarm1 = fixedDate + " " + firstAlarm + "Z";
                    var fixedAlarm2 = fixedDate + " " + secondAlarm + "Z";
                    DateTime alarm1Time = DateTime.parse(fixedAlarm1);
                    DateTime alarm2Time = DateTime.parse(fixedAlarm2);
                    var closestAlarm =
                    (pushTime.isAfter(alarm1Time) ||
                        pushTime.isAtSameMomentAs(alarm1Time)) &&
                        pushTime.isBefore(alarm2Time) ?
                    alarm1Time : alarm2Time;

                    var farAlarm =
                    (pushTime.isAfter(alarm1Time) ||
                        pushTime.isAtSameMomentAs(alarm1Time)) &&
                        pushTime.isBefore(alarm2Time) ?
                    alarm2Time : alarm1Time;
                    var status = "late";


                    if (index == 0) {
                      lastAlarm = closestAlarm;
                    }
                    else {
                      lastAlarm = closestAlarm;
                    }

                    //checking status

                    if (pushTime.isAfter(_start) || pushTime.isBefore(_end)) {
                      if ((pushTime.hour == closestAlarm.hour &&
                          pushTime.minute - alarm1Time.minute > 11)
                          || pushTime.hour - closestAlarm.hour < 3) {
                        status = "late";
                        medicineIntake intakeTime = medicineIntake(
                            pushTime, status);
                        late.add(intakeTime);
                        pushes.add(pushTime);
                        if (lastPushDate.isBefore(pushTime)) {
                          lastPushDate = pushTime;
                        }
                        if (firstPushDate.isAfter(pushTime)) {
                          firstPushDate = pushTime;
                          firstClosestAlarm = closestAlarm;
                          firstFarAlarm = farAlarm;
                        }
                        lastPushDate = pushTime;
                        if (closestAlarm.hour < 14) {
                          morning = 1;
                        }
                        else {
                          morning = 0;
                        }
                      }

                      if ((pushTime.hour == closestAlarm.hour) &&
                          (pushTime.minute - closestAlarm.minute < 11)) {
                        status = "onTime";
                        medicineIntake intakeTime = medicineIntake(
                            pushTime, status);
                        onTime.add(intakeTime);
                        //pushes.add(pushTime);
                        if (lastPushDate.isBefore(pushTime)) {
                          lastPushDate = pushTime;
                        }
                        if (firstPushDate.isAfter(pushTime)) {
                          firstPushDate = pushTime;
                          firstClosestAlarm = closestAlarm;
                          firstFarAlarm = farAlarm;
                        }
                        if (closestAlarm.hour < 14) {
                          morning = 1;
                        }
                        else {
                          morning = 0;
                        }
                      }

                      if (pushTime.hour - closestAlarm.hour > 3 &&
                          pushTime.isBefore(farAlarm)) {
                        status = "veryLate";
                        medicineIntake intakeTime = medicineIntake(
                            pushTime, status);
                        veryLate.add(intakeTime);
                        pushes.add(pushTime);
                        if (lastPushDate.isBefore(pushTime)) {
                          lastPushDate = pushTime;
                        }
                        if (firstPushDate.isAfter(pushTime)) {
                          firstPushDate = pushTime;
                          firstClosestAlarm = closestAlarm;
                          firstFarAlarm = farAlarm;
                        }
                        if (closestAlarm.hour < 14) {
                          morning = 1;
                        }
                        else {
                          morning = 0;
                        }
                      }
                    }
                  }


                  pushes.sort((a,b) {
                    return a.compareTo(b);
                  });

                  pushes.removeWhere((push) => push.isBefore(_start) || push.isAfter(_end));


                  if(firstClosestAlarm.isBefore(_start)){
                    firstClosestAlarm = DateTime(_start.year,_start.month, _start.day, firstClosestAlarm.hour,firstClosestAlarm.minute,);
                    firstFarAlarm = DateTime(_start.year,_start.month, _start.day, firstFarAlarm.hour,firstFarAlarm.minute,);
                  }






                  var morningAlarm = firstClosestAlarm;
                  var eveningAlarm = firstFarAlarm;

                  if(morningAlarm.hour > 15){
                    var temp = morningAlarm;
                    morningAlarm = eveningAlarm;
                    eveningAlarm = temp;
                  }
                  var eveningMorningDiff = eveningAlarm.hour - morningAlarm.hour;
                  var morningEveningDiff = (morningAlarm.hour + 24 - eveningAlarm.hour);

                  var i = 0;
                  var status = "missed";
                  for(;i < (pushes.length);){

                    while(pushes[i].difference(morningAlarm).inHours < 0){
                      i++;
                    }

                    if(pushes[i].difference(morningAlarm).inHours >= eveningMorningDiff){
                      if (pushes[i].isAfter(_start) || pushes[i].isBefore(_end)) {
                        medicineIntake intakeTime = medicineIntake(
                            morningAlarm, status);
                        missed.add(intakeTime);
                      }
                    }
                    else{
                      i++;
                    };

                    while( i <  pushes.length && pushes[i].difference(eveningAlarm).inHours < 0){
                      i++;
                    }


                    if(i <  pushes.length && pushes[i].difference(eveningAlarm).inHours >= morningEveningDiff){
                      medicineIntake intakeTime = medicineIntake(eveningAlarm, status);
                      missed.add(intakeTime);
                    }
                    else{i++;};

                    morningAlarm = morningAlarm.add(const Duration(days: 1));
                    eveningAlarm = eveningAlarm.add(const Duration(days: 1));

                  }


                  chartData = [

                new charts.Series<medicineIntake, int>(
                      id: 'Late',
                      // Providing a color function is optional.
                      colorFn: (medicineIntake medicineTime, _) {
                        return charts.MaterialPalette.lime.shadeDefault;
                      },
                      radiusPxFn: (medicineIntake medicineTime, _) => 4.5,
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
                radiusPxFn: (medicineIntake medicineTime, _) => 5.5,
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
                radiusPxFn: (medicineIntake medicineTime, _) => 6.0,
                domainFn: (medicineIntake times, _) => times.dateTime.day,
                measureFn: (medicineIntake times, _) => times.dateTime.hour,
                // // Providing a radius function is optional.
                data: missed,

                )];
                  widget =
                  new charts.ScatterPlotChart(
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
        )
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (newDateRange == null) return; // pressed 'X'

    setState(() => dateRange = newDateRange); // pressed 'SAVE'
  }
}

