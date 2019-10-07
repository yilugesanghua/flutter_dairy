import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dairy/flutter_redux_store/redux_state.dart';
import 'package:flutter_dairy/ui/create/create_dairy_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new StoreBuilder(
        builder: (BuildContext context, Store<ReduceState> store) {
      return Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          title: Text(
            "日记",
            style: TextStyle(color: Colors.white, fontSize: 15),
            maxLines: 1,
          ),
          centerTitle: true,
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return CreateDairyPage();
                }));
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 12),
            ),
          ],
        ),
        body: ListView.builder(
          padding: EdgeInsets.only(top: 16),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              color: Colors.white,
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "this is titile",
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                    ),
                    Text(
                      "this is content",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "${formatDate(DateTime.now(), [
                            yyyy,
                            '-',
                            mm,
                            '-',
                            dd,
                            ' ',
                            HH,
                            ':',
                            mm,
                          ])}",
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: 20,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          splashColor: Colors.pink,
          elevation: 2,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return CreateDairyPage();
            }));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
    });
  }
}
