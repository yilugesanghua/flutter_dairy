import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dairy/ui/home/home_page.dart';
import 'package:flutter_dairy/ui/user/login_in.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        home: MainPage(store),
      ),
    ),
  );
}

class MainPage extends StatefulWidget {
  final Store<ReduceState> store;

  MainPage(this.store) ;


  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    print("initState2");
  }

  @override
  Widget build(BuildContext context) {
    print("initState3");
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return StoreProvider(
        store: widget.store,

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
              home: (token == null || token == "")
                  ? LoginInPage()
                  : HomePage(widget.store));
        }));
  }
}
