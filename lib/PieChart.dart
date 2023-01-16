

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/cupertino.dart';










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


class pieChartDB extends StatefulWidget {
  const pieChartDB({Key? key}) : super(key: key);

  @override
  State<pieChartDB> createState() => _pieChartDBState();
}

class _pieChartDBState extends State<pieChartDB> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Symptoms').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final dataMap1 = <String, double>{
            "Cough": 0,
            "Whizzing": 0,
            "Sputum discharge": 0,
            "Short breath": 0,
            "Other": 0,
          };
          if (snapshot.hasData) {
            for (int index = 0; index < snapshot.data?.docs.length; index++) {
              DocumentSnapshot documentSnapshot = snapshot.data?.docs[index];
              var symptoms = documentSnapshot["symptoms"];
              symptoms = symptoms.split(",");
              for (var i = 0; i < symptoms.length; i++) {
                switch (symptoms[i]) {
                  case "Cough":
                    dataMap1["Cough"] = dataMap1["Cough"]! + 1;
                    break;
                  case "Whizzing":
                    dataMap1["Whizzing"] = dataMap1["Whizzing"]! + 1;
                    break;
                  case "Sputum discharge":
                    dataMap1["Sputum discharge"] =
                        dataMap1["Sputum discharge"]! + 1;
                    break;
                  case "Short breath":
                    dataMap1["Short breath"] = dataMap1["Short breath"]! + 1;
                    break;
                  default:
                    dataMap1["Other"] = dataMap1["Other"]! + 1;
                }
              }
            }
          }
          return PieChart(
            dataMap: dataMap1,
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
            centerText: "Symptoms\n distribution",
            //centerTextStyle: TextStyle(backgroundColor: Color.fromARGB(0, 0, 0, 0)),
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
    );
  }
}
