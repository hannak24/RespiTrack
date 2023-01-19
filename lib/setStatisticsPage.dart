import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AvgNumberOfPushes.dart';
import "GroupedStackedBarChart.dart";
import 'MedicineIntakeTimeChart.dart';
import 'doses_remaining.dart';
import "icons.dart";
import 'PieChart.dart';
import "SimpleScatterPlotChart.dart";
import 'inhalerTimeTakingDistribution.dart';




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
                        height: 2100 - MediaQuery
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
                              ), //pie chart symptom distribution

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
                            height: 290.0,
                            width: size.width,
                            child: Card(
                              elevation: 3.5,
                              child: GroupedStackedBarChartDB(false),
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
                              //inhaler uses per month stacked group chart


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
                                height: 250.0,
                                width: size.width,
                                child: Card(
                                  elevation: 3.5,
                                  child: InhalerTimeTakingDistribution(),
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
                                  child: MedicineIntakeTimeChartDB(),
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
                        height: 1600 - MediaQuery
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

                              dosesRemainingRoutine(size.width),//doses remaining


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
                                  child: GroupedStackedBarChartDB(true),
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

                              AvgNumOfPushesRoutine(size.width),


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
                                  child: SimpleScatterPlotChartDB(),
                                ),
                              ),

                              SizedBox(
                                height: 10,
                                width: size.width,
                              ),

                              SizedBox(
                                height: 250.0,
                                width: size.width,
                                child: Card(
                                  elevation: 3.5,
                                  child: InhalerTimeTakingDistribution(),
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
                                  child: MedicineIntakeTimeChartDB(),
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
