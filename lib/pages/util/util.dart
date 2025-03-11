import 'dart:convert';
import 'package:flutter/widgets.dart';

class Util {

  static Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

}