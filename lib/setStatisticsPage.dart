import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AvgNumberOfPushes.dart';
import "GroupedStackedBarChart.dart";
import 'MedicineIntakeTimeChart.dart';
import 'doses_remaining.dart';
import "icons.dart";
import 'PieChart.dart';
import "SimpleScatterPlotChart.dart";




class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // bottomNavigationBar: BottomAppBar(
        //   child: Padding(
        //     padding: const EdgeInsets.all(8),
        //     child: OverflowBar(
        //       alignment: MainAxisAlignment.spaceEvenly,
        //       overflowAlignment: OverflowBarAlignment.center,
        //       children: <Widget>[
        //         Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: <Widget>[
        //             IconButton(
        //               icon: const Icon(Icons.person_outlined),
        //               onPressed: () {_pushProfile();},
        //               tooltip: "medicine settings",
        //             ),
        //           ],
        //         ),
        //         Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: <Widget>[
        //             IconButton(
        //               icon: const Icon(_SliverAppBarExampleState.alarm),
        //               onPressed: () {_pushSetMedicineAlarm();},
        //               tooltip: "Set medicine alarm",
        //             ),
        //           ],
        //         ),
        //         Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: <Widget>[
        //             IconButton(
        //               icon: const Icon(_SliverAppBarExampleState.home_outlined),
        //               onPressed: () {Navigator.of(context).popUntil((route) => route.isFirst);},
        //               tooltip: "Back to home page",
        //             ),
        //           ],
        //         ),
        //         Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: <Widget>[
        //             IconButton(
        //               icon: const Icon(_SliverAppBarExampleState.bar_chart),
        //               onPressed: () {_pushMedicineStatistics();},
        //               tooltip: "Medicines statistics",
        //             ),
        //           ],
        //         ),
        //         Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: <Widget>[
        //             IconButton(
        //               icon: const Icon(Icons.sick_outlined),
        //               onPressed: () {},
        //               tooltip: "add symptom entry",
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
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
                        height: 1800 - MediaQuery
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
                               dosesRemaining(size.width),
                              //dozes remaining

                              SizedBox(
                                height: 5.0,
                                width: size.width,
                              ),
                              // space

                              SizedBox(
                                height: 290.0,
                                width: size.width,
                                child: Card(
                                  elevation: 3.5,
                                  child: GroupedStackedBarChartDB(),
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

                               AvgNumOfPushes(size.width),
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
                                  child: pieChartDB(),
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
                              //pie chart symptoms before asthma attacks


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
                                  child: SimpleScatterPlotChartDB(),
                                ),
                              ),

                              SizedBox(
                                height: 10,
                                width: size.width,
                              ),

                              SizedBox(
                                height: 370.0,
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
                                        .all(Radius.circular(20)),
                                  ),
                                  child: MedicineIntakeTimeChart(),
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
                                        .createSampleData(),),
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
                                  child: pieChartDB(),
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
  }
}
