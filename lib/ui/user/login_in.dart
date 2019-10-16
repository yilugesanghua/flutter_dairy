import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dairy/flutter_redux_store/redux_state.dart';
import 'package:flutter_dairy/ui/user/user_reducer.dart';
import 'package:flutter_dairy/util/screen_size.dart';
import 'package:flutter_dairy/util/toast_util.dart';
import 'package:flutter_dairy/widget/inkwidget.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sharesdk_plugin/sharesdk_defines.dart';

class LoginInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateLoginPage();
  }
}

class StateLoginPage extends State<LoginInPage> {
  final _formKey = GlobalKey<FormState>();
  final emailTextFieldNode = FocusNode();
  final passwordTextFieldNode = FocusNode();
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();
  String _email, _pass;
  bool _offstageEmail = true;
  bool _offstagePwd = true;
  Color qq = Colors.greenAccent;
  Color wx = Colors.greenAccent;

  @override
  Widget build(BuildContext context) {
    print("***" * 20);
    return new Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: pxh160),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textBaseline: TextBaseline.ideographic,
                  children: <Widget>[
                    Icon(
                      Icons.ac_unit,
                      color: Colors.pink,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: px40),
                    ),
                    Text(
                      "日记",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                          fontSize: px40),
                    ),
                  ],
                ),
                Form(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(px60, pxh60, px60, pxh30),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: emailControl,
                          focusNode: emailTextFieldNode,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.black54,
                            ),
                            suffixIcon: Offstage(
                              offstage: _offstageEmail,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    FocusScope.of(context)
                                        .requestFocus(emailTextFieldNode);
                                    Future.delayed(Duration(milliseconds: 50),
                                        () {
                                      _email = "";
                                      emailControl.clear();
                                    });
                                  });
                                },
                                child: Offstage(
                                  offstage: false,
                                  child: Icon(
                                    Icons.cancel,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                            errorStyle:
                                TextStyle(color: Colors.red, fontSize: px30),
                            hintText: '请输入邮箱地址',
                            hintStyle: TextStyle(
                                color: Colors.black26, fontSize: px36),
                            labelText: '用户名(邮箱地址)',
                            labelStyle: TextStyle(
                                color: Colors.black54, fontSize: px36),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.pink, width: px10),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(px12)),
                            ),
                          ),
                          onEditingComplete: () {
                            //切换焦点
                            FocusScope.of(context)
                                .requestFocus(passwordTextFieldNode);
                            print("email onEditingComplete $_email");
                          },
                          onFieldSubmitted: (value) {
                            _email = value;
                            print("email onFieldSubmitted  $_email");
                          },
                          onSaved: (value) {
                            _email = value;
                            print("onSave emial: $_email");
                          },
                          onChanged: (value) {
                            print("onChanged  $value");
                            setState(() {
                              _offstageEmail =
                                  (value == null || value.length == 0);
                              print(
                                  "onChanged  _offstageEmail: $_offstageEmail");
                            });
                          },
                          validator: (String value) {
                            var emailReg = RegExp(
                                r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
                            if (!emailReg.hasMatch(value)) {
                              print('not validator email: $value');
                              return '请输入正确的邮箱地址';
                            } else {
                              _email = value;
                              print('validator email: $value');
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          px60,
                          0,
                          px60,
                          pxh40,
                        ),
                        child: TextFormField(
                          onEditingComplete: () {
                            print('onEditingComplete password :');
                          },
                          onFieldSubmitted: (value) {
                            _pass = value;
                            FocusScope.of(context).requestFocus(FocusNode());
                            print('onFieldSubmitted password : $value');
                          },
                          textInputAction: TextInputAction.done,
                          controller: passwordControl,
                          focusNode: passwordTextFieldNode,
                          //密码类型
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.remove_red_eye,
                                color: Colors.black54,
                              ),
                              suffixIcon: Offstage(
                                offstage: _offstagePwd,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context)
                                          .requestFocus(passwordTextFieldNode);
                                      Future.delayed(Duration(milliseconds: 50),
                                          () {
                                        _pass = "";
                                        passwordControl.clear();
                                      });
                                    });
                                  },
                                  child: Offstage(
                                    offstage: false,
                                    child: Icon(
                                      Icons.cancel,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                              hintText: '请输入密码(长度不小于6)',
                              hintStyle: TextStyle(
                                  color: Colors.black26, fontSize: px36),
                              labelText: '密码',
                              errorStyle:
                                  TextStyle(color: Colors.red, fontSize: px30),
                              labelStyle: TextStyle(
                                  color: Colors.black26, fontSize: px36),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.pink, width: px10),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(px12)),
                              )),
                          onChanged: (value) {
                            setState(() {
                              _offstagePwd =
                                  (value == null || value.length == 0);
                            });
                          },
                          validator: (String value) {
                            if (value == null || value.length < 6) {
                              return "密码长度小于6";
                            } else {
                              _pass = value;
                              return null;
                            }
                          },
                          onSaved: (String value) {
                            _pass = value;
                            print('onSaved password : $value');
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, pxh80, 0, 0),
                        child: Container(
                          width: px686,
                          height: pxh96,
                          child: RaisedButton(
                            color: Colors.pink,
                            highlightColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(pxh48),
                            ),
                            onPressed: _login,
                            child: Text(
                              "登录",
                              style: TextStyle(
                                  color: Colors.white, fontSize: px36),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: pxh60),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            StoreConnector<ReduceState, Function>(
                              converter: (store) {
                                return (type) {
                                  store.dispatch(thirdPartAuth(context, type));
                                };
                              },
                              builder: (context, callBack) {
                                return InkWidget(
                                  child: SvgPicture.asset(
                                    "svgs/wx.svg",
                                    width: px120,
                                    height: px120,
                                    color: wx,
                                  ),
                                  highlightColor: Colors.blue,
                                  borderRadius: BorderRadius.all(
                                      const Radius.circular(60)),
                                  splashColor: Colors.pink,
                                  onTap: () {
                                    callBack(ShareSDKPlatforms.wechatSession);
                                  },
                                );
                              },
                            ),
                            StoreConnector<ReduceState, Function>(
                              converter: (store) {
                                return (type) {
                                  store.dispatch(thirdPartAuth(context, type));
                                };
                              },
                              builder: (context, callBack) {
                                print("qqq" * 20);
                                return InkWidget(
                                  child: SvgPicture.asset(
                                    "svgs/qq.svg",
                                    width: px120,
                                    height: px120,
                                    color: qq,
                                  ),
                                  highlightColor: Colors.blue,
                                  borderRadius: BorderRadius.all(
                                      const Radius.circular(60)),
                                  splashColor: Colors.pink,
                                  onTap: () {
                                    callBack(ShareSDKPlatforms.qq);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  autovalidate: true,
                  key: _formKey,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _login() {
//    showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return Center(
//            child: Container(
//              color: Colors.transparent,
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  SizedBox(
//                    width: px50,
//                    height: px50,
//                    child: CircularProgressIndicator(),
//                  ),
//                  Text(
//                    "loading...",
//                    style: TextStyle(fontSize: px24, color: Colors.black54),
//                  ),
//                ],
//              ),
//            ),
//          );
//        });
//    showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return AlertDialog(
//            title: Center(child: Text("this is title"),),
//            titlePadding: EdgeInsets.only(
//                left: px12, right: px12, top: px12, bottom: px12),
//            titleTextStyle: TextStyle(fontSize: px30, color: Colors.red),
//            content: Text("this is content,please see"),
//            actions: <Widget>[
//              Text("确定",style: TextStyle(fontSize: px30,color: Colors.green),),
//              Padding(padding: EdgeInsets.only(left: px100),),
//              Text("取消"),
//            ],
//          );
//        });
    FocusScope.of(context).requestFocus(FocusNode());
    print('press');
    //保存最后的值
    if (_formKey.currentState.validate()) {
      print('validate login--->');
      _formKey.currentState.save();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) {
        //TODO  按钮 StoreConnector
//        return HomePage();
      }), (route) => route == null);
      KingToast.show("登录成功", gravity: ToastGravity.CENTER);
    } else {
      _formKey.currentState.save();
      if (_email == null || _email.length == 0) {
        KingToast.show("请输入用户名", gravity: ToastGravity.CENTER);
        return;
      }
      if (_pass == null || _pass.length == 0) {
        KingToast.show("请输入密码", gravity: ToastGravity.CENTER);
        return;
      }

      KingToast.show("请输入正确的用户名和密码", gravity: ToastGravity.CENTER);
      print('not validate login--->');
    }
  }
}
