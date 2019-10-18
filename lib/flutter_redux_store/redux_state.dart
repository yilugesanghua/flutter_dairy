import 'package:flutter_dairy/biz/dairy_biz.dart';
import 'package:flutter_dairy/flutter_redux_store/redux_middle_ware.dart';
import 'package:flutter_dairy/model/config.dart';
import 'package:flutter_dairy/model/dairy.dart';
import 'package:flutter_dairy/ui/config/config_reducer.dart';
import 'package:flutter_dairy/ui/create/dairy_reducer.dart';
import 'package:flutter_dairy/model/user.dart';
import 'package:flutter_dairy/ui/user/user_reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class ReduceState {
  User user;
  List<Dairy> dairyList;
  DiaryConfig diaryConfig;

  ReduceState({this.user, this.dairyList, this.diaryConfig});

  factory ReduceState.initial() {
    return ReduceState(dairyList: List(), user: User(),diaryConfig: DiaryConfig());
  }
}

ReduceState getReduce(ReduceState state, action) {
  return ReduceState(
    user: userReducer(state.user, action),
    dairyList: dairyReducer(state.dairyList, action),
    diaryConfig: configReducer(state.diaryConfig, action),
  );
}

final List<Middleware<ReduceState>> middleware = [
  DairyMiddleWare(),
  thunkMiddleware
];
