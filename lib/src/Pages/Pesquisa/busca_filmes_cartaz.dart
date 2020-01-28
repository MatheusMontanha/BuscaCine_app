import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/Models/post_filmes_cartaz.dart';
import 'package:flutter_app/src/Pages/Pesquisa/detalhes_filmes.dart';
import 'package:flutter_app/src/app/Negocio/bloc_requests.dart';

class BuscaFilmeCartaz extends StatefulWidget {
  @override
  _BuscaFilmeCartazState createState() => _BuscaFilmeCartazState();
}

var newTaskCtrl = TextEditingController();

class _BuscaFilmeCartazState extends State<BuscaFilmeCartaz> {
  Dio dio = new Dio();
  List<PostFilmeCartaz> filmesEmCartaz = [];
  BuscaCineRequisicoes bcRequisicoes = BuscaCineRequisicoes();

  Future<List<PostFilmeCartaz>> _getFilmesCartaz(String nomeCidade) async {
    int id = await bcRequisicoes.recuperaIDCidade(nomeCidade);
    filmesEmCartaz = await bcRequisicoes.recuperaFilmeCartaz(id);
    setState(() {
      return filmesEmCartaz;
    });
    return null;
  }

  void buscarFilmesCartaz() {
    setState(() {
      _getFilmesCartaz(newTaskCtrl.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: TextField(
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          decoration: InputDecoration(
              labelText: "Digite o nome da cidade...",
              labelStyle: TextStyle(
                color: Colors.white,
              )),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: buscarFilmesCartaz,
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: filmesEmCartaz.length,
          itemBuilder: (BuildContext context, int index) {
            if (filmesEmCartaz[0].id.contains("null") &&
                filmesEmCartaz[0].title.contains("null")) {
              return Center(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Nenhum cinema foi Encontrado :(.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Verifique se o nome da cidade foi preenchido corretamente.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(filmesEmCartaz[index].images[0].url),
                      ),
                      title: Text(
                        filmesEmCartaz[index].title,
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        "Distribuidora: ${filmesEmCartaz[index].distributor}, Classificação ${filmesEmCartaz[index].contentRating}, Duração: ${filmesEmCartaz[index].duration}",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    DetalhesFilme(filmesEmCartaz[index])));
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
