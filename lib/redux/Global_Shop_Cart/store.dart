import 'package:fish_redux/fish_redux.dart';
import 'reducer.dart';
import 'state.dart';
class GlobalShopCartStore{
  static Store<GlobalShopCartState> _globalStore;
  static Store<GlobalShopCartState> get store=>
  _globalStore??=createStore<GlobalShopCartState>(GlobalShopCartState(), buildReducer());
}