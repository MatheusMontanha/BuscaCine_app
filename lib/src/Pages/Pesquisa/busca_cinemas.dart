import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/Models/post_model.dart';
import 'package:flutter_app/src/app/Negocio/bloc_requests.dart';

class BuscaCinemas extends StatefulWidget {
  @override
  _BuscaCinemasState createState() => _BuscaCinemasState();
}

class _BuscaCinemasState extends State<BuscaCinemas> {
  Dio dio = new Dio();
  List<PostModel> cinemasPorCidade = [];
  BuscaCineRequisicoes bcRequisicoes = BuscaCineRequisicoes();

  Future<List<PostModel>> _getCinemas(String nomeCidade) async {
    int id = await bcRequisicoes.recuperaIDCidade(nomeCidade);
    cinemasPorCidade = await bcRequisicoes.recuperaCinemas(id);
    setState(() {
      return cinemasPorCidade;
    });
    return null;
  }

  var newTaskCtrl = TextEditingController();

  void atualizarLista() {
    setState(() {
      _getCinemas(newTaskCtrl.text);
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
            onPressed: atualizarLista,
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: cinemasPorCidade.length,
          itemBuilder: (BuildContext context, int index) {
            if (cinemasPorCidade[0].name.contains("null")) {
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
                        child: Text("BC"),
                      ),
                      title: Text(
                        cinemasPorCidade[index].name,
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        "Bairro: ${cinemasPorCidade[index].neighborhood}, ${cinemasPorCidade[index].address}, Número: ${cinemasPorCidade[index].number}",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue),
                      ),
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
