import 'package:flutter/material.dart';
import 'setMedicineAlarm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'setSymptoms.dart';
import 'setStatisticsPage.dart';
import 'setProfilePage.dart';
import 'setHomePage.dart';


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
      home: RespiTrack(),
    );
  }
}

enum LegendShape { circle, rectangle }

class RespiTrack extends StatefulWidget {
  const RespiTrack({super.key});

  @override
  State<RespiTrack> createState() => _RespiTrackState();
}

class _RespiTrackState extends State<RespiTrack> {
  static const IconData alarm = IconData(0xe072, fontFamily: 'MaterialIcons');
  static const IconData bar_chart = IconData(0xe0cc, fontFamily: 'MaterialIcons');
  static const IconData home_outlined = IconData(0xf107, fontFamily: 'MaterialIcons');



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
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return  ProfilePage();
    }));
  }

  void _pushHome() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return HomePage();
    }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    icon: const Icon(_RespiTrackState.alarm),
                    onPressed: () {_pushSetMedicineAlarm();},
                    tooltip: "Set medicine alarm",
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(_RespiTrackState.home_outlined),
                    onPressed: () {_pushHome();},
                    tooltip: "Back to home page",
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(_RespiTrackState.bar_chart),
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
      body: HomePage()
    );

  }
}






