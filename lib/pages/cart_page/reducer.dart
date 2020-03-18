import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CartState> buildReducer() {
  return asReducer(
    <Object, Reducer<CartState>>{
      CartAction.loadData: _loadData,

    },
  );
}


CartState _loadData(CartState state, Action action) {
  final CartState newState = state.clone();
  newState.hotGoodsList=action.payload["hotGoodsList"];
  return newState;
}
