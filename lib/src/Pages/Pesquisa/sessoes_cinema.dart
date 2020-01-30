import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/Models/post_model.dart';
import 'package:flutter_app/src/Models/post_sessoes_filme.dart';
import 'package:flutter_app/src/app/Negocio/bloc_requests.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class SessoesCinema extends StatefulWidget {
  final PostModel cinema;

  SessoesCinema(this.cinema);

  @override
  _SessoesCinemaState createState() => _SessoesCinemaState();
}

class _SessoesCinemaState extends State<SessoesCinema> {
  List<PostSessaoFilme> sessoesPorCinema = [];

  var newTaskCtrl = TextEditingController();

  Dio dio = new Dio();

  BuscaCineRequisicoes bcRequisicoes = BuscaCineRequisicoes();

  Future<List<PostSessaoFilme>> _getSessoesCinema() async {
    sessoesPorCinema = await bcRequisicoes.recuperaSessoesCinema(
        int.parse(widget.cinema.cityId), int.parse(widget.cinema.id));
    setState(() {
      _carregarLista = true;
      return sessoesPorCinema;
    });
    return null;
  }

  @override
  void initState() {
    super.initState();
    _getSessoesCinema();
  }

  bool _carregarLista = false;

  Color corPrimaria = Color.fromRGBO(58, 66, 86, 1.0);
  Color corCards = Color.fromRGBO(64, 75, 96, .9);

  Image idenClassificacao(String classificacao) {
    switch (classificacao) {
      case "18 anos":
        return Image.asset("assets/class-18-anos-logo.png");
        break;
      case "16 anos":
        return Image.asset("assets/class-16-anos-logo.png");
        break;
      case "14 anos":
        return Image.asset("assets/class_14_anos.png");
        break;
      case "12 anos":
        return Image.asset("assets/class-12-anos-logo.png");
        break;
      case "10 anos":
        return Image.asset("assets/class-10-anos-logo.png");
        break;
      case "Livre":
        return Image.asset("assets/class-livre-logo.png");
        break;
      default:
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corPrimaria,
      appBar: AppBar(
        title: Text(
          "Sessões em ${widget.cinema.name}",
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: corPrimaria,
      ),
      body: Container(
        child: _carregarLista
            ? ListView.separated(
                itemCount: sessoesPorCinema[0].movies.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Card(
                      color: corCards,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              sessoesPorCinema[0].movies[index].title,
                              style: TextStyle(
                                color: Color(0xFFE0BC00),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "Faixa Etária: ${sessoesPorCinema[0].movies[index].contentRating}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  padding: EdgeInsets.all(7.0),
                                  child: Image.asset(
                                      "assets/class-12-anos-logo.png"),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      color: Color(0xFF6A7288), width: 5.0),
                                  top: BorderSide(
                                      color: Color(0xFF6A7288), width: 5.0),
                                  bottom: BorderSide(
                                      color: Color(0xFF6A7288), width: 5.0),
                                  right: BorderSide(
                                      color: Color(0xFF6A7288), width: 5.0)),
                              //borderRadius: BorderRadius.circular(5.0),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [
                                    0.4,
                                    1
                                  ],
                                  colors: [
                                    Color(0xFF3A4256),
                                    Color(0xFF6A7288),
                                  ]),
                            ),
                            child: ListBody(
                              children: _salasDoFilme(index),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
      ),
    );
  }

  List<Widget> _salasDoFilme(int index) {
    List<Widget> listaDeSalas = [];
    for (var i = 0; i < sessoesPorCinema[0].movies[index].rooms.length; i++) {
      listaDeSalas.add(Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            sessoesPorCinema[0].movies[index].rooms[i].name,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          )));
      listaDeSalas += _sessoesDoFilme(index, i);
    }

    return listaDeSalas;
  }

  List<Widget> _sessoesDoFilme(int indexMovie, int indexRoom) {
    List<Widget> listaDeSessoes = [];
    for (var i = 0;
        i <
            sessoesPorCinema[0]
                .movies[indexMovie]
                .rooms[indexRoom]
                .sessions
                .length;
        i++) {
      FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
          amount: sessoesPorCinema[0]
              .movies[indexMovie]
              .rooms[indexRoom]
              .sessions[i]
              .price);
      listaDeSessoes.add(Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Tipo: ${sessoesPorCinema[0].movies[indexMovie].rooms[indexRoom].sessions[i].types[0].alias}\n"
            "Valor: R${fmf.output.compactSymbolOnLeft}\n"
            "Data: ${sessoesPorCinema[0].movies[indexMovie].rooms[indexRoom].sessions[i].date.dayOfWeek} "
            "(${sessoesPorCinema[0].movies[indexMovie].rooms[indexRoom].sessions[i].date.dayAndMonth}"
            "/${sessoesPorCinema[0].movies[indexMovie].rooms[indexRoom].sessions[i].date.year}) às "
            "${sessoesPorCinema[0].movies[indexMovie].rooms[indexRoom].sessions[i].date.hour}",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          )));
    }
    return listaDeSessoes;
  }
}
