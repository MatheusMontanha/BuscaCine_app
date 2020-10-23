import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/feature_modules/search_cine/models/post_model.dart';
import 'package:flutter_app/src/feature_modules/search_cine/widgets/sessoes_cinema.dart';
import 'package:flutter_app/src/Connect_api/connect_api.dart';

class BuscaCinemas extends StatefulWidget {
  @override
  _BuscaCinemasState createState() => _BuscaCinemasState();
}

class _BuscaCinemasState extends State<BuscaCinemas> {
  Dio dio = Dio();
  List<PostModel> cinemasPorCidade = [];
  ConnectApi bcRequisicoes = ConnectApi();

  Future<List<PostModel>> _getCinemas(String nomeCidade) async {
    int id = await bcRequisicoes.recuperaIDCidade(nomeCidade);
    cinemasPorCidade = await bcRequisicoes.recuperaCinemas(id);
    setState(() {
      _carregarLista = true;
      return cinemasPorCidade;
    });
    return null;
  }

  var newTaskCtrl = TextEditingController();

  void atualizarLista() {
    setState(() {
      _estadoInicial = false;
      _getCinemas(newTaskCtrl.text);
      _carregarLista = false;
    });
  }

  bool _estadoInicial;
  bool _carregarLista;
  Color corPrimaria = Color.fromRGBO(58, 66, 86, 1.0);
  Color corCards = Color.fromRGBO(64, 75, 96, .9);
  @override
  void initState() {
    _estadoInicial = true;
    _carregarLista = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corPrimaria,
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
            onPressed: atualizarLista,
          ),
        ],
      ),
      body: _estadoInicial
          ? Center(
              child: Container(
                  width: 110,
                  height: 110,
                  padding: const EdgeInsets.all(7.0),
                  child: Image.asset("assets/cinema-icon.png")),
            )
          : Container(
              child: _carregarLista
                  ? ListView.builder(
                      itemCount: cinemasPorCidade.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (cinemasPorCidade[0].name.contains("null")) {
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
                            child: Container(
                              decoration: BoxDecoration(
                                color: corCards,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                          "${cinemasPorCidade[index].images[0].url}"),
                                    ),
                                    title: Text(
                                      cinemasPorCidade[index].name,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      "Bairro: ${cinemasPorCidade[index].neighborhood}, ${cinemasPorCidade[index].address}, Número: ${cinemasPorCidade[index].number}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      opcoesCardCinema(
                                          "Sessões",
                                          Container(
                                            child: Image.asset(
                                                "assets/sessoes.png"),
                                          ),
                                          1,
                                          cinemasPorCidade[index],
                                          Color(0xFF6495ED)),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      opcoesCardCinema(
                                          "Localização",
                                          Container(
                                            child: Image.asset(
                                                "assets/google-maps.png"),
                                          ),
                                          0,
                                          null,
                                          Color(0xFF3CB371)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    )),
    );
  }

  Container opcoesCardCinema(String tituloBotao, Container icone,
      int numeroOpcao, PostModel cinema, Color color) {
    return Container(
      height: 45,
      width: 157,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: FlatButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              tituloBotao,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Container(
              child: SizedBox(
                child: icone,
                height: 28,
                width: 28,
              ),
            ),
          ],
        ),
        onPressed: () {
          if (numeroOpcao == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => SessoesCinema(cinema)));
          } else {}
        },
      ),
    );
  }
}
