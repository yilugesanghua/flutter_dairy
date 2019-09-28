import 'package:flutter_dairy/flutter_redux_store/redux_state.dart';
import 'package:redux/redux.dart';

class DairyMiddleWare implements MiddlewareClass<ReduceState> {
  @override
  void call(Store<ReduceState> store, action, NextDispatcher next) {
    print("DairyMiddleWare========>$action");
    next(action);
  }
}
