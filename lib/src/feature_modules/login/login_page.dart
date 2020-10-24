import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/components/buttons/large_button.dart';
import 'package:flutter_app/src/components/buttons/large_text_field.dart';
import 'package:flutter_app/src/feature_modules/home_page/opcoes_BuscaCine.dart';
import 'package:flutter_app/src/models%20commun/post_token.dart';
import 'package:flutter_app/src/outputs/JoyUiText.dart';
import 'package:flutter_app/src/outputs/icons_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLogado = false;
  bool isUseNativeIcon;
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
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  IconsCustom.popconricon,
                  width: 128,
                  height: 128,
                ),
              ),
              LargeTextField(
                textController: emailController,
                labelText: JoyUiText.labelEmailFone,
                maxLength: 50,
              ),
              LargeTextField(
                  textController: passwordController,
                  labelText: JoyUiText.labelPassword,
                  maxLength: 10),
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
              LargeButton(
                Color(0xFF4267B2),
                () {},
                JoyUiText.labelLoginButton,
                isUseNativeIcon = true,
                Icons.assignment_ind,
              ),
              SizedBox(
                height: 10,
              ),
              LargeButton(
                Color(0xFF4267B2),
                () {
                  if (_formKey.currentState.validate()) {
                    snackBars(true);
                    signIn(emailController.text, passwordController.text);
                    snackBars(_isLogado);
                  }
                },
                JoyUiText.titleButtonLoginFacebook,
                isUseNativeIcon = false,
                null,
                IconsCustom.fbicon,
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
      return Row(children: <Widget>[
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
