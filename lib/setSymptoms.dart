import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'clockView.dart';
import 'data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'symptoms.dart';
import 'splashScreenSymptoms.dart';


class SymptomsPage extends StatefulWidget {
  @override
  _SymptomsPageState createState() => _SymptomsPageState();
}

class _SymptomsPageState extends State<SymptomsPage> {
  List<Symptom> childSymptoms =  [
    Symptom("Cough", "", false),
    Symptom("Whizzing", "", false),
    Symptom("Sputum discharge", "", false),
    Symptom("Short breath", "", false),
    Symptom("Else / Additional Info", "describe in comment", false),

  ];

  List<Symptom> selectedSymptoms = [];
  final TextEditingController _titleController = TextEditingController();
  final CollectionReference _symptoms = FirebaseFirestore.instance.collection('Symptoms');
  DateTime dateTime = DateTime.now();

  void _pushSplashScreen(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return  SplashScreen();
    }));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Choose Symptoms"),
    centerTitle: true,
    backgroundColor: Colors.blue,
    ),
    body: SafeArea(
    child: Container(

      child: Column(
        children:[
          SizedBox(height: 40),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    width: 1000,
                    decoration: const BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.black26, spreadRadius: 3, blurRadius: 10, offset: Offset(15,5))],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      //color: Colors.blue,
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.blue, Colors.red,],
                      )
                    ),
                  ),
                ),
                GestureDetector(
                onTap: () async{
                  DateTime? newDate = await showDatePicker(
                  context: context, initialDate: dateTime, firstDate: DateTime(2000), lastDate: DateTime(2100),);
                  if (newDate == null){
                  return;
                  }
                  TimeOfDay? newTime = await showTimePicker(context: context, initialTime: TimeOfDay(hour: dateTime.hour+2, minute: dateTime.minute));
                  if (newTime == null){
                  return;
                  }
                  final updatedDateTime = DateTime(newDate.year,newDate.month,newDate.day,newTime.hour, newTime.minute,);
                  setState(() {
                  dateTime = updatedDateTime;
                  });
                  },
                child: Row(
                  children: [
                    SizedBox(width: 15,),
                    Icon( Icons.calendar_today, color: Colors.white,size: 30,),
                    SizedBox(width: 25,),
                    Container(
                      height: 50, margin: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Text('${dateTime.day}/${dateTime.month}/${dateTime.year} - ${dateTime.hour+2}:${dateTime.minute}', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),),

                          ],
                        ),
                    ),
                  ],
                ),
                ),
              ],
            ),
          ),


          SizedBox(height: 25),
          Expanded(
            child:
              ListView.builder(
                itemCount: childSymptoms.length,
                itemBuilder: (BuildContext context, int index){
                return SymptomItem(childSymptoms[index].name,childSymptoms[index].description,childSymptoms[index].isSelected,index,);
    },
    ),

          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 10,
            ),
            child: SizedBox(
             width: 150,
              child: FloatingActionButton.extended(
                onPressed: () async {
                  String sym ='';

                  selectedSymptoms.forEach((element) async {
                    if(element.name != selectedSymptoms.last.name){
                      sym = sym + element.name + ' ,';
                    }
                    else {sym = sym + element.name;
                  }});
                  await _symptoms.add({ "symptoms": sym, "date": dateTime, "info" : _titleController.text});
                  _titleController.text = '';
                  _pushSplashScreen();
                },
               // icon: Icon(Icons.alarm),
                label: Text('Submit'),

              ),
            ),
          ),//: Container(),
        ],
      ),
    ),
    ),
    );
 }
 Widget SymptomItem(String name, String description, bool isSelected, int index){
    return Card(
     elevation: 5,
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(15.0),
     ),
     child: ListTile(
       leading: CircleAvatar(
         backgroundColor: Colors.red.shade400,
         child: Icon(
           Icons.sick,
           color: Colors.white,
         ),
       ),
       title: Text(
         name,
         style: TextStyle(
           fontWeight: FontWeight.w600,
         ),
       ),
       subtitle: Text(description),
       trailing: isSelected
           ? Icon(
         Icons.check_circle,
         color: Colors.green,
       )
           : Icon(
         Icons.check_circle_outline,
         color: Colors.grey,
       ),
       onTap: () {
         setState(() {
           childSymptoms[index].isSelected = !childSymptoms[index].isSelected;
           if (childSymptoms[index].isSelected == true) {
             selectedSymptoms.add(Symptom(name, description, true));
           } else if (childSymptoms[index].isSelected == false) {
             selectedSymptoms
                 .removeWhere((element) => element.name == childSymptoms[index].name);
           }
         }
         );
         if (childSymptoms[index].name == "Else / Additional Info"){
           showModalBottomSheet(useRootNavigator: true, context: context, clipBehavior: Clip.antiAlias,
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24),),),
             builder: (BuildContext ctx) {
               return Container(
                 padding: const EdgeInsets.all(30),
                 child: Column(
                   children: [
                     Container(
                       child: Text( 'Add additional information:',
                         style: TextStyle(fontSize: 25, color: Colors.blue, fontWeight: FontWeight.bold),
                       ),
                     ),
                     SizedBox(height: 20),
                     TextField(
                       controller: _titleController,
                       decoration: const InputDecoration(labelText: 'info'),
                     ),
                     SizedBox(height: 50),
                     FloatingActionButton.extended(
                       onPressed: () async {
                        // await _alarms.add({"time": _alarmTimeString.toString() +':00', "title": _titleController.text});
                         //_titleController.text = '';
                         Navigator.of(context).pop();
                       },
                       icon: Icon(Icons.done),
                       label: Text('Save'),
                     ),
                   ],
                 ),
               );
             },
           );
         }
       },
     ),
   );
 }
}

