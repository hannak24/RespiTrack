import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  String doc="";
  String field="";

  Data(String doc, String field) {
    this.doc = doc;
    this.field = field;
  }
}

Future<T?> showTextDialog<T>(
    BuildContext context, {
      required String title,
      required String value,
      required String doc,
      required String field,
    }) =>
    showDialog<T>(
      context: context,
      builder: (context) => TextDialogWidget(
        title: title,
        value: value,
        doc: doc,
        field: field,
      ),
    );

class TextDialogWidget extends StatefulWidget {
  final String title;
  final String value;
  final String doc;
  final String field;


  const TextDialogWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.doc,
    required this.field,
  }) : super(key: key);


  @override
  _TextDialogWidgetState createState() => _TextDialogWidgetState();
}

class _TextDialogWidgetState extends State<TextDialogWidget> {
  late TextEditingController controller;
  final CollectionReference _settings = FirebaseFirestore.instance.collection('Settings');


  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.title),
    content: TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
    ),
    actions: [
      ElevatedButton(
        child: Text('Done'),
        onPressed: () {
          _settings.doc(widget.doc).update({widget.field: controller.text});
          Navigator.of(context).pop(controller.text);},
      )
    ],
  );
}