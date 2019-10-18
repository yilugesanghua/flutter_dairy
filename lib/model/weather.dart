class Weather {
  int id;
  String weather;
  String iconUrl;

  Weather({this.id, this.weather, this.iconUrl});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weather = json['weather'];
    iconUrl = json['iconUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['weather'] = this.weather;
    data['iconUrl'] = this.iconUrl;
    return data;
  }
}
