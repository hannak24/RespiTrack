import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_icons_icons.dart';

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

  @override
  Widget build(BuildContext context) {
    IconData warning = IconData(0xe6cb, fontFamily: 'MaterialIcons');
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                    Tab(icon: Icon(warning, color: Colors.white),)
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
                      padding:  EdgeInsets.only(
                          bottom: 40.0, left: 60.0, top: 2.0),
                      child:  Image(
                      //   image: NetworkImage(
                      //       "https://cdn.pixabay.com/photo/2019/04/27/01/46/asthma-4159147_1280.png"),
                      // )
                       image: AssetImage('images/our_inhaler.png',),opacity: const AlwaysStoppedAnimation(.8)),
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