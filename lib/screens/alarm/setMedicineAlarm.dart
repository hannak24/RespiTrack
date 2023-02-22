import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'widgets/clockView.dart';
import 'data/data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:respi_track/constants/theme_data.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {

  DateTime? _alarmTime;
  late String _alarmTimeString = DateFormat('HH:mm').format(DateTime.now());
  bool _isRepeatSelected = false;
  final CollectionReference _alarms = FirebaseFirestore.instance.collection('alarms');
  final TextEditingController _titleController = TextEditingController();

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async{
  //_alarmTimeString = DateFormat('HH:mm').format(DateTime.now());
  await showModalBottomSheet(useRootNavigator: true, context: context, clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24),),),
    builder: (BuildContext ctx) {
          return Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                TextButton(
                  onPressed: () async {
                    var selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (selectedTime != null) {
                      final now = DateTime.now();
                      var selectedDateTime = DateTime(
                          now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
                      _alarmTime = selectedDateTime;
                      _alarmTimeString = DateFormat('HH:mm').format(selectedDateTime);

                    }
                  },
                  child: Text(
                    _alarmTimeString,
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                ListTile(
                  title: Text('Repeat'),
                  trailing: Switch(
                    onChanged: (value) {
                        _isRepeatSelected = value;
                    },
                    value: _isRepeatSelected,
                  ),
                ),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                SizedBox(height: 50),
                FloatingActionButton.extended(
                  onPressed: () async {
                    await _alarms.add({"time": _alarmTimeString.toString() +':00', "title": _titleController.text});
                    _titleController.text = '';
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.alarm),
                  label: Text('Save'),
                ),
              ],
            ),
          );
    },
  );
  // scheduleAlarm();
}//////////////////////////////////////////////////////////onpressed


  Future<void> _delete(String productId) async {
    await _alarms.doc(productId).delete();

    /*ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));*/
  }

  @override
  Widget build(BuildContext context) {
    var timeNow =DateTime.now();
    var time = DateFormat('HH:mm').format(timeNow);
    var date = DateFormat('EEEE, d MMM').format(timeNow);
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('SET MEDICINE ALARM'),
        ),
        body: StreamBuilder(
          stream: _alarms.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];

                  return Card(
                  elevation: 0,
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),

                  ),
                  child: Container(
                    //////////////////////////////////////////////////////////////////////
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    margin: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gradient: LinearGradient(colors: [Colors.blue, Colors.blueGrey], begin: Alignment.centerLeft, end: Alignment.centerRight),

                       // gradient: LinearGradient(colors: [const Color(0xFF010280), const Color(0xFF135CC5), const Color(0xFF010280),],
                          //  begin: const FractionalOffset(0.0, 0.0), end: const FractionalOffset(1.0, 0.0), stops: [0.0, 0.5, 0.8], tileMode: TileMode.mirror),

                        boxShadow: [BoxShadow(color: Colors.black26, spreadRadius: 5, blurRadius: 2, )]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 10),
                                Icon(Icons.label_important, color: Colors.white),
                                SizedBox(width: 10),
                                Text(documentSnapshot['title'], style: TextStyle(color: Colors.white, fontSize: 20),),],
                            ),
                            Switch(activeColor: Colors.white, value: true, onChanged: (bool value) {},)
                          ],
                        ),
                        Text(documentSnapshot['time'].toString().substring(0,5) , style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('  Sun - Sat', style: TextStyle(color: Colors.white, fontSize: 20)),
                            IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () =>
                                    _delete(documentSnapshot.id),
                                color: Colors.white
                                )
                          ],
                        ),
                      ],
                    ),
                  ), //////////////////////////////////////////////////////////////////////////////////////////
                  );


                },
              );
          }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        ////add new
          floatingActionButton: FloatingActionButton(
            onPressed: () => _create(),
            child: const Icon(Icons.add),

          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat

      ),
    );
  } //below overridw


}
