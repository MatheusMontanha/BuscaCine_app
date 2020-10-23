import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/feature_modules/search_movie_poster/models/post_filmes_cartaz.dart';
import 'package:flutter_app/src/feature_modules/search_movie_poster/models/detalhes_filmes.dart';
import 'package:flutter_app/src/Connect_api/connect_api.dart';

class BuscaFilmeCartaz extends StatefulWidget {
  @override
  _BuscaFilmeCartazState createState() => _BuscaFilmeCartazState();
}

var newTaskCtrl = TextEditingController();

class _BuscaFilmeCartazState extends State<BuscaFilmeCartaz> {
  Dio dio = new Dio();
  List<PostFilmeCartaz> filmesEmCartaz = [];
  ConnectApi bcRequisicoes = ConnectApi();

  Future<List<PostFilmeCartaz>> _getFilmesCartaz(String nomeCidade) async {
    int id = await bcRequisicoes.recuperaIDCidade(nomeCidade);
    filmesEmCartaz = await bcRequisicoes.recuperaFilmeCartaz(id);
    setState(() {
      _carregandoLista = true;
      return filmesEmCartaz;
    });
    return null;
  }

  void buscarFilmesCartaz() {
    setState(() {
      _estadoInicial = false;
      _getFilmesCartaz(newTaskCtrl.text);
      _carregandoLista = false;
    });
  }

  bool _estadoInicial;
  bool _carregandoLista;
  @override
  void initState() {
    _estadoInicial = true;
    _carregandoLista = false;
    super.initState();
  }

  Color corPrimaria = Color.fromRGBO(58, 66, 86, 1.0);
  Color corCards = Color.fromRGBO(64, 75, 96, .9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        backgroundColor: corPrimaria,
        title: TextField(
          autofocus: true,
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
            onPressed: () {
              buscarFilmesCartaz();
            },
          ),
        ],
        centerTitle: true,
      ),
      body: _estadoInicial
          ? Center(
              child: Container(
                  width: 100,
                  height: 100,
                  padding: const EdgeInsets.all(7.0),
                  child: Image.asset("assets/cartaz-icon.png")),
            )
          : Container(
              child: _carregandoLista
                  ? ListView.builder(
                      itemCount: filmesEmCartaz.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (filmesEmCartaz[0].id.contains("null") &&
                            filmesEmCartaz[0].title.contains("null")) {
                          return Center(
                            child: Card(
                              color: corCards,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      "Nenhum cinema foi Encontrado :(.",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Verifique se o nome da cidade foi preenchido corretamente.",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
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
                            color: corCards,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        filmesEmCartaz[index].images[0].url),
                                  ),
                                  title: Text(
                                    filmesEmCartaz[index].title,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFFE0BC00),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "Distribuidora: ${filmesEmCartaz[index].distributor}, "
                                    "Classificação ${filmesEmCartaz[index].contentRating}, "
                                    "Duração: ${filmesEmCartaz[index].duration} minutos",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                DetalhesFilme(
                                                    filmesEmCartaz[index])));
                                  },
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Text(
                                        "*Clique para maiores informações",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ),
                                    Icon(
                                      Icons.info,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    ),
            ),
    );
  }
}
