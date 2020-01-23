import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/Models/post_model.dart';

class BuscaCinemas extends StatelessWidget {
  Dio dio = new Dio();

  Future<List<PostModel>> _getCinemas() async {
    List<PostModel> cinemas = [];
    var response = await dio.get(
        "https://api-content.ingresso.com/v0/theaters/city/461?partnership=buscacine");
    var jsonData = (response.data as List)
        .map((item) => PostModel.fromJson(item))
        .toList();
    for (var i in jsonData) {
      PostModel postModel = PostModel(
          name: i.name,
          address: i.address,
          neighborhood: i.neighborhood,
          addressComplement: i.addressComplement,
          number: i.number,
          cityId: i.cityId,
          images: i.images);
      cinemas.add(postModel);
    }
    return cinemas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: TextField(
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          decoration: InputDecoration(
              labelText: "Digite o nome da cidade...",
              labelStyle: TextStyle(
                color: Colors.white,
              )),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder<List<PostModel>>(
          future: _getCinemas(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text(
                    "Carregando...",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  snapshot.data[index].images[0].url),
                            ),
                            title: Text(
                              snapshot.data[index].name,
                              style: TextStyle(fontSize: 18),
                            ),
                            subtitle: Text(
                              "Endereço: ${snapshot.data[index].address}, Número: ${snapshot.data[index].number}",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
