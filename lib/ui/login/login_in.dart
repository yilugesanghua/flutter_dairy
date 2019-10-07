import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dairy/flutter_redux_store/redux_state.dart';
import 'package:flutter_dairy/ui/home/home_page.dart';
import 'package:flutter_dairy/util/toast_util.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

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
  var _email, _pass;

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder(
        builder: (BuildContext context, Store<ReduceState> store) {
      return new Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 100),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.ideographic,
                    children: <Widget>[
                      Icon(
                        Icons.ac_unit,
                        color: Colors.pink,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                      ),
                      Text(
                        "日记",
                        style: TextStyle(color: Colors.pink, fontSize: 26),
                      ),
                    ],
                  ),
                  Form(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.email, color: Colors.black54),
                              Padding(
                                padding: EdgeInsets.only(left: 12),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: emailControl,
                                  focusNode: emailTextFieldNode,
                                  decoration: InputDecoration(
                                    hintText: '请输入邮箱地址',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 12),
                                    labelText: '用户名(邮箱地址)',
                                    labelStyle: TextStyle(
                                        color: Colors.black54, fontSize: 16),
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
                                  validator: (String value) {
                                    var emailReg = RegExp(
                                        r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
                                    if (!emailReg.hasMatch(value)) {
                                      print('not validator email: $value');
                                      return '请输入正确的邮箱地址';
                                    } else {
                                      print('validator email: $value');
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Icon(
                                Icons.remove_red_eye,
                                color: Colors.black54,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    onEditingComplete: () {
                                      print('onEditingComplete password :');
                                    },
                                    onFieldSubmitted: (value) {
                                      _pass = value;
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      print(
                                          'onFieldSubmitted password : $value');
                                    },
                                    controller: passwordControl,
                                    focusNode: passwordTextFieldNode,
                                    //密码类型
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        hintText: '请输入密码(长度不小于6)',
                                        hintStyle: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 12),
                                        labelText: '密码',
                                        labelStyle: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 14)),
                                    validator: (String value) =>
                                        (value == null || value.length < 6)
                                            ? "密码长度小于6"
                                            : null,
                                    onSaved: (String value) {
                                      _pass = value;
                                      print('onSaved password : $value');
                                    },
                                  ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Container(
                            width: 150,
                            height: 50,
                            child: RaisedButton(
                              color: Colors.pink,
                              highlightColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              onPressed: _login,
                              child: Text(
                                "登录",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
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
    });
  }

  void _login() {
    print('press');
    //保存最后的值
    if (_formKey.currentState.validate()) {
      print('validate login--->');
      _formKey.currentState.save();
      Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context){
        return HomePage();
      } ));
      KingToast.show("登录成功");
    } else {
      print('not validate login--->');
    }
  }
}
