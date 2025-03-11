

class Usuario {

  String id = "";
  String grupo_usuario = "";
  String nome = "";
  String email = "";

  Usuario();

  Usuario.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
    grupo_usuario = json["grupo_usuario"];
    nome = json["nome"];
    email = json["email"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['grupo_usuario'] = this.grupo_usuario;
    data['nome'] = this.nome;
    data['email'] = this.email;
    return data;

  }


}