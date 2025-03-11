import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Usuario.dart';
import '../../main.dart';

class UsuarioApi {

  static Future<Usuario?> getUsuario(email) async {

    var token =
        "";


    var url = MyApp.URL_SERVIDOR + 'usuario/' + email;

    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    var response =
    await http.get(Uri.parse(url), headers: header);

    List listaResponse = json.decode(response.body);
    var usuarios = <Usuario>[];
    if (response.statusCode == 200) {
      for (Map map in listaResponse) {
        Usuario t = Usuario.fromJson(map);
        usuarios.add(t);
      }
    } else {
      throw Exception;
    }

    return usuarios.isEmpty ? null : usuarios.first;
  }

}
