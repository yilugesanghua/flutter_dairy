import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dairy/biz/dairy_biz.dart';
import 'package:flutter_dairy/const/shareprefer_const.dart';
import 'package:flutter_dairy/flutter_redux_store/redux_state.dart';
import 'package:flutter_dairy/ui/home/home_page.dart';
import 'package:flutter_dairy/ui/user/user.dart';
import 'package:flutter_dairy/util/sharepreference_util.dart';
import 'package:flutter_dairy/util/toast_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sharesdk_plugin/sharesdk_defines.dart';
import 'package:sharesdk_plugin/sharesdk_interface.dart';

final userReducer = combineReducers<User>([
  TypedReducer<User, UserLoginAction>(_login),
  TypedReducer<User, UserLogTimeOutAction>(_logTimeOut),
]);

/// 定义了一个 用户登录action UserLoginAction
class UserLoginAction {
  User user;

  UserLoginAction(this.user);
}

class UserLogin_Action {
  User user;

  UserLogin_Action(this.user);
}

/// 定义了一个要与AddUserAction绑定一起函数
/// 该函数的作用主要是修改数据，就是之前的if和else里各自要处理的逻辑
User _login(User user, UserLoginAction addAction) {
  print("======_login=======>${addAction.user}");
  user = addAction.user;
  return user;
}

/// 定义了一个 用户登录action UserLoginAction
class UserLogTimeOutAction {
  User user;

  UserLogTimeOutAction(this.user);
}

/// 定义了一个要与AddUserAction绑定一起函数
/// 该函数的作用主要是修改数据，就是之前的if和else里各自要处理的逻辑
User _logTimeOut(User user, UserLogTimeOutAction addAction) {
  print("======_logTimeOut=======>${addAction.user}");
  user = addAction.user;
  return user;
}

/// type  登录方式 ShareSDKPlatforms.qq
ThunkAction<ReduceState> thirdPartAuth(
    BuildContext context, ShareSDKPlatform type) {
  print("--->${type.name}");
  return (Store<ReduceState> store) async {
    if (type == ShareSDKPlatforms.qq || type == ShareSDKPlatforms.whatsApp) {
      print("=" * 100);
      SharesdkPlugin.getUserInfo(type,
          (SSDKResponseState state, Map user, SSDKError error) {
        if (state == SSDKResponseState.Success) {
          KingToast.show("授权成功~", gravity: ToastGravity.CENTER);
          var dbInfo = json.decode(user['dbInfo']);
          String openId = dbInfo['userID'];
          String accessToken = dbInfo['token'];
          Map<String, String> params = {};
          params['loginType'] = 'qq';
          params['openId'] = openId;
          params['accessToken'] = accessToken;
          login(
              (result) async {
                print("====>登录成功$result");
                var user = User.fromJson(result);
                await SharePreferenceUtil.getInstance()
                    .putStringValue(TOKEN, user?.token);
                store.dispatch(UserLoginAction(user));

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(store),
                    ),
                    (route) => route == null);
              },
              data: params,
              failCallBack: (code, msg) {
                print("====>登录失败$code");
              },
              onStart: () {
                print("====>登录开始");
              });
        } else if (state == SSDKResponseState.Cancel) {
          KingToast.show("取消授权~", gravity: ToastGravity.CENTER);
        } else if (state == SSDKResponseState.Fail) {
          KingToast.show("授权失败~", gravity: ToastGravity.CENTER);
        } else {
          KingToast.show("授权未知错误~", gravity: ToastGravity.CENTER);
        }
      });
    } else {
      ///用户名密码登录
    }
  };
}
