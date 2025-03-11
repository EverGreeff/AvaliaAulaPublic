import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../avaliacao.dart';
import '../../main.dart';

class AvaliacaoApi {
  static Future<http.Response> enviarAvaliacao(Avaliacao avaliacao) async {
    var prefs = await SharedPreferences.getInstance();
    var token =
        "";
    var emailUsuario = prefs.getString("email_usuario") ?? "";

    var url = MyApp.URL_SERVIDOR + 'avaliacao';

    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
      "Accept-Encoding": "gzip, deflate, br"
    };
    //jsonEncode(topico);

    var response = await http.post(Uri.parse(url), headers: header, body: jsonEncode(avaliacao));

    return response;
  }

  static Future<List<Avaliacao>> getAvaliacoes() async {
    var prefs = await SharedPreferences.getInstance();
    var token =
        "";
    var emailUsuario = prefs.getString("email_usuario") ?? "";

    var url = MyApp.URL_SERVIDOR + 'avaliacao/listar/' + emailUsuario;

    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    Map params = {"criterio": ""};

    var _body = json.encode(params);

    var response =
    await http.get(Uri.parse(url), headers: header);

    List listaResponse = json.decode(response.body);
    var avaliacoes = <Avaliacao>[];
    if (response.statusCode == 200) {
      for (Map map in listaResponse) {
        Avaliacao t = Avaliacao.fromJson(map);
        avaliacoes.add(t);
      }
    } else {
      throw Exception;
    }

    return avaliacoes;
  }

  static Future<List<Avaliacao>> getAvaliacoesPorDisciplina(String id_disciplina) async {

    var token =
        "";


    var url = MyApp.URL_SERVIDOR + 'avaliacao/listar/disciplina/' + id_disciplina;

    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    Map params = {"criterio": ""};

    var _body = json.encode(params);

    var response =
    await http.get(Uri.parse(url), headers: header);

    List listaResponse = json.decode(response.body);
    var avaliacoes = <Avaliacao>[];
    if (response.statusCode == 200) {
      for (Map map in listaResponse) {
        Avaliacao t = Avaliacao.fromJson(map);
        avaliacoes.add(t);
      }
    } else {
      throw Exception;
    }

    return avaliacoes;
  }
}
