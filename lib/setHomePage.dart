import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:respi_track/rouineHomePageCard.dart';
import 'package:respi_track/utils.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'acuteHomePageCard.dart';
import 'custom_icons_icons.dart';
import 'pdfMobile.dart';
import 'pdf_api.dart';
import 'setStatisticsPage.dart';
import 'variables.dart' as globals;
import 'package:permission_handler/permission_handler.dart';
import 'package:external_path/external_path.dart';

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

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }
  final CollectionReference _routine = FirebaseFirestore.instance.collection('Routine');

  @override
  Widget build(BuildContext context) {
  IconData warning = IconData(0xe6cb, fontFamily: 'MaterialIcons');
  return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Send report to doctor',
        onPressed: () async {

          Map<Permission, PermissionStatus> statuses = await [
            Permission.storage,
          ].request();

          List<List<String>> data = [
          ['Subject', 'Start Day', 'Start Time', 'End Date', 'End Time', 'All day event','Description','Location'],
          ['bla','bla','bla','bla','bla','bla','bla','bla',],
          ];
          String csvData = ListToCsvConverter().convert(data);
          //String directory = (await getApplicationSupportDirectory()).path;

          String dir = await ExternalPath.getExternalStoragePublicDirectory(
              ExternalPath.DIRECTORY_DOWNLOADS);
         // final path = "$directory/csv-alert-data.csv";
          //File file = File(path);
          // await file.writeAsString(csvData);
          String file = "$dir";
          File f = File(file + "/filename.csv");

          f.writeAsString(csvData);
          //f.openRead();
          print("file saved");
          print(csvData.length);
         /* Navigator.of(context).push(
          MaterialPageRoute(
          builder: (_) {
          return MyCSVDisplayScreen(csvFilePath: filePath);
          },
          ),
          );*/

        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.download),
      ),

    body: Center(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Settings').snapshots(),
        builder: (context,snapshot){
        return Scaffold(
          body: Center(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Symptoms').snapshots() ,
              builder: (context, snap){
                return DefaultTabController(
                  length: 2,
                  child: Scaffold(

                    body: NestedScrollView(
                      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverAppBar(
                            bottom: TabBar(
                              indicatorColor: Color(0xFF1A237E),
                              unselectedLabelColor: Color(0xFFE0A1A1),
                              tabs: <Widget>[
                                Tab(icon: Icon(CustomIcons.inhalator__1_,size:20, color: Colors.white)),
                                Tab(icon: Icon(warning, color: Colors.white),)
                              ],
                            ),
                            expandedHeight: 200.0,
                            //backgroundColor: Color(0xFF2196F3),
                            backgroundColor: Colors.lightBlue,
                            flexibleSpace:  FlexibleSpaceBar(
                              title: Text(
                                  'RespiTrack',
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: Colors.white,
                                  )
                              ),
                              titlePadding: EdgeInsets.only(bottom: 48.0, left: 12.0),
                              background: Padding(
                                  padding:  EdgeInsets.only(
                                      bottom: 50.0, left: 40.0, top: 2.0),
                                      child:CircleAvatar(
                                          backgroundColor: Colors.white54,
                                          radius: 200,
                                            child: Image.asset(
                                                'images/final_logo.png',
                                                  scale: 0.1
                                  )
                                      ),
                              ),
                            ),
                          ),
                        ];
                      },
                      body: Container(
                        decoration: BoxDecoration( gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              //Color(0xFFE3F2FD),
                              Colors.lightBlue,
                              Color(0xFF1A237E),
                            ]
                        )),
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


                                          // child: Card(
                                          //     shape: RoundedRectangleBorder(
                                          //       borderRadius: BorderRadius.circular(15.0),
                                          //     ),
                                          //     elevation: 5,
                                          //     color: Colors.white,
                                          //     child: Column(
                                          //       children: [
                                          //         Padding(
                                          //             padding: EdgeInsets.only(top: 5.0, left: 5.0),
                                          //             child: Row(
                                          //                 children: [
                                          //                   Icon(CustomIcons.inhalator__1_, color: Colors.orange, size: 15.0),
                                          //                   Padding(
                                          //                       padding: EdgeInsets.only(top: 5.0, left: 11.0),
                                          //                       child: Text("Symbicort", style: TextStyle(fontSize: 19, color: Colors.black),)
                                          //                   )
                                          //                 ]
                                          //             )
                                          //         ),
                                          //         SizedBox(
                                          //           height: 13,
                                          //         ),
                                          //         Padding(
                                          //           padding: EdgeInsets.only(left: 9.0),
                                          //           child: Row(
                                          //               children:[
                                          //                 Text("2 doses per AM & PM", style: TextStyle(fontSize: 13, color: Colors.black),),
                                          //               ]
                                          //           ),
                                          //         ),
                                          //         SizedBox(
                                          //           height: 14,
                                          //         ),
                                          //         Padding(
                                          //           padding: EdgeInsets.only(left: 30.0,right: 30.0),
                                          //           child: Row(
                                          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //             children: [
                                          //               Container(
                                          //                 height: 41.0,
                                          //                 width: 150.0,
                                          //                 decoration: BoxDecoration(
                                          //                     color: Colors.lightGreen.withOpacity(0.3),
                                          //                     border: Border.all(
                                          //                       color: Colors.lightGreen.withOpacity(0.3),
                                          //                     ),
                                          //                     borderRadius: BorderRadius.all(Radius.circular(14))
                                          //                 ),
                                          //                 child: Padding(
                                          //                   padding: EdgeInsets.all(10.0),
                                          //                   child: Row(
                                          //                       children: [
                                          //                         Icon(Icons.alarm, color: Color(0xFF006400), size:20.0),
                                          //                         Text("  AM dose taken", style: TextStyle(
                                          //                             fontSize: 12, color: Color(0xFF006400), fontWeight: FontWeight.bold),)
                                          //                       ]
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //               SizedBox(
                                          //                 width: 12,
                                          //               ),
                                          //               Container(
                                          //                 height: 41.0,
                                          //                 width: 150.0,
                                          //                 decoration: BoxDecoration(
                                          //                     color: Colors.cyan.withOpacity(0.3),
                                          //                     border: Border.all(
                                          //                       color: Colors.cyan.withOpacity(0.3),
                                          //                     ),
                                          //                     borderRadius: BorderRadius.all(Radius.circular(14))
                                          //                 ),
                                          //                 child: Padding(
                                          //                   padding: EdgeInsets.all(10.0),
                                          //                   child: Row(
                                          //                       children: [
                                          //                         Icon(Icons.alarm, color: Color(0xFF006400), size:20.0),
                                          //                         Text("  PM dose 18:00", style: TextStyle(
                                          //                             fontSize: 12, color: Color(0xFF006400), fontWeight: FontWeight.bold),)
                                          //                       ]
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //             ],
                                          //           ),
                                          //         )
                                          //       ],
                                          //     )
                                          // ),

                                          Container(
                                            color: Colors.transparent,
                                            height: 140.0,
                                            child: routineHomePageCard(),
                                          ),

                                        SizedBox(
                                          height: 5,
                                        ),

                                        SizedBox(

                                          height: 140.0,
                                          child: acuteHomePageCard(),
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
            ),
          ),

        );
        }
      ),
    ),
  );

  }

  Widget buildImage(Uint8List bytes) => bytes != null ?
  Image.memory(bytes) : Container();

}