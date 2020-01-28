import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/Models/post_cidade.dart';
import 'package:flutter_app/src/Models/post_model.dart';

class BuscaCinemas extends StatefulWidget {
  @override
  _BuscaCinemasState createState() => _BuscaCinemasState();
}

class _BuscaCinemasState extends State<BuscaCinemas> {
  Dio dio = new Dio();
  List<PostModel> cinemasPorCidade = [];
  Future<List<PostModel>> _getCinemas(String nomeCidade) async {
    int id;
    cinemasPorCidade = [];
    try {
      var dadosCidade = await dio.get(
          "https://api-content.ingresso.com/v0/states/city/name/$nomeCidade");

      var cidade = Cidade.fromJson(dadosCidade.data);
      id = int.parse(cidade.id);
      var response = await dio.get(
          "https://api-content.ingresso.com/v0/theaters/city/$id?partnership=buscacine");
      var jsonData = (response.data as List)
          .map((item) => PostModel.fromJson(item))
          .toList();
      for (var i in jsonData) {
        PostModel postModel = PostModel(
            name: i.name,
            address: i.address,
            neighborhood: i.neighborhood,
            addressComplement: i.addressComplement,
            number: i.number,
            cityId: i.cityId,
            images: i.images);
        cinemasPorCidade.add(postModel);
      }
      setState(() {
        return cinemasPorCidade;
      });
    } catch (e) {
      if (cinemasPorCidade.length == 0) {
        PostModel postModel = PostModel(
            name: "null",
            address: "null",
            neighborhood: "null",
            addressComplement: "null",
            number: "null",
            cityId: "null",
            images: null);
        cinemasPorCidade.add(postModel);
      }
      setState(() {
        return cinemasPorCidade;
      });
    }
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
                        backgroundImage:
                            NetworkImage(cinemasPorCidade[index].images[0].url),
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
