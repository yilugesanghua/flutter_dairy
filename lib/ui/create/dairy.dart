class Dairy {
  ///心情
  String mood;

  ///天气
  String weather;
  int id;

  ///时间
  int time;

  ///图片列表
  String imageList;

  ///内容
  String content;

  ///是否是本地数据
  bool isLocal;

  Dairy(
      {this.isLocal,
      this.mood,
      this.weather,
      this.id,
      this.time,
      this.imageList,
      this.content});

  Dairy.fromJson(Map<String, dynamic> json) {
    isLocal = json['islocal'] ?? false;
    mood = json['mood'];
    weather = json['weather'];
    id = json['id'];
    time = json['time'];
    imageList = json['imageList'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['islocal'] = this.isLocal ?? false;
    data['mood'] = this.mood;
    data['weather'] = this.weather;
    data['id'] = this.id;
    data['time'] = this.time;
    data['imageList'] = this.imageList;
    data['content'] = this.content;
    return data;
  }
  static List<Dairy> fromMapList(dynamic mapList) {
    List<Dairy> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = Dairy.fromJson(mapList[i]);
    }
    return list;
  }
}
