
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/alarm/setMedicineAlarm.dart';
import 'package:firebase_core/firebase_core.dart';
import '../screens/symptomes/setSymptoms.dart';
import '../screens/statistics/setStatisticsPage.dart';
import '../screens/profile/setProfilePage.dart';
import '../screens/home/setHomePage.dart';
import 'main_page.dart';

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
      home: MainPage(),
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
  final user = FirebaseAuth.instance.currentUser!;


  void _pushMedicineStatistics() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return  StatisticsPage();
    }));
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






