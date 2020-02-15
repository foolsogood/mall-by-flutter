import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CartState> buildReducer() {
  return asReducer(
    <Object, Reducer<CartState>>{
      CartAction.action: _onAction,
    },
  );
}

CartState _onAction(CartState state, Action action) {
  final CartState newState = state.clone();
  return newState;
}
