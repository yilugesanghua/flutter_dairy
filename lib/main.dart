import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dairy/ui/user/login_in.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';

import 'flutter_redux_store/redux_state.dart';

main() {
  /// 创建全局Store
  final store = Store<ReduceState>(
    getReduce,
    initialState: ReduceState.initial(),
    middleware: middleware,
  );
//  runApp(MyHomePage(
//    store,
//  ));
  runApp(
    StoreProvider(
      store: store,
      child: MaterialApp(
        theme: ThemeData(
          platform: TargetPlatform.iOS,
          primaryColor: Colors.deepPurpleAccent,
        ),
        home: MyHomePage(store),
      ),
    ),
  );
}


class MyHomePage extends StatelessWidget {
  final Store<ReduceState> store;

  MyHomePage(this.store);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return StoreProvider(
        store: store,

        /// StoreBuilder后要跟上我们定义的那个State类，要不会报错，
        child: StoreBuilder<ReduceState>(
            builder: (BuildContext context, Store<ReduceState> store) {
          ///屏幕适配
          ScreenUtil.instance =
              ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
                ..init(context);

          return MaterialApp(
              title: 'Dairy',
              theme: new ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: LoginInPage());
        }));
    ;
  }
}
