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
    Symptom("Cough", "description..", false),
    Symptom("Whizzing", "description..", false),
    Symptom("Sputum discharge", "description..", false),
    Symptom("Short breath", "description..", false),
    Symptom("Else / Additional Info", "describe in comment", false),

  ];

  List<Symptom> selectedSymptoms = [];
  final TextEditingController _titleController = TextEditingController();

  final CollectionReference _symptoms = FirebaseFirestore.instance.collection('Symptoms');

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
        children: [
          SizedBox(height: 30),
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
                  await _symptoms.add({ "symptoms": sym, "date": DateTime.now(), "info" : _titleController.text});
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
   return ListTile(
     leading: CircleAvatar(
       backgroundColor: Colors.blue.shade300,
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
       color: Colors.lightBlue.shade300,
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
   );
 }
}

