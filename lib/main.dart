//import 'package:charts_flutter/flutter.dart';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pie_chart/pie_chart.dart';
//import 'setMedicineAlarmPage.dart';
import 'setMedicineAlarm.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'custom_icons_icons.dart';
//import 'setMedicineAlarmPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'setSymptoms.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AppBarApp());
}
//void main() => runApp(const AppBarApp());


class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: SliverAppBarExample(),
      home: SliverAppBarExample(),
    );
  }
}

enum LegendShape { circle, rectangle }

class SliverAppBarExample extends StatefulWidget {
  const SliverAppBarExample({super.key});

  @override
  State<SliverAppBarExample> createState() => _SliverAppBarExampleState();
}

class _SliverAppBarExampleState extends State<SliverAppBarExample> {
  static const IconData alarm = IconData(0xe072, fontFamily: 'MaterialIcons');
  static const IconData create = IconData(0xe19d, fontFamily: 'MaterialIcons');
  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;
  static const IconData graph = IconData(0xf35a, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData bar_chart = IconData(0xe0cc, fontFamily: 'MaterialIcons');
  static const IconData medication = IconData(0xe3d9, fontFamily: 'MaterialIcons');
  static const IconData stethoscope = IconData(0xf0f1, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData home = IconData(0xe318, fontFamily: 'MaterialIcons');
  static const IconData home_outlined = IconData(0xf107, fontFamily: 'MaterialIcons');
  static const IconData warning = IconData(0xe6cb, fontFamily: 'MaterialIcons');



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

  void _pushMedicineStatistics() {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (context) {
              return DefaultTabController(
                length: 4,
                child: Scaffold(
                  bottomNavigationBar: BottomAppBar(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: OverflowBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        overflowAlignment: OverflowBarAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.person_outlined),
                                onPressed: () {_pushProfile();},
                                tooltip: "medicine settings",
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(_SliverAppBarExampleState.alarm),
                                onPressed: () {_pushSetMedicineAlarm();},
                                tooltip: "Set medicine alarm",
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(_SliverAppBarExampleState.home_outlined),
                                onPressed: () {Navigator.of(context).popUntil((route) => route.isFirst);},
                                tooltip: "Back to home page",
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(_SliverAppBarExampleState.bar_chart),
                                onPressed: () {_pushMedicineStatistics();},
                                tooltip: "Medicines statistics",
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.sick_outlined),
                                onPressed: () {},
                                tooltip: "add symptom entry",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  appBar: AppBar(
                    bottom:  TabBar(
                      tabs: [
                        Tab(icon: graphIcon()),
                        Tab(icon: routineIcon()),
                        Tab(icon: acuteIcon()),
                        Tab(icon: symptomIcon()),
                      ],
                    ),
                    title: const Text('Medical Statistics'),
                  ),
                  body: TabBarView(
                    children: [
                      CustomScrollView(
                        slivers: <Widget>[
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                Size size = MediaQuery
                                    .of(context)
                                    .size;
                                return Container(
                                  height: 1000 - MediaQuery
                                      .of(context)
                                      .viewInsets
                                      .bottom,
                                  color: Colors.black12,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 7.0,
                                          width: size.width,
                                        ),
                                        Container(
                                            height: 70.0,
                                            width: size.width,
                                            //color: Color(0xFF010280),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                    const Color(0xFF010280),
                                                    const Color(0xFF135CC5),
                                                    const Color(0xFF010280),
                                                  ],
                                                  begin: const FractionalOffset(
                                                      0.0, 0.0),
                                                  end: const FractionalOffset(
                                                      1.0, 0.0),
                                                  stops: [0.0, 0.5, 0.8],
                                                  tileMode: TileMode.mirror),
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 8.0),
                                                  child: Text(
                                                    "Doses remaining ",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 50.0, right: 50.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    mainAxisSize: MainAxisSize
                                                        .max,
                                                    children: [
                                                      Column(
                                                          children: [
                                                            Text(
                                                              "acute inhaler: ",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white),),
                                                            Text("146",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight: FontWeight
                                                                      .bold),)
                                                          ]
                                                      ),
                                                      Column(
                                                          children: [
                                                            Text(
                                                              "Routine inhaler: ",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white),),
                                                            Text("25",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight: FontWeight
                                                                      .bold),)
                                                          ]
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                        ),
                                        //dozes remaining

                                        SizedBox(
                                          height: 5.0,
                                          width: size.width,
                                        ),
                                        // space

                                        SizedBox(
                                          height: 250.0,
                                          width: size.width,
                                          child: Card(
                                            elevation: 3.5,
                                            child: GroupedStackedBarChart(
                                                GroupedStackedBarChart
                                                    .createSampleData()),
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .outline,
                                              ),
                                              borderRadius: const BorderRadius
                                                  .all(Radius.circular(12)),
                                            ),
                                          ),
                                        ),
                                        // bar chart inhaler uses per month

                                        SizedBox(
                                          height: 10,
                                          width: size.width,
                                        ),
                                        //space

                                        SizedBox(
                                          height: 87.0,
                                          width: size.width,
                                          child: Card(
                                              elevation: 3.5,
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 5.0),
                                                    child: Text(
                                                      "Average number of squeezes/rotations per usage: ",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors
                                                              .black),),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 70.0,
                                                        right: 70.0,
                                                        top: 10),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceBetween,
                                                      mainAxisSize: MainAxisSize
                                                          .max,
                                                      children: [
                                                        Column(
                                                            children: [
                                                              Text(
                                                                "acute inhaler: ",
                                                                style: TextStyle(
                                                                    fontSize: 12,
                                                                    color: Colors
                                                                        .black),),
                                                              Text("1.4",
                                                                style: TextStyle(
                                                                    fontSize: 12,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight: FontWeight
                                                                        .bold),)
                                                            ]
                                                        ),
                                                        Column(
                                                            children: [
                                                              Text(
                                                                "Routine inhaler: ",
                                                                style: TextStyle(
                                                                    fontSize: 12,
                                                                    color: Colors
                                                                        .black),),
                                                              Text("1.1",
                                                                style: TextStyle(
                                                                    fontSize: 12,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight: FontWeight
                                                                        .bold),)
                                                            ]
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                          ),
                                        ),
                                        //average number of squeezes per use

                                        SizedBox(
                                          height: 10,
                                          width: size.width,
                                        ),
                                        // space

                                        SizedBox(
                                          height: 250.0,
                                          width: size.width,
                                          child: Card(
                                            elevation: 3.5,
                                            child: PieChart(
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
                                            ),
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .outline,
                                              ),
                                              borderRadius: const BorderRadius
                                                  .all(Radius.circular(12)),
                                            ),
                                          ),
                                        ),
                                        // pie chart symptoms before asthma attacks

                                        SizedBox(
                                          height: 10,
                                          width: size.width,
                                        ),

                                        SizedBox(
                                          height: 250.0,
                                          width: size.width,
                                          child: Card(
                                            elevation: 3.5,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .outline,
                                              ),
                                              borderRadius: const BorderRadius
                                                  .all(Radius.circular(12)),
                                            ),
                                            child: SimpleScatterPlotChart(
                                              SimpleScatterPlotChart
                                                  ._createSampleData(),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: 1,
                            ),
                          ),
                        ],
                      ),
                      CustomScrollView(
                        slivers: <Widget>[
                        SliverList(
                        delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                        Size size = MediaQuery
                            .of(context)
                            .size;
                        return Container(
                          height: 1000 - MediaQuery
                              .of(context)
                              .viewInsets
                              .bottom,
                          color: Colors.black12,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                              SizedBox(
                              height: 7.0,
                              width: size.width,
                              ),

                              Container(
                              height: 70.0,
                              width: size.width,
                              //color: Color(0xFF010280),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF010280),
                                    const Color(0xFF135CC5),
                                    const Color(0xFF010280),
                                  ],
                                  begin: const FractionalOffset(
                                    0.0, 0.0),
                                  end: const FractionalOffset(
                                    1.0, 0.0),
                                  stops: [0.0, 0.5, 0.8],
                                  tileMode: TileMode.mirror),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                    padding: EdgeInsets.only(
                                    top: 8.0),
                                    child: Text(
                                      "Doses remaining ",
                                      style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white),),
                                    ),
                                    Padding(
                                    padding: EdgeInsets.only(
                                    left: 50.0, right: 50.0),
                                    child: Center(
                                      child: Column(
                                      children: [
                                      Text("25",
                                      style: TextStyle(
                                      fontSize: 20,
                                      color: Colors
                                          .white,
                                      fontWeight: FontWeight
                                          .bold),)
                                      ]
                                      )
                                     ),
                                   )
                                 ],
                                )
                              ),//doses remaining


                              SizedBox(
                              height: 5.0,
                              width: size.width,
                              ),
                              // space

                              SizedBox(
                              height: 250.0,
                              width: size.width,
                              child: Card(
                              elevation: 3.5,
                              child: GroupedStackedBarChart(
                              GroupedStackedBarChart
                                  .createSampleDataRoutine()),
                              shape: RoundedRectangleBorder(
                              side: BorderSide(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .outline,
                              ),
                              borderRadius: const BorderRadius
                                  .all(Radius.circular(12)),
                              ),
                              ),
                              ),// bar chart inhaler uses per month


                              SizedBox(
                              height: 10,
                              width: size.width,
                              ),
                              //space

                              SizedBox(
                              height: 87.0,
                              width: size.width,
                              child: Card(
                                elevation: 3.5,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                      top: 5.0),
                                      child: Text(
                                      "Average number of squeezes per usage: ",
                                      style: TextStyle(
                                      fontSize: 15,
                                      color: Colors
                                          .black),),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                      left: 70.0,
                                      right: 70.0,
                                      top: 10),
                                      child: Center(
                                        child: Column(
                                        children: [
                                      Text("1.1",
                                      style: TextStyle(
                                      fontSize: 20,
                                      color: Colors
                                          .black,
                                      fontWeight: FontWeight
                                          .bold),)
                                      ]
                                        )
                                      ),
                                    ),
                                  ]
                                )
                               ),
                              ),//average number of squeezes per use


                              SizedBox(
                              height: 10,
                              width: size.width,
                              ),// space


                              SizedBox(
                              height: 250.0,
                              width: size.width,
                              child: Card(
                              elevation: 3.5,
                              shape: RoundedRectangleBorder(
                              side: BorderSide(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .outline,
                              ),
                              borderRadius: const BorderRadius
                                  .all(Radius.circular(12)),
                              ),
                              child: SimpleScatterPlotChart(
                              SimpleScatterPlotChart
                                  ._createSampleData(),),
                              ),
                              ),
                              ],
                            ),
                          ),
                        );
                        },
                        childCount: 1,
                        ),
                        ),
                        ],
                      ),
                      CustomScrollView(
                        slivers: <Widget>[
                        SliverList(
                        delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                        Size size = MediaQuery
                            .of(context)
                            .size;
                        return Container(
                          height: 1000 - MediaQuery
                              .of(context)
                              .viewInsets
                              .bottom,
                          color: Colors.black12,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                              SizedBox(
                              height: 7.0,
                              width: size.width,
                              ),

                              Container(
                              height: 70.0,
                              width: size.width,
                              //color: Color(0xFF010280),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF010280),
                                    const Color(0xFF135CC5),
                                    const Color(0xFF010280),
                                  ],
                                  begin: const FractionalOffset(
                                    0.0, 0.0),
                                  end: const FractionalOffset(
                                    1.0, 0.0),
                                  stops: [0.0, 0.5, 0.8],
                                  tileMode: TileMode.mirror),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                    padding: EdgeInsets.only(
                                    top: 8.0),
                                    child: Text(
                                      "Doses remaining ",
                                      style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white),),
                                    ),
                                    Padding(
                                    padding: EdgeInsets.only(
                                    left: 50.0, right: 50.0),
                                    child: Center(
                                      child: Column(
                                      children: [
                                      Text("146",
                                      style: TextStyle(
                                      fontSize: 20,
                                      color: Colors
                                          .white,
                                      fontWeight: FontWeight
                                          .bold),)
                                      ]
                                      )
                                     ),
                                   )
                                 ],
                                )
                              ),//doses remaining


                              SizedBox(
                              height: 5.0,
                              width: size.width,
                              ),
                              // space

                              SizedBox(
                              height: 250.0,
                              width: size.width,
                              child: Card(
                              elevation: 3.5,
                              child: GroupedStackedBarChart(
                              GroupedStackedBarChart
                                  .createSampleDataAcute()),
                              shape: RoundedRectangleBorder(
                              side: BorderSide(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .outline,
                              ),
                              borderRadius: const BorderRadius
                                  .all(Radius.circular(12)),
                              ),
                              ),
                              ),// bar chart inhaler uses per month


                              SizedBox(
                              height: 10,
                              width: size.width,
                              ),
                              //space

                              SizedBox(
                              height: 87.0,
                              width: size.width,
                              child: Card(
                                elevation: 3.5,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                      top: 5.0),
                                      child: Text(
                                      "Average number of squeezes per usage: ",
                                      style: TextStyle(
                                      fontSize: 15,
                                      color: Colors
                                          .black),),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                      left: 70.0,
                                      right: 70.0,
                                      top: 10),
                                      child: Center(
                                        child: Column(
                                        children: [
                                      Text("1.4",
                                      style: TextStyle(
                                      fontSize: 20,
                                      color: Colors
                                          .black,
                                      fontWeight: FontWeight
                                          .bold),)
                                      ]
                                        )
                                      ),
                                    ),
                                  ]
                                )
                               ),
                              ),//average number of squeezes per use

                              ],
                            ),
                          ),
                        );
                        },
                        childCount: 1,
                        ),
                        ),
                        ],
                      ),
                      CustomScrollView(
                        slivers: <Widget>[
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                Size size = MediaQuery
                                    .of(context)
                                    .size;
                                return Container(
                                  height: 1000 - MediaQuery
                                      .of(context)
                                      .viewInsets
                                      .bottom,
                                  color: Colors.black12,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [

                                        SizedBox(
                                          height: 7.0,
                                          width: size.width,
                                        ), // space

                                        SizedBox(
                                          height: 250.0,
                                          width: size.width,
                                          child: Card(
                                            elevation: 3.5,
                                            child: PieChart(
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
                                            ),
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .outline,
                                              ),
                                              borderRadius: const BorderRadius
                                                  .all(Radius.circular(12)),
                                            ),
                                          ),
                                        ), // pie chart symptoms before asthma attacks

                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
    ));
  }

  void _pushLogin() {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) {
            return Scaffold(
              //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              body: Stack(
                  children: [
                    CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          expandedHeight: 160.0,
                          backgroundColor: Colors.blue,
                          flexibleSpace: const FlexibleSpaceBar(
                            title: Text(
                                'RespiTrack',
                                style: TextStyle(
                                  fontSize: 19,
                                )
                            ),
                            titlePadding: EdgeInsets.all(11.0),
                            background: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0, left: 6.0, top: 2.0),
                                child: const Image(
                                  //image: NetworkImage("https://www.aaaai.org/Aaaai/media/MediaLibraryRedesign/Tools%20for%20the%20Public/Conditions%20Library/Library%20-%20Asthma/skd238387sdc-mother-daugh-inhaler-cropped.jpg"),
                                  image: NetworkImage("https://cdn.pixabay.com/photo/2019/04/27/01/46/asthma-4159147_1280.png"),
                                )
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              Size size = MediaQuery.of(context).size;
                              return Container(
                                height: 1000 - MediaQuery.of(context).viewInsets.bottom,
                                color: Colors.white,
                                child: SingleChildScrollView(
                                  child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                      children: [
                                        const Text(
                                          "Welcome to RespiTrack, your smart inhalor app! please log in!",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        TextField(
                                          obscureText: false,
                                          //controller: emailController,
                                          decoration: InputDecoration(
                                            labelText: 'Email',
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        TextField(
                                          obscureText: true,
                                          //controller: passwordController,
                                          decoration: InputDecoration(
                                            labelText: 'Password',
                                          ),
                                        ),
                                        SizedBox(height: 40),
                                        TextButton(
                                          style: ButtonStyle(
                                            minimumSize: MaterialStateProperty.all(Size(380, 50)),
                                            foregroundColor: const MaterialStatePropertyAll<
                                                Color>(Colors.white),
                                            backgroundColor: const MaterialStatePropertyAll<
                                                Color>(Colors.indigo),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                side: const BorderSide(width: 3,
                                                    color: Colors.indigo),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: Column(
                                            children: const <Widget>[
                                              Text("Login"),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            foregroundColor: const MaterialStatePropertyAll<
                                                Color>(Colors.white),
                                            backgroundColor: const MaterialStatePropertyAll<
                                                Color>(Colors.blue),
                                            minimumSize: MaterialStateProperty.all(Size(380, 50)),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                side: const BorderSide(width: 3,
                                                    color: Colors.blue),
                                              ),
                                            ),
                                          ),
                                          onPressed: () async {
                                            showModalBottomSheet<void>(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (BuildContext context) {
                                                return Container(
                                                    height: 800 - MediaQuery.of(context).viewInsets.bottom,
                                                    color: Colors.white,
                                                    child:Padding(
                                                        padding: EdgeInsets.only(
                                                            bottom: MediaQuery.of(context).viewInsets.bottom),
                                                        child: Center(
                                                          child: SingleChildScrollView(
                                                            reverse: true,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(16.0),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: <Widget>[
                                                                  const Text('Please confirm your password below:'),
                                                                  TextField(
                                                                      obscureText: true,
                                                                      //controller: confirmPasswordController,
                                                                      decoration: const InputDecoration(
                                                                        labelText: 'Password',
                                                                      )),
                                                                  SizedBox(height: 10),
                                                                  ElevatedButton(
                                                                      child: const Text('Confirm'),
                                                                      onPressed: () async {},
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                    )
                                                );
                                              },
                                            );
                                          },
                                          child: Column(
                                            children: const <Widget>[
                                              Text("New user? Click to sign up"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: 1,
                          ),
                        ),
                      ],
                    ),
                  ]
              ),
            );
          }
        )
    );
  }

  void _pushSetMedicineAlarm(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return  AlarmPage();
    }));
  }

  void _pushSymptoms(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return  SymptomsPage();
    }));
  }

  void _pushMedicineSettings() {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (context) {
              return DefaultTabController(
                length: 3,
                child: Scaffold(
                  bottomNavigationBar: BottomAppBar(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: OverflowBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        overflowAlignment: OverflowBarAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.person_outlined),
                                onPressed: () {_pushProfile();},
                                tooltip: "medicine settings",
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(_SliverAppBarExampleState.alarm),
                                onPressed: () {_pushSetMedicineAlarm();},
                                tooltip: "Set medicine alarm",
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(_SliverAppBarExampleState.home_outlined),
                                onPressed: () {Navigator.of(context).popUntil((route) => route.isFirst);},
                                tooltip: "Back to home page",
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(_SliverAppBarExampleState.bar_chart),
                                onPressed: () {_pushMedicineStatistics();},
                                tooltip: "Medicines statistics",
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.sick_outlined),
                                onPressed: () {},
                                tooltip: "add symptom entry",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  appBar: AppBar(
                      bottom: const TabBar(
                      tabs: [
                        Tab(icon: Icon(Icons.person), text: "profile"),
                        Tab(icon: Icon(CustomIcons.inhalator__1_), text: "Medications"),
                        Tab(icon: Icon(CustomIcons.stethoscope),text: "Doctor"),
                      ],
                    ),
                    title: const Text("Pippi's profile"),
                  ),
                  body: TabBarView(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                              children: [
                                SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    fit: StackFit.expand,
                                    children: [
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        child: CircleAvatar(
                                          radius: 100,
                                          backgroundImage: NetworkImage(
                                              "https://www.aaaai.org/Aaaai/media/MediaLibraryRedesign/Tools%20for%20the%20Public/Conditions%20Library/Library%20-%20Asthma/skd238387sdc-mother-daugh-inhaler-cropped.jpg"),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: -15,
                                        child: RawMaterialButton(
                                          onPressed: () {},
                                          elevation: 5.0,
                                          fillColor: Color(0xFFF5F6F9),
                                          child: Icon(Icons.camera_alt_outlined,
                                            color: Colors.blue,),
                                          padding: EdgeInsets.all(15.0),
                                          shape: CircleBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12),
                                TextButton(
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                        Size(380, 50)),
                                    foregroundColor: const MaterialStatePropertyAll<
                                        Color>(Colors.white),
                                    backgroundColor: const MaterialStatePropertyAll<
                                        Color>(Colors.blue),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            30.0),
                                        side: const BorderSide(width: 3,
                                            color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Column(
                                    children: const <Widget>[
                                      Text("Log out"),
                                    ],
                                  ),
                                ), //logout
                                SizedBox(height: 12),
                                Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                        children: [
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text("name", style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                                    Text("Pippi")
                                                  ],
                                                ),
                                                IconButton(
                                                  icon: Icon(_SliverAppBarExampleState.create),
                                                  onPressed: () {},
                                                ),
                                              ]
                                          ), //name
                                          SizedBox(height: 10),
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("age",style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                                    Text("11")
                                                  ],
                                                ),
                                                IconButton(
                                                  icon: Icon(_SliverAppBarExampleState.create),
                                                  onPressed: () {},
                                                ),
                                              ]
                                          ), //age
                                          SizedBox(height: 10),
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("id",style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                                    Text("123456789")
                                                  ],
                                                ),
                                                IconButton(
                                                  icon: Icon(_SliverAppBarExampleState.create),
                                                  onPressed: () {},
                                                ),
                                              ]
                                          ), //i
                                        ]
                                    )
                                ),
                              ]
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Center(
                          child:Column(
                            children: [
                              SizedBox(height: 10),
                              Card(
                                elevation: 3.5,
                                child: Column(
                                    children: [
                                      Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                                            gradient: LinearGradient(
                                                colors: [
                                                  const Color(0xFFFF4E00),
                                                  const Color(0xFFEC9F05),
                                                  const Color(0xFFFF4E00),
                                                ],
                                                begin: const FractionalOffset(0.0, 0.0),
                                                end: const FractionalOffset(1.0, 0.0),
                                                stops: [0.0, 0.5, 0.8],
                                                tileMode: TileMode.mirror),
                                          ),
                                          child: Center(
                                              child: Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: Column(
                                                      children:[
                                                        Icon(CustomIcons.inhalator__1_, color: Colors.white),
                                                        SizedBox(height: 7),
                                                        Text("Routine Inhaler",style:TextStyle(color: Colors.white))
                                                      ]
                                                  )
                                              )
                                          )
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                              children: [
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Medicine name", style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                                          Text("Salbutrim")
                                                        ],
                                                      ),
                                                      IconButton(
                                                        icon: Icon(_SliverAppBarExampleState.create),
                                                        onPressed: () {},
                                                      ),
                                                    ]
                                                ), //name
                                                SizedBox(height: 10),
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Prescripted Dose",style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                                          Text("1 squeeze twice a day")
                                                        ],
                                                      ),
                                                      IconButton(
                                                        icon: Icon(_SliverAppBarExampleState.create),
                                                        onPressed: () {},
                                                      ),
                                                    ]
                                                ), //age
                                                SizedBox(height: 10),
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Num of doses in bottle",style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                                          Text("200")
                                                        ],
                                                      ),
                                                      IconButton(
                                                        icon: Icon(_SliverAppBarExampleState.create),
                                                        onPressed: () {},
                                                      ),
                                                    ]
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Expiration Date",style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                                          Text("11/11/2026"),
                                                          // SfDateRangePicker(
                                                          // view: DateRangePickerView.month,
                                                          // monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                                                          // )
                                                        ],
                                                      ),
                                                      IconButton(
                                                        icon: Icon(_SliverAppBarExampleState.create),
                                                        onPressed: () {},
                                                      ),
                                                    ]
                                                ), //i
                                              ]
                                          )
                                      ),
                                    ]
                                ),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Theme.of(context).colorScheme.outline,
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                ),
                              ),
                              SizedBox(height: 10),
                              Card(
                                elevation: 3.5,
                                child: Column(
                                    children: [
                                      Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                                            gradient: LinearGradient(
                                                colors: [
                                                  const Color(0xFF010280),
                                                  const Color(0xFF135CC5),
                                                  const Color(0xFF010280),
                                                ],
                                                begin: const FractionalOffset(0.0, 0.0),
                                                end: const FractionalOffset(1.0, 0.0),
                                                stops: [0.0, 0.5, 0.8],
                                                tileMode: TileMode.mirror),
                                          ),
                                          child: Center(
                                              child: Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: Column(
                                                      children:[
                                                        Icon(CustomIcons.inhalator__1_, color: Colors.white),
                                                        SizedBox(height: 7),
                                                        Text("acute Inhaler",style: TextStyle(color:Colors.white))
                                                      ]
                                                  )
                                              )
                                          )
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                              children: [
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Medicine name", style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                                          Text("Turbuhaler")
                                                        ],
                                                      ),
                                                      IconButton(
                                                        icon: Icon(_SliverAppBarExampleState.create),
                                                        onPressed: () {},
                                                      ),
                                                    ]
                                                ), //name
                                                SizedBox(height: 10),
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Prescripted Dose",style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                                          Text("2 squeezes when needed")
                                                        ],
                                                      ),
                                                      IconButton(
                                                        icon: Icon(_SliverAppBarExampleState.create),
                                                        onPressed: () {},
                                                      ),
                                                    ]
                                                ), //age
                                                SizedBox(height: 10),
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Num of doses in bottle",style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                                          Text("120")
                                                        ],
                                                      ),
                                                      IconButton(
                                                        icon: Icon(_SliverAppBarExampleState.create),
                                                        onPressed: () {},
                                                      ),
                                                    ]
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Expiration Date",style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                                          Text("11/11/2026")
                                                        ],
                                                      ),
                                                      IconButton(
                                                        icon: Icon(_SliverAppBarExampleState.create),
                                                        onPressed: () {},
                                                      ),
                                                    ]
                                                ), //i
                                              ]
                                          )
                                      ),
                                    ]
                                ),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Theme.of(context).colorScheme.outline,
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                ),
                              ),
                            ]
                          )
                        )
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Column(
                                        children: [
                                          Text("Doctor's name", style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                          Text("Dr. Strange")
                                        ],
                                      ),
                                      IconButton(
                                        icon: Icon(_SliverAppBarExampleState.create),
                                        onPressed: () {},
                                      ),
                                    ]
                                ), //name
                                SizedBox(height: 10),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Doctor's Email",style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                                          Text("DoctorStrange@gmail.com")
                                        ],
                                      ),
                                      IconButton(
                                        icon: Icon(_SliverAppBarExampleState.create),
                                        onPressed: () {},
                                      ),
                                    ]
                                ), //age
                              ]
                          )
                      ),
                    ],
                  ),
                ),
              );
            },
        ),
    );
  }


// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].
  //@override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     floatingActionButton: FloatingActionButton(
  //       tooltip: 'Send report to doctor',
  //       onPressed: () {},
  //       backgroundColor: Colors.blue,
  //       child: const Icon(Icons.send),
  //     ),
  //     //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  //     body: Stack(
  //       children: [
  //         CustomScrollView(
  //
  //           slivers: <Widget>[
  //             SliverAppBar(
  //               expandedHeight: 160.0,
  //               backgroundColor: Colors.blue,
  //               flexibleSpace: const FlexibleSpaceBar(
  //                 title: Text(
  //                     'RespiTrack',
  //                     style: TextStyle(
  //                       fontSize: 19,
  //                     )
  //                 ),
  //                 titlePadding: EdgeInsets.all(11.0),
  //                 background: Padding(
  //                     padding: const EdgeInsets.only(bottom: 10.0, left: 6.0, top: 2.0),
  //                     child: const Image(
  //                       //image: NetworkImage("https://www.aaaai.org/Aaaai/media/MediaLibraryRedesign/Tools%20for%20the%20Public/Conditions%20Library/Library%20-%20Asthma/skd238387sdc-mother-daugh-inhaler-cropped.jpg"),
  //                       image: NetworkImage("https://cdn.pixabay.com/photo/2019/04/27/01/46/asthma-4159147_1280.png"),
  //                       )
  //                     ),
  //               ),
  //             ),
  //             SliverList(
  //               delegate: SliverChildBuilderDelegate(
  //                     (BuildContext context, int index) {
  //                       Size size = MediaQuery.of(context).size;
  //                       return Container(
  //                         height: 1000 - MediaQuery.of(context).viewInsets.bottom,
  //                         color: Colors.black12,
  //                         child: SingleChildScrollView(
  //                           child: Column(
  //                             children: [
  //                               Container(
  //                                 height: 60.0,
  //                                 width: size.width,
  //                                 //color: Color(0xFF010280),
  //                                   decoration: BoxDecoration(
  //                                     gradient: LinearGradient(
  //                                         colors: [
  //                                           const Color(0xFF010280),
  //                                           const Color(0xFF135CC5),
  //                                           const Color(0xFF010280),
  //                                         ],
  //                                         begin: const FractionalOffset(0.0, 0.0),
  //                                         end: const FractionalOffset(1.0, 0.0),
  //                                         stops: [0.0, 0.5, 0.8],
  //                                         tileMode: TileMode.mirror),
  //                                   ),
  //                                 child: Column(
  //                                   children: [
  //                                     Padding(
  //                                     padding: EdgeInsets.only(top: 5.0),
  //                                       child: Text("Dozes remaining ",style: TextStyle(
  //                                           fontSize: 15, color: Colors.white),),
  //                                     ),
  //                                     Padding(
  //                                       padding: EdgeInsets.only(left: 50.0,right: 50.0),
  //                                       child: Row(
  //                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                       mainAxisSize: MainAxisSize.max,
  //                                       children: [
  //                                         Column(
  //                                             children: [
  //                                               Text("acute inhaler: ", style: TextStyle(
  //                                                   fontSize: 12, color: Colors.white),),
  //                                               Text("146", style: TextStyle(
  //                                                   fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),)
  //                                               ]
  //                                         ),
  //                                         Column(
  //                                             children: [
  //                                               Text("Routine inhaler: ",style: TextStyle(
  //                                                   fontSize: 12, color: Colors.white),),
  //                                               Text("25", style: TextStyle(
  //                                                   fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),)
  //                                             ]
  //                                         )
  //                                       ],
  //
  //                                     ),
  //                                     )
  //                                   ],
  //                                 )
  //                               ), //dozes remaining
  //
  //                               SizedBox(
  //                                 height: 5.0,
  //                                 width: size.width,
  //                               ),// space
  //
  //                               SizedBox(
  //                               height: 250.0,
  //                               width: size.width,
  //                               child: Card(
  //                                 elevation: 3.5,
  //                                 child: GroupedStackedBarChart(GroupedStackedBarChart.createSampleData()),
  //                                 shape: RoundedRectangleBorder(
  //                                   side: BorderSide(
  //                                     color: Theme.of(context).colorScheme.outline,
  //                                   ),
  //                                   borderRadius: const BorderRadius.all(Radius.circular(12)),
  //                                 ),
  //                                ),
  //                               ),// bar chart inhaler uses per month
  //
  //                               SizedBox(
  //                                 height: 10,
  //                                 width: size.width,
  //                               ), //space
  //
  //                               SizedBox(
  //                                   height: 87.0,
  //                                   width: size.width,
  //                                   child: Card(
  //                                     elevation: 3.5,
  //                                       color: Colors.white,
  //                                       child: Column(
  //                                       children: [
  //                                         Padding(
  //                                           padding: EdgeInsets.only(top: 5.0),
  //                                           child: Text("Average number of squeezes/rotations per usage: ",style: TextStyle(
  //                                               fontSize: 15, color: Colors.black),),
  //                                         ),
  //                                         Padding(
  //                                           padding: EdgeInsets.only(left: 70.0,right: 70.0, top: 10),
  //                                           child: Row(
  //                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                             mainAxisSize: MainAxisSize.max,
  //                                             children: [
  //                                               Column(
  //                                                   children: [
  //                                                     Text("acute inhaler: ", style: TextStyle(
  //                                                         fontSize: 12, color: Colors.black),),
  //                                                     Text("1.4", style: TextStyle(
  //                                                         fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),)
  //                                                   ]
  //                                               ),
  //                                               Column(
  //                                                   children: [
  //                                                     Text("Routine inhaler: ",style: TextStyle(
  //                                                         fontSize: 12, color: Colors.black),),
  //                                                     Text("1.1", style: TextStyle(
  //                                                         fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),)
  //                                                   ]
  //                                               )
  //                                           ],
  //                                         ),
  //                                       )
  //                                     ],
  //                                   )
  //                                 ),
  //                               ), //average number of squeezes per use
  //
  //                               SizedBox(
  //                                 height: 10,
  //                                 width: size.width,
  //                               ), // space
  //
  //                               SizedBox(
  //                                 height: 250.0,
  //                                 width: size.width,
  //                                 child: Card(
  //                                   elevation: 3.5,
  //                                   child: PieChart(
  //                                     dataMap: dataMap,
  //                                     animationDuration: Duration(milliseconds: 1500),
  //                                     chartLegendSpacing: 40,
  //                                     chartRadius: MediaQuery.of(context).size.width / 3.3,
  //                                     colorList: colorList,
  //                                     initialAngleInDegree: 0,
  //                                     chartType: ChartType.ring,
  //                                     ringStrokeWidth: 32,
  //                                     centerText: "Symptoms\n before\n attacks",
  //                                     legendOptions: LegendOptions(
  //                                       showLegendsInRow: false,
  //                                       legendPosition: LegendPosition.right,
  //                                       showLegends: true,
  //                                       //legendShape: _BoxShape.circle,
  //                                       legendTextStyle: TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                       ),
  //                                     ),
  //                                     chartValuesOptions: ChartValuesOptions(
  //                                       showChartValueBackground: true,
  //                                       showChartValues: true,
  //                                       showChartValuesInPercentage: true,
  //                                       showChartValuesOutside: true,
  //                                       decimalPlaces: 1,
  //                                     ),
  //                                       gradientList: gradientList,
  //                                     // emptyColorGradient: ---Empty Color gradient---
  //                                   ),
  //                                   shape: RoundedRectangleBorder(
  //                                     side: BorderSide(
  //                                       color: Theme.of(context).colorScheme.outline,
  //                                     ),
  //                                     borderRadius: const BorderRadius.all(Radius.circular(12)),
  //                                   ),
  //                                 ),
  //                               ), // pie chart symptoms before asthma attacks
  //
  //                               SizedBox(
  //                                 height: 10,
  //                                 width: size.width,
  //                               ),
  //
  //                               SizedBox(
  //                                 height: 250.0,
  //                                 width: size.width,
  //                                 child: Card(
  //                                   elevation: 3.5,
  //                                   shape: RoundedRectangleBorder(
  //                                     side: BorderSide(
  //                                       color: Theme.of(context).colorScheme.outline,
  //                                     ),
  //                                     borderRadius: const BorderRadius.all(Radius.circular(12)),
  //                                   ),
  //                                   child: SimpleScatterPlotChart(SimpleScatterPlotChart._createSampleData(),),
  //                                   ),
  //                                 ),
  //                             ],
  //                         ),
  //                       ),
  //                   );
  //                 },
  //                 childCount: 1,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ]
  //     ),
  //     bottomNavigationBar: BottomAppBar(
  //       child: Padding(
  //         padding: const EdgeInsets.all(8),
  //         child: OverflowBar(
  //           alignment: MainAxisAlignment.spaceEvenly,
  //           overflowAlignment: OverflowBarAlignment.center,
  //           children: <Widget>[
  //             Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 IconButton(
  //                   icon: const Icon(Icons.person_outlined),
  //                   onPressed: () {_pushProfile();},
  //                   tooltip: "medicine settings",
  //                 ),
  //               ],
  //             ),
  //             Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 IconButton(
  //                     icon: const Icon(_SliverAppBarExampleState.alarm),
  //                     onPressed: () {_pushSetMedicineAlarm();},
  //                     tooltip: "Set medicine alarm",
  //                 ),
  //               ],
  //             ),
  //             Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 IconButton(
  //                   icon: const Icon(_SliverAppBarExampleState.home_outlined),
  //                   onPressed: () {_pushHomePage();},
  //                   tooltip: "Go to home page",
  //                 ),
  //               ],
  //             ),
  //             Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 IconButton(
  //                   icon: const Icon(_SliverAppBarExampleState.bar_chart),
  //                   onPressed: () {_pushMedicineStatistics();},
  //                   tooltip: "Medicines statistics",
  //                 ),
  //               ],
  //             ),
  //             Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 IconButton(
  //                   icon: const Icon(Icons.sick_outlined),
  //                   onPressed: () {},
  //                   tooltip: "add symptom entry",
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      // child: Builder(builder: (BuildContext context) {
      //   return NestedScrollView(
      child: Scaffold(
          bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: OverflowBar(
              alignment: MainAxisAlignment.spaceEvenly,
              overflowAlignment: OverflowBarAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.person_outlined),
                      onPressed: () {_pushProfile();},
                      tooltip: "medicine settings",
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(_SliverAppBarExampleState.alarm),
                      onPressed: () {_pushSetMedicineAlarm();},
                      tooltip: "Set medicine alarm",
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(_SliverAppBarExampleState.home_outlined),
                      onPressed: () {Navigator.of(context).popUntil((route) => route.isFirst);},
                      tooltip: "Back to home page",
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(_SliverAppBarExampleState.bar_chart),
                      onPressed: () {_pushMedicineStatistics();},
                      tooltip: "Medicines statistics",
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.sick_outlined),
                      onPressed: () {},
                      tooltip: "add symptom entry",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
          floatingActionButton: FloatingActionButton(
                tooltip: 'Send report to doctor',
                onPressed: () {},
                backgroundColor: Colors.blue,
                child: const Icon(Icons.send),
              ),
          body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                bottom: TabBar(
                  indicatorColor: Colors.red,
                  unselectedLabelColor: Color(0xFFE0A1A1),
                  tabs: <Widget>[
                    Tab(icon: Icon(CustomIcons.inhalator__1_,size:20, color: Colors.white)),
                    Tab(icon: Icon(_SliverAppBarExampleState.warning, color: Colors.white),)
                  ],
                ),
                expandedHeight: 200.0,
                backgroundColor: Colors.blue,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text(
                      'RespiTrack',
                      style: TextStyle(
                        fontSize: 19,
                      )
                  ),
                  titlePadding: EdgeInsets.only(bottom: 48.0, left: 12.0),
                  background: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 50.0, left: 6.0, top: 2.0),
                      child: const Image(
                        //image: NetworkImage("https://www.aaaai.org/Aaaai/media/MediaLibraryRedesign/Tools%20for%20the%20Public/Conditions%20Library/Library%20-%20Asthma/skd238387sdc-mother-daugh-inhaler-cropped.jpg"),
                        image: NetworkImage(
                            "https://cdn.pixabay.com/photo/2019/04/27/01/46/asthma-4159147_1280.png"),
                      )
                  ),
                ),
              ),
            ];
          },
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.red,],
                )
              // gradient: LinearGradient(
              //     colors: [
              //       const Color(0xFF010280),
              //       const Color(0xFF135CC5),
              //       const Color(0xFF010280),
              //     ],
              //     begin: const FractionalOffset(0.0, 0.0),
              //     end: const FractionalOffset(1.0, 0.0),
              //     stops: [0.0, 0.5, 0.8],
              //     tileMode: TileMode.mirror),
            ),
            child: TabBarView(
              children: [
                // FIRST TabBarView
                CustomScrollView(
                  slivers: [
                    SliverPadding(
                        padding: EdgeInsets.all(6.0),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              SizedBox(
                                height: 10,
                              ), //space
                              SizedBox(
                                height: 140.0,

                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    elevation: 5,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(top: 5.0, left: 5.0),
                                            child: Row(
                                                children: [
                                                  Icon(CustomIcons.inhalator__1_, color: Colors.orange, size: 15.0),
                                                  Padding(
                                                      padding: EdgeInsets.only(top: 5.0, left: 11.0),
                                                      child: Text("Symbicort", style: TextStyle(fontSize: 19, color: Colors.black),)
                                                  )
                                                ]
                                            )
                                        ),
                                        SizedBox(
                                          height: 13,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 9.0),
                                          child: Row(
                                              children:[
                                                Text("2 doses per AM & PM", style: TextStyle(fontSize: 13, color: Colors.black),),
                                              ]
                                          ),
                                        ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 30.0,right: 30.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 41.0,
                                                width: 150.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.lightGreen.withOpacity(0.3),
                                                    border: Border.all(
                                                      color: Colors.lightGreen.withOpacity(0.3),
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(14))
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Row(
                                                      children: [
                                                        Icon(Icons.alarm, color: Color(0xFF006400), size:20.0),
                                                        Text("  AM dose taken", style: TextStyle(
                                                            fontSize: 12, color: Color(0xFF006400), fontWeight: FontWeight.bold),)
                                                      ]
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Container(
                                                height: 41.0,
                                                width: 150.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.cyan.withOpacity(0.3),
                                                    border: Border.all(
                                                      color: Colors.cyan.withOpacity(0.3),
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(14))
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Row(
                                                      children: [
                                                        Icon(Icons.alarm, color: Color(0xFF006400), size:20.0),
                                                        Text("  PM dose 18:00", style: TextStyle(
                                                            fontSize: 12, color: Color(0xFF006400), fontWeight: FontWeight.bold),)
                                                      ]
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ), //space
                              SizedBox(
                                height: 140.0,
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    elevation: 5,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(top: 5.0, left: 5.0),
                                            child: Row(
                                                children: [
                                                  Icon(CustomIcons.inhalator__1_, color: Colors.indigo, size: 15.0),
                                                  Padding(
                                                      padding: EdgeInsets.only(top: 5.0, left: 11.0),
                                                      child: Text("Ventolin", style: TextStyle(fontSize: 19, color: Colors.black),)
                                                  )
                                                ]
                                            )
                                        ),
                                        SizedBox(
                                          height: 13,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 9.0),
                                          child: Row(
                                              children:[
                                                Text("2 doses when needed", style: TextStyle(fontSize: 13, color: Colors.black),),
                                              ]
                                          ),
                                        ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 30.0,right: 30.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 41.0,
                                                width: 170.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.cyan.withOpacity(0.3),
                                                    border: Border.all(
                                                      color: Colors.cyan.withOpacity(0.3),
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(14))
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Row(
                                                      children: [
                                                        Icon(Icons.alarm, color: Color(0xFF006400), size:20.0),
                                                        Text("  Last taken 3 days ago", style: TextStyle(
                                                            fontSize: 12, color: Color(0xFF006400), fontWeight: FontWeight.bold),)
                                                      ]
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                    )

                  ],
                ),

                // SECOND TabBarView
                CustomScrollView(
                  slivers: [
                    SliverPadding(
                        padding: EdgeInsets.all(6.0),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              SizedBox(
                                height: 10,
                              ), //space
                              SizedBox(
                                height: 60.0,
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    elevation: 5,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(top: 5.0, left: 5.0),
                                            child: Row(
                                                children: [
                                                  Icon(CustomIcons.inhalator__1_, color: Colors.orange, size: 15.0),
                                                  Padding(
                                                      padding: EdgeInsets.only(top: 5.0, left: 11.0),
                                                      child: Text("Only 10% battery left in routine inhaler!", style: TextStyle(fontSize: 19, color: Colors.black),)
                                                  )
                                                ]
                                            )
                                        ),
                                        SizedBox(
                                          height: 13,
                                        ),
                                      ],
                                    )
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ), //space
                              SizedBox(
                                height: 60.0,
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    elevation: 5,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(top: 5.0, left: 5.0),
                                            child: Row(
                                                children: [
                                                  Icon(CustomIcons.inhalator__1_, color: Colors.indigo, size: 15.0),
                                                  Padding(
                                                      padding: EdgeInsets.only(top: 5.0, left: 11.0),
                                                      child: Text("Only 5 doses left in acute inhaler!", style: TextStyle(fontSize: 19, color: Colors.black),)
                                                  )
                                                ]
                                            )
                                        ),
                                        SizedBox(
                                          height: 13,
                                        ),
                                      ],
                                    )
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ), //space
                              SizedBox(
                                height: 60.0,
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    elevation: 5,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(top: 5.0, left: 5.0),
                                            child: Row(
                                                children: [
                                                  Icon(CustomIcons.inhalator__1_, color: Colors.indigo, size: 15.0),
                                                  Padding(
                                                      padding: EdgeInsets.only(top: 5.0, left: 11.0),
                                                      child: Text("Acute inhaler expires in 2 days!", style: TextStyle(fontSize: 19, color: Colors.black),)
                                                  )
                                                ]
                                            )
                                        ),
                                        SizedBox(
                                          height: 13,
                                        ),
                                      ],
                                    )
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ), //space
                              SizedBox(
                                height: 100.0,
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    elevation: 5,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 5.0),
                                            child: Row(
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(top: 5.0),
                                                      child: Column(
                                                          children:[
                                                            Row(
                                                                children:[
                                                                  Icon(CustomIcons.inhalator__1_, color: Colors.indigo, size: 15.0),
                                                                  SizedBox(
                                                                    width: 11,
                                                                  ),
                                                                  Text("The average time between the uses ", style: TextStyle(fontSize: 19, color: Colors.black),),
                                                                ]
                                                            ),
                                                            Text("of the acute inhaler is less than ", style: TextStyle(fontSize: 19, color: Colors.black),),
                                                            Text("4 hours. Better get checked!", style: TextStyle(fontSize: 19, color: Colors.black),)
                                                          ]
                                                      )

                                                  )
                                                ]
                                            )
                                        ),
                                        SizedBox(
                                          height: 13,
                                        ),
                                      ],
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

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


class SimpleScatterPlotChart extends StatelessWidget {

  final List<charts.Series<medicineIntake, int>> seriesList;
  //final bool animate;
  SimpleScatterPlotChart(this.seriesList,); //this.animate);
  factory SimpleScatterPlotChart.withSampleData() {
    return SimpleScatterPlotChart(
      _createSampleData(),
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
  static List<charts.Series<medicineIntake, int>> _createSampleData() {
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

class GradientIcon extends StatelessWidget {
  GradientIcon(
      this.icon,
      this.size,
      this.gradient,
      this.title
      );

  final IconData icon;
  final double size;
  final Gradient gradient;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          ShaderMask(
            child: Icon(
            icon,
            size: size,
            color: Colors.white,
            ),
            shaderCallback: (Rect bounds) {
            final Rect rect = Rect.fromLTRB(0, 0, size * 0.9, size * 0.85);
            return gradient.createShader(rect);
            },
          ),
          SizedBox(
            height: 3,
          ),
          Text(title, style: TextStyle(color:Colors.white.withOpacity(0.6))),
        ]
    );
  }
}

class graphIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientIcon(
      CustomIcons.graph,
      27.0,
      LinearGradient(
        colors: <Color>[
          Colors.indigo,
          Colors.orange,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      "General",
    );
  }
}

class symptomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientIcon(
      Icons.sick_outlined,
      27.0,
      LinearGradient(
        colors: <Color>[
          Colors.orange,
          Colors.indigo,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      "Symptom",
    );
  }
}

class routineIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientIcon(
      CustomIcons.inhalator__1_,
      27.0,
      LinearGradient(
        colors: <Color>[
          Colors.orange,
          Colors.orange,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      "Routine",
    );
  }
}

class acuteIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientIcon(
      CustomIcons.inhalator__1_,
      27.0,
      LinearGradient(
        colors: <Color>[
          Colors.indigo,
          Colors.indigo,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      "Acute",
    );
  }
}


class homePage extends StatefulWidget {
  @override
  homePageState createState() => homePageState();
}

class homePageState extends State<homePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          tooltip: 'Send report to doctor',
          onPressed: () {},
          backgroundColor: Colors.blue,
          child: const Icon(Icons.send),
        ),
        body: Stack(
            children: [
              CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      expandedHeight: 160.0,
                      backgroundColor: Colors.blue,
                      flexibleSpace: const FlexibleSpaceBar(
                        title: Text(
                            'RespiTrack',
                            style: TextStyle(
                              fontSize: 19,
                            )
                        ),
                        titlePadding: EdgeInsets.all(11.0),
                        background: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10.0, left: 6.0, top: 2.0),
                            child: const Image(
                              //image: NetworkImage("https://www.aaaai.org/Aaaai/media/MediaLibraryRedesign/Tools%20for%20the%20Public/Conditions%20Library/Library%20-%20Asthma/skd238387sdc-mother-daugh-inhaler-cropped.jpg"),
                              image: NetworkImage(
                                  "https://cdn.pixabay.com/photo/2019/04/27/01/46/asthma-4159147_1280.png"),
                            )
                        ),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            Size size = MediaQuery
                                .of(context)
                                .size;
                            return Container(
                                height: 1000 - MediaQuery
                                    .of(context)
                                    .viewInsets
                                    .bottom,
                                color: Colors.black12,
                                child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        TabBar(
                                          tabs: [
                                            Tab(icon: Icon(_SliverAppBarExampleState.home, color: Colors.indigo),),
                                            Tab(icon: Icon(_SliverAppBarExampleState.warning, color: Colors.indigo),)
                                          ],
                                          controller: _tabController,
                                          indicatorSize: TabBarIndicatorSize
                                              .tab,
                                        ),
                                        Expanded(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      top: BorderSide(
                                                          color: Colors.grey, width: 0.5))),
                                              child: TabBarView(
                                                  children: <Widget>[
                                                    Container(),
                                                    Container(),
                                                    Container(),
                                                  ])),),
                                      ],
                                    )
                                )
                            );
                          },
                        )
                    )
                  ]
              )
            ]
        )
    );
  }
}

class MoboApp extends StatefulWidget {
  @override
  _MoboAppState createState() => _MoboAppState();
}

class _MoboAppState extends State<MoboApp> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(builder: (BuildContext context) {
        return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                bottom: TabBar(
                  unselectedLabelColor: Color(0xFFE0A1A1),
                  tabs: <Widget>[
                    Tab(icon: Icon(CustomIcons.inhalator__1_,size:20, color: Colors.white)),
                    Tab(icon: Icon(_SliverAppBarExampleState.warning, color: Colors.white),)
                  ],
                ),
                expandedHeight: 200.0,
                backgroundColor: Colors.blue,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text(
                      'RespiTrack',
                      style: TextStyle(
                        fontSize: 19,
                      )
                  ),
                  titlePadding: EdgeInsets.only(bottom: 48.0, left: 12.0),
                  background: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 50.0, left: 6.0, top: 2.0),
                      child: const Image(
                        //image: NetworkImage("https://www.aaaai.org/Aaaai/media/MediaLibraryRedesign/Tools%20for%20the%20Public/Conditions%20Library/Library%20-%20Asthma/skd238387sdc-mother-daugh-inhaler-cropped.jpg"),
                        image: NetworkImage(
                            "https://cdn.pixabay.com/photo/2019/04/27/01/46/asthma-4159147_1280.png"),
                      )
                  ),
                ),
              ),
            ];
          },
          body: Container(
            //color: Color(0xffffdead),
            //color: Colors.white70,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.red,],
                )
              // gradient: LinearGradient(
              //     colors: [
              //       const Color(0xFF010280),
              //       const Color(0xFF135CC5),
              //       const Color(0xFF010280),
              //     ],
              //     begin: const FractionalOffset(0.0, 0.0),
              //     end: const FractionalOffset(1.0, 0.0),
              //     stops: [0.0, 0.5, 0.8],
              //     tileMode: TileMode.mirror),
            ),
            child: TabBarView(
              children: [
                // FIRST TabBarView
                CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SizedBox(
                            height: 10,
                          ), //space
                          SizedBox(
                            height: 140.0,
                            child: Card(
                                elevation: 5,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 5.0, left: 5.0),
                                      child: Row(
                                        children: [
                                          Icon(CustomIcons.inhalator__1_, color: Colors.orange, size: 15.0),
                                          Padding(
                                            padding: EdgeInsets.only(top: 5.0, left: 11.0),
                                            child: Text("Symbicort", style: TextStyle(fontSize: 19, color: Colors.black),)
                                          )
                                        ]
                                      )
                                    ),
                                    SizedBox(
                                      height: 13,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 9.0),
                                        child: Row(
                                            children:[
                                              Text("2 doses per AM & PM", style: TextStyle(fontSize: 13, color: Colors.black),),
                                            ]
                                        ),
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 30.0,right: 30.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                          height: 41.0,
                                          width: 150.0,
                                            decoration: BoxDecoration(
                                                color: Colors.lightGreen.withOpacity(0.3),
                                                border: Border.all(
                                                  color: Colors.lightGreen.withOpacity(0.3),
                                                ),
                                                borderRadius: BorderRadius.all(Radius.circular(14))
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Row(
                                                children: [
                                                        Icon(Icons.alarm, color: Color(0xFF006400), size:20.0),
                                                        Text("  AM dose taken", style: TextStyle(
                                                            fontSize: 12, color: Color(0xFF006400), fontWeight: FontWeight.bold),)
                                                      ]
                                                    ),
                                                ),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Container(
                                            height: 41.0,
                                            width: 150.0,
                                            decoration: BoxDecoration(
                                                color: Colors.cyan.withOpacity(0.3),
                                                border: Border.all(
                                                  color: Colors.cyan.withOpacity(0.3),
                                                ),
                                                borderRadius: BorderRadius.all(Radius.circular(14))
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Row(
                                                  children: [
                                                    Icon(Icons.alarm, color: Color(0xFF006400), size:20.0),
                                                    Text("  PM dose 18:00", style: TextStyle(
                                                        fontSize: 12, color: Color(0xFF006400), fontWeight: FontWeight.bold),)
                                                  ]
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ), //space
                          SizedBox(
                            height: 140.0,
                            child: Card(
                                elevation: 5,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(top: 5.0, left: 5.0),
                                        child: Row(
                                            children: [
                                              Icon(CustomIcons.inhalator__1_, color: Colors.indigo, size: 15.0),
                                              Padding(
                                                  padding: EdgeInsets.only(top: 5.0, left: 11.0),
                                                  child: Text("Ventolin", style: TextStyle(fontSize: 19, color: Colors.black),)
                                              )
                                            ]
                                        )
                                    ),
                                    SizedBox(
                                      height: 13,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 9.0),
                                      child: Row(
                                          children:[
                                            Text("2 doses when needed", style: TextStyle(fontSize: 13, color: Colors.black),),
                                          ]
                                      ),
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 30.0,right: 30.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 41.0,
                                            width: 170.0,
                                            decoration: BoxDecoration(
                                                color: Colors.cyan.withOpacity(0.3),
                                                border: Border.all(
                                                  color: Colors.cyan.withOpacity(0.3),
                                                ),
                                                borderRadius: BorderRadius.all(Radius.circular(14))
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Row(
                                                  children: [
                                                    Icon(Icons.alarm, color: Color(0xFF006400), size:20.0),
                                                    Text("  Last taken 3 days ago", style: TextStyle(
                                                        fontSize: 12, color: Color(0xFF006400), fontWeight: FontWeight.bold),)
                                                  ]
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              // SECOND TabBarView
              CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                width: double.infinity,
                                child: Image.network('https://cdn.britannica.com/24/58624-050-73A7BF0B/valley-Atlas-Mountains-Morocco.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                width: double.infinity,
                                child: Text('text'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
          ),
        );
      }),
    );
  }
}

