import 'package:flutter/material.dart';

import 'src/Pages/Home/opcoes_BuscaCine.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BuscaCine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OpcoesBuscaCine(),
    );
  }
}
