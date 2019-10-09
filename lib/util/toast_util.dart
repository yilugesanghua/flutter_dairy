import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class KingToast {
  static show(String msg, {gravity = ToastGravity.BOTTOM}) {
    print("======gravity :$gravity======");
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity,
        timeInSecForIos: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 12.0);
  }

  static cancel() {
    Fluttertoast.cancel();
  }
}
