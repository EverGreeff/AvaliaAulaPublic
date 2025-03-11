import 'package:avalia_aula/avaliacao.dart';
import 'package:avalia_aula/pages/apis/avaliacaoApi.dart';
import 'package:avalia_aula/pages/apis/disciplinasApi.dart';
import 'package:avalia_aula/pages/avaliacao_page.dart';
import 'package:flutter/material.dart';

import '../Disciplina.dart';

class ListaAvaliacoes extends StatefulWidget {
  const ListaAvaliacoes({super.key});


  @override
  State<ListaAvaliacoes> createState() => _ListaAvaliacoesState();
}

class _ListaAvaliacoesState extends State<ListaAvaliacoes> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minhas Avaliações"),
      ),
      body: Column(children: [
        Expanded(
          child: _body(),
        )
      ]),
    );
  }

  _body() {
    Future<List<Avaliacao>> avaliacoes = AvaliacaoApi.getAvaliacoes();
    return FutureBuilder(
      future: avaliacoes,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Erro ao acessar os dados");
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        List<Avaliacao>? avaliacoes = snapshot.data;
        return Column(children: [
          Expanded(
            child: _listView(avaliacoes),
          )
        ]);
      },
    );
    //return;
  }

  _listView(avaliacoes) {
    return Scrollbar(
        thumbVisibility: false,
        child: ListView.builder(
            itemCount: avaliacoes != null ? avaliacoes.length : 0,
            itemBuilder: (context, index) {
              Avaliacao t = avaliacoes[index];

              return Card(
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AvaliacaoPage(Disciplina(), avaliacoes[index])));
                      },
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              t.nome_disciplina,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              t.observacao,
                              style: const TextStyle(fontSize: 15),
                            ),
                          )
                        ],
                      )));
            }));
  }
}