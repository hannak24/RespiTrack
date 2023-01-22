//define global variables

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:respi_track/utils.dart';

GlobalKey key_1 = GlobalKey();
Uint8List bytes_1 = Uint8List(2);
void setBytes_1(key) async{
   bytes_1= await Utils.capture(key);
}
