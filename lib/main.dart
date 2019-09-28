import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dairy/biz/api.dart';
import 'package:flutter_dairy/flutter_redux_store/first_page.dart';
import 'package:flutter_dairy/model/test_db_model.dart';
import 'package:flutter_dairy/sql/sql_manager.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'flutter_redux_store/redux_state.dart';

main() {
  /// 创建全局Store
  final store = Store<ReduceState>(
    getReduce,
    initialState: ReduceState(1),
    middleware: middleware,
  );
  runApp(MyHomePage(
    store,
  ));
}

class MyHomePage extends StatelessWidget {
  final Store<ReduceState> store;

  MyHomePage(this.store);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

//  @override
//  _MyHomePageState createState() => _MyHomePageState();

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,

        /// StoreBuilder后要跟上我们定义的那个State类，要不会报错，
        child: StoreBuilder<ReduceState>(
            builder: (BuildContext context, Store<ReduceState> store) {
          return MaterialApp(
              title: 'Dairy',
              theme: new ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: FirstPage());
        }));
    ;
  }
}
