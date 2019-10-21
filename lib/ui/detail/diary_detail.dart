import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dairy/biz/dairy_biz.dart';
import 'package:flutter_dairy/model/dairy.dart';
import 'package:flutter_dairy/util/screen_size.dart';
import 'package:flutter_dairy/widget/input_note.dart';
import 'package:flutter_dairy/widget/widget_loading.dart';

class DiaryDetailPage extends StatefulWidget {
  Dairy dairy;
  int id;

  DiaryDetailPage(this.id);

  @override
  State<StatefulWidget> createState() {
    return DiaryDetailPageState();
  }
}

class DiaryDetailPageState extends State<DiaryDetailPage> {
  @override
  void initState() {
    super.initState();
    fetchDetailInfo();
  }

  void fetchDetailInfo() {
    Map<String, String> params = Map();
    params["id"] = '${widget.id}';
    getDiaryDetail(
        (result) {
          print("info  result : $result");
          setState(() {
            widget.dairy = Dairy.fromJson(result);
          });
        },
        queryParameters: params,
        failCallBack: (code, msg) {
          print("===info fail  code is : $code   msg is :$msg=====");
        },
        onStart: () {
          print("===开始  info =====");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.blueAccent,
            leading: Icon(
              Icons.close,
              color: Colors.white,
            ),
            title: Text(
              widget.dairy == null ? "" : "${widget.dairy?.weather?.weather}",
              style: TextStyle(color: Colors.white, fontSize: 15),
              maxLines: 1,
            ),
            centerTitle: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Hero(
                transitionOnUserGestures: true,
                tag: "detail${widget.id}",
                child: Container(
                  padding:
                      EdgeInsets.only(left: px24, right: px24, bottom: px24),
                  child: InputNote(
                    formatDate(
                        DateTime.fromMillisecondsSinceEpoch(widget.dairy == null
                            ? 0
                            : widget.dairy.time * 1000),
                        [
                          yyyy,
                          '-',
                          mm,
                          '-',
                          dd,
                          ' ',
                          HH,
                          ':',
                          mm,
                        ]),
                    widget.dairy == null ? "" : widget.dairy?.content,
                    MediaQuery.of(context).size.width - px48,
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
