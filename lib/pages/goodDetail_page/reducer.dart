import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GoodDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<GoodDetailState>>{
      // GoodDetailAction.action: _onAction,
      GoodDetailAction.loadData:_onLoadData,
    },
  );
}

// GoodDetailState _onAction(GoodDetailState state, Action action) {
//   final GoodDetailState newState = state.clone();
//   return newState;
// }
GoodDetailState _onLoadData(GoodDetailState state, Action action) {
  final GoodDetailState newState = state.clone();
  newState.goodDetail=action.payload["goodDetail"];
  return newState;
}
