import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'pdf_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:respi_track/utils.dart';
import 'AvgNumberOfPushes.dart';
import "GroupedStackedBarChart.dart";
import 'MedicineIntakeTimeChart.dart';
import 'doses_remaining.dart';
import "icons.dart";
import 'PieChart.dart';
import "SimpleScatterPlotChart.dart";
import 'inhalerTimeTakingDistribution.dart';
import 'widgetToImage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'variables.dart' as globals;



String parse (String s){
  String returned="";
  String date = s;
  String year = date.substring(0,4);
  String month = date.substring(5,7);
  String day = date.substring(8,10);
  String hour = date.substring(11,16);

  returned =  day + "/" + month + "/" +year  + " , " + hour;
  return returned;
}

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late GlobalKey key1 = GlobalKey();
  Uint8List bytes1 = Uint8List(2);
  late GlobalKey key2 = GlobalKey();
  Uint8List bytes2 = Uint8List(2);
  late GlobalKey key3 = GlobalKey();
  Uint8List bytes3 = Uint8List(2);
  late GlobalKey key4 = GlobalKey();
  Uint8List bytes4 = Uint8List(2);
  late GlobalKey key5 = GlobalKey();
  Uint8List bytes5 = Uint8List(2);
  late GlobalKey key6 = GlobalKey();
  Uint8List bytes6 = Uint8List(2);
  late GlobalKey key7 = GlobalKey();
  Uint8List bytes7 = Uint8List(2);
  late GlobalKey key8 = GlobalKey();
  Uint8List bytes8 = Uint8List(2);
  late GlobalKey key9 = GlobalKey();
  Uint8List bytes9 = Uint8List(2);

  //Uint8List bytes_ = 0 as Uint8List;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Settings').snapshots() ,
            builder: (context,snapshot){
              return Scaffold(
                body: Center(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Symptoms').snapshots() ,
                    builder: (context, snap){
                      return DefaultTabController(
                        length: 4,
                        child: Scaffold(
                          floatingActionButton: FloatingActionButton(
                            tooltip: 'Send report to doctor',
                            onPressed: () async {
                              String childName = snapshot.data?.docs[3]['Name'] ?? '';
                              String birthday = snapshot.data?.docs[3]['Date of Birth'] ?? '';
                              String IDnumber = snapshot.data?.docs[3]['ID number'] ?? '';
                              String routineMed = snapshot.data?.docs[1]['medicine name'] ?? '';
                              String prescriptedDose = snapshot.data?.docs[1]['Prescripted Dose'] ?? '';

                              String symptomsList = "";
                              int i = 1;
                              if (snap.data?.docs != null){
                                for ( var doc in snap.data!.docs){
                                  String parsedDate = parse( doc['date'].toDate().toString());
                                  symptomsList = symptomsList + i.toString() +'. '+ parsedDate + "  -";
                                  symptomsList = "$symptomsList\n";
                                  symptomsList = symptomsList + doc['symptoms'] + "." ;
                                  symptomsList = "$symptomsList\n";
                                  symptomsList = symptomsList + "Additional information: " +doc['info'] + ".\n";
                                  // symptomsList = "$symptomsList\n";
                                  i++;
                                }//symptomsList = symptomsList + doc['date'].toString();
                              }


                              final bytes_1 = await Utils.capture(key1);
                              final bytes_2 = await Utils.capture(key2);
                              final bytes_3 = await Utils.capture(key3);
                              final bytes_4 = await Utils.capture(key4);
                              final bytes_5 = await Utils.capture(key5);
                              setState(() {
                                bytes1 = bytes_1;
                                bytes2 = bytes_2;
                                bytes3 = bytes_3;
                                bytes4 = bytes_4;
                                bytes5 = bytes_5;
                              });

                               PdfApi.createPDF(childName,birthday,IDnumber,routineMed,prescriptedDose, symptomsList,bytes1, bytes2, bytes3, bytes4, bytes5 );
                            },
                            backgroundColor: Colors.blue,
                            child: const Icon(Icons.send),
                          ),
                          appBar: AppBar(
                            bottom: TabBar(
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
                                        Size size = MediaQuery.of(context).size;
                                        return Container(
                                          height: 2100 - MediaQuery.of(context).viewInsets.bottom,
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
                                                  child: WidgetToImage(
                                                    builder: (key) {
                                                      key1 = key;
                                                      globals.key_1 = key;
                                                      return Card(
                                                        elevation: 3.5,
                                                        child: pieChartDB(),
                                                        shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                            color: Theme.of(context)
                                                                .colorScheme
                                                                .outline,
                                                          ),
                                                          borderRadius: const BorderRadius.all(
                                                              Radius.circular(12)),
                                                        ),
                                                      );
                                                    },
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
                                                //logout
                                                SizedBox(
                                                  height: 290.0,
                                                  width: size.width,
                                                  child: WidgetToImage(
                                                    builder: (key) {
                                                      key2 = key;
                                                      return Card(
                                                        elevation: 3.5,
                                                        child: GroupedStackedBarChartDB(false),
                                                        shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                            color: Theme.of(context)
                                                                .colorScheme
                                                                .outline,
                                                          ),
                                                          borderRadius: const BorderRadius.all(
                                                              Radius.circular(12)),
                                                        ),
                                                      );
                                                    },
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
                                                  child: WidgetToImage(builder: (key) {
                                                    key3 = key;
                                                    return Card(
                                                      elevation: 3.5,
                                                      shape: RoundedRectangleBorder(
                                                        side: BorderSide(
                                                          color: Theme.of(context)
                                                              .colorScheme
                                                              .outline,
                                                        ),
                                                        borderRadius: const BorderRadius.all(
                                                            Radius.circular(12)),
                                                      ),
                                                      child: SimpleScatterPlotChartDB(),
                                                    );
                                                  }),
                                                ),

                                                SizedBox(
                                                  height: 10,
                                                  width: size.width,
                                                ),

                                                SizedBox(
                                                  height: 250.0,
                                                  width: size.width,
                                                  child: WidgetToImage(builder: (key) {
                                                    key4 = key;
                                                    return Card(
                                                      elevation: 3.5,
                                                      child: InhalerTimeTakingDistribution(),
                                                      shape: RoundedRectangleBorder(
                                                        side: BorderSide(
                                                          color: Theme.of(context)
                                                              .colorScheme
                                                              .outline,
                                                        ),
                                                        borderRadius: const BorderRadius.all(
                                                            Radius.circular(12)),
                                                      ),
                                                    );
                                                  }),
                                                ),

                                                SizedBox(
                                                  height: 10,
                                                  width: size.width,
                                                ),

                                                SizedBox(
                                                  height: 370.0,
                                                  width: size.width,
                                                  child: WidgetToImage(builder: (key) {
                                                    key5 = key;
                                                    return Card(
                                                      elevation: 3.5,
                                                      shape: RoundedRectangleBorder(
                                                        side: BorderSide(
                                                          color: Theme.of(context)
                                                              .colorScheme
                                                              .outline,
                                                        ),
                                                        borderRadius: const BorderRadius.all(
                                                            Radius.circular(20)),
                                                      ),
                                                      child: MedicineIntakeTimeChartDB(),
                                                    );
                                                  }),
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
                                        Size size = MediaQuery.of(context).size;
                                        return Container(
                                          height: 1600 - MediaQuery.of(context).viewInsets.bottom,
                                          color: Colors.black12,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 7.0,
                                                  width: size.width,
                                                ),

                                                dosesRemainingRoutine(size.width),
                                                //doses remaining

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
                                                        color:
                                                        Theme.of(context).colorScheme.outline,
                                                      ),
                                                      borderRadius: const BorderRadius.all(
                                                          Radius.circular(12)),
                                                    ),
                                                  ),
                                                ),
                                                // bar chart inhaler uses per month

                                                SizedBox(
                                                  height: 10,
                                                  width: size.width,
                                                ),
                                                //space

                                                AvgNumOfPushesRoutine(size.width),

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
                                                    shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                        color:
                                                        Theme.of(context).colorScheme.outline,
                                                      ),
                                                      borderRadius: const BorderRadius.all(
                                                          Radius.circular(12)),
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
                                                        color:
                                                        Theme.of(context).colorScheme.outline,
                                                      ),
                                                      borderRadius: const BorderRadius.all(
                                                          Radius.circular(12)),
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
                                                        color:
                                                        Theme.of(context).colorScheme.outline,
                                                      ),
                                                      borderRadius: const BorderRadius.all(
                                                          Radius.circular(20)),
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
                                        Size size = MediaQuery.of(context).size;
                                        return Container(
                                          height: 1000 - MediaQuery.of(context).viewInsets.bottom,
                                          color: Colors.black12,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 7.0,
                                                  width: size.width,
                                                ),

                                                dosesRemainingAcute(size.width), //doses remaining

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
                                                        color:
                                                        Theme.of(context).colorScheme.outline,
                                                      ),
                                                      borderRadius: const BorderRadius.all(
                                                          Radius.circular(12)),
                                                    ),
                                                  ),
                                                ), // bar chart inhaler uses per month

                                                SizedBox(
                                                  height: 10,
                                                  width: size.width,
                                                ),
                                                //space

                                                AvgNumOfPushesAcute(size.width), //average number of squeezes per use
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
                                        Size size = MediaQuery.of(context).size;
                                        return Container(
                                          height: 1000 - MediaQuery.of(context).viewInsets.bottom,
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
                                                        color:
                                                        Theme.of(context).colorScheme.outline,
                                                      ),
                                                      borderRadius: const BorderRadius.all(
                                                          Radius.circular(12)),
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
                  ),
                ),
              );
            }
        ),
      ),
    );

  }

  Widget buildImage(Uint8List bytes) =>
      bytes != null ? Image.memory(bytes) : Container();
}
