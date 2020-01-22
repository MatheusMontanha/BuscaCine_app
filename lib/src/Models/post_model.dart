class PostModel {
  String name;
  String address;
  String addressComplement;
  String number;
  String neighborhood;

  PostModel(
      {this.name,
      this.address,
      this.addressComplement,
      this.number,
      this.neighborhood});

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    addressComplement = json['addressComplement'];
    number = json['number'];
    neighborhood = json['neighborhood'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['addressComplement'] = this.addressComplement;
    data['number'] = this.number;
    data['neighborhood'] = this.neighborhood;
    return data;
  }
}
