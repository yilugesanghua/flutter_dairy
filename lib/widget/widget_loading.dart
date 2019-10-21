import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 加载状态
enum LS {
  LOADING,
  S_WITH_DATA,
  S_WITH_NONE,
  FAIL,
}

abstract class LoadingState<T extends StatefulWidget> extends State<T> {
  LS _state = LS.LOADING;
  bool fillParent = false;
  Color bgColor;

  @override
  Widget build(BuildContext context) {
    var body;
    switch (_state) {
      case LS.LOADING:
        body = Container(
          color: bgColor,
          padding: EdgeInsets.all(20),
          child: CupertinoActivityIndicator(),
        );
        break;
      case LS.S_WITH_DATA:
        body = getSuccessWidget();
        break;
      case LS.S_WITH_NONE:
        body = Container(
          color: bgColor,
          padding: EdgeInsets.all(20),
          child: Text('内容去哪了～'),
        );
        break;
      case LS.FAIL:
        body = GestureDetector(
          onTap: () {
            updateLoadingState(LS.LOADING);
            onFailRetry();
          },
          child: Container(
            color: bgColor,
            padding: EdgeInsets.all(20),
            child: Text('Load Fail'),
          ),
        );
        break;
    }
    return fillParent
        ? SizedBox.expand(
            child: body,
          )
        : Center(
            child: body,
          );
  }

  updateLoadingState(ls) {
    if (_state == ls) return;
    setState(() {
      _state = ls;
    });
  }

  Widget getSuccessWidget();

  Function onFailRetry();
}
