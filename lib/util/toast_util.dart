import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class KingToast {
  static show(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 12.0);
  }

  static cancel() {
    Fluttertoast.cancel();
  }
}
