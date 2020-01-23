class Cidade {
  String id;
  String name;
  String uf;
  String state;
  String urlKey;
  String timeZone;

  Cidade({this.id, this.name, this.uf, this.state, this.urlKey, this.timeZone});

  Cidade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    uf = json['uf'];
    state = json['state'];
    urlKey = json['urlKey'];
    timeZone = json['timeZone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['uf'] = this.uf;
    data['state'] = this.state;
    data['urlKey'] = this.urlKey;
    data['timeZone'] = this.timeZone;
    return data;
  }
}
