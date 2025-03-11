import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../emoji.dart';
import '../../main.dart';

class EmojisApi {
  static Future<List<Emoji>> getEmojis() async {

    var token =
        "";


    var url = MyApp.URL_SERVIDOR + 'emoji/listar';

    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    Map params = {"criterio": ""};


    var response =
    await http.get(Uri.parse(url), headers: header);

    List listaResponse = json.decode(response.body);
    var emojis = <Emoji>[];
    if (response.statusCode == 200) {
      for (Map map in listaResponse) {
        Emoji t = Emoji.fromJson(map);
        emojis.add(t);
      }
    } else {
      throw Exception;
    }

    return emojis;
  }

  static Future<Emoji> getEmoji(id) async {

    var token =
        "";


    var url = MyApp.URL_SERVIDOR + 'emoji/' + id;

    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    Map params = {"criterio": ""};


    var response =
    await http.get(Uri.parse(url), headers: header);

    List listaResponse = json.decode(response.body);
    var emojis = <Emoji>[];
    if (response.statusCode == 200) {
      for (Map map in listaResponse) {
        Emoji t = Emoji.fromJson(map);
        emojis.add(t);
      }
    } else {
      throw Exception;
    }

    return emojis[0];
  }
}
