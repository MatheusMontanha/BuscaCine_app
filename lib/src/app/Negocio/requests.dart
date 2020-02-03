import 'package:dio/dio.dart';
import 'package:flutter_app/src/Models/post_cidade.dart';
import 'package:flutter_app/src/Models/post_filmes_cartaz.dart';
import 'package:flutter_app/src/Models/post_model.dart';
import 'package:flutter_app/src/Models/post_sessoes_filme.dart';

class BuscaCineRequisicoes {
  Dio dio = Dio();
  int id;
  List<PostModel> cinemasPorCidade;
  List<PostFilmeCartaz> cartazPorCidade;
  List<PostSessaoFilme> sessoesPorCinema;
  Future<int> recuperaIDCidade(String nomeCidade) async {
    try {
      var dados = await dio.get(
          "https://api-content.ingresso.com/v0/states/city/name/$nomeCidade");
      var cidade = Cidade.fromJson(dados.data);
      id = int.parse(cidade.id);
      return id;
    } catch (e) {
      return -1;
    }
  }

  Future<List<PostModel>> recuperaCinemas(int id) async {
    cinemasPorCidade = [];
    try {
      var response = await dio.get(
          "https://api-content.ingresso.com/v0/theaters/city/$id?partnership=buscacine");
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
            images: i.images,
            cityName: i.cityName,
            enabled: i.enabled,
            id: i.id,
            totalRooms: i.totalRooms);
        cinemasPorCidade.add(postModel);
      }

      return cinemasPorCidade;
    } catch (e) {
      if (cinemasPorCidade.length == 0) {
        PostModel postModel = PostModel(
            name: "null",
            address: "null",
            neighborhood: "null",
            addressComplement: "null",
            number: "null",
            cityId: "null",
            images: null);
        cinemasPorCidade.add(postModel);
      }

      return cinemasPorCidade;
    }
  }

  Future<List<PostFilmeCartaz>> recuperaFilmeCartaz(int id) async {
    cartazPorCidade = [];
    try {
      var response = await dio.get(
          "https://api-content.ingresso.com/v0/templates/nowplaying/$id?partnership=buscacine");
      var jsonData = (response.data as List)
          .map((item) => PostFilmeCartaz.fromJson(item))
          .toList();
      for (var i in jsonData) {
        PostFilmeCartaz postFilmeCartaz = PostFilmeCartaz(
            id: i.id,
            title: i.title,
            originalTitle: i.originalTitle,
            countryOrigin: i.countryOrigin,
            contentRating: i.contentRating,
            duration: i.duration,
            synopsis: i.synopsis,
            director: i.director,
            distributor: i.distributor,
            genres: i.genres,
            trailers: i.trailers,
            city: i.city,
            images: i.images,
            inPreSale: i.inPreSale);
        cartazPorCidade.add(postFilmeCartaz);
      }
      return cartazPorCidade;
    } catch (e) {
      if (cartazPorCidade.length == 0) {
        PostFilmeCartaz postFilmeCartaz = PostFilmeCartaz(
          id: "null",
          title: "null",
        );
        cartazPorCidade.add(postFilmeCartaz);
      }
      return cartazPorCidade;
    }
  }

  Future<List<PostSessaoFilme>> recuperaSessoesCinema(
      int idCidade, int idCinema) async {
    sessoesPorCinema = [];
    try {
      var response = await dio.get(
          "https://api-content.ingresso.com/v0/sessions/city/$idCidade/theater/$idCinema?partnership=buscacine");
      var jsonData = (response.data as List)
          .map((item) => PostSessaoFilme.fromJson(item))
          .toList();
      for (var i in jsonData) {
        PostSessaoFilme postFilmeCartaz = PostSessaoFilme(
            movies: i.movies,
            isToday: i.isToday,
            date: i.date,
            dateFormatted: i.dateFormatted,
            dayOfWeek: i.dayOfWeek);
        sessoesPorCinema.add(postFilmeCartaz);
      }
    } catch (e) {
      if (sessoesPorCinema.length == 0) {
        PostSessaoFilme postFilmeCartaz = PostSessaoFilme(movies: null);
        sessoesPorCinema.add(postFilmeCartaz);
        return sessoesPorCinema;
      }
    }
    return sessoesPorCinema;
  }
}
