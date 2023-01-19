import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';



class GroupedStackedBarChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  //final bool animate;
  GroupedStackedBarChart(this.seriesList,); //this.animate);
  factory GroupedStackedBarChart.withSampleData() {
    return GroupedStackedBarChart(
      createSampleData(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: true,
      barGroupingType: charts.BarGroupingType.groupedStacked,
      behaviors: [
        new charts.ChartTitle('Inhaler uses per month',
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
            innerPadding: 18),
        new charts.SeriesLegend(position: charts.BehaviorPosition.bottom,),
      ],
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<medicineTaken, String>> createSampleData() {
    final blue = charts.MaterialPalette.indigo.makeShades(22);
    final lightBlue = charts.MaterialPalette.blue.makeShades(2);

    final routine_Inhalor = [
      new medicineTaken('January', 60),
      new medicineTaken('February', 47),
      new medicineTaken('March', 53),
      new medicineTaken('April', 45),
    ];

    final acute_Inhalor = [
      new medicineTaken('January', 5),
      new medicineTaken('February', 2),
      new medicineTaken('March', 10),
      new medicineTaken('April', 4),
    ];

    return [
      new charts.Series<medicineTaken, String>(
        id: 'routine Inhalor',
        seriesCategory: 'routine',
        domainFn: (medicineTaken count, _) => count.month,
        measureFn: (medicineTaken count, _) => count.count,
        data: routine_Inhalor,
        colorFn: (medicineTaken count, _) => lightBlue[1],
      ),
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

  static List<charts.Series<medicineTaken, String>> createSampleDataRoutine() {
    final blue = charts.MaterialPalette.indigo.makeShades(22);
    final lightBlue = charts.MaterialPalette.blue.makeShades(2);

    final routine_Inhalor = [
      new medicineTaken('January', 60),
      new medicineTaken('February', 47),
      new medicineTaken('March', 53),
      new medicineTaken('April', 45),
    ];


    return [
      new charts.Series<medicineTaken, String>(
        id: 'routine Inhalor',
        seriesCategory: 'routine',
        domainFn: (medicineTaken count, _) => count.month,
        measureFn: (medicineTaken count, _) => count.count,
        data: routine_Inhalor,
        colorFn: (medicineTaken count, _) => lightBlue[1],
      ),
    ];
  }

  static List<charts.Series<medicineTaken, String>> createSampleDataAcute() {
    final blue = charts.MaterialPalette.indigo.makeShades(22);
    final lightBlue = charts.MaterialPalette.blue.makeShades(2);


    final acute_Inhalor = [
      new medicineTaken('January', 5),
      new medicineTaken('February', 2),
      new medicineTaken('March', 10),
      new medicineTaken('April', 4),
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
}

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
    // new charts.Series<medicineTaken, String>(
    //   id: 'routine Inhalor',
    //   seriesCategory: 'routine',
    //   domainFn: (medicineTaken count, _) => count.month,
    //   measureFn: (medicineTaken count, _) => count.count,
    //   data: routine_Inhalor,
    //   colorFn: (medicineTaken count, _) => lightBlue[1],
    // ),
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
  const GroupedStackedBarChartDB({Key? key}) : super(key: key);

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
          var seriesList = createSampleData();
          var months = List.filled(13, 0, growable: false);
          final lightBlue = charts.MaterialPalette.blue.makeShades(2);
          final blue = charts.MaterialPalette.indigo.makeShades(22);
          if(snapshot1.hasData){
            for (int index = 0; index < snapshot1.data?.docs.length; index++) {
              DocumentSnapshot documentSnapshot = snapshot1.data?.docs[index];
              var initialTime = documentSnapshot["dateTime"].replaceAll(".","-");
              var temp = initialTime.split(" ");
              var temp2 = temp[1].split("-");
              var fixedDate = temp2[2] + "-" + temp2[1] + "-" + temp2[0];
              var fixedTime = fixedDate +" "+ temp[0]+"Z";
              DateTime pushTime = DateTime.parse(fixedTime);
              months[pushTime.month] = months[pushTime.month] + 1;


              final routine_Inhalor = [
                new medicineTaken('1', months[1]),
                new medicineTaken('2', months[2]),
                new medicineTaken('3', months[3]),
                new medicineTaken('4', months[4]),
                new medicineTaken('5', months[5]),
                new medicineTaken('6', months[6]),
                new medicineTaken('7', months[7]),
                new medicineTaken('8', months[8]),
                new medicineTaken('9', months[9]),
                new medicineTaken('10', months[10]),
                new medicineTaken('11', months[11]),
                new medicineTaken('12', months[12]),
              ];

              final acute_Inhalor = [
                new medicineTaken('12', 2),
                new medicineTaken('10', 8),
                new medicineTaken('11', 4),
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
              seriesList.add(routine_series);
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
                  titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                  innerPadding: 18),
              new charts.SeriesLegend(position: charts.BehaviorPosition.bottom,),
            ],
          );
        }
      )
    );
  }
}
