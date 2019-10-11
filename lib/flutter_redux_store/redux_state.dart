import 'package:flutter_dairy/flutter_redux_store/redux_middle_ware.dart';
import 'package:flutter_dairy/ui/create/dairy.dart';
import 'package:flutter_dairy/ui/create/dairy_reducer.dart';
import 'package:flutter_dairy/ui/user/user.dart';
import 'package:flutter_dairy/ui/user/user_reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class ReduceState {
  User user;
  List<Dairy> dairyList;

  ReduceState({this.user, this.dairyList});

  factory ReduceState.initial() {
    return ReduceState(dairyList: List());
  }
}

ReduceState getReduce(ReduceState state, action) {
  return ReduceState(
    user: userReducer(state.user, action),
    dairyList: dairyReducer(state.dairyList,action),
  );
}

final List<Middleware<ReduceState>> middleware = [
  DairyMiddleWare(),
  thunkMiddleware
];
