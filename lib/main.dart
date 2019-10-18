import 'package:flutter/material.dart';
import 'package:flutter_dairy/ui/diary_welcome.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'flutter_redux_store/redux_state.dart';

String token;

main() async {
  /// 创建全局Store
  final store = Store<ReduceState>(
    getReduce,
    initialState: ReduceState.initial(),
    middleware: middleware,
  );
  runApp(
    StoreProvider(
      store: store,
      child: MaterialApp(
        theme: ThemeData(
          platform: TargetPlatform.iOS,
          primaryColor: Colors.deepPurpleAccent,
        ),
        home: WelComePage(store),
      ),
    ),
  );
}
