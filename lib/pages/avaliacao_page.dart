import 'package:avalia_aula/avaliacao.dart';
import 'package:avalia_aula/pages/apis/avaliacaoApi.dart';
import 'package:avalia_aula/pages/apis/disciplinasApi.dart';
import 'package:avalia_aula/pages/apis/emojiApi.dart';
import 'package:avalia_aula/pages/util/util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Disciplina.dart';
import '../emoji.dart';

class AvaliacaoPage extends StatelessWidget {
  final Disciplina disciplina;
  Avaliacao avaliacao;

  AvaliacaoPage(this.disciplina, this.avaliacao);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
      ),
      body: MyAvaliacaoPage(disciplina, avaliacao),
    );
  }
}

class MyAvaliacaoPage extends StatefulWidget {
  final Disciplina disciplina;
  Avaliacao avaliacao;

  MyAvaliacaoPage(this.disciplina, this.avaliacao);

  @override
  _AvaliacaoPageState createState() => _AvaliacaoPageState(disciplina, avaliacao);
}

class _AvaliacaoPageState extends State<MyAvaliacaoPage> {
  final Disciplina disciplina;
  Avaliacao avaliacao;

  Emoji emojiSelected = Emoji();
  TextEditingController observacaoController = new TextEditingController();
  TextEditingController nomeDisciplinaController = new TextEditingController();

  _AvaliacaoPageState(this.disciplina, this.avaliacao);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(avaliacao.id != '') {
      preencheTela();
      nomeDisciplinaController.text = disciplina.nome_disciplina;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    child: const Image(
                      width: 20,
                      image: AssetImage("doc/images/icone_laranja.png"),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        disciplina.nome_disciplina
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            Column(
              children: [_imagens(), _campoOpcional(), _buttonBottom()],
            )
          ],
        ),
      ),
    );
  }

  _imagens() {
    Future<List<Emoji>> emojis = EmojisApi.getEmojis();
    return FutureBuilder(
      future: emojis,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Erro ao acessar os dados");
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        List<Emoji>? emojis = snapshot.data;
        return Column(children: [
          SizedBox(
            height: 200,
            child: _listView(emojis),
          )
        ]);
      },
    );
  }

  _listView(emojis) {
    return Scrollbar(
        thumbVisibility: false,
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              Emoji e1 = emojis[0];
              Emoji e2 = emojis[1];
              Emoji e3 = emojis[2];
              Emoji e4 = emojis[3];
              Emoji e5 = emojis[4];
              Emoji e6 = emojis[5];
              Emoji e7 = emojis[6];
              Emoji e8 = emojis[7];

              return Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          selecionaEmoji(e1);
                        },
                        child: SizedBox(
                          height: 100,
                          width: 80,
                          child: Image(
                              opacity: emojiSelected.id == e1.id
                                  ? const AlwaysStoppedAnimation(1)
                                  : const AlwaysStoppedAnimation(.5),
                              image: Util.imageFromBase64String(e1.foto_base64)
                                  .image),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          selecionaEmoji(e2);
                        },
                        child: SizedBox(
                          height: 100,
                          child: Image(
                              opacity: emojiSelected.id == e2.id
                                  ? const AlwaysStoppedAnimation(1)
                                  : const AlwaysStoppedAnimation(.5),
                              image: Util.imageFromBase64String(e2.foto_base64)
                                  .image),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          selecionaEmoji(e3);
                        },
                        child: SizedBox(
                          height: 100,
                          child: Image(
                              opacity: emojiSelected.id == e3.id
                                  ? const AlwaysStoppedAnimation(1)
                                  : const AlwaysStoppedAnimation(.5),
                              image: Util.imageFromBase64String(e3.foto_base64)
                                  .image),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            selecionaEmoji(e4);
                          },
                          child: SizedBox(
                            height: 100,
                            child: Image(
                                opacity: emojiSelected.id == e4.id
                                    ? const AlwaysStoppedAnimation(1)
                                    : const AlwaysStoppedAnimation(.5),
                                image:
                                    Util.imageFromBase64String(e4.foto_base64)
                                        .image),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          selecionaEmoji(e5);
                        },
                        child: SizedBox(
                          height: 100,
                          width: 80,
                          child: Image(
                              opacity: emojiSelected.id == e5.id
                                  ? const AlwaysStoppedAnimation(1)
                                  : const AlwaysStoppedAnimation(.5),
                              image: Util.imageFromBase64String(e5.foto_base64)
                                  .image),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          selecionaEmoji(e6);
                        },
                        child: SizedBox(
                          height: 100,
                          child: Image(
                              opacity: emojiSelected.id == e6.id
                                  ? const AlwaysStoppedAnimation(1)
                                  : const AlwaysStoppedAnimation(.5),
                              image: Util.imageFromBase64String(e6.foto_base64)
                                  .image),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          selecionaEmoji(e7);
                        },
                        child: SizedBox(
                          height: 100,
                          child: Image(
                              opacity: emojiSelected.id == e7.id
                                  ? const AlwaysStoppedAnimation(1)
                                  : const AlwaysStoppedAnimation(.5),
                              image: Util.imageFromBase64String(e7.foto_base64)
                                  .image),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            selecionaEmoji(e8);
                          },
                          child: SizedBox(
                            height: 100,
                            child: Image(
                                opacity: emojiSelected.id == e8.id
                                    ? const AlwaysStoppedAnimation(1)
                                    : const AlwaysStoppedAnimation(.5),
                                image:
                                    Util.imageFromBase64String(e8.foto_base64)
                                        .image),
                          )),
                    ],
                  )
                ],
              );
            }));
  }

  _campoOpcional() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: null,
                cursorHeight: 30,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                controller: observacaoController,
                decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20)),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buttonBottom() {
    return SizedBox(
      width: double.infinity,
      height: 100.0,
      child: ElevatedButton(
          onPressed: () {
            _avaliar(context);
          },
          child: Text("ENVIAR",
              style: new TextStyle(
                fontSize: 20,
              ))),
    );
  }

  Future<void> _avaliar(context) async {
    if (emojiSelected == null) {
      Fluttertoast.showToast(
          msg: "Favor, selecione um EMOJI!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }

    var prefs = await SharedPreferences.getInstance();
    var email_usuario = prefs.getString("email_usuario");


    avaliacao.id_emoji = emojiSelected.id;
    avaliacao.id_disciplina = disciplina.id;
    avaliacao.observacao = observacaoController.text.toString();
    avaliacao.email_usuario = email_usuario!;

    var response = await AvaliacaoApi.enviarAvaliacao(avaliacao);

    if (response.body == "OK") {
      Fluttertoast.showToast(
          msg: "Sucesso!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pop(context);
    }
  }

  selecionaEmoji(Emoji emoji) {
    emojiSelected = emoji;
    setState(() {});
  }

  preencheTela() async {
    emojiSelected = await EmojisApi.getEmoji(avaliacao.id_emoji);
    observacaoController.text = avaliacao.observacao;
  }

}
