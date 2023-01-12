
import 'package:flutter/services.dart';

import 'pdfMobile.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';


String parse (){
  String returned="";
  String date = DateTime.now().toString();
  String year = date.substring(0,4);
  String month = date.substring(5,7);
  String day = date.substring(8,10);
  String hour = date.substring(11,16);

  returned =  day + "/" + month + "/" +year  + " at " + hour;
  return returned;
}

class PdfApi{

   static Future<void> createPDF(String childName,String birthday,String IDnumber,String routineMed, String prescriptedDose, String symptoms) async {
   final pdf = Document();

   pdf.addPage(MultiPage(
       build: (context) => <Widget>[
         Container(
           alignment: Alignment.centerRight,
           child: Text(parse()),
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