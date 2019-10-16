import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dairy/ui/create/dairy.dart';
import 'package:flutter_dairy/util/screen_size.dart';
import 'package:flutter_dairy/widget/input_note.dart';

class DiaryDetailPage extends StatefulWidget {
  final Dairy dairy;

  DiaryDetailPage(this.dairy);

  @override
  State<StatefulWidget> createState() {
    return DiaryDetailPageState();
  }
}

class DiaryDetailPageState extends State<DiaryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "${widget.dairy.weather}",
              style: TextStyle(color: Colors.white, fontSize: 15),
              maxLines: 1,
            ),
            centerTitle: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Hero(
                transitionOnUserGestures: true,
                tag: "detail${widget.dairy.id}",
                child: Container(
                  padding:
                      EdgeInsets.only(left: px24, right: px24, bottom: px24),
                  child: InputNote(
                    formatDate(
                        DateTime.fromMillisecondsSinceEpoch(
                            widget.dairy.time * 1000),
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
                    widget.dairy.content,
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
