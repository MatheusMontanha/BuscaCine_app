import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/Models/post_cidade.dart';
import 'package:flutter_app/src/Models/post_model.dart';

class BuscaCinemas extends StatefulWidget {
  Dio dio = new Dio();
  List<PostModel> cinemas = [];
  List<PostModel> cinemasPorCidade = [];
  Future<List<PostModel>> _getCinemas(String nomeCidade) async {
    int id;
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
    return cinemasPorCidade;
  }

  @override
  _BuscaCinemasState createState() => _BuscaCinemasState();
}

class _BuscaCinemasState extends State<BuscaCinemas> {
  var newTaskCtrl = TextEditingController();

  void atualizarLista() {
    setState(() {
      widget._getCinemas(newTaskCtrl.text);
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
      body: ListView.builder(
        itemCount: widget.cinemasPorCidade.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          widget.cinemasPorCidade[index].images[0].url),
                    ),
                    title: Text(
                      widget.cinemasPorCidade[index].name,
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      "Endereço: ${widget.cinemasPorCidade[index].address}, Número: ${widget.cinemasPorCidade[index].number}",
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
    );
  }
}
