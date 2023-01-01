import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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