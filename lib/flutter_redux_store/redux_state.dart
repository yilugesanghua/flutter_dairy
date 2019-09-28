import 'package:flutter_dairy/flutter_redux_store/redux_middle_ware.dart';
import 'package:redux/redux.dart';

class ReduceState {
  int count;
  ReduceState(this.count);
}

ReduceState getReduce(ReduceState state, action) {
  return ReduceState(
    state.count
  );
}

final List<Middleware<ReduceState>> middleware = [
  DairyMiddleWare(),
];
