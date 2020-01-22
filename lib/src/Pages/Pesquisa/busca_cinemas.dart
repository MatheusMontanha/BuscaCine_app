import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/Models/post_model.dart';

class BuscaCinemas extends StatelessWidget {
  Dio dio = new Dio();

  Future<List<PostModel>> _getUsers() async {
    List<PostModel> cinemas = [];
    var response = await dio.get(
        "https://api-content.ingresso.com/v0/theaters/city/5?partnership=buscacine");
    var jsonData = (response.data as List)
        .map((item) => PostModel.fromJson(item))
        .toList();
    for (var i in jsonData) {
      PostModel postModel = PostModel(
          name: i.name,
          address: i.address,
          neighborhood: i.neighborhood,
          addressComplement: i.addressComplement,
          number: i.number);
      cinemas.add(postModel);
    }
    return cinemas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("Busque por cinemas."),
      ),
      body: Container(
        child: FutureBuilder<List<PostModel>>(
          future: _getUsers(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading..."),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index].name),
                  );
                },
              );
            }
          },
        ),
      ),

      //     Container(
      //   child: Column(
      //     children: <Widget>[
      //       TextFormField(
      //         keyboardType: TextInputType.text,
      //         decoration: InputDecoration(
      //           prefixIcon: Icon(Icons.search),
      //           labelText: "Nome da Cidade",
      //           labelStyle: TextStyle(
      //             color: Colors.black38,
      //             fontWeight: FontWeight.w400,
      //             fontSize: 20,
      //           ),
      //         ),
      //         style: TextStyle(fontSize: 20),
      //       ),
      //       Container(
      //         height: 40,
      //         alignment: Alignment.center,
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //           borderRadius: BorderRadius.all(
      //             Radius.circular(5),
      //           ),
      //         ),
      //         child: FlatButton(
      //           child: Text(
      //             "Pesquisar",
      //             style: TextStyle(
      //               fontWeight: FontWeight.bold,
      //               color: Colors.white,
      //             ),
      //           ),
      //           onPressed: () {},
      //         ),
      //       ),
      //       FutureBuilder(
      //           future: _getUsers(),
      //           builder: (context, snapshot) {
      //             if (snapshot.data == null) {
      //               return Container(
      //                 child: Center(
      //                   child: Text("Loading..."),
      //                 ),
      //               );
      //             } else {
      //               return ListView.builder(
      //                 itemCount: snapshot.data.length,
      //                 itemBuilder: (BuildContext context, int index) {
      //                   return ListTile(
      //                     title: Text(snapshot.data[index].name),
      //                   );
      //                 },
      //               );
      //             }
      //           }),
      //     ],
      //   ),
      // ),
    );
  }
}
