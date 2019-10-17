import 'package:flutter_dairy/model/mood.dart';
import 'package:flutter_dairy/model/weather.dart';

class Dairy {
  ///心情
  Mood mood;

  ///天气
  Weather weather;
  int id;

  ///时间
  int time;

  ///图片列表
  String imageList;

  ///内容
  String content;

  ///是否是本地数据
  bool isLocal;

  ///TODO
  int type;

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
    mood = json['mood'] != null ? new Mood.fromJson(json['mood']) : null;
    weather =
        json['weather'] != null ? new Weather.fromJson(json['weather']) : null;
    id = json['id'];
    time = json['time'];
    imageList = json['imageList'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['islocal'] = this.isLocal ?? false;
    if (this.mood != null) {
      data['mood'] = this.mood.toJson();
    }
    if (this.weather != null) {
      data['weather'] = this.weather.toJson();
    }
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
