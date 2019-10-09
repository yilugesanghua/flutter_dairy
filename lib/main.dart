import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dairy/ui/login/login_in.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';

import 'flutter_redux_store/redux_state.dart';

main() {
  /// 创建全局Store
  final store = Store<ReduceState>(
    getReduce,
    initialState: ReduceState(1),
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
          primaryColor: Colors.deepPurpleAccent,
        ),
        home: MyHomePage(store),
      ),
    ),
  );
}
void run(){
  for(int i =1;i<=1080;i++){
    print("final double px$i=ScreenUtil.getInstance().setWidth($i);");
  }
}
class MyHomePage extends StatelessWidget {
  final Store<ReduceState> store;

  MyHomePage(this.store);

  @override
  Widget build(BuildContext context) {
    run();
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
          print("------------------->${ScreenUtil.getInstance().width}");
          print("------------------->${ScreenUtil.screenWidthDp}");
          print("------------------->${ScreenUtil.pixelRatio}");
          print("------------------->${ScreenUtil.textScaleFactory}");
          print("------------------->${ScreenUtil.getInstance().scaleWidth},${ScreenUtil.getInstance().scaleHeight}");

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
