
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'pdfMobile.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';



/*String loadSymptoms(){
  final CollectionReference symptoms = FirebaseFirestore.instance.collection('Symptoms');
  String s ="de";
  symptoms.get().then((QuerySnapshot snapshot) {
    for (var doc in snapshot.docs) {
      s = s + doc.data.toString();
      s = s + doc['date'];
     // s = '$s\n';
      s = 'fff';
    }
  });
  return s;
}
*/


class PdfApi{

   static Future<void> createPDF(String childName,String birthday,String IDnumber,String routineMed, String prescriptedDose, String symptoms) async {
   final pdf = Document();

   pdf.addPage(MultiPage(
       build: (context) => <Widget>[
         Container(
           alignment: Alignment.centerRight,
           child: Text(DateTime.now().toString()),
         ),
         SizedBox(height: 20),
         Row( children: [
           SizedBox(width: 0.5 * PdfPageFormat.cm),
            Header(child: Text(childName + "'s Asthma Review", style: TextStyle(fontSize: 30, color: PdfColors.blue,))),
            ],),
         /*Header(child: Text(childName + "'s Asthma Review", style: TextStyle(fontSize: 30, color: PdfColors.white, fontWeight: FontWeight.bold), ),
             decoration: BoxDecoration(color: PdfColors.blue)),*/

         Bullet(text: "Full name: " + childName, bulletColor: PdfColors.blue,style: TextStyle( fontSize: 15)),
         Bullet(text: "Date of Birth: " + birthday,bulletColor: PdfColors.blue,style: TextStyle( fontSize: 15)),
         Bullet(text: "ID number: " + IDnumber,bulletColor: PdfColors.blue,style: TextStyle( fontSize: 15)),
         Bullet(text: "Routine medicine: " + routineMed,bulletColor: PdfColors.blue,style: TextStyle( fontSize: 15)),
         Bullet(text: "Prescripted Dose: " + prescriptedDose,bulletColor: PdfColors.blue,style: TextStyle( fontSize: 15)),
         SizedBox(height: 20),
         Text('Symptoms history:', style: TextStyle(fontSize: 15, color: PdfColors.blue800,decoration: TextDecoration.underline)),
         Text(symptoms),

   ],
     footer: (context) {
         final text  = 'Page ${context.pageNumber} of ${context.pagesCount}';

         return Container(
           //margin: EdgeInsets.only(top: 1*PdfPageFormat.cm),
           alignment: Alignment.centerRight,
           child: Text(text, style: TextStyle(color: PdfColors.black))
         );
     }
   ),
   );

   List<int> bytes = await pdf.save();
   //pdf.dispose();
   saveAndLaunchFile(bytes, 'MedicalReview.pdf');
  }


}