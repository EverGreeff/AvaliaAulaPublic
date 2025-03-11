

class Disciplina {

  String id = "";
  String nome_disciplina = "";
  String excluido = "";

  Disciplina();

  Disciplina.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
    nome_disciplina = json["nome_disciplina"];
    excluido = json["excluido"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['nome_disciplina'] = this.nome_disciplina;
    data['excluido'] = this.excluido;
    return data;

  }


}