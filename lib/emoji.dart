

import 'package:flutter/animation.dart';

class Emoji {

  String id = "";
  String foto_base64 = "";
  String excluido = "";

  Emoji();

  Emoji.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
    foto_base64 = json["foto_base64"];
    excluido = json["excluido"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['foto_base64'] = this.foto_base64;
    data['excluido'] = this.excluido;
    return data;

  }
}