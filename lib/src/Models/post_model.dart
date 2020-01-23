class PostModel {
  String name;
  String images;
  String address;
  String addressComplement;
  String number;
  String cityId;
  String neighborhood;

  PostModel(
      {this.name,
      this.images,
      this.address,
      this.addressComplement,
      this.number,
      this.cityId,
      this.neighborhood});

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    images = json['images'];
    address = json['address'];
    addressComplement = json['addressComplement'];
    number = json['number'];
    cityId = json['cityId'];
    neighborhood = json['neighborhood'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['images'] = this.images;
    data['address'] = this.address;
    data['addressComplement'] = this.addressComplement;
    data['number'] = this.number;
    data['cityId'] = this.cityId;
    data['neighborhood'] = this.neighborhood;
    return data;
  }
}
