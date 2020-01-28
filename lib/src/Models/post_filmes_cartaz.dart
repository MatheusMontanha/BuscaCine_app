class PostFilmeCartaz {
  String id;
  String title;
  String originalTitle;
  String countryOrigin;
  String contentRating;
  String duration;
  String synopsis;
  String director;
  String distributor;
  bool inPreSale;
  String city;
  List<Images> images;
  List<String> genres;
  List<Trailers> trailers;

  PostFilmeCartaz(
      {this.id,
      this.title,
      this.originalTitle,
      this.countryOrigin,
      this.contentRating,
      this.duration,
      this.synopsis,
      this.director,
      this.distributor,
      this.inPreSale,
      this.city,
      this.images,
      this.genres,
      this.trailers});

  PostFilmeCartaz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    originalTitle = json['originalTitle'];
    countryOrigin = json['countryOrigin'];
    contentRating = json['contentRating'];
    duration = json['duration'];
    synopsis = json['synopsis'];
    director = json['director'];
    distributor = json['distributor'];
    inPreSale = json['inPreSale'];
    city = json['city'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    genres = json['genres'].cast<String>();
    if (json['trailers'] != null) {
      trailers = new List<Trailers>();
      json['trailers'].forEach((v) {
        trailers.add(new Trailers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['originalTitle'] = this.originalTitle;
    data['countryOrigin'] = this.countryOrigin;
    data['contentRating'] = this.contentRating;
    data['duration'] = this.duration;
    data['synopsis'] = this.synopsis;
    data['director'] = this.director;
    data['distributor'] = this.distributor;
    data['inPreSale'] = this.inPreSale;
    data['city'] = this.city;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['genres'] = this.genres;
    if (this.trailers != null) {
      data['trailers'] = this.trailers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String url;
  String type;

  Images({this.url, this.type});

  Images.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['type'] = this.type;
    return data;
  }
}

class Trailers {
  String type;
  String url;
  String embeddedUrl;

  Trailers({this.type, this.url, this.embeddedUrl});

  Trailers.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
    embeddedUrl = json['embeddedUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['url'] = this.url;
    data['embeddedUrl'] = this.embeddedUrl;
    return data;
  }
}
