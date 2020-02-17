import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CartState> buildReducer() {
  return asReducer(
    <Object, Reducer<CartState>>{
      // CartAction.action: _onAction,
      CartAction.loadData: _loadData,

    },
  );
}

// CartState _onAction(CartState state, Action action) {
//   final CartState newState = state.clone();
//   return newState;
// }
CartState _loadData(CartState state, Action action) {
  final CartState newState = state.clone();
  newState.hotGoodsList=action.payload["hotGoodsList"];
  return newState;
}
