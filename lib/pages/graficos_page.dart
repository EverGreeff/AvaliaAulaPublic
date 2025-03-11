import 'package:avalia_aula/avaliacao.dart';
import 'package:avalia_aula/emoji.dart';
import 'package:avalia_aula/pages/apis/avaliacaoApi.dart';
import 'package:avalia_aula/pages/util/util.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Disciplina.dart';
import 'apis/emojiApi.dart';

class GraficosPage extends StatelessWidget {
  final Disciplina disciplina;
  GraficosPage(this.disciplina);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Avaliações da disciplina"),
      ),
      body: MyGraficosPage(disciplina),
    );
  }
}

class MyGraficosPage extends StatefulWidget {
  final Disciplina disciplina;

  MyGraficosPage(this.disciplina);

  @override
  _GraficosPageState createState() => _GraficosPageState(disciplina);
}

class _GraficosPageState extends State<MyGraficosPage> {
  final Disciplina disciplina;

  _GraficosPageState(this.disciplina);

  @override
  void initState() {
    super.initState();


  }



  @override
  Widget build(BuildContext context) {


    return _body();
  }

  _body() {
    Future<List<Avaliacao>> avaliacoes = AvaliacaoApi.getAvaliacoesPorDisciplina(disciplina.id);
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
  }

  _imagePrint(Emoji emoji) {
    Image image = Util.imageFromBase64String(emoji.foto_base64);

    return SizedBox(
      height: 100,
      width: 80,
      child: Image(image: image.image),
    );
  }

  _image(var id_emoji) {
    Future<Emoji> emoji = EmojisApi.getEmoji(id_emoji);

    return FutureBuilder(
        future: emoji,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Erro ao acessar a imagem");
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          Emoji? emoji = snapshot.data;
          return Column(children: [
            Expanded(
              child: _imagePrint(emoji!),
            )
          ]);
        }
    );

  }


  _listView(avaliacoes) {
    return Scrollbar(
        thumbVisibility: false,
        child: ListView.builder(
            itemCount: avaliacoes != null ? avaliacoes.length : 0,
            itemBuilder: (context, index) {
              Avaliacao a = avaliacoes[index];

              return Card(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          a.observacao,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      Text(
                        a.data_hora,
                        style: const TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 100,
                        child: _image(a.id_emoji),
                      ),
                    ],
                  ));
            }));
  }

  Future<Image> preencheEmoji(var id_emoji) async {
    Emoji emojiSelected = await EmojisApi.getEmoji(id_emoji);

    Image image = Util.imageFromBase64String(emojiSelected.foto_base64);

    return image;
  }

  _listView2(avaliacoes) {

    Map<String, double> dataMap = {
      "Flutter": 5,
      "React": 3,
      "Xamarin": 2,
      "Ionic": 2,
    };

    return PieChart(dataMap: dataMap);
  }

}