import 'package:dio/dio.dart';
import "package:flutter/material.dart";
import 'package:flutter_dairy/biz/api.dart';
import 'package:flutter_dairy/flutter_redux_store/redux_state.dart';
import 'package:flutter_dairy/model/test_db_model.dart';
import 'package:flutter_dairy/sql/sql_manager.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class FirstPage extends StatefulWidget {
  static final String sName = "/";
  int _counter = 0;
  CancelToken cancelToken = new CancelToken();

  @override
  State createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  CancelToken cancelToken=CancelToken();
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<ReduceState>(
        builder: (BuildContext context, Store<ReduceState> store) {
      return Scaffold(
        appBar: AppBar(
          title: Text("ReduxDemo3"),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Text("姓名是：" + store.state.toString()),
            SizedBox(
              height: 50,
            ),
            Text("书名是：" + store.state.toString()),
            SizedBox(
              height: 100,
            ),
            FlatButton(onPressed: _incrementCounter, child: Text("下一页"))
          ],
        )),
      );
    });
  }

  void _incrementCounter() async {
    NoteBook noteBook =
        NoteBook.create(1, "this is title", "this is content", 127823687, 4.25);
    noteBook.insert(TABLE_NOTE);
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });

    await getCategory(cancelToken: cancelToken);
    if (widget._counter.isEven) {
//      await downLoadTest(cancelToken: widget.cancelToken);
    } else {
      try {
//        cancelToken.cancel();
      } catch (e) {
        print("======================");
      }
    }
  }
}
