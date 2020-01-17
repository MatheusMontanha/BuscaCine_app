import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:link/link.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
        child: Column( 
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            TextFormField(
              autofocus: true,
              keyboardType: TextInputType.number,
              style: new TextStyle(color: Colors.white, fontSize: 20),
              decoration: InputDecoration(
                labelText: "CPF",
                labelStyle: TextStyle(color: Colors.white)
              ),
            ),
            Divider(),
            TextFormField(
              autofocus: true,
              keyboardType: TextInputType.text,
              obscureText: true,
              style: new TextStyle(color: Colors.white, fontSize: 20),
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(color: Colors.white)
              ),
            ),
            Divider(),
            ButtonTheme(
              height: 60.0,
              child: RaisedButton(
                onPressed: () => {},
                child: Text(
                  "Entrar", 
                  style: TextStyle(color: Colors.deepPurple),
                ),
                color: Colors.white,
              ),
            ),
            Divider(),
            GestureDetector(
            child: Center(
                 child: Link(
                   child: Text('Esqueci minha senha.', style: TextStyle(decoration: TextDecoration.underline, color: Colors.white)),
                   url: 'www.google.com',
                 ),
                )
              )
            ]
          ),
        )
      ),
    );
  }
}