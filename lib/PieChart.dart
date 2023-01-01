

import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/cupertino.dart';


// pie chart data:
final dataMap = <String, double>{
  "Cough": 5,
  "Whizzing": 3,
  "Sputum discharge": 2,
  "Short breath": 2,
};

final legendLabels = <String, String>{
  "Flutter": "Flutter legend",
  "React": "React legend",
  "Xamarin": "Xamarin legend",
  "Ionic": "Ionic legend",
};

final colorList = <Color>[
  const Color(0xfffdcb6e),
  const Color(0xff0984e3),
  const Color(0xfffd79a8),
  const Color(0xffe17055),
  const Color(0xff6c5ce7),
];

final gradientList = <List<Color>>[
  [
    const Color.fromRGBO(135, 0, 9, 1),
    const Color.fromRGBO(250, 134, 242,1),
  ],
  [
    const Color.fromRGBO(255, 98, 0, 1),
    const Color.fromRGBO(253, 183, 119, 1),
  ],
  [
    const Color.fromRGBO(85, 37, 134, 1.0),
    const Color.fromRGBO(181, 137, 214, 1),
  ],
  [
    const Color.fromRGBO(0, 0, 255, 1),
    const Color.fromRGBO(191, 191, 255, 1),
  ],
];


class pieChart extends StatelessWidget {
  const pieChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: dataMap,
      animationDuration: Duration(
          milliseconds: 1500),
      chartLegendSpacing: 40,
      chartRadius: MediaQuery
          .of(context)
          .size
          .width / 3.3,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 32,
      centerText: "Symptoms\n before\n attacks",
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition
            .right,
        showLegends: true,
        //legendShape: _BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: true,
        decimalPlaces: 1,
      ),
      gradientList: gradientList,
      // emptyColorGradient: ---Empty Color gradient---
    );
  }
}
