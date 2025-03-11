import 'package:avalia_aula/avaliacao.dart';
import 'package:avalia_aula/pages/apis/disciplinasApi.dart';
import 'package:avalia_aula/pages/avaliacao_page.dart';
import 'package:avalia_aula/pages/graficos_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Disciplina.dart';
import 'avaliacoes_page.dart';

class DisciplinasPage extends StatefulWidget {
  const DisciplinasPage({super.key});

  @override
  State<DisciplinasPage> createState() => _DisciplinasPageState();
}

class _DisciplinasPageState extends State<DisciplinasPage> {
  //1 - Aluno 2 - Professor 3 - Admin
  String grupoUsuario = "1";

  @override
  void initState() {
    super.initState();
    preencheGrupoUsuario();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Disciplinas"),
      ),
      body: Column(children: [
        Expanded(
          child: _body(),
        ),
        Visibility(
          visible: false,
          child: SizedBox(
            width: double.infinity,
            height: 100.0,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GraficosPage(Disciplina())));
                },
                child: const Text("SOU PROFESSOR",
                    style: TextStyle(
                      fontSize: 20,
                    ))),
          ),
        ),
        Visibility(
          visible: grupoUsuario == "1" || grupoUsuario == "3" ? true : false,
          child: SizedBox(
            width: double.infinity,
            height: 100.0,
            child: ElevatedButton(
                onPressed: () {
                  _incrementCounter();
                },
                child: const Text("MINHAS AVALIAÇÕES",
                    style: TextStyle(
                      fontSize: 20,
                    ))),
          ),
        )
      ]),
    );
  }

  void _incrementCounter() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ListaAvaliacoes()));
  }

  _body() {
    Future<List<Disciplina>> disciplinas = DisciplinasApi.getDisciplinas();
    return FutureBuilder(
      future: disciplinas,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Erro ao acessar os dados");
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        List<Disciplina>? disciplinas = snapshot.data;
        return Column(children: [
          Expanded(
            child: _listView(disciplinas),
          )
        ]);
      },
    );
    //return;
  }

  _listView(disciplinas) {
    return Scrollbar(
        thumbVisibility: false,
        child: ListView.builder(
            itemCount: disciplinas != null ? disciplinas.length : 0,
            itemBuilder: (context, index) {
              Disciplina t = disciplinas[index];

              return Card(
                  child: InkWell(
                      onTap: () {
                        if(grupoUsuario == "1") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AvaliacaoPage(
                                      disciplinas[index], Avaliacao()))
                          );
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GraficosPage(
                                      disciplinas[index]))
                          );
                        }
                      },
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              t.nome_disciplina,
                              style: const TextStyle(fontSize: 15),
                            ),
                          )
                        ],
                      )));
            }));
  }

  preencheGrupoUsuario() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      grupoUsuario = prefs.getString("grupo_usuario")!;
    });
  }
}
