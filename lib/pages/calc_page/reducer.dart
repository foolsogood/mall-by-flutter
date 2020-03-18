import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CalcState> buildReducer() {
  return asReducer(
    <Object, Reducer<CalcState>>{
      CalcAction.sendTime: _onSendTime,

    },
  );
}


CalcState _onSendTime(CalcState state, Action action) {
  final CalcState newState = state.clone();
  newState.sendTime=action.payload["sendTime"];
  return newState;
}
