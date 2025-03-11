

class Avaliacao {

  String id = "";
  String id_disciplina = "";
  String id_emoji = "";
  String observacao = "";
  String data_hora = "";
  String excluido = "";
  String nome_disciplina = "";
  String email_usuario = "";

  Avaliacao();

  Avaliacao.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
    id_disciplina = json["id_disciplina"];
    id_emoji = json["id_emoji"];
    observacao = json["observacao"];
    data_hora = json["data_hora"];
    excluido = json["excluido"];
    nome_disciplina = json["nome_disciplina"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['id_disciplina'] = this.id_disciplina;
    data['id_emoji'] = this.id_emoji;
    data['observacao'] = this.observacao;
    data['data_hora'] = this.data_hora;
    data['excluido'] = this.excluido;
    data['nome_disciplina'] = this.nome_disciplina;
    data['email_usuario'] = this.email_usuario;
    return data;

  }
}