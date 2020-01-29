class PostModel {
  String id;
  List<Images> images;
  String name;
  String address;
  String addressComplement;
  String number;
  String cityId;
  String cityName;
  String neighborhood;
  int totalRooms;
  bool enabled;

  PostModel(
      {this.id,
      this.images,
      this.name,
      this.address,
      this.addressComplement,
      this.number,
      this.cityId,
      this.cityName,
      this.neighborhood,
      this.totalRooms,
      this.enabled});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    name = json['name'];
    address = json['address'];
    addressComplement = json['addressComplement'];
    number = json['number'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    neighborhood = json['neighborhood'];
    totalRooms = json['totalRooms'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['address'] = this.address;
    data['addressComplement'] = this.addressComplement;
    data['number'] = this.number;
    data['cityId'] = this.cityId;
    data['cityName'] = this.cityName;
    data['neighborhood'] = this.neighborhood;
    data['totalRooms'] = this.totalRooms;
    data['enabled'] = this.enabled;
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
