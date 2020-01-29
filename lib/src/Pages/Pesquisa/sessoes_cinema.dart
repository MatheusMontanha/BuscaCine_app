import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/Models/post_model.dart';
import 'package:flutter_app/src/Models/post_sessoes_filme.dart';
import 'package:flutter_app/src/app/Negocio/bloc_requests.dart';

class SessoesCinema extends StatefulWidget {
  final PostModel cinema;

  SessoesCinema(this.cinema);

  @override
  _SessoesCinemaState createState() => _SessoesCinemaState();
}

class _SessoesCinemaState extends State<SessoesCinema> {
  List<PostSessaoFilme> sessoesPorCinema;

  var newTaskCtrl = TextEditingController();

  Dio dio = new Dio();

  BuscaCineRequisicoes bcRequisicoes = BuscaCineRequisicoes();

  Future<List<PostSessaoFilme>> _getSessoesCinema() async {
    sessoesPorCinema = await bcRequisicoes.recuperaSessoesCinema(
        int.parse(widget.cinema.cityId), int.parse(widget.cinema.id));
    setState(() {
      return sessoesPorCinema;
    });
    return null;
  }

  @override
  void initState() {
    super.initState();
    _getSessoesCinema();
  }

  Color corPrimaria = Color.fromRGBO(58, 66, 86, 1.0);
  Color corCards = Color.fromRGBO(64, 75, 96, .9);
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
        child: ListView.builder(
          itemCount: sessoesPorCinema.length,
          itemBuilder: (BuildContext context, int index) {
            if (sessoesPorCinema[0].movies == null) {
              return Center(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Nenhum sessão foi encontrada neste cinema.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Espera algumas horas e retorne a realizar sua consulta.",
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
                        title: Text(sessoesPorCinema[index].movies[0].title),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
