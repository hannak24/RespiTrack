import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pie_chart/pie_chart.dart';
import 'setMedicineAlarm.dart';
import 'custom_icons_icons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'setSymptoms.dart';
import 'setStatisticsPage.dart';


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


  void _pushMedicineStatistics() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return  StatisticsPage();
    }));
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


  void _pushProfile() {
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
                      onPressed: () {_pushSymptoms();},
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

