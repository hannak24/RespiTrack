import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';


/// Sample ordinal data type.
class medicineTaken {
  final String month;
  final int count;

  medicineTaken(this.month, this.count);
}

List<charts.Series<medicineTaken, String>> createSampleData() {
  final blue = charts.MaterialPalette.indigo.makeShades(22);
  final lightBlue = charts.MaterialPalette.blue.makeShades(2);

  final routine_Inhalor = [
    new medicineTaken('1', 60),
    new medicineTaken('2', 47),
    new medicineTaken('3', 53),
    new medicineTaken('4', 45),
  ];

  final acute_Inhalor = [
    new medicineTaken('1', 5),
    new medicineTaken('2', 2),
    new medicineTaken('3', 10),
    new medicineTaken('11', 4),
  ];

  return [
    new charts.Series<medicineTaken, String>(
      id: 'acute Inhalor',
      seriesCategory: 'acute',
      domainFn: (medicineTaken sales, _) => sales.month,
      measureFn: (medicineTaken sales, _) => sales.count,
      data: acute_Inhalor,
      colorFn: (medicineTaken count, _) => blue[1],
    ),
  ];
}



class GroupedStackedBarChartDB extends StatefulWidget {
  final String whichInhaler;
  const GroupedStackedBarChartDB(this.whichInhaler);

  @override
  State<GroupedStackedBarChartDB> createState() => _GroupedStackedBarChartDBState();
}

class _GroupedStackedBarChartDBState extends State<GroupedStackedBarChartDB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<void>(
        stream: FirebaseFirestore.instance.collection('Routine').orderBy('dateTime').snapshots(),
         builder: (BuildContext context, AsyncSnapshot snapshot1) {
        return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Acute').orderBy('dateTime').snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot2) {
              var seriesList = createSampleData();
              var monthsRoutine = List.filled(13, 0, growable: false);
              var monthsAcute = List.filled(13, 0, growable: false);
              final lightBlue = charts.MaterialPalette.blue.makeShades(2);
              final blue = charts.MaterialPalette.indigo.makeShades(22);
              if (snapshot1.hasData && snapshot2.hasData) {
                for (int index = 0; index < snapshot1.data?.docs.length; index++) {
                    DocumentSnapshot documentSnapshot = snapshot1.data?.docs[index];
                    var initialTime = documentSnapshot["dateTime"].replaceAll(
                    ".", "-");
                    var temp = initialTime.split(" ");
                    var temp2 = temp[1].split("-");
                    var fixedDate = temp2[2] + "-" + temp2[1] + "-" + temp2[0];
                    var fixedTime = fixedDate + " " + temp[0] + "Z";
                    DateTime pushTime = DateTime.parse(fixedTime);
                    monthsRoutine[pushTime.month] = monthsRoutine[pushTime.month] + 1;
                    }

                for (int index = 0; index < snapshot2.data?.docs.length; index++) {
                  DocumentSnapshot documentSnapshot = snapshot2.data?.docs[index];
                  var initialTime = documentSnapshot["dateTime"].replaceAll(
                      ".", "-");
                  var temp = initialTime.split(" ");
                  var temp2 = temp[1].split("-");
                  var fixedDate = temp2[2] + "-" + temp2[1] + "-" + temp2[0];
                  var fixedTime = fixedDate + " " + temp[0] + "Z";
                  DateTime pushTime = DateTime.parse(fixedTime);
                  monthsAcute[pushTime.month] = monthsAcute[pushTime.month] + 1;
                }

                  final routine_Inhalor = [
                    new medicineTaken('1', monthsRoutine[1]),
                    new medicineTaken('2', monthsRoutine[2]),
                    new medicineTaken('3', monthsRoutine[3]),
                    new medicineTaken('4', monthsRoutine[4]),
                    new medicineTaken('5', monthsRoutine[5]),
                    new medicineTaken('6', monthsRoutine[6]),
                    new medicineTaken('7', monthsRoutine[7]),
                    new medicineTaken('8', monthsRoutine[8]),
                    new medicineTaken('9', monthsRoutine[9]),
                    new medicineTaken('10', monthsRoutine[10]),
                    new medicineTaken('11', monthsRoutine[11]),
                    new medicineTaken('12', monthsRoutine[12]),
                  ];

                  final acute_Inhalor = [
                    new medicineTaken('1', monthsAcute[1]),
                    new medicineTaken('2', monthsAcute[2]),
                    new medicineTaken('3', monthsAcute[3]),
                    new medicineTaken('4', monthsAcute[4]),
                    new medicineTaken('5', monthsAcute[5]),
                    new medicineTaken('6', monthsAcute[6]),
                    new medicineTaken('7', monthsAcute[7]),
                    new medicineTaken('8', monthsAcute[8]),
                    new medicineTaken('9', monthsAcute[9]),
                    new medicineTaken('10', monthsAcute[10]),
                    new medicineTaken('11', monthsAcute[11]),
                    new medicineTaken('12', monthsAcute[12]),
                  ];

                  var routine_series = new charts.Series<medicineTaken, String>(
                    id: 'routine Inhalor',
                    seriesCategory: 'routine',
                    domainFn: (medicineTaken count, _) => count.month,
                    measureFn: (medicineTaken count, _) => count.count,
                    data: routine_Inhalor,
                    colorFn: (medicineTaken count, _) => lightBlue[1],
                  );

                  var acute_series = new charts.Series<medicineTaken, String>(
                    id: 'acute Inhalor',
                    seriesCategory: 'acute',
                    domainFn: (medicineTaken sales, _) => sales.month,
                    measureFn: (medicineTaken sales, _) => sales.count,
                    data: acute_Inhalor,
                    colorFn: (medicineTaken count, _) => blue[1],
                  );


                  seriesList = [];
                  if (widget.whichInhaler == "both") {
                    seriesList.add(routine_series);
                    seriesList.add(acute_series);
                  }
                  if(widget.whichInhaler == "routine"){
                    seriesList.add(routine_series);
                  }
                  if(widget.whichInhaler == "acute"){
                    seriesList.add(acute_series);
                  }
                }

                return new charts.BarChart(
                  seriesList,
                  animate: true,
                  barGroupingType: charts.BarGroupingType.groupedStacked,
                  behaviors: [
                    new charts.ChartTitle('Inhaler uses per month',
                        behaviorPosition: charts.BehaviorPosition.top,
                        titleOutsideJustification: charts.OutsideJustification
                            .middleDrawArea,
                        innerPadding: 18),
                    new charts.SeriesLegend(
                      position: charts.BehaviorPosition.bottom,),
                  ],
                );
              });
         }
          )
        );
      }
    }






