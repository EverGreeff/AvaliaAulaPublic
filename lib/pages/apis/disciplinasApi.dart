import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Disciplina.dart';
import '../../main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisciplinasApi {
  static Future<List<Disciplina>> getDisciplinas() async {
    var prefs = await SharedPreferences.getInstance();
    var token =
        "";
    var emailUsuario = prefs.getString("email_usuario") ?? "";

    var url = MyApp.URL_SERVIDOR + 'disciplina/listar/' + emailUsuario;

    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    Map params = {"criterio": ""};

    var _body = json.encode(params);

    var response =
        await http.get(Uri.parse(url), headers: header);

    List listaResponse = json.decode(response.body);
    var disciplinas = <Disciplina>[];
    if (response.statusCode == 200) {
      for (Map map in listaResponse) {
        Disciplina t = Disciplina.fromJson(map);
        disciplinas.add(t);
      }
    } else {
      throw Exception;
    }

    return disciplinas;
  }

  static Future<Disciplina> getDisciplina(id) async {

    var token =
        "";


    var url = MyApp.URL_SERVIDOR + 'disciplina/' + id;

    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    var response =
    await http.get(Uri.parse(url), headers: header);

    List listaResponse = json.decode(response.body);
    var disciplinas = <Disciplina>[];
    if (response.statusCode == 200) {
      for (Map map in listaResponse) {
        Disciplina t = Disciplina.fromJson(map);
        disciplinas.add(t);
      }
    } else {
      throw Exception;
    }

    return disciplinas[0];
  }

}
