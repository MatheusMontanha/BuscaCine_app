class PostModel {
  String name;
  List<Images> images;
  String address;
  String addressComplement;
  String number;
  String cityId;
  String cityName;
  String neighborhood;

  PostModel(
      {this.name,
      this.images,
      this.address,
      this.addressComplement,
      this.number,
      this.cityId,
      this.cityName,
      this.neighborhood});

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    address = json['address'];
    addressComplement = json['addressComplement'];
    number = json['number'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    neighborhood = json['neighborhood'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['address'] = this.address;
    data['addressComplement'] = this.addressComplement;
    data['number'] = this.number;
    data['cityId'] = this.cityId;
    data['cityName'] = this.cityName;
    data['neighborhood'] = this.neighborhood;
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
