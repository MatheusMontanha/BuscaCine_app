import 'package:flutter/material.dart';
import 'package:flutter_app/src/feature_modules/search_movie_poster/models/post_filmes_cartaz.dart';
import 'package:flutter_app/src/utils/comuns.dart';

class DetalhesFilme extends StatelessWidget {
  final PostFilmeCartaz filme;
  final Usaveis usaveis = Usaveis();
  DetalhesFilme(this.filme);

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
    final classificacao = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: idenClassificacao(filme.contentRating),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 50.0),
        SizedBox(height: 10.0),
        Text(
          filme.title,
          style: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Diretor: ${filme.director} \nDistribuição: ${filme.distributor}\nCidade: ${filme.city}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))),
            Expanded(flex: 1, child: classificacao)
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            // height: MediaQuery.of(context).size.height,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new NetworkImage(filme.images[0].url),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color.fromRGBO(58, 66, 86, .7),
          ),
          child: ListView(
            children: <Widget>[
              Center(
                child: topContentText,
              )
            ],
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      filme.synopsis,
      style: TextStyle(fontSize: 18.0, color: Colors.white),
    );
    final readButton = Container(
        height: 60,
        width: 250,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Color(0xFF3C5A99),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: SizedBox.expand(
          child: FlatButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Assista ao trailer",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
                Container(
                  child: SizedBox(
                    child: Image.asset("assets/youtube.png"),
                    height: 28,
                    width: 28,
                  ),
                ),
              ],
            ),
            onPressed: () {
              usaveis.abrirAppURL(filme.trailers[0].url, true, false);
            },
          ),
        ));
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(40.0),
      color: corCards,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Sinopse",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          bottomContentText,
          SizedBox(
            height: 20,
          ),
          readButton,
        ],
      ),
    );

    return Scaffold(
      body: ListView(
        children: <Widget>[
          topContent,
          bottomContent,
        ],
      ),
    );
  }
}
