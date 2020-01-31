import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/Models/post_token.dart';
import 'package:flutter_app/src/Pages/Home/opcoes_BuscaCine.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? "O campo de email deve ser preenchido." : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? "O campo de senha deve ser preenchido." : null;
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLogado = false;
  Dio dio = Dio();

  signIn(String email, String password) async {
    email = "eve.holt@reqres.in";
    password = "cityslicka";
    var data = {'email': email, 'password': password};

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      var response = await dio.post("https://reqres.in/api/login", data: data);
      var token = PostToken.fromJson(response.data);
      if (token != null) {
        setState(() {
          _isLogado = true;
          sharedPreferences.setString("token", token.token);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => OpcoesBuscaCine()),
              (Route<dynamic> route) => false);
        });
      }
    } catch (e) {
      setState(() {
        _isLogado = false;
        sharedPreferences.setString("token", null);
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                width: 128,
                height: 128,
                child: Image.asset("assets/pop-corn.png"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                //initialValue: "eve.holt@reqres.in",
                validator: EmailFieldValidator.validate,
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                validator: PasswordFieldValidator.validate,
                obscureText: true,
                //initialValue: "cityslicka",
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
              Divider(),
              Container(
                height: 40,
                child: FlatButton(
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Recuperar Senha",
                      ),
                      Container(
                        child: SizedBox(
                          child: Image.asset("assets/reset-password-icon.png"),
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [
                        0.3,
                        1
                      ],
                      colors: [
                        Color(0xFF5F9EA0),
                        Color(0xFF3C5A99),
                      ]),
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
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          child: SizedBox(
                            child: Icon(
                              Icons.assignment_ind,
                              color: Colors.white,
                              size: 30,
                            ),
                            height: 28,
                            width: 28,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        snackBars(true);
                        signIn(emailController.text, passwordController.text);
                        snackBars(_isLogado);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
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
                          "Login com Facebook",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          child: SizedBox(
                            child: Image.asset("assets/fb-icon.png"),
                            height: 28,
                            width: 28,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                child: FlatButton(
                  child: Text(
                    "Cadastre-se",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  snackBars(bool value) {
    return _scaffoldKey.currentState.showSnackBar(new SnackBar(
      duration: new Duration(seconds: 4),
      content: conteudosnackBars(value),
    ));
  }

  conteudosnackBars(bool value) {
    if (!value) {
      return new Row(children: <Widget>[
        Text(
          "Email ou senha incorretos!",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Icon(
          Icons.error,
          color: Colors.red,
        )
      ]);
    } else {
      return new Row(
        children: <Widget>[
          CircularProgressIndicator(),
          Text("Autenticando..."),
        ],
      );
    }
  }
}
