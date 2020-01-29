class PostSessaoFilme {
  List<Movies> movies;
  String date;
  String dateFormatted;
  String dayOfWeek;
  bool isToday;

  PostSessaoFilme(
      {this.movies,
      this.date,
      this.dateFormatted,
      this.dayOfWeek,
      this.isToday});

  PostSessaoFilme.fromJson(Map<String, dynamic> json) {
    if (json['movies'] != null) {
      movies = new List<Movies>();
      json['movies'].forEach((v) {
        movies.add(new Movies.fromJson(v));
      });
    }
    date = json['date'];
    dateFormatted = json['dateFormatted'];
    dayOfWeek = json['dayOfWeek'];
    isToday = json['isToday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.movies != null) {
      data['movies'] = this.movies.map((v) => v.toJson()).toList();
    }
    data['date'] = this.date;
    data['dateFormatted'] = this.dateFormatted;
    data['dayOfWeek'] = this.dayOfWeek;
    data['isToday'] = this.isToday;
    return data;
  }
}

class Movies {
  String id;
  String title;
  String originalTitle;
  String movieIdUrl;
  bool inPreSale;
  String duration;
  String contentRating;
  String distributor;
  String urlKey;
  String siteURL;
  String siteURLByTheater;
  String boxOfficeId;
  String ancineId;
  List<Images> images;
  List<Trailers> trailers;
  List<String> genres;
  List<String> tags;
  List<CompleteTags> completeTags;
  List<Rooms> rooms;

  Movies(
      {this.id,
      this.title,
      this.originalTitle,
      this.movieIdUrl,
      this.inPreSale,
      this.duration,
      this.contentRating,
      this.distributor,
      this.urlKey,
      this.siteURL,
      this.siteURLByTheater,
      this.boxOfficeId,
      this.ancineId,
      this.images,
      this.trailers,
      this.genres,
      this.tags,
      this.completeTags,
      this.rooms});

  Movies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    originalTitle = json['originalTitle'];
    movieIdUrl = json['movieIdUrl'];
    inPreSale = json['inPreSale'];
    duration = json['duration'];
    contentRating = json['contentRating'];
    distributor = json['distributor'];
    urlKey = json['urlKey'];
    siteURL = json['siteURL'];
    siteURLByTheater = json['siteURLByTheater'];
    boxOfficeId = json['boxOfficeId'];
    ancineId = json['ancineId'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    if (json['trailers'] != null) {
      trailers = new List<Trailers>();
      json['trailers'].forEach((v) {
        trailers.add(new Trailers.fromJson(v));
      });
    }
    genres = json['genres'].cast<String>();
    tags = json['tags'].cast<String>();
    if (json['completeTags'] != null) {
      completeTags = new List<CompleteTags>();
      json['completeTags'].forEach((v) {
        completeTags.add(new CompleteTags.fromJson(v));
      });
    }
    if (json['rooms'] != null) {
      rooms = new List<Rooms>();
      json['rooms'].forEach((v) {
        rooms.add(new Rooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['originalTitle'] = this.originalTitle;
    data['movieIdUrl'] = this.movieIdUrl;
    data['inPreSale'] = this.inPreSale;
    data['duration'] = this.duration;
    data['contentRating'] = this.contentRating;
    data['distributor'] = this.distributor;
    data['urlKey'] = this.urlKey;
    data['siteURL'] = this.siteURL;
    data['siteURLByTheater'] = this.siteURLByTheater;
    data['boxOfficeId'] = this.boxOfficeId;
    data['ancineId'] = this.ancineId;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.trailers != null) {
      data['trailers'] = this.trailers.map((v) => v.toJson()).toList();
    }
    data['genres'] = this.genres;
    data['tags'] = this.tags;
    if (this.completeTags != null) {
      data['completeTags'] = this.completeTags.map((v) => v.toJson()).toList();
    }
    if (this.rooms != null) {
      data['rooms'] = this.rooms.map((v) => v.toJson()).toList();
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

class CompleteTags {
  String name;
  String background;
  String color;

  CompleteTags({this.name, this.background, this.color});

  CompleteTags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    background = json['background'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['background'] = this.background;
    data['color'] = this.color;
    return data;
  }
}

class Rooms {
  String name;
  List<Sessions> sessions;

  Rooms({this.name, this.sessions});

  Rooms.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['sessions'] != null) {
      sessions = new List<Sessions>();
      json['sessions'].forEach((v) {
        sessions.add(new Sessions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.sessions != null) {
      data['sessions'] = this.sessions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sessions {
  String id;
  double price;
  List<String> type;
  List<Types> types;
  Date date;
  Date realDate;
  String time;
  String defaultSector;
  String siteURL;
  bool hasSeatSelection;
  bool enabled;
  String blockMessage;

  Sessions(
      {this.id,
      this.price,
      this.type,
      this.types,
      this.date,
      this.realDate,
      this.time,
      this.defaultSector,
      this.siteURL,
      this.hasSeatSelection,
      this.enabled,
      this.blockMessage});

  Sessions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    type = json['type'].cast<String>();
    if (json['types'] != null) {
      types = new List<Types>();
      json['types'].forEach((v) {
        types.add(new Types.fromJson(v));
      });
    }
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    realDate =
        json['realDate'] != null ? new Date.fromJson(json['realDate']) : null;
    time = json['time'];
    defaultSector = json['defaultSector'];
    siteURL = json['siteURL'];
    hasSeatSelection = json['hasSeatSelection'];
    enabled = json['enabled'];
    blockMessage = json['blockMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['type'] = this.type;
    if (this.types != null) {
      data['types'] = this.types.map((v) => v.toJson()).toList();
    }
    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
    if (this.realDate != null) {
      data['realDate'] = this.realDate.toJson();
    }
    data['time'] = this.time;
    data['defaultSector'] = this.defaultSector;
    data['siteURL'] = this.siteURL;
    data['hasSeatSelection'] = this.hasSeatSelection;
    data['enabled'] = this.enabled;
    data['blockMessage'] = this.blockMessage;
    return data;
  }
}

class Types {
  int id;
  String name;
  String alias;
  bool display;

  Types({this.id, this.name, this.alias, this.display});

  Types.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
    display = json['display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['alias'] = this.alias;
    data['display'] = this.display;
    return data;
  }
}

class Date {
  String localDate;
  bool isToday;
  String dayOfWeek;
  String dayAndMonth;
  String hour;
  String year;

  Date(
      {this.localDate,
      this.isToday,
      this.dayOfWeek,
      this.dayAndMonth,
      this.hour,
      this.year});

  Date.fromJson(Map<String, dynamic> json) {
    localDate = json['localDate'];
    isToday = json['isToday'];
    dayOfWeek = json['dayOfWeek'];
    dayAndMonth = json['dayAndMonth'];
    hour = json['hour'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['localDate'] = this.localDate;
    data['isToday'] = this.isToday;
    data['dayOfWeek'] = this.dayOfWeek;
    data['dayAndMonth'] = this.dayAndMonth;
    data['hour'] = this.hour;
    data['year'] = this.year;
    return data;
  }
}
