import 'package:flutter/material.dart';
import 'package:flutter_dairy/biz/dairy_biz.dart';
import 'package:flutter_dairy/const/shareprefer_const.dart';
import 'package:flutter_dairy/flutter_redux_store/redux_state.dart';
import 'package:flutter_dairy/ui/config/config_reducer.dart';
import 'package:flutter_dairy/ui/home/home_page.dart';
import 'package:flutter_dairy/ui/user/login_in.dart';
import 'package:flutter_dairy/util/screen_size.dart';
import 'package:flutter_dairy/util/sharepreference_util.dart';
import 'package:flutter_dairy/widget/inkwidget.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';

class WelComePage extends StatefulWidget {
  final Store<ReduceState> store;

  WelComePage(this.store);

  @override
  State<StatefulWidget> createState() {
    return WelComePageState();
  }
}

class WelComePageState extends State<WelComePage> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    widget.store.dispatch(dairyInitConfig());
    Future.wait([
      (SharePreferenceUtil.getInstance().getStringValue(TOKEN)),
    ]).then((values) {
      widget.store.state.user.token = values[0];
      setState(() {
        _opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: widget.store,

        /// StoreBuilder后要跟上我们定义的那个State类，要不会报错，
        child: StoreBuilder<ReduceState>(
            builder: (BuildContext context, Store<ReduceState> store) {
          ///屏幕适配
          ScreenUtil.instance =
              ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
                ..init(context);

          return Scaffold(
            body: Center(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.pink,
                  ),
                  Opacity(
                    opacity: _opacity,
                    child: Container(
                      alignment: Alignment.center,
                      child: InkWidget(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: px36, right: px36, top: px12, bottom: px12),
                          child: Text(
                            "立即体验",
                            style:
                                TextStyle(fontSize: px36, color: Colors.white),
                          ),
                        ),
                        highlightColor: Colors.blue,
                        borderRadius:
                            BorderRadius.all(const Radius.circular(60)),
                        splashColor: Colors.pink,
                        normalColor: Colors.black,
                        onTap: () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                            builder: (context) {
                              if (store.state.user.token == null ||
                                  store.state.user.token.isEmpty) {
                                return LoginInPage();
                              } else {
                                return HomePage(widget.store);
                              }
                            },
                          ), (route) => route == null);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
