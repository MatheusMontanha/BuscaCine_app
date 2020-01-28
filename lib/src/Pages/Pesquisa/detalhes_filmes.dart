import 'package:flutter/material.dart';
import 'package:flutter_app/src/Models/post_filmes_cartaz.dart';

class DetalhesFilme extends StatelessWidget {
  final PostFilmeCartaz filme;

  DetalhesFilme(this.filme);
  @override
  Widget build(BuildContext context) {
    final classificacao = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: Image.asset("assets/class_14_anos.png"),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 100.0),
        SizedBox(height: 10.0),
        Text(
          filme.title,
          style: TextStyle(color: Colors.white, fontSize: 45.0),
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
                          color: Colors.white70, fontWeight: FontWeight.bold),
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
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
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
      style: TextStyle(fontSize: 18.0),
    );
    final readButton = Container(
        height: 60,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            onPressed: () {},
          ),
        ));
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              "Sinopse",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            bottomContentText,
            readButton,
          ],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          topContent,
          bottomContent,
        ],
      ),
    );
  }
}
