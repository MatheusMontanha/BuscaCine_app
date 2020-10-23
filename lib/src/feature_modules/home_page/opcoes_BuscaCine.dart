import 'package:flutter/material.dart';
import 'package:flutter_app/src/feature_modules/search_cine/widgets/busca_cinemas.dart';
import 'package:flutter_app/src/feature_modules/search_movie_poster/widgets/busca_filmes_cartaz.dart';
import 'package:flutter_app/src/feature_modules/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpcoesBuscaCine extends StatefulWidget {
  @override
  _OpcoesBuscaCineState createState() => _OpcoesBuscaCineState();
}

class _OpcoesBuscaCineState extends State<OpcoesBuscaCine> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  alertDialogExit(BuildContext context) {
    Widget cancelarButton = FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("Cancelar"));
    Widget continuarButton = FlatButton(
        onPressed: () {
          sharedPreferences.clear();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
              (Route<dynamic> route) => false);
        },
        child: Text("Continuar"));

    AlertDialog alert = AlertDialog(
      title: Text("Alerta!"),
      content: Text("Tem certeza que deseja sair?"),
      actions: <Widget>[
        cancelarButton,
        continuarButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Color corPrimaria = Color.fromRGBO(58, 66, 86, 1.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
        backgroundColor: corPrimaria,
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              color: corPrimaria,
              child: DrawerHeader(
                child: CircleAvatar(
                  radius: 20,
                  child: Text("BC"),
                  // backgroundImage:
                  //     NetworkImage("https://i.pravatar.cc/150?img=3"),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              color: corPrimaria,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.account_box,
                      size: 30,
                      color: Colors.grey,
                    ),
                    title: Text(
                      "Minha conta",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.exit_to_app,
                      size: 30,
                      color: Colors.grey,
                    ),
                    title: Text(
                      "Sair",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    onTap: () {
                      alertDialogExit(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: corPrimaria,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset("assets/pop-corn.png"),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
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
                        "Cinemas no Brasil",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      Container(
                        child: SizedBox(
                          child: Icon(
                            Icons.home,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => BuscaCinemas()));
                  },
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
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
                        "Filmes em Cartaz",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      Container(
                        child: SizedBox(
                          child: Icon(
                            Icons.movie,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                BuscaFilmeCartaz()));
                  },
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 80,
              child: Image.asset(
                "assets/logo-busca-cine.png",
              ),
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
