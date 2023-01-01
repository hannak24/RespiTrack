import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;



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