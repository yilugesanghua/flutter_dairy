import 'package:flutter_dairy/model/mood.dart';
import 'package:flutter_dairy/model/weather.dart';

class DiaryConfig {
	List<Weather> weathers;
	List<Mood> moods;

	DiaryConfig({this.weathers, this.moods});

	DiaryConfig.fromJson(Map<String, dynamic> json) {
		if (json['weathers'] != null) {
			weathers = new List<Weather>();(json['weathers'] as List).forEach((v) { weathers.add(new Weather.fromJson(v)); });
		}
		if (json['moods'] != null) {
			moods = new List<Mood>();(json['moods'] as List).forEach((v) { moods.add(new Mood.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.weathers != null) {
      data['weathers'] =  this.weathers.map((v) => v.toJson()).toList();
    }
		if (this.moods != null) {
      data['moods'] =  this.moods.map((v) => v.toJson()).toList();
    }
		return data;
	}
}


