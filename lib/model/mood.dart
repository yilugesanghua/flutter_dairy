class Mood {
  int id;
  String mood;
  String iconUrl;

  Mood({this.id, this.mood, this.iconUrl});

  Mood.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mood = json['mood'];
    iconUrl = json['iconUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mood'] = this.mood;
    data['iconUrl'] = this.iconUrl;
    return data;
  }
}