import 'package:flutter_dairy/sql/base_model_entity.dart';

final String columnId = 'id';
final String columnTitle = 'title';
final String columnContent = 'content';
final String columnSendTime = 'sendTime';
final String columnTemp = 'temp';

class NoteBook extends BaseModelEntity {
  int id;
  String title;
  String content;
  int sendTime;
  double temp;

  NoteBook();

  @override
  String toString() {
    return 'NoteBook{id: $id, title: $title, content: $content, sendTime: $sendTime, temp: $temp}';
  }

  NoteBook.create(this.id, this.title, this.content, this.sendTime, this.temp);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[columnId] = this.id;
    data[columnTitle] = this.title;
    data[columnContent] = this.content;
    data[columnSendTime] = this.sendTime;
    data[columnTemp] = this.temp;
    return data;
  }

  NoteBook.fromJson(Map<String, dynamic> json) {
    id = json[columnId];
    title = json[columnTitle];
    content = json[columnContent];
    sendTime = json[columnSendTime];
    temp = json[columnTemp];
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return NoteBook.fromJson(json);
  }

  @override
  Map<String, dynamic> toDbJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[columnId] = this.id;
    data[columnTitle] = this.title;
    data[columnContent] = this.content;
    data[columnSendTime] = this.sendTime;
    data[columnTemp] = this.temp;
    return data;
  }
}
