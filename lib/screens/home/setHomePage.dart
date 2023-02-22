import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:respi_track/screens/home/widgets/rouineHomePageCard.dart';
import 'package:respi_track/utils/utils.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/acuteHomePageCard.dart';
import 'widgets/alerts.dart';
import '../../icons/custom_icons_icons.dart';
import '../../globals/globals.dart';
import '../statistics/pdf_to_doctor/pdfMobile.dart';
import '../statistics/pdf_to_doctor/pdf_api.dart';
import '../statistics/setStatisticsPage.dart';
import '../../globals/variables.dart' as globals;
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //
      //     Map<Permission, PermissionStatus> statuses = await [
      //       Permission.storage,
      //     ].request();
      //
      //     List<List<String>> data = [
      //     ['Subject', 'Start Day', 'Start Time', 'End Date', 'End Time', 'All day event','Description','Location'],
      //     ['bla','bla','bla','bla','bla','bla','bla','bla',],
      //     ];
      //     String csvData = ListToCsvConverter().convert(data);
      //     //String directory = (await getApplicationSupportDirectory()).path;
      //
      //     String dir = await ExternalPath.getExternalStoragePublicDirectory(
      //         ExternalPath.DIRECTORY_DOWNLOADS);
      //    // final path = "$directory/csv-alert-data.csv";
      //     //File file = File(path);
      //     // await file.writeAsString(csvData);
      //     String file = "$dir";
      //     File f = File(file + "/filename.csv");
      //
      //     f.writeAsString(csvData);
      //     //f.openRead();
      //     print("file saved");
      //     print(csvData.length);
      //    /* Navigator.of(context).push(
      //     MaterialPageRoute(
      //     builder: (_) {
      //     return MyCSVDisplayScreen(csvFilePath: filePath);
      //     },
      //     ),
      //     );*/
      //
      //   },
      //   backgroundColor: Colors.blue,
      //   child: const Icon(Icons.download),
      // ),

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
                            automaticallyImplyLeading: false,
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
                        height: 2000 - MediaQuery.of(context).viewInsets.bottom,
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
                                        // SizedBox(
                                        //   height: 10,
                                        // ), //space
                                        // SizedBox(
                                        //   height: 60.0,
                                        //   child: Card(
                                        //       shape: RoundedRectangleBorder(
                                        //         borderRadius: BorderRadius.circular(15.0),
                                        //       ),
                                        //       elevation: 5,
                                        //       color: Colors.white,
                                        //       child: Column(
                                        //         children: [
                                        //           Padding(
                                        //               padding: EdgeInsets.only(top: 5.0, left: 5.0),
                                        //               child: Row(
                                        //                   children: [
                                        //                     Icon(CustomIcons.inhalator__1_, color: Colors.orange, size: 15.0),
                                        //                     Padding(
                                        //                         padding: EdgeInsets.only(top: 5.0, left: 11.0),
                                        //                         child: Text("Only 10% battery left in routine inhaler!", style: TextStyle(fontSize: 19, color: Colors.black),)
                                        //                     )
                                        //                   ]
                                        //               )
                                        //           ),
                                        //           SizedBox(
                                        //             height: 13,
                                        //           ),
                                        //         ],
                                        //       )
                                        //   ),
                                        // ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        //space
                                        dosesRemainingAlert("routine"),
                                        SizedBox(
                                          height: heightRemainingDosesAlertRoutine! > 0 ? 5 : 0,
                                        ),
                                        dosesRemainingAlert("acute"),
                                        SizedBox(
                                          height: heightRemainingDosesAlertAcute! > 0 ? 5 : 0,
                                        ),//space
                                        expireAlert("routine"),
                                        SizedBox(
                                          height: heightExpiringAlertRoutine! > 0 ? 5 : 0,
                                        ),
                                        expireAlert("acute"),
                                        SizedBox(
                                          height: heightExpiringAlertAcute! > 0 ? 5 : 0,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        averageUseTimeAlert(),//space
                                        // SizedBox(
                                        //   height: 100.0,
                                        //   child: Card(
                                        //       shape: RoundedRectangleBorder(
                                        //         borderRadius: BorderRadius.circular(15.0),
                                        //       ),
                                        //       elevation: 5,
                                        //       color: Colors.white,
                                        //       child: Column(
                                        //         children: [
                                        //           Padding(
                                        //               padding: EdgeInsets.only(left: 5.0),
                                        //               child: Row(
                                        //                   children: [
                                        //                     Padding(
                                        //                         padding: EdgeInsets.only(top: 5.0),
                                        //                         child: Column(
                                        //                             children:[
                                        //                               Row(
                                        //                                   children:[
                                        //                                     Icon(CustomIcons.inhalator__1_, color: Colors.indigo, size: 15.0),
                                        //                                     SizedBox(
                                        //                                       width: 11,
                                        //                                     ),
                                        //                                     Text("The average time between the uses ", style: TextStyle(fontSize: 19, color: Colors.black),),
                                        //                                   ]
                                        //                               ),
                                        //                               Text("of the acute inhaler is less than ", style: TextStyle(fontSize: 19, color: Colors.black),),
                                        //                               Text("4 hours. Better get checked!", style: TextStyle(fontSize: 19, color: Colors.black),)
                                        //                             ]
                                        //                         )
                                        //
                                        //                     )
                                        //                   ]
                                        //               )
                                        //           ),
                                        //           SizedBox(
                                        //             height: 13,
                                        //           ),
                                        //         ],
                                        //       )
                                        //   ),
                                        // ),
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